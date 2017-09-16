/*
 * sitesDialog.java
 *
 * Created on May 13, 2008, 1:32 AM
 */

package blogtracker.gui.blogtrackers;

/**
 *
 * @author  skumar34
 * @subauthor msaadghouri
 */
import blogtracker.util.UtilFunctions;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class sitesDialog extends UtilFunctions{

	public ArrayList<BlogSites2> getBlogSites()
	{
		ArrayList<BlogSites2> sites = new ArrayList<BlogSites2>();
		try {
			Connection conn = getConn();
			//String queryStr = "select a.blogsite_id, a.blogsite_name, a.site_type,count(post) from blogsites a left join blogposts b on a.blogsite_id = b.blogsite_id group by a.blogsite_id order by a.blogsite_name";
			String queryStr="select blogsite_id, blogsite_name, site_type, totalposts from blogsites order by blogsite_name";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			while (rset.next())
			{

				String siteName = rset.getString("blogsite_name");
				int siteID = rset.getInt("blogsite_ID");
				String siteType = rset.getString("site_type");
				int count = rset.getInt("totalposts");
				BlogSites2 bsites = new BlogSites2(siteName,siteID,siteType,count,false);
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
	public ArrayList<BlogSites2> getBlogSitesBasedOnKeyword(String searchText)
	{
		ArrayList<BlogSites2> sites = new ArrayList<BlogSites2>();
		try {
			Connection conn = getConn();
			//String queryStr = "select a.blogsite_id, a.blogsite_name, a.site_type,count(post) from blogsites a left join blogposts b on a.blogsite_id = b.blogsite_id group by a.blogsite_id order by a.blogsite_name";
			// String queryStr="select blogsite_id, blogsite_name, site_type, totalposts from blogsites order by blogsite_name";
			String queryStr= "select blogsite_id,blogsite_name,totalposts from blogsites where blogsite_id in (select distinct blogsiteid from terms where term in " +searchText+") order by blogsite_name";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			while (rset.next())
			{
				String siteName = rset.getString("blogsite_name");
				int siteID = rset.getInt("blogsite_ID");
				int count = rset.getInt("totalposts");
				BlogSites2 bsites = new BlogSites2(siteName,siteID,"",count,false);
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

}