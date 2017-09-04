/**
 * 
 */
package blogtracker.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import blogtracker.gui.blogtrackers.BeanInfluenceGraph;
import blogtracker.gui.blogtrackers.BeanInfluenceScatter;
import blogtracker.gui.blogtrackers.BeanTopKeywords;
import blogtracker.gui.blogtrackers.getGraphData;
import blogtracker.gui.blogtrackers.getTagPost;
import blogtracker.gui.blogtrackers.sitesDialog;

/**
 * @author msaadghouri
 *
 */
public class InfluenceDialog extends UtilFunctions{
	public ArrayList<BeanInfluenceScatter> inflActScatterGraph(String startDate, String endDate, String selectedSites){
		ArrayList<BeanInfluenceScatter> scatterPlot = new ArrayList<BeanInfluenceScatter>();
		try {
			Connection conn = getConn();
			String queryStr="select count(*) as co, blogger,influence_score from blogposts where "+selectedSites+" and (date >= '"+startDate+"' AND date <= '"+endDate+"')and blogger not like ''group by blogger order by co desc limit 50;";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			while (rset.next())
			{
				String bloggerName = rset.getString("blogger");
				int activityCount = rset.getInt("co");
				int influenceScore= rset.getInt("influence_score");
				BeanInfluenceScatter data = new BeanInfluenceScatter(bloggerName,influenceScore,activityCount);
				scatterPlot.add(data);
			}
			rset.close();
			stmt.close();
			conn.close();
			return scatterPlot;
		} catch (SQLException ex) {
			Logger.getLogger(sitesDialog.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}
	}

	public List<BeanInfluenceGraph> getGraphData(Date startDate,Date endDate,String authorName ,int numIncr,String calScale,String selectedsites)
	{
		int calendarFiledIDX;

		java.util.Date curStartDate = startDate;
		java.util.Date curEndDate;
		boolean isStop = false;
		SimpleDateFormat sdform = new SimpleDateFormat();
		sdform.applyPattern("yyyy-MM-dd");
		List<BeanInfluenceGraph> graphPoints = new ArrayList<BeanInfluenceGraph>();
		java.util.Calendar clndr = java.util.Calendar.getInstance();
		clndr.setTime(startDate);
		if (calScale.equals("day"))
		{
			calendarFiledIDX = java.util.Calendar.DATE;
		}
		else if(calScale.equals("week"))
		{
			calendarFiledIDX = java.util.Calendar.DATE;
		}
		else if (calScale.equals("month"))
		{
			calendarFiledIDX = java.util.Calendar.MONTH;
		}
		else
		{
			calendarFiledIDX = java.util.Calendar.YEAR;
		}

		// initialize the time period
		if (calendarFiledIDX == java.util.Calendar.DATE) {
			clndr.add(calendarFiledIDX, numIncr - 1);
			curEndDate = clndr.getTime();
			clndr.setTime(curEndDate);
			clndr.add(java.util.Calendar.DATE, 1);
		} else if (calendarFiledIDX == java.util.Calendar.MONTH) {
			curEndDate = getLastDayOfMonth(clndr.get(java.util.Calendar.YEAR), clndr.get(java.util.Calendar.MONTH) + 1);
			clndr.setTime(curEndDate);
			clndr.add(java.util.Calendar.DATE, 1);
		} else {
			curEndDate = getLastDayOfYear(clndr.get(java.util.Calendar.YEAR));
			clndr.setTime(curEndDate);
			clndr.add(java.util.Calendar.DATE, 1);
		}
		if (curEndDate.compareTo(endDate) > 0)
		{
			curEndDate = endDate;
			isStop = true;
		}
		Connection conn = getConn();
		boolean tempFlag = false;
		//fill the chart datapoints
		int i=0;

		do
		{
			if(tempFlag == true)
			{
				isStop = true;
			}

			String queryStr1= "SELECT sum(influence_score) FROM blogposts WHERE "+selectedsites + " and blogger = '"+ authorName+"' and (date >= '" + sdform.format(curStartDate) + "' AND date <= '" + sdform.format(curEndDate) + "')";
			int iVal;
			ResultSet rSet1= null;
			try
			{
				Statement stmt = conn.createStatement();

				stmt=conn.createStatement();
				rSet1=stmt.executeQuery(queryStr1);
			} catch (SQLException e)
			{
				e.printStackTrace();
			}
			try
			{

				if(rSet1.next())
				{   
					iVal = rSet1.getInt(1);
					if(rSet1.wasNull()){
						// move to the next period
						curStartDate = clndr.getTime();
						clndr.add(calendarFiledIDX, numIncr);
						clndr.add(java.util.Calendar.DATE, -1);
						curEndDate = clndr.getTime();
						clndr.add(java.util.Calendar.DATE, 1);
						if (curEndDate.compareTo(endDate) > 0) {
							curEndDate = endDate;
							tempFlag=true;              //added another flag because the iteration was ending one month early.
						}
						i++;
						continue;
					}
					//System.out.println(rSet1.getObject(1).toString());
					//adding chart fields.
					if(calScale.equals("day")||calScale.equals("week"))
					{
						BeanInfluenceGraph dp = new BeanInfluenceGraph(Integer.parseInt(rSet1.getObject(1).toString()),sdform.format(curStartDate));
						graphPoints.add(dp);
					}
					else
						if(calScale.equals("month"))
						{
							SimpleDateFormat dateformat = new SimpleDateFormat();
							dateformat.applyPattern("MMMM-yyyy");
							BeanInfluenceGraph dp = new BeanInfluenceGraph( Integer.parseInt(rSet1.getObject(1).toString()),sdform.format(curStartDate));
							graphPoints.add(dp);
						}
						else
							if(calScale.equals("year"))
							{
								SimpleDateFormat dateformat = new SimpleDateFormat();
								dateformat.applyPattern("yyyy");
								BeanInfluenceGraph dp = new BeanInfluenceGraph( Integer.parseInt(rSet1.getObject(1).toString()),sdform.format(curStartDate));
								graphPoints.add(dp);
							}


				}

			}catch(SQLException e)
			{
				e.printStackTrace();
			}
			// move to the next period
			curStartDate = clndr.getTime();
			clndr.add(calendarFiledIDX, numIncr);
			clndr.add(java.util.Calendar.DATE, -1);
			curEndDate = clndr.getTime();
			clndr.add(java.util.Calendar.DATE, 1);
			if (curEndDate.compareTo(endDate) > 0) {
				curEndDate = endDate;
				tempFlag=true;              //added another flag because the iteration was ending one month early.
			}
			i++;
		}while(!isStop);
		try {
			conn.close();
		} catch (SQLException ex) {
			Logger.getLogger(getGraphData.class.getName()).log(Level.SEVERE, null, ex);
		}
		return graphPoints;

	}

	public String getInfluentialPost(String startDate,String endDate,String selectedsites, String bloggerName){
		String inflPost=null;
		try {
			String querystr = "select post,max(influence_score) from blogposts where "+selectedsites+" and date >= '"+startDate+"' AND date <= '"+endDate+"' and blogger='"+bloggerName+"'";
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(querystr);
			while(rset.next())
			{   
				inflPost = rset.getString("post");

			}
			conn.close();
			return inflPost;
		} catch (SQLException ex) {
			Logger.getLogger(getTagPost.class.getName()).log(Level.SEVERE, null, ex);
		}
		return null;

	}
	public ArrayList<BeanTopKeywords> getTopKeywords(String bloggerName, String selsites, String sdate, String edate)
	{
		ArrayList<BeanTopKeywords> keywords = new ArrayList<BeanTopKeywords>();
		try {
			Connection conn = getConn();
			String sqlStatement="SELECT term,frequency FROM blogtrackers.terms WHERE blogpostid in (SELECT blogpost_id FROM blogtrackers.blogposts where "+selsites+"and blogger = '"+bloggerName+"') and (date >= '" +sdate+ "' AND date <= '" + edate + "') group by term order by frequency desc limit 40";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(sqlStatement);
			while (rset.next())
			{
				String term = rset.getString("term");
				int freq = rset.getInt("frequency");
				BeanTopKeywords bsites = new BeanTopKeywords(term,freq);
				keywords.add(bsites);
			}
			rset.close();
			stmt.close();
			conn.close();
			return keywords;
		} catch (SQLException ex) {
			Logger.getLogger(sitesDialog.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}
	}

	//		public static void main(String[] args)
	//		{
	//			InfluenceDialog gp =  new InfluenceDialog();
	//			ArrayList<Integer> aa =new ArrayList<Integer>();
	//			aa.add(8);
	//			ArrayList<BeanTopKeywords> dp = gp.getTopKeywords("Irena Chalupa",aa,"2015-09-01","2016-09-10");
	//			System.out.println(dp);
	//	
	//		}
	public java.util.Date getLastDayOfMonth(int year, int month)
	{
		java.util.Calendar cal = java.util.Calendar.getInstance();
		cal.set(java.util.Calendar.YEAR, year);
		cal.set(java.util.Calendar.MONTH, month - 1);
		cal.set(java.util.Calendar.DATE, 1);
		cal.add(java.util.Calendar.MONTH, 1);
		cal.add(java.util.Calendar.DATE, -1);
		return cal.getTime();
	}

	public java.util.Date getLastDayOfYear(int year)
	{
		java.util.Calendar cal = java.util.Calendar.getInstance();
		cal.set(java.util.Calendar.YEAR, year);
		cal.set(java.util.Calendar.MONTH, 1);
		cal.set(java.util.Calendar.DATE, 1);
		cal.add(java.util.Calendar.YEAR, 1);
		cal.add(java.util.Calendar.DATE, -1);
		return cal.getTime();
	}
	public class TestMT implements Runnable {

		private final Date startDate,endDate;
		private final String authorName,calScale,selectedsites;
		private final int numIncr; 

		/**
		 * @param startDate
		 * @param endDate
		 * @param authorName
		 * @param calScale
		 * @param selectedsites
		 * @param numIncr
		 */
		public TestMT(Date startDate, Date endDate, String authorName, String calScale, String selectedsites,
				int numIncr) {
			super();
			this.startDate = startDate;
			this.endDate = endDate;
			this.authorName = authorName;
			this.calScale = calScale;
			this.selectedsites = selectedsites;
			this.numIncr = numIncr;
		}

		@Override
		public void run() {

		}
	}
}
