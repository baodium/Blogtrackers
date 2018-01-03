/**
 * 
 */
package blogtracker.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.json.JSONException;
import org.json.simple.JSONObject;

import blogtracker.gui.blogtrackers.BeanBloggerDetails;
import blogtracker.gui.blogtrackers.BeanDoughnut;
import blogtracker.gui.blogtrackers.ChartPoint;
import blogtracker.gui.blogtrackers.DataPoint;
import blogtracker.gui.blogtrackers.DomainLink;

/**
 * @author msaadghouri
 *
 */
public class BloggerInfoDialog extends UtilFunctions{

	public ArrayList<BeanBloggerDetails> getBloggerDetails(String authorName, String selectedSites) throws JSONException{
		ArrayList<BeanBloggerDetails> postIDList= new ArrayList<>();
		try
		{
			Connection conn = getConn();
			Statement stmt = conn.createStatement();

			String querystr = "SELECT a.*, blogsite_name,blogsite_url, last_cleaned, description FROM blogtrackers.blogsites JOIN (select max(influence_score) as score, blogger, blogsite_id from blogtrackers.blogposts where "+selectedSites+" and blogger = '"+authorName+"' Group by blogsite_id) a On a.blogsite_id =blogsites.blogsite_id;";

			ResultSet rset = stmt.executeQuery(querystr);
			while(rset.next())
			{ 
				String blogger=rset.getString("blogger");
				String siteName=rset.getString("blogsite_name");
				String siteURL=rset.getString("blogsite_url");
				String lastCleaned= rset.getString("last_cleaned");
				String description= rset.getString("description");
				int maxInfluence= rset.getInt("score");
				BeanBloggerDetails jsonObject= new BeanBloggerDetails(blogger, siteName, siteURL, lastCleaned, description, maxInfluence);

				postIDList.add(jsonObject);
			}
			rset.close();
			stmt.close();
			conn.close();
			return postIDList;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}

	}

	public ArrayList<Integer> getPostID(String authorName, String selectedSites){
		ArrayList<Integer> postIDList= new ArrayList<>();
		try
		{
			Connection conn = getConn();
			Statement stmt = conn.createStatement();

			String querystr = "select blogpost_id from blogposts where blogger = '"+authorName+"' and "+selectedSites+"";
			ResultSet rset = stmt.executeQuery(querystr);
			while(rset.next())
			{
				int postID= rset.getInt("blogpost_id");
				postIDList.add(postID);
			}
			rset.close();
			stmt.close();
			conn.close();
			return postIDList;
		} catch (SQLException ex) {
			ex.printStackTrace();
			return null;
		}
	}

	public List<DataPoint> getFrequentDays(String postIDs)
	{
		HashMap<Integer,Integer> daysmap = new HashMap<Integer,Integer>();
		HashMap<Integer, String> days = new HashMap<Integer, String>();
		days.put(1,"Sunday");
		days.put(2, "Monday");
		days.put(3, "Tuesday");
		days.put(4, "Wednesday");
		days.put(5, "Thursday");
		days.put(6, "Friday");
		days.put(7, "Saturday");
		
		try
		{
			Connection conn = getConn();
			Statement stmt = conn.createStatement();

			String querystr = "select date from blogposts where blogpost_id in "+postIDs+"";
			ResultSet rset = stmt.executeQuery(querystr);
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

			rset.close();
			List<DataPoint> dps= new ArrayList<DataPoint>();
			Set<Integer> keys = daysmap.keySet();
			for(int key:keys)
			{
				DataPoint dp = new DataPoint(days.get(key),daysmap.get(key),0,"","");
				dps.add(dp);
			}
			rset.close();
			stmt.close();
			conn.close();
			return dps;
		} catch (SQLException ex) {
			ex.printStackTrace();
			List<DataPoint> dps= new ArrayList<DataPoint>();
			return dps;
		}
	}

	public List<BeanDoughnut> getSentiments(String postIDs){
		List<BeanDoughnut> data= new ArrayList<>();

		try {

			Calendar currentCal = Calendar.getInstance();
			int year = currentCal.get(Calendar.YEAR);
			Connection conn = getConn();
			for(int i = year; i > year-3; i--)
			{
				String sdate = i+"-01-01";
				String edate = (i)+"-12-31";
				String query="SELECT sum(posemo) as pos, sum(anx) as anx, sum(anger) as ang, sum(sad) as sad FROM blogtrackers.liwc where blogpostid in "+postIDs+" and date >= '"+sdate+"' and date<= '"+edate+"'";
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
			return data;
		}catch (Exception e) {
			return null;
		}

	}

	public ArrayList<DomainLink> getMostFrequentLinks(String postIDs)
	{
		ArrayList<DomainLink> urllinks= new ArrayList<>();
		try {
			String querystr = "select link, count(*) as rank from outlinks where blogpost_id in "+postIDs+" group by link order by count(*) desc";
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(querystr);
			while (rs.next()) {
				String url = rs.getString("link");
				int rank= rs.getInt("rank");
				DomainLink dm = new DomainLink(url,rank);
				urllinks.add(dm);
			}
			rs.close();
			stmt.close();
			conn.close();
			return urllinks;
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return null;
	}

	public ArrayList<DomainLink> getMostFrequentDomains(String postIDs)
	{
		ArrayList<DomainLink> urllinks= new ArrayList<>();
		try {
			String querystr = "select domain, count(*) as rank from outlinks where blogpost_id in "+postIDs+" group by domain order by count(*) desc";
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(querystr);
			while (rs.next()) {
				String url = rs.getString("domain");
				int rank= rs.getInt("rank");
				DomainLink dm = new DomainLink(url,rank);
				urllinks.add(dm);
			}
			rs.close();
			stmt.close();
			conn.close();
			return urllinks;
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		return null;
	}

	public List<ChartPoint> getAvgMonthlyFrequency(String postIDs)
	{
		HashMap<String,Integer> hm = new HashMap<String,Integer>();
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
					hm.put(key,0);
				}
			}
			String querystr = "select date from blogposts where blogpost_id in "+postIDs+" and date between '"+sdate+"' and '"+edate+"'";
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(querystr);
			while(rset.next())
			{
				java.util.Date postdate= rset.getDate("date");
				Calendar cal = Calendar.getInstance();
				cal.setTime(postdate);
				int month = cal.get(Calendar.MONTH);
				int dateyear = cal.get(Calendar.YEAR);
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
						if(point.interval.equalsIgnoreCase(months.get(month+1)))
						{
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
					}
					if(!flag)
					{
						dps.add(cp);
					}
				}        
			}
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
			System.out.println("avg months Done");
			return dps;
		} catch (SQLException ex) {
			List<ChartPoint> dps= new ArrayList<ChartPoint>();
			return dps;
		}
	}

	@SuppressWarnings("unchecked")
	public ArrayList<JSONObject> getBloggerNames(String selectedSites){
		ArrayList<JSONObject> arrayList= new ArrayList<>();
		try
		{
			Connection conn = getConn();
			Statement stmt = conn.createStatement();

			String querystr = "select distinct blogger from blogposts where "+selectedSites+" and blogger not like '' order by blogger limit 50";

			ResultSet rset = stmt.executeQuery(querystr);
			while(rset.next())
			{ 
				String blogger=rset.getString("blogger");
				JSONObject object= new JSONObject();
				object.put("blogger", blogger);
				arrayList.add(object);
			}
			rset.close();
			stmt.close();
			conn.close();
			return arrayList;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	
	public ArrayList<JSONObject> searchBlogger(String term){
		ArrayList arrayList= new ArrayList();
		try
		{
			Connection conn = getConn();
			Statement stmt = conn.createStatement();

			String querystr = "select distinct blogger from blogposts where blogger like '%"+term+"%' and blogger not like '' order by blogger limit 50";

			ResultSet rset = stmt.executeQuery(querystr);
			while(rset.next())
			{ 
				String blogger=rset.getString("blogger");
				JSONObject object= new JSONObject();
				object.put("blogger", blogger);
				arrayList.add(blogger);
			}
			rset.close();
			stmt.close();
			conn.close();
			return arrayList;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	public ArrayList<JSONObject> getDetail(String blogger_name){
		ArrayList arrayList= new ArrayList();
		try
		{
			Connection conn = getConn();
			Statement stmt = conn.createStatement();
			ArrayList result=new ArrayList();  	
			String querystr = "select distinct * from blogposts where blogger = '"+blogger_name+"' and blogger not like '' order by blogger limit 2";
			ResultSet rset = stmt.executeQuery(querystr);

			ResultSetMetaData rsmd = rset.getMetaData();
			int column_size = rsmd.getColumnCount();
			int i=0;
			while(rset.next()){
				ArrayList output=new ArrayList();
				int total=column_size;//rs.getFetchSize();
				//rs.
				for(int j=1;j<=(total); j++ ){
					output.add((j-1), rset.getString(j));
					
				}
				result.add(i,output);
				i++;
			}
			
			rset.close();
			stmt.close();
			conn.close();
			return result;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	
	
	public ArrayList<BeanBloggerDetails> searchBloggerDetails(String authorName) throws JSONException{
		ArrayList<BeanBloggerDetails> postIDList= new ArrayList<>();
		try
		{
			Connection conn = getConn();
			Statement stmt = conn.createStatement();

			String querystr = "SELECT a.*, blogsite_name,blogsite_url, last_cleaned, description FROM blogtrackers.blogsites JOIN (select max(influence_score) as score, blogger, blogsite_id from blogtrackers.blogposts where blogger = '"+authorName+"' Group by blogsite_id) a On a.blogsite_id =blogsites.blogsite_id;";

			ResultSet rset = stmt.executeQuery(querystr);
			while(rset.next())
			{ 
				String blogger=rset.getString("blogger");
				String siteName=rset.getString("blogsite_name");
				String siteURL=rset.getString("blogsite_url");
				String lastCleaned= rset.getString("last_cleaned");
				String description= rset.getString("description");
				int maxInfluence= rset.getInt("score");
				BeanBloggerDetails jsonObject= new BeanBloggerDetails(blogger, siteName, siteURL, lastCleaned, description, maxInfluence);

				postIDList.add(jsonObject);
			}
			rset.close();
			stmt.close();
			conn.close();
			return postIDList;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		BloggerInfoDialog dialog= new BloggerInfoDialog();
		System.out.println(dialog.getBloggerNames(""));

	}

}