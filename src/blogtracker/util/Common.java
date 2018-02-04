package blogtracker.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Month;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import blogtracker.util.UtilFunctions;
/**
 * author mukti
 */
public class Common extends UtilFunctions
{

	public List<String> returnDates(String datePicked){
		List<String> listDates = new ArrayList<>();
		try{
			String arr[] = datePicked.split("-", 2);
			String sdate1 = arr[0];   
			String sdate2 = arr[1];
			sdate2=sdate2.trim();  // date 2 will have space trim it
			int mm1=Month.valueOf(sdate1.substring(0, sdate1.indexOf(' ')).toUpperCase()).getValue();
			int mm2=Month.valueOf(sdate2.substring(0, sdate2.indexOf(' ')).toUpperCase()).getValue();

			String tempdate[] = sdate1.split(" ", 3);
			String dd=tempdate[1];
			String year=tempdate[2];
			String d1 = year+"-"+mm1+"-"+dd;
			d1=d1.replace(" ", "");

			String tempdate2[] = sdate2.split(" ", 3);
			dd=tempdate2[1];
			year=tempdate2[2];
			String d2 = year+"-"+mm2+"-"+dd;
			d2=d2.replace(" ", "");
			listDates.add(d1);
			listDates.add(d2);
			return listDates;
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
	
	public String returnScale(List<String> aa){
		String d1 = aa.get(0);
		String d2 = aa.get(1);
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String scale=null;
		try {
			Date startdate = df.parse(d1);
			Date enddate = df.parse(d2);
			long diff= enddate.getTime()-startdate.getTime();
			int days = (int) (diff / (1000*60*60*24));
//			System.out.println(days);
			if(days>=0 && days<=13){
				scale="day";
			}else if(days>=14 && days<=84){
				scale="week";
			}else if(days>=85 && days<=365){
				scale="month";
			}else{
				scale="year";
			}
			return scale;
		}
		catch (ParseException e) {
			e.printStackTrace();
			return "month";
		}
	}

	public ArrayList<String> gettrackers(String name)
	{
		Connection conn = getConn();
		String queryStr = "select tracker_name from trackers where userid = ?";

		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(queryStr);

			pstmt.setString(1, name);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<String> t = new ArrayList<String>();
			while(rs.next())
			{
				String tracker = rs.getString("tracker_name");
				t.add(tracker);

			}

			rs.close();
			pstmt.close();
			conn.close();
			return t;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	public long[] differenceBetweenDates(Date fromDate, Date toDate) {
		Calendar startDate = Calendar.getInstance();
		startDate.setTime(fromDate);
		long years = 0;
		long months = 0;
		long days = 0;
		Calendar endDate = Calendar.getInstance();
		endDate.setTime(toDate);
		Calendar tmpdate = Calendar.getInstance();
		tmpdate.setTime(startDate.getTime());

		tmpdate.add(Calendar.YEAR, 1);
		while (tmpdate.compareTo(endDate) <= 0) {
			startDate.add(Calendar.YEAR, 1);
			tmpdate.add(Calendar.YEAR, 1);
			years++;
		}
		tmpdate.setTime(startDate.getTime());
		tmpdate.add(Calendar.MONTH, 1);
		while (tmpdate.compareTo(endDate) <= 0) {
			startDate.add(Calendar.MONTH, 1);
			tmpdate.add(Calendar.MONTH, 1);
			months++;
		}
		tmpdate.setTime(startDate.getTime());
		tmpdate.add(Calendar.DATE, 1);
		while (tmpdate.compareTo(endDate) <= 0) {
			startDate.add(Calendar.DATE, 1);
			tmpdate.add(Calendar.DATE, 1);
			days++;
		}
		return new long[]{days, months, years};
	}
}
