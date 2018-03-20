package wrapper;


import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.Month;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonBuilderFactory;
import javax.json.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;

import authentication.DBConnector;
import blogtracker.util.CountryCodes;
import blogtracker.util.TopicDistributionUtil;
import blogtracker.util.BlogClusteringUtil;
import blogtracker.util.BlogClusteringUtil;
import blogtracker.util.TrackerDialog;
/*
 * Servlet Author Adigun Adekunle
 * 
 */

@WebServlet("/BlogClustering")
public class BlogClustering extends HttpServlet  {

	private static final long serialVersionUID = 1L;
	
	public BlogClustering()
	{
		super();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession();
		
		doPost(request,response);
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
	
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		request.setCharacterEncoding("UTF-8");
		// initialized the session ;
		HttpSession session= request.getSession();	
		// check if tracker has been initialized
		// request of tracker
		if(request.getParameter("tracker")!=null)
		{
		String tracker = request.getParameter("tracker");
		String userName = (String) session.getAttribute("user");
		TopicDistributionUtil td = new TopicDistributionUtil();
		
		}
		if(request.getParameter("datepicked") != null)
		{
			try
			{
			String date = request.getParameter("datepicked");
			session.setAttribute("datepicked", date);

			//System.out.println("Filter Value"+filtervalue );
			//System.out.println("Date for Request "+date);
			// addition by adekunle blog network by date range
			date = session.getAttribute("datepicked").toString();
			String arr[] = date.split("-", 2);
			String sdate1 = arr[0];   
			String sdate2 = arr[1];
			sdate2=sdate2.trim();  // date 2 will have space trim it
			int mm1=Month.valueOf(sdate1.substring(0, sdate1.indexOf(' ')).toUpperCase()).getValue();
			int mm2=Month.valueOf(sdate2.substring(0, sdate2.indexOf(' ')).toUpperCase()).getValue();

			String tempdate[] = sdate1.split(" ", 3);
			String dd=tempdate[1];
			String year=tempdate[2];
			String d1 = year+"-"+mm1+"-"+dd;
			d1=d1.replace(" ", "");

			String tempdate2[] = sdate2.split(" ", 3);
			dd=tempdate2[1];
			year=tempdate2[2];
			String d2 = year+"-"+mm2+"-"+dd;
			d2=d2.replace(" ", "");

			DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 

			Date startdate = df.parse(d1);
			Date enddate = df.parse(d2);

	// initalize tracker name and user session
		String tracker = (String) session.getAttribute("tracker");
		String userName = (String) session.getAttribute("user");
		BlogClusteringUtil td = new BlogClusteringUtil();
		td.GetAllBlogPost(startdate, enddate, userName, tracker);
		session.setAttribute("cluster1", "x: [1, 2, 3, 4, 5],y: [1, 6, 3, 6, 1],");
		session.setAttribute("cluster2", "x: [1.5, 2.5, 3.5, 4.5, 5.5], y: [4, 1, 7, 1, 4],"); 
			}
			
			catch(Exception e)
			{
				
			}
	
		}
		
		response.setContentType("text/html;");
		response.sendRedirect("blog_clustering.jsp");
	}

}
