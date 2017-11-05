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

import blogtracker.gui.blogtrackers.JSONEntities;
import wrapper.ExportJSON;

/**
 * This class(ExportJSONDialog) is used for fetching required fields for JSON export
 * based on queries from Blogtrackers DB
 * @author Kiran
 */
public class ExportJSONDialog extends UtilFunctions{
	
	/**
	 * Returns an Integer object value that can then be displayed as count of records on the screen 
	 * for a particular date range. The arguments must specify a queryTracker and Date range. 
	 * This method always returns immediately, whether or not the data exists. When date range and tracker 
	 * are selected, this method attempts to return count of records to the screen, the data will be loaded. 
	 *
	 * @param  queryTracker the blogid's for selected tracker
	 * @param  startDate 	user selected start date in date range
	 * @param  endDate 		user selected end date in date range
	 * @return      		the count of records in Integer type based on date range selected
	 * @see         		Integer
	 */
	public Integer getCount(String queryTracker, String startDate, String endDate)
	{
		try {
			//appending "p." here since table blogtrackers.blogposts is aliased as "p"
			String qTracker = "p." + queryTracker;
			Connection conn = getConn();
			int recordCount=0;
			String count ="SELECT COUNT(*) as numb from blogtrackers.blogposts p, blogtrackers.blogsites s, blogtrackers.liwc l where s.blogsite_id = p.blogsite_id and l.blogpostid = p.blogpost_id and "+ qTracker + " and p.date >= '"+startDate+"' AND p.date <= '"+endDate+"' ";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(count);
			while (rset.next())
			recordCount = rset.getInt("numb");
			rset.close();
			stmt.close();
			conn.close();
			return recordCount;
		} 
		catch (SQLException ex) {
			Logger.getLogger(ExportJSON.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}
	}

	/**
	 * Returns an ArrayList of JSONEntities that can then be saved into a JSON file.
	 * The arguments must specify a queryTracker and Date range. 
	 * This method always returns immediately, whether or not the data exists. When date range and tracker 
	 * are selected, this method attempts to return JSONEntities objects in ArrayList. 
	 *
	 * @param  queryTracker the blogid's for selected tracker
	 * @param  startDate 	user selected start date in date range
	 * @param  endDate 		user selected end date in date range
	 * @return      		ArrayList of JSONEntities
	 * @see         		ArrayList<JSONEntities>
	 */
	public ArrayList<JSONEntities> getFieldsJSON(String queryTracker, String startDate, String endDate)
	{
		ArrayList<JSONEntities> jsonEntities = new ArrayList<JSONEntities>();
		try {
			//appending "p." here since table blogtrackers.blogposts is aliased as "p"
			String qTracker = "p." + queryTracker;
			Connection conn = getConn();
			String queryStr="select s.blogsite_name as BlogSiteName, p.blogger as Blogger, p.title as Title, p.post as Post, p.date as PostingDate, p.comments_url as Comments, l.posemo as PositiveEmotion, l.negemo as NegativeEmotion, p.language as Language, p.permalink as Permalink, s.location as Location from blogtrackers.blogposts p, blogtrackers.blogsites s, blogtrackers.liwc l where s.blogsite_id = p.blogsite_id and l.blogpostid = p.blogpost_id and "+qTracker + " and p.date >= '"+startDate+"' AND p.date <= '"+endDate+"' ";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			while (rset.next())
			{
				String BlogSiteName = rset.getString("BlogSiteName");
				String Blogger = rset.getString("Blogger");
				String Title = rset.getString("Title");
				String Post = rset.getString("Post");
				String PostingDate = rset.getString("PostingDate");
				int PositiveEmotion = rset.getInt("PositiveEmotion");
				int NegativeEmotion = rset.getInt("NegativeEmotion");
				String Language = rset.getString("Language");
				String Location = rset.getString("Location");
				String Comments = rset.getString("Comments");
				String Permalink = rset.getString("Permalink");
				
				if (Comments == null)
					Comments ="";
				jsonEntities.add(new JSONEntities(BlogSiteName,Blogger,Title,Post,PostingDate,Comments,PositiveEmotion,NegativeEmotion,Location,Language,Permalink));
			}
			stmt.close();
			conn.close();
			return jsonEntities;
		} 
		catch (SQLException ex) {
			Logger.getLogger(ExportJSON.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}
	}
}