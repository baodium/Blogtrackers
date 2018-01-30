/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import blogtracker.util.UtilFunctions;

/**
 *
 * @author skumar34 & Nihal Muhammad & msaadghouri
 * retrieves traffic information and top links from sites or categories
 *
 */
public class BlogSiteInfo extends UtilFunctions
{
	public String getBlogLink (int blogsiteID)
	{
		try
		{
			String bloglink = "";
			String query = "select blogsite_url from blogtrackers.blogsites where blogsite_id =" + blogsiteID;
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while(rs.next())
			{
				bloglink = rs.getString("blogsite_url");
			}
			//System.out.println(bloglink);
			return bloglink;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}


	public ArrayList<DomainLink> getMostFrequentLinks(int blogsiteID)
	{
		ArrayList<DomainLink> urllinks= new ArrayList<>();
		try {
			String querystr = "select link, count(*) as rank from outlinks where blogsite_id in ("+blogsiteID+") group by link order by count(*) desc";
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(querystr);
			while (rs.next()) {
				String url = rs.getString("link");
				int rank= rs.getInt("rank");
				DomainLink dm = new DomainLink(url,rank);
				urllinks.add(dm);
			}
//			System.out.println("Most links Done");
			return urllinks;
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return null;
	}

	public List<BlogSites> getblogsites(ArrayList<Integer> selsites)
	{
		try {
			String selSitesQuery = getSelSitesQuery(selsites);
			List<BlogSites> blogsites = new ArrayList<BlogSites>();
			Connection  conn = getConn();
			Statement stmt = conn.createStatement();
			String querystr = "select blogsite_id, blogsite_name, site_type from blogsites WHERE "+selSitesQuery+" 1 order by blogsite_name asc";
			//number '1' was added in the above query to reduce the hassle of rewriting getSelSiteQuery()
			//			System.out.println(querystr);
			ResultSet rset = stmt.executeQuery(querystr);
			while (rset.next())
			{
				BlogSites bs = new BlogSites(rset.getString("blogsite_name"), rset.getInt("blogsite_id"), rset.getString("site_type"),false);
				blogsites.add(bs);
			}
			rset.close();
			conn.close();
			return blogsites;
		} catch (SQLException ex) {

			return null;
		}
	}


	public BlogSiteInfo()
	{
	}

	public List<DataPoint> getFrequentDays(int siteid)
	{
		HashMap<Integer,Integer> daysmap = new HashMap<Integer,Integer>();
		//hashmap for days of the week
		HashMap<Integer, String> days = new HashMap<Integer, String>();
		days.put(1,"Sunday");
		days.put(2, "Monday");
		days.put(3, "Tuesday");
		days.put(4, "Wednesday");
		days.put(5, "Thursday");
		days.put(6, "Friday");
		days.put(7, "Saturday");
		try {
			String querystr = "select blogsite_id from blogsites where blogsite_id = "+siteid;
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(querystr);
			//System.out.println("inside");
			while(rset.next())
			{
				int blogsiteID = rset.getInt("blogsite_id");
				querystr = "select date from blogposts where blogsite_id = '"+blogsiteID+"'";
				rset = stmt.executeQuery(querystr);
				while(rset.next())
				{
					java.util.Date postdate= rset.getDate("date");
					Calendar cal = Calendar.getInstance();
					cal.setTime(postdate);
					int dow = cal.get(Calendar.DAY_OF_WEEK);                    
					if(daysmap.containsKey(dow))
					{
						daysmap.put(dow,(daysmap.get(dow)+1));
					}
					else
						daysmap.put(dow, 1);

				}
			}
			rset.close();
			List<DataPoint> dps= new ArrayList<DataPoint>();
			Set<Integer> keys = daysmap.keySet();
			for(int key:keys)
			{
				//System.out.println(days.get(key)+" "+hm.get(key));
				DataPoint dp = new DataPoint(days.get(key),daysmap.get(key),0,"","");
				dps.add(dp);
			}
//			System.out.println("Frequent Days Done");
			return dps;
		} catch (SQLException ex) {
			ex.printStackTrace();
			List<DataPoint> dps= new ArrayList<DataPoint>();
			return dps;
		}
	}

	public static void main(String args[])
	{
		BlogSiteInfo info= new BlogSiteInfo();
//		System.out.println(info.getBlogLink(47));


	}

	public List<ChartPoint> getAvgMonthlyFrequency(int siteid)
	{
		HashMap<String,Integer> hm = new HashMap<String,Integer>();
		//hashmap for months of a year
		HashMap<Integer, String> months = new HashMap<Integer, String>();
		months.put(1,"January");
		months.put(2, "February");
		months.put(3, "March");
		months.put(4, "April");
		months.put(5, "May");
		months.put(6, "June");
		months.put(7, "July");
		months.put(8, "August");
		months.put(9, "September");
		months.put(10, "October");
		months.put(11, "November");
		months.put(12, "December");        
		try {

			Calendar currentCal = Calendar.getInstance();
			int year = currentCal.get(Calendar.YEAR);
			year = year-3;
			String sdate = year+"-01-01";
			String edate = (year+4)+"-01-01";
			for(int i = year; i < year+4; i++)
			{
				for(int j =0; j<12; j++)
				{
					String key = j + "-" + i;
					//System.out.println(key);
					hm.put(key,0);
				}
			}
			String querystr = "select date from blogposts where blogsite_id = "+siteid+" and date between '"+sdate+"' and '"+edate+"'";
			//System.out.println(querystr);
			//System.out.println(querystr);
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(querystr);
			while(rset.next())
			{
				java.util.Date postdate= rset.getDate("date");
				//System.out.println(postdate);
				Calendar cal = Calendar.getInstance();
				cal.setTime(postdate);
				int month = cal.get(Calendar.MONTH);
				//System.out.println(month);
				int dateyear = cal.get(Calendar.YEAR);
				//System.out.println(dateyear);
				String key = month+"-"+dateyear;
				if(hm.containsKey(key))
				{
					hm.put(key,(hm.get(key)+1));
				}
			}

			List<ChartPoint> dps= new ArrayList<ChartPoint>();
			for(int i=0;i<12;i++)
			{
				ChartPoint cp = new ChartPoint();
				cp.setInterval(months.get(i+1));
				dps.add(cp);
			}
			Set<String> keys = hm.keySet();
			double[] avgs = new double[12];
			int[] count = new int[12];
			for(String key:keys)
			{
				String[] keysplit = key.split("-");
				if(keysplit.length==2)
				{
					int month = Integer.parseInt(keysplit[0]);
					int dateyear = Integer.parseInt(keysplit[1]);
					ChartPoint cp = null;
					boolean flag = false;
					for(ChartPoint point:dps)
					{
						//System.out.println(point.interval+" "+months.get(month+1)+" "+point.interval.equalsIgnoreCase(months.get(month+1)));
						if(point.interval.equalsIgnoreCase(months.get(month+1)))
						{
							//System.out.println(point.interval+" "+months.get(month+1));
							cp = point;
							flag = true;
							break;
						}                        
					}
					if(dateyear==year)
					{
						cp.setNoofposts0(hm.get(key));
					}
					else
						if(dateyear==year+1)
						{
							cp.setNoofposts1(hm.get(key));
						}
						else
							if(dateyear==year+2)
							{
								cp.setNoofposts2(hm.get(key));
							}
							else
								if(dateyear==year+3)
								{
									cp.setNoofposts3(hm.get(key));
								}
					if(month>=0)
					{
						avgs[month] = avgs[month]+hm.get(key);
						count[month]++;
						//System.out.println(months.get(index+1)+" "+hm.get(key));
					}
					if(!flag)
					{
						dps.add(cp);
					}
				}        
			}
			//Set the averages for the respective months
			for(int i=0;i<12;i++)
			{
				if(count[i]>0)
				{
					int k=0;
					for(ChartPoint dp:dps)
					{
						if(dp.interval.equals(months.get(i+1)))
						{
							dp.setAvg(avgs[i]/count[i]);
							dps.set(k, dp);
							break;
						}
						k++;
					}
				}
			}
//			System.out.println("avg months Done");
			return dps;
		} catch (SQLException ex) {
			List<ChartPoint> dps= new ArrayList<ChartPoint>();
			return dps;
		}
	}

	public ArrayList<DomainLink> getMostFrequentDomains(int blogsiteID)
	{
		ArrayList<DomainLink> urllinks= new ArrayList<>();
		try {
			String querystr = "select domain, count(*) as rank from outlinks where blogsite_id in ("+blogsiteID+") group by domain order by count(*) desc";
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(querystr);
			while (rs.next()) {
				String url = rs.getString("domain");
				int rank= rs.getInt("rank");
				DomainLink dm = new DomainLink(url,rank);
				urllinks.add(dm);
			}
//			System.out.println("Most Domains Done");
			return urllinks;
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return null;
	}


	//compute the monthly average number of posts of the bloggers.
	public void getblogfrequency()
	{

		BufferedWriter bw = null;
		try {
			Connection conn = getConn();
			bw = new BufferedWriter(new FileWriter("C:\\indonesia\\blogger-properties\\blogfreq-monthly.txt"));
			Statement stmt = conn.createStatement();
			for (int i = 1; i <= 2; i++) {
				String querystr = "select avg(ct) as ag from (select ct = count(*), Month(date) as mt, Year(date) as yr  from blogposts where blogsite_id = " + i + " group by Month(date),Year(date)) blogposts";
				ResultSet rs = stmt.executeQuery(querystr);
				if (rs.next())
				{
					//                        System.out.println(rs.getInt("ag"));
					bw.write(i+","+rs.getInt("ag"));
					bw.newLine();
				}
			}
			bw.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		catch (SQLException ex) {
			ex.printStackTrace();
		}
	}

	public List<BeanDoughnut> getSentiments(int siteID){
		List<BeanDoughnut> data= new ArrayList<>();

		try {

			Calendar currentCal = Calendar.getInstance();
			int year = currentCal.get(Calendar.YEAR);
			Connection conn = getConn();
			for(int i = year; i > year-3; i--)
			{
				String sdate = i+"-01-01";
				String edate = (i)+"-12-31";
				//System.out.println(i + sdate + edate);
				String query="SELECT sum(posemo) as pos, sum(anx) as anx, sum(anger) as ang, sum(sad) as sad FROM blogtrackers.liwc where blogpostid in ( select blogpost_id from blogposts where blogsite_id = "+siteID+") and date >= '"+sdate+"' and date<= '"+edate+"'";
//				System.out.println(query);
				Statement stmt = conn.createStatement();
				ResultSet rset = stmt.executeQuery(query);
				while (rset.next())
				{
					int pos = rset.getInt("pos");
					int anx = rset.getInt("anx");
					int ang = rset.getInt("ang");
					int sad = rset.getInt("sad");
					BeanDoughnut doughnut= new BeanDoughnut(pos, anx, ang,sad, i);
					data.add(doughnut);
				}
				rset.close();
				stmt.close();

			}
			conn.close();
//			System.out.println("Senti Done");
			return data;
		}catch (Exception e) {
			// TODO: handle exception
			return null;
		}

	}

	//SELECT max(influence_score) FROM blogtrackers.blogposts where blogsite_id=47;

	public int getMaxScore(int siteID){
		int maxScore = 0;

		try {

			Connection conn = getConn();
			String query="SELECT max(influence_score) as score FROM blogtrackers.blogposts where blogsite_id="+siteID;
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(query);
			while (rset.next())
			{
				maxScore = rset.getInt("score");
			}
			rset.close();
			stmt.close();
			conn.close();
			return maxScore;
		}catch (Exception e) {
			return 0;
		}
	}

	class urls implements Comparable
	{
		public String url;
		public int count;
		public int compareTo(Object obj)
		{
			urls tempObject=new urls();
			tempObject=(urls) obj;
			if(this.count>tempObject.count)
				return 1;
			if(this.count<tempObject.count)
				return -1;
			else
				return 0;
		}

	}
}
