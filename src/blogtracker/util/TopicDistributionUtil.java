package blogtracker.util;
/*
Author: Adigun Adekunle

*/
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Date;

public class TopicDistributionUtil extends UtilFunctions {

public void GetTopicAllTopics(Date startDate, Date endDate,String username, String trackername)
{
Connection conn = getConn();
java.sql.Date sqldate1 = new java.sql.Date(startDate.getTime());
java.sql.Date sqldate2 = new java.sql.Date(endDate.getTime());
Statement st;
String query = "";
try {

	// fetch query from tracker name 
	String queryStr = "select query from trackers where userid=\'"+username+"\' and tracker_name=\'"+trackername+"\'";
	st = conn.createStatement();
	ResultSet rs = st.executeQuery(queryStr);
	rs.next();
	query = rs.getString("query"); 	
	//System.out.println(query);
	
	// fetch title and post content by date
	queryStr  = "select title,post from blogtrackers.blogposts where date >=\'"+sqldate1+"\' and date<=\'"+sqldate2+"\' and "+query;
	st = conn.createStatement();
	rs = st.executeQuery(queryStr);
	
	while(rs.next())
	{
	String title = rs.getString("title");
//	String post = rs.getString("post");
	System.out.println(title);
//	System.out.println(post);
	}
	
	
	
	
	rs.close();
	st.close();
	conn.close();
	
}
catch(SQLException e)
{
e.printStackTrace();	
}



	
}
	
}
