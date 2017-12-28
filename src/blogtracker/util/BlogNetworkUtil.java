package blogtracker.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class BlogNetworkUtil extends UtilFunctions{

	/*public void get(String username, String trackername)
	{
		Connection conn= getConn();
		String queryStr = "select query from blogtrackers.trackers where userid = \'"+ username +"\' and tracker_name = \'" + trackername + "\'";

		Statement st;
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			String query = rs.getString("query");
			queryStr = "select blogsite_id,blogsite_name from blogtrackers.blogsites where "+query;
			st = conn.createStatement();
			rs = st.executeQuery(queryStr);
			HashMap<Integer,String> site =new HashMap<Integer,String>();
			while(rs.next())
			{
				site.put(rs.getInt("blogsite_id"), rs.getString("blogsite_name"));
				
			}
			
			HashMap<String,ArrayList<String>> site_blogger =new HashMap<String,ArrayList<String>>();
			queryStr = "SELECT distinct blogger, blogsite_id from blogtrackers.blogposts where "+query;
			st = conn.createStatement();
			rs = st.executeQuery(queryStr);
			int site_id =0;
			ArrayList<String> temp = new ArrayList<String>();
			
			if(rs.first())
			{
				site_id = rs.getInt("blogsite_id");
				temp.add(rs.getString("blogger"));
			}
			
				while(rs.next())
				{
					
					if(site_id==rs.getInt("blogsite_id"))
					{	
						//System.out.println(" "+rs.getString("blogger"));
						//System.out.println(" again "+rs.getString("blogger"));
						temp.add(rs.getString("blogger"));
						//System.out.println(" "+temp.get(0));
					}
					else
					{	
						site_blogger.put(site.get(site_id), temp);
						System.out.println(" size"+site_blogger.get(site.get(site_id)).size());
						site_id =rs.getInt("blogsite_id");
						temp=new ArrayList<String>();
						temp.add(rs.getString("blogger"));
					}
				}
			
			System.out.println(" "+site_blogger.entrySet());
		//	System.out.println(" "+site_blogger.get(site_id).size());	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}*/
	
	public HashMap<Integer,String> get_bn_sites(String username, String trackername)
	{
		
		Connection conn= getConn();
		String queryStr = "select query from blogtrackers.trackers where userid = \'"+ username +"\' and tracker_name = \'" + trackername + "\'";
		HashMap<Integer,String> site =new HashMap<Integer,String>();
		
		Statement st;
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			String query = rs.getString("query");
			queryStr = "select blogsite_id,blogsite_name from blogtrackers.blogsites where "+query;
			st = conn.createStatement();
			rs = st.executeQuery(queryStr);
			
			HashMap<Integer,Integer> sid =new HashMap<Integer,Integer>();
			int i=1;
			while(rs.next())
			{
				site.put(rs.getInt("blogsite_id"), rs.getString("blogsite_name"));
				sid.put(rs.getInt("blogsite_id"), i++);
			}
			
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return site;
		
	}
	
	public HashMap<Integer,String> get_bn_bloggers(String username, String trackername)
	{
		Connection conn= getConn();
		String queryStr = "select query from blogtrackers.trackers where userid = \'"+ username +"\' and tracker_name = \'" + trackername + "\'";
		HashMap<Integer,String> blogger =new HashMap<Integer,String>();
		
		Statement st;
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			String query = rs.getString("query");
			queryStr = "SELECT distinct blogger, blogsite_id from blogtrackers.blogposts where "+query;
			st = conn.createStatement();
			rs = st.executeQuery(queryStr);
			
			while(rs.next())
			{
				blogger.put(rs.getInt("blogsite_id"), rs.getString("blogger"));
			}
			
	     }
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return blogger;
	}
	
	public HashMap<Integer,String> get_bn_medias(String username, String trackername)
	{
		Connection conn= getConn();
		String queryStr = "select query from blogtrackers.trackers where userid = \'"+ username +"\' and tracker_name = \'" + trackername + "\'";
		HashMap<Integer,String> media =new HashMap<Integer,String>();
		
		Statement st;
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			String query = rs.getString("query");
			queryStr = "SELECT blogsite_id, domain from blogtrackers.outlinks where "+query;
			st = conn.createStatement();
			rs = st.executeQuery(queryStr);
			
			while(rs.next())
			{
				media.put(rs.getInt("blogsite_id"), rs.getString("domain"));
			}
			
	     }
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return media;
	}
	
	public HashMap<String,String> get_bn_media_category(String username, String trackername)
	{
		Connection conn= getConn();
		HashMap<String,String> media =new HashMap<String,String>();
		
		Statement st;
		try {
			String queryStr = "select distinct prescribed_category from blogtrackers.media_categories";
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			
			while(rs.next())
			{
				media.put(rs.getString("prescribed_category"), rs.getString("prescribed_category"));
			}
			
	     }
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return media;
	}
	
	public ArrayList<ArrayList<String>> get_bn_entity(String username, String trackername)
	{
		Connection conn= getConn();
		String queryStr = "select query from blogtrackers.trackers where userid = \'"+ username +"\' and tracker_name = \'" + trackername + "\'";
		ArrayList<ArrayList<String>> en = new ArrayList<ArrayList<String>>();
		
		Statement st;
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			String query = rs.getString("query");
			queryStr = "select blogsite_id,blogpost_id from blogtrackers.blogposts where "+query;
			System.out.println("    "+queryStr);
			st = conn.createStatement();
			rs = st.executeQuery(queryStr);
			HashMap<Integer,Integer> bp =new HashMap<Integer,Integer>();
			String bp_ids ="(";
			
			while(rs.next())
			{
				
				bp_ids = bp_ids+rs.getInt("blogpost_id")+",";
				bp.put(rs.getInt("blogpost_id"), rs.getInt("blogsite_id"));
			}
			
			bp_ids = bp_ids.substring(0, bp_ids.length() - 1);
			bp_ids = bp_ids+")";
			
			queryStr = "select blogpost_id, entity from blogtrackers.blogpost_entitysentiment where blogpost_id in "+bp_ids;
			System.out.println("    "+queryStr);
			st = conn.createStatement();
			rs = st.executeQuery(queryStr);
			
			while(rs.next())
			{
				ArrayList<String> t = new ArrayList<String>();
				t.add(Integer.toString(bp.get(rs.getInt("blogpost_id"))));
				t.add(rs.getString("entity"));
				en.add(t);				
			}
	     }
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return en;
	}	
	
}
