/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package blogtracker.gui.blogtrackers;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import blogtracker.util.KeywordResult;
import blogtracker.util.UtilFunctions;

/**
 *12/7/2010
 * @author skumar34
 * @info this class generates the trend information for provided keyword
 */
public class KeywordTrends extends UtilFunctions
{
	public KeywordTrends()
	{
		//empty constructor for Flex to instantiate this class.
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




	public KeywordResult getchartpoints(Date startDate,Date endDate, String selectedsites, String keywords) throws SQLException
	{

		KeywordResult k = new KeywordResult();

		java.sql.Date sqldate1 = new java.sql.Date(startDate.getTime());
		java.sql.Date sqldate2 = new java.sql.Date(endDate.getTime());

		Connection conn= getConn();
		String postsearchquery = PreparePostSearchQuery(keywords);
		String queryStr = "SELECT blogpost_id,title,post " +
				"FROM blogposts " +
				"WHERE "+selectedsites+"AND (date >= '" + sqldate1 +
				"' AND date <= '" + sqldate2 + "') AND "+postsearchquery;	
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(queryStr);
		ArrayList<ArrayList<String>> titles = new  ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<String>> post = new  ArrayList<ArrayList<String>>();
		int count=0;
		while(rs.next())
		{
			ArrayList<String> t = new ArrayList<String>();
			ArrayList<String> p = new ArrayList<String>();
			t.add(String.valueOf(rs.getInt("blogpost_id")));
			t.add(rs.getString("title"));
			p.add(String.valueOf(rs.getInt("blogpost_id")));
			p.add(rs.getString("post"));
			titles.add(t);
			post.add(p);
			count=count+1;
		}

		k.titles=titles;
		k.post=post;
		k.count=count;
		k.date=sqldate1.toString();
		
		rs.close();
		st.close();
		conn.close();
		return k;

	}

	private String PreparePostSearchQuery(String keyword)
	{
		String[] keywordparts = BreakKeywordIntoParts(keyword);
		String postquery = "(";
		for(int i=0;i<keywordparts.length;i++)
		{           
			if(i==keywordparts.length-1)
			{
				String t = keywordparts[i];
				t=t.replaceAll("\\s+","");
				keywordparts[i]=t;
				keywordparts[i]=keywordparts[i].replaceAll("\\s+","");
				postquery = postquery+"post like '%"+keywordparts[i]+"%')";
				continue;
			}
			String t = keywordparts[i];
			t=t.replaceAll("\\s+","");
			keywordparts[i]=t;
			postquery = postquery+"post like '%"+keywordparts[i]+"%' or ";
		}
		return postquery;
	}

	private String[] BreakKeywordIntoParts(String keyword)
	{
		keyword = keyword.replaceAll("\\s+", " ");
		keyword = keyword.trim();
		return keyword.split(" ");
	}
}
