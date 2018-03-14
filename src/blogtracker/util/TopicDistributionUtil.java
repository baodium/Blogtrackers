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

import java.util.*;
import java.io.File;
import java.io.PrintWriter;
import java.io.FileNotFoundException;

public class TopicDistributionUtil extends UtilFunctions {

	
// fetches all 
public void GetTopicAllTopics(Date startDate, Date endDate,String username, String trackername) throws IOException
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
	queryStr  = "select title,post,date,influence_score from blogtrackers.blogposts where date >=\'"+sqldate1+"\' and date<=\'"+sqldate2+"\' and "+query;
	st = conn.createStatement();
	rs = st.executeQuery(queryStr);
	
		//String relativeWebPath = "/images";
		//String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
	
		String path=  new File(".").getCanonicalPath();//"assets/";   //application.getRealPath("/").replace('\\', '/')+"assets/";
		path = path.replace("build/", "");
		String filePath = path;//"c:/apache-tomcat/";
		
	   PrintWriter pw = new PrintWriter(new File(filePath+"test.csv"));
       StringBuilder sb = new StringBuilder();

	
	int k=0;
	while(rs.next())
	{
		k++;
	String title = rs.getString("title");
	String weight = rs.getString("influence_score");
	String date = rs.getString("date");
//	String post = rs.getString("post");
	System.out.println(title);
	
	sb.append(k);
    sb.append(',');
    sb.append(title);
    sb.append('\n');
    sb.append(weight);
    sb.append('\n');
    sb.append(date);
    sb.append('\n');
//	System.out.println(post);
	}
	
	
	
	pw.write(sb.toString());
    pw.close();
    
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
