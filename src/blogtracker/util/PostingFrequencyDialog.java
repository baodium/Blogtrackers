/**
 * 
 */
package blogtracker.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import blogtracker.gui.blogtrackers.BeanBlogTitlePost;
import blogtracker.gui.blogtrackers.BeanTopBlogger;
import blogtracker.gui.blogtrackers.BeanTopEntities;
import blogtracker.gui.blogtrackers.BeanTopKeywords;
import blogtracker.gui.blogtrackers.getTagPost;
import blogtracker.gui.blogtrackers.sitesDialog;

/**
 * @author msaadghouri
 *
 */
public class PostingFrequencyDialog extends UtilFunctions{
	public ArrayList<BeanTopBlogger> getTopBlogger(String startDate, String endDate, String selectedSites)
	{
		ArrayList<BeanTopBlogger> sites = new ArrayList<BeanTopBlogger>();
		try {
			Connection conn = getConn();
			String queryStr="select count(*) as numb, blogger from blogposts where "+ selectedSites +" and date >= '"+startDate+"' AND date <= '"+endDate+"' group by blogger order by numb desc limit 15";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			while (rset.next())
			{
				String bloggerName = rset.getString("blogger");
				int blogCount = rset.getInt("numb");
				BeanTopBlogger bsites = new BeanTopBlogger(bloggerName,blogCount);
				sites.add(bsites);
			}
			rset.close();
			stmt.close();
			conn.close();
			return sites;
		} catch (SQLException ex) {
			Logger.getLogger(sitesDialog.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}
	}
	public ArrayList<BeanTopKeywords> getTopKeywords(String startDate,String endDate,String selectedSites)
	{
		System.out.println("ArrayList<BeanTopKeywords> getTopKeywords");
		ArrayList<BeanTopKeywords> keywords = new ArrayList<BeanTopKeywords>();
		try {
			Connection conn = getConn();
			selectedSites = selectedSites.replace("blogsite_id in ", "");
			String queryStr="select term,frequency from blogtrackers.terms where blogsiteid in "+ selectedSites +" and date >= '"+startDate+"' AND date <= '"+endDate+"' group by term order by frequency desc limit 40;";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			System.out.println("Query Eexecuted");
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

	public ArrayList<BeanBlogTitlePost> fillblogpost(String startDate,String endDate,String selectedSites)
	{
		try {
			System.out.println("ArrayList<BeanBlogTitlePost> fillblogpost");
			String querystr = "select title,post from blogposts where "+selectedSites+" and date >= '"+startDate+"' AND date <= '"+endDate+"'";
			Connection conn = getConn();
			ArrayList<BeanBlogTitlePost> posts = new ArrayList<BeanBlogTitlePost>();
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(querystr);
			System.out.println("Query Eexecuted");
			while(rset.next())
			{   
				String title = rset.getString("title");
				String post = rset.getString("post");
				posts.add(new BeanBlogTitlePost(title,post));
			}
			conn.close();
			return posts;
		} catch (SQLException ex) {
			Logger.getLogger(getTagPost.class.getName()).log(Level.SEVERE, null, ex);
		}
		return null;

	}
	//	public static void main(String[] args)
	//	{
	//		PostingFrequencyDialog gp =  new PostingFrequencyDialog();
	//		ArrayList<Integer> aa =new ArrayList<Integer>();
	//		aa.add(8);
	//		ArrayList<BeanTopEntities> bp= gp.getTopEntities("2014-01-01", "2015-01-01", "blogsite_id in (8)");
	//
	//	}

	public ArrayList<BeanTopEntities> getTopEntities(String startDate,String endDate,String selectedSites)
	{
		ArrayList<BeanTopEntities> entities = new ArrayList<BeanTopEntities>();
		try {
			Connection conn = getConn();
			String queryStr="select entity, type, count(*) as count,SUM(CASE WHEN sentiment<0 THEN sentiment ELSE 0 END) as NegativeTotal, SUM(CASE WHEN sentiment>=0 THEN sentiment ELSE 0 END) as PostiveTotal from blogtrackers.blogpost_entitysentiment where blogpost_id in (select blogpost_id from blogtrackers.blogposts where "+selectedSites+" and date between '"+startDate+"' and '"+endDate+"') group by entity order by count(*) desc";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			while (rset.next())
			{
				String entityName = rset.getString("entity");
				String type = rset.getString("type");
				int freq = rset.getInt("count");
				float posSenti= rset.getFloat("PostiveTotal");
				float negSenti= rset.getFloat("NegativeTotal");
				System.out.println(negSenti +"  "+posSenti);
				entities.add(new BeanTopEntities(entityName,type,freq,posSenti,negSenti));
			}
			rset.close();
			stmt.close();
			conn.close();
			return entities;
		} 
		catch (SQLException ex) {
			Logger.getLogger(sitesDialog.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}
	}
}
