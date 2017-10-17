package wrapper;

import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
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

import blogtracker.util.CountryCodes;
/**
 * Servlet implementation class Analytics
 * @author Adekunle
 */
@WebServlet("/Trackerlist")
public class Trackerlist extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Trackerlist() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		StringBuffer trackerurl =  request.getRequestURL();
		if(trackerurl != null)
		{
		//System.out.println(trackerurl);	
		}
		if(session.getAttribute("tracker")==null && request.getParameter("tracker")==null)
		{
			/*session.setAttribute("nblogs", 0);
			session.setAttribute("nblogposts", 0);
			session.setAttribute("nbloggers", 0);
			session.setAttribute("npsenti", 0);
			session.setAttribute("nnsenti", 0);
			session.setAttribute("nloc", "");
			session.setAttribute("data", "");
			session.setAttribute("nlang", "");
			session.setAttribute("nlg", "");
			session.setAttribute("series", "");	*/		
			response.setContentType("text/html");
	    	response.sendRedirect("trackerlist.jsp");
		}
		else
		{	
		
		if(request.getParameter("tracker")!=null)
		{
			String tracker = request.getParameter("tracker");
			session.setAttribute("tracker", tracker);
		}
        response.setContentType("text/html");
		response.sendRedirect("trackerlist.jsp");

		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("tracker")==null && request.getParameter("tracker")==null)
		{
			
			/*session.setAttribute("nblogs", 0);
			session.setAttribute("nblogposts", 0);
			session.setAttribute("nbloggers", 0);
			session.setAttribute("npsenti", 0);
			session.setAttribute("nnsenti", 0);
			session.setAttribute("nloc", "");
			session.setAttribute("data", "");
			session.setAttribute("nlang", "");
			session.setAttribute("series", "");	*/		
			response.setContentType("text/html");
	    	response.sendRedirect("trackerlist.jsp");
		}
		else
		{
			
			if(request.getParameter("tracker")!=null)
			{
				String tracker = request.getParameter("tracker");
				session.setAttribute("tracker", tracker);
			}

		response.setContentType("text/html");
		response.sendRedirect("trackerlist.jsp");
		}
	}
}