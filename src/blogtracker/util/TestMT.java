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

import javax.servlet.http.HttpSession;

import blogtracker.gui.blogtrackers.BeanInfluenceGraph;
import blogtracker.gui.blogtrackers.getGraphData;


/**
 * @author msaadghouri
 *
 */
public class TestMT extends UtilFunctions implements Runnable {

	private final Date startDate,endDate;
	private final String authorName,calScale,selectedsites;
	private final int numIncr,incrValue; 
	private final HttpSession curSession;

	/**
	 * @param startDate
	 * @param endDate
	 * @param authorName
	 * @param calScale
	 * @param selectedsites
	 * @param numIncr
	 */
	public TestMT(Date startDate,Date endDate,String authorName ,int numIncr,String calScale,String selectedsites,HttpSession curSession,int incrValue) {
		super();
		this.startDate = startDate;
		this.endDate = endDate;
		this.authorName = authorName;
		this.calScale = calScale;
		this.selectedsites = selectedsites;
		this.numIncr = numIncr;
		this.curSession=curSession;
		this.incrValue=incrValue;
	}



	@Override
	public void run() {
		System.out.println("Started");
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
		System.out.println(graphPoints);
		curSession.setAttribute("inflGraph"+incrValue, graphPoints);
	}
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
}
