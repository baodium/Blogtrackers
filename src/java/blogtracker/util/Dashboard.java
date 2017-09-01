package blogtracker.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;


public class Dashboard extends UtilFunctions
{
	String query;
	public Dashboard(String username, String trackername){ 
		try{
			Connection conn = getConn();
			String queryStr = "select query from blogtrackers.trackers where userid = \'"+ username +"\' and tracker_name = \'" + trackername + "\'";
			//String queryStr = "select count(distinct blogsite_id) AS nsites from blogsites";

			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			this.query = rs.getString("query");
		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("deprecation")
	public int getnblogs(Date date,String username, String trackername)
	{
				
		java.sql.Date sqldate = new java.sql.Date(date.getTime());
		int blogs;
		try{
			Connection conn = getConn();
			
			Statement st = conn.createStatement();
			String queryStr = "select count(*) as count1 from blogtrackers.blogsites where " + query +" and last_crawled >"+sqldate;
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			blogs = rs.getInt("count1");
			rs.close();
			st.close();
			conn.close();
		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return blogs;
		
		
}

	public int getnblogs(String username,String trackername)
	{
		int blogs;
		try{

			Connection conn = getConn();

			Statement st = conn.createStatement();
			String queryStr = "select count(*) as count1 from blogtrackers.blogsites where " + query;
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			blogs = rs.getInt("count1");
			rs.close();
			st.close();
			conn.close();

		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return blogs;

	}

	public int getnblogposts(String username, String trackername)
	{

		int blogposts;
		try{


			Connection conn = getConn();
			Statement st = conn.createStatement();
			String queryStr = "select count(*) as count1 from blogtrackers.blogposts where " + query;
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			blogposts = rs.getInt("count1");
			rs.close();
			st.close();
			conn.close();

		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return blogposts;
	}


	public int getnblogposts(Date date,String username, String trackername)
	{
		java.sql.Date sqldate = new java.sql.Date(date.getTime());
		int blogposts;
		try{


			Connection conn = getConn();
			Statement st = conn.createStatement();
			String queryStr = "select count(*) as count1 from blogtrackers.blogposts where " + query+" and date >"+sqldate;
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			blogposts = rs.getInt("count1");
			rs.close();
			st.close();
			conn.close();

		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return blogposts;
	}

	public int getnbloggers(String username,String trackername)
	{
		int bloggers;
		try{
			Connection conn = getConn();
			Statement st = conn.createStatement();
			String queryStr = "select count(distinct blogger) as count1 from blogtrackers.blogposts where " + query;
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			bloggers = rs.getInt("count1");
			rs.close();
			st.close();
			conn.close();

		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return bloggers;
	}


	public int getnbloggers(Date date,String username, String trackername)
	{
		
		java.sql.Date sqldate = new java.sql.Date(date.getTime());
		int bloggers;
		try{
			Connection conn = getConn();
			Statement st = conn.createStatement();
			String queryStr = "select count(distinct blogger) as count1 from blogtrackers.blogposts where " + query+"and date >"+sqldate;
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			bloggers = rs.getInt("count1");
			rs.close();
			st.close();
			conn.close();

		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return bloggers;
	}

	public double getnpsenti(String username, String trackername)
	{
		double psentiment;
		try{
			Connection conn = getConn();
			Statement st = conn.createStatement();
			String queryStr = "select sum(sentiment) as count1 from blogtrackers.blogposts where sentiment > 0 and  " + query;
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			psentiment = rs.getInt("count1");
			rs.close();
			st.close();
			conn.close();

		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return psentiment;
	}

	public double getnpsenti(Date date,String username, String trackername)
	{
		
		java.sql.Date sqldate = new java.sql.Date(date.getTime());
		double psentiment;
		try{
			Connection conn = getConn();
			Statement st = conn.createStatement();
			String queryStr = "select sum(sentiment) as count1 from blogtrackers.blogposts where sentiment > 0 and  " + query+" and date >"+sqldate;
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			psentiment = rs.getInt("count1");
			rs.close();
			st.close();
			conn.close();

		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return psentiment;
	}


	public double getnnsenti(String username, String trackername)
	{
		double nsentiment;
		try{
			Connection conn = getConn();
			Statement st = conn.createStatement();
			String queryStr = "select sum(sentiment) as count1 from blogtrackers.blogposts where sentiment < 0 and  " + query;
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			nsentiment = rs.getInt("count1");
			rs.close();
			st.close();
			conn.close();

		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return nsentiment;
	}

	public double getnnsenti(Date date,String username, String trackername)
	{
		
		java.sql.Date sqldate = new java.sql.Date(date.getTime());
		double nsentiment;
		try{
			Connection conn = getConn();
			Statement st = conn.createStatement();
			String queryStr = "select sum(sentiment) as count1 from blogtrackers.blogposts where sentiment < 0 and  " + query+"and date >"+sqldate;
			ResultSet rs = st.executeQuery(queryStr);
			rs.next();
			nsentiment = rs.getInt("count1");
			rs.close();
			st.close();
			conn.close();

		} catch (SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return -1;
		}
		return nsentiment;
	}


	public ArrayList<ArrayList<String>> getnlocation(Date d, String username,String trackername)
	{
		
		
		ArrayList<ArrayList<String>> a = new ArrayList<ArrayList<String>>(); 

		try {
		Connection conn = getConn();

		Statement st = conn.createStatement();
	    String queryStr = "select count(location) as nloc, location from blogtrackers.blogsites where "+query+"group by location order by nloc desc";

		
			
	    ResultSet rs = st.executeQuery(queryStr);
			while(rs.next())
			{
				ArrayList<String> b = new ArrayList<String>();
				b.add(rs.getString("nloc"));
				b.add(rs.getString("location"));
				a.add(b);

			}

			rs.close();
			st.close();
			conn.close();
			return a;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return a;
		}

	}




	public ArrayList<ArrayList<String>> getnlanguage(String username, String trackername)
	{
		ArrayList<ArrayList<String>> a = new ArrayList<ArrayList<String>>();
		
		try{
			Connection conn = getConn();
			Statement st = conn.createStatement();
			String queryStr = "select count(language) AS nlanguage, language from blogtrackers.blogposts where "+ query + "group by language order by nlanguage desc";
			ResultSet rs = st.executeQuery(queryStr);
			while(rs.next())
			{
				ArrayList<String> b = new ArrayList<String>();
				b.add(rs.getString("nlanguage").toString());
				b.add(rs.getString("language"));
				a.add(b);

			}
			rs.close();
			st.close();
			conn.close();
			return a;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return a;
		}
	}
	public ArrayList<ArrayList<String>> tree_result(String username, String trackername)
	{
		ArrayList<ArrayList<String>> a = new ArrayList<ArrayList<String>>();
		ArrayList<ArrayList<String>> a1 = new ArrayList<ArrayList<String>>();
		ArrayList<String>  site_id = new ArrayList<String>();
		HashMap<Integer,String> site =new HashMap<Integer,String>(); 
		try{
			Connection conn = getConn();

			Statement st = conn.createStatement();
			String queryStr = "select blogsite_id,blogsite_name,totalposts from blogtrackers.blogsites where "+ query ;
			ResultSet rs = st.executeQuery(queryStr);
			
			
			while(rs.next())
			{
				ArrayList<String> b = new ArrayList<String>();
				b.add(rs.getString("blogsite_id").toString());
				b.add(rs.getString("blogsite_name").toString());
				b.add(trackername);
				b.add("null");
				b.add(rs.getString("totalposts"));
				site_id.add(rs.getString("blogsite_id").toString());
				site.put(rs.getInt("blogsite_id"), rs.getString("blogsite_name"));
				a.add(b);
			}
			
		    
			queryStr ="select blogsite_id, blogpost_id,blogger, post from blogtrackers.blogposts where " + query ;
			System.out.println(" "+queryStr);
		    rs = st.executeQuery(queryStr);
		    while(rs.next())
		    {
		    	ArrayList<String> b = new ArrayList<String>();
				b.add(rs.getString("blogsite_id").toString());
				b.add(site.get(Integer.parseInt(rs.getString("blogsite_id"))));
				b.add(rs.getString("blogpost_id").toString());
				b.add(rs.getString("blogger").toString());
				b.add(rs.getString("post").toString());
				a1.add(b);    
		    }
		   	    
		    
			for(int i=0;i<site_id.size();i++)
			{
				HashMap<String,Integer> bloggers =new HashMap<String,Integer>();
				for(int j=0;j<a1.size();j++)
				{	
					if(site_id.get(i).equals(a1.get(j).get(0)))
					{
						if(bloggers.containsKey(a1.get(j).get(3)))
						{
							bloggers.put(a1.get(j).get(3),Integer.parseInt(bloggers.get(a1.get(j).get(3)).toString())+1);
						}
						else
						{
							bloggers.put(a1.get(j).get(3),1);
						}
					}
				}
				
				for (HashMap.Entry<String, Integer> entry : bloggers.entrySet()) {
				ArrayList<String> b = new ArrayList<String>();
				b.add(site_id.get(i));
				b.add(entry.getKey());
				b.add(site.get(  Integer.parseInt(site_id.get(i)) ));
				b.add(entry.getValue().toString());
				a.add(b);
				}
			}
			
		    
			return a;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return a;
			}
	}	
}