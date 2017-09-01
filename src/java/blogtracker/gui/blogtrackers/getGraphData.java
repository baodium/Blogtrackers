/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

import blogtracker.util.UtilFunctions;
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

/**
 *
 * @author skumar34
 * Return the data to generate traffic pattern graph.
 */
public class getGraphData extends UtilFunctions
{

	public getGraphData()
	{
		//empty constructor for Flex to instantiate this class.
	}

//	public List<DataPoint> getPosts(Date startDate,Date endDate, int numIncr,String calScale, ArrayList<Integer> selectedsites)
//	{
//		int calendarFiledIDX;
//		String selsitesQuery = getSelSitesQuery(selectedsites);
//		java.util.Date curStartDate = startDate;
//		java.util.Date curEndDate;
//		boolean isStop = false;
//		SimpleDateFormat sdform = new SimpleDateFormat();
//		sdform.applyPattern("yyyy-MM-dd");
//		List<DataPoint> dpoints = new ArrayList<DataPoint>();
//		java.util.Calendar clndr = java.util.Calendar.getInstance();
//		clndr.setTime(startDate);
//		if (calScale.equals("day"))
//		{
//			calendarFiledIDX = java.util.Calendar.DATE;
//		}
//		else if(calScale.equals("week"))
//		{
//			calendarFiledIDX = java.util.Calendar.DATE;
//		}
//		else if (calScale.equals("month"))
//		{
//			calendarFiledIDX = java.util.Calendar.MONTH;
//		}
//		else
//		{
//			calendarFiledIDX = java.util.Calendar.YEAR;
//		}
//
//		// initialize the time period
//		if (calendarFiledIDX == java.util.Calendar.DATE) {
//			clndr.add(calendarFiledIDX, numIncr - 1);
//			curEndDate = clndr.getTime();
//			clndr.setTime(curEndDate);
//			clndr.add(java.util.Calendar.DATE, 1);
//		} else if (calendarFiledIDX == java.util.Calendar.MONTH) {
//			curEndDate = getLastDayOfMonth(clndr.get(java.util.Calendar.YEAR), clndr.get(java.util.Calendar.MONTH) + 1);
//			clndr.setTime(curEndDate);
//			clndr.add(java.util.Calendar.DATE, 1);
//		} else {
//			curEndDate = getLastDayOfYear(clndr.get(java.util.Calendar.YEAR));
//			clndr.setTime(curEndDate);
//			clndr.add(java.util.Calendar.DATE, 1);
//		}
//		if (curEndDate.compareTo(endDate) > 0)
//		{
//			curEndDate = endDate;
//			isStop = true;
//		}
//		Connection conn = getConn();
//		boolean tempFlag = false;
//		//fill the chart datapoints
//		int i=0;
//
//		do
//		{
//			if(tempFlag == true)
//			{
//				isStop = true;
//			}
//			//            // obtain information from database
//			//shamanth obtain the count for each period.
//			String queryStr1= "SELECT COUNT(*) " +
//					"FROM blogposts " +
//					"WHERE "+selsitesQuery+" (date >= '" + sdform.format(curStartDate) + "' AND date <= '" + sdform.format(curEndDate) + "')";
//			ResultSet rSet1= null;
//			try
//			{
//				Statement stmt = conn.createStatement();
//
//				stmt=conn.createStatement();
//				rSet1=stmt.executeQuery(queryStr1);
//			} catch (SQLException e)
//			{
//				e.printStackTrace();
//			}
//			try
//			{
//				if(rSet1.next())
//				{   //System.out.println(rSet1.getObject(1).toString());
//					//adding chart fields.
//					if(calScale.equals("day")||calScale.equals("week"))
//					{
//						DataPoint dp = new DataPoint(sdform.format(curStartDate), Integer.parseInt(rSet1.getObject(1).toString()), i, sdform.format(curEndDate),sdform.format(curStartDate));
//						dpoints.add(dp);
//					}
//					else
//						if(calScale.equals("month"))
//						{
//							SimpleDateFormat dateformat = new SimpleDateFormat();
//							dateformat.applyPattern("MMMM-yyyy");
//							System.out.println("Data Points"+rSet1.getObject(1).toString());
//							DataPoint dp = new DataPoint(dateformat.format(curStartDate), Integer.parseInt(rSet1.getObject(1).toString()), i, sdform.format(curEndDate),sdform.format(curStartDate));
//							dpoints.add(dp);
//						}
//						else
//							if(calScale.equals("year"))
//							{
//								SimpleDateFormat dateformat = new SimpleDateFormat();
//								dateformat.applyPattern("yyyy");
//								DataPoint dp = new DataPoint(dateformat.format(curStartDate), Integer.parseInt(rSet1.getObject(1).toString()), i, sdform.format(curEndDate),sdform.format(curStartDate));
//								dpoints.add(dp);
//							}
//
//
//				}
//
//			}catch(SQLException e)
//			{
//				e.printStackTrace();
//			}
//			// move to the next period
//			curStartDate = clndr.getTime();
//			clndr.add(calendarFiledIDX, numIncr);
//			clndr.add(java.util.Calendar.DATE, -1);
//			curEndDate = clndr.getTime();
//			clndr.add(java.util.Calendar.DATE, 1);
//			if (curEndDate.compareTo(endDate) > 0) {
//				curEndDate = endDate;
//				tempFlag=true;              //added another flag because the iteration was ending one month early.
//			}
//			i++;
//		}while(!isStop);
//		try {
//			conn.close();
//		} catch (SQLException ex) {
//			Logger.getLogger(getGraphData.class.getName()).log(Level.SEVERE, null, ex);
//		}
//		return dpoints;
//
//	}
	
	public List<DataPoint> getPosts(Date startDate,Date endDate, int numIncr,String calScale, String selectedsites)
	{
		int calendarFiledIDX;
		java.util.Date curStartDate = startDate;
		java.util.Date curEndDate;
		boolean isStop = false;
		SimpleDateFormat sdform = new SimpleDateFormat();
		sdform.applyPattern("yyyy-MM-dd");
		List<DataPoint> dpoints = new ArrayList<DataPoint>();
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
			//            // obtain information from database
			//shamanth obtain the count for each period.
			String queryStr1= "SELECT COUNT(*) " +
					"FROM blogposts " +
					"WHERE "+selectedsites+" and (date >= '" + sdform.format(curStartDate) + "' AND date <= '" + sdform.format(curEndDate) + "')";
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
				{   //System.out.println(rSet1.getObject(1).toString());
					//adding chart fields.
					if(calScale.equals("day")||calScale.equals("week"))
					{
						DataPoint dp = new DataPoint(sdform.format(curStartDate), Integer.parseInt(rSet1.getObject(1).toString()), i, sdform.format(curEndDate),sdform.format(curStartDate));
						dpoints.add(dp);
					}
					else
						if(calScale.equals("month"))
						{
							SimpleDateFormat dateformat = new SimpleDateFormat();
							dateformat.applyPattern("MMMM-yyyy");
							System.out.println("Data Points"+rSet1.getObject(1).toString());
							DataPoint dp = new DataPoint(dateformat.format(curStartDate), Integer.parseInt(rSet1.getObject(1).toString()), i, sdform.format(curEndDate),sdform.format(curStartDate));
							dpoints.add(dp);
						}
						else
							if(calScale.equals("year"))
							{
								SimpleDateFormat dateformat = new SimpleDateFormat();
								dateformat.applyPattern("yyyy");
								DataPoint dp = new DataPoint(dateformat.format(curStartDate), Integer.parseInt(rSet1.getObject(1).toString()), i, sdform.format(curEndDate),sdform.format(curStartDate));
								dpoints.add(dp);
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
		return dpoints;

	}

//		public static void main(String[] args)
//		{
//			getGraphData gp =  new getGraphData();
//			ArrayList<Integer> aa =new ArrayList<Integer>();
//			
//			aa.add(47);
//			
//			List<DataPoint> dp = gp.getPosts(new Date(110,00,01),new Date(111,05,01),1 , "month", aa);
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

}
