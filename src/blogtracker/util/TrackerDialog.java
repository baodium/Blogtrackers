/**
 * 
 */
package blogtracker.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

import blogtracker.gui.blogtrackers.BeanAllSites;
import blogtracker.gui.blogtrackers.sitesDialog;


/**
 * @author msaadghouri
 *
 */
public class TrackerDialog extends UtilFunctions{


	public boolean addTracker(String userID,String trackerName,String dateCreated,
			String dateModified,String sqlQuery,String trackerDescription,int blogsitesNumber)
	{
		Connection conn = getConn();
		String queryStr = "INSERT INTO trackers(userid,tracker_name,date_created,date_modified,query,description,blogsites_num) VALUES(?,?,?,?,?,?,?)";

		try{
			PreparedStatement pstmt = conn.prepareStatement(queryStr);
			pstmt.setString(1, userID);
			pstmt.setString(2, trackerName);
			pstmt.setString(3, dateCreated);
			pstmt.setString(4, dateModified);
			pstmt.setString(5, sqlQuery);
			pstmt.setString(6, trackerDescription);
			pstmt.setInt(7, blogsitesNumber);
			pstmt.execute();
			pstmt.close();
			return true;
		}catch(SQLException e)
		{
			e.printStackTrace();
			return false;
		}
	}
    public String getTrackerIDByName(String username, String trackername)
    {
    String queryData=null;	
    Connection conn = getConn();
    String queryStr = "select tid from trackers where userid='"+username+"'and tracker_name='"+trackername+"' LIMIT 1";
    try{
    Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery(queryStr);
	while (rset.next())
	{
	queryData = rset.getString("tid");
	}
	rset.close();
	stmt.close();
	conn.close();
	System.out.println(queryData);
	System.out.println(username);
    return queryData;
    }
    catch(SQLException ex)
    {	
    Logger.getLogger(sitesDialog.class.getName()).log(Level.SEVERE, null, ex);	
    return null;
    }
    }
	public String getSelectedSites(String userName, String trackerName)
	{
		String queryData=null;
		try {
			Connection conn = getConn();
		
			String queryStr="select query from trackers where userid='"+userName+"' and tracker_name='"+trackerName+"'";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			while (rset.next())
			{
				queryData = rset.getString("query");
			}
			rset.close();
			stmt.close();
			conn.close();
			System.out.println("I see This");
			System.out.println(userName);
			System.out.println(trackerName);
			System.out.println(queryData);
			return queryData;
			
			
		} catch (SQLException ex) {
			Logger.getLogger(sitesDialog.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}
	}

	public ArrayList<BeanAllSites> getSiteNames(String sites){
		ArrayList<BeanAllSites> arrayList=new ArrayList<>();
		try {
			Connection conn = getConn();
			String queryStr="select blogsite_name,blogsite_id from blogtrackers.blogsites where "+sites+"";
			Statement stmt = conn.createStatement();
			ResultSet rset = stmt.executeQuery(queryStr);
			while (rset.next())
			{
				String siteName = rset.getString("blogsite_name");
				int siteID=rset.getInt("blogsite_id");
				System.out.println(siteID + siteName);
				BeanAllSites allSites= new BeanAllSites(siteName, siteID);
				arrayList.add(allSites);
			}
			rset.close();
			stmt.close();
			conn.close();
			return arrayList;
		} catch (SQLException ex) {
			Logger.getLogger(sitesDialog.class.getName()).log(Level.SEVERE, null, ex);
			return null;
		}
	}
}



