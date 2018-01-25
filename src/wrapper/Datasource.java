package wrapper;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import blogtracker.gui.blogtrackers.BeanAllSites;
import blogtracker.gui.blogtrackers.BlogSites2;
import blogtracker.gui.blogtrackers.sitesDialog;
import blogtracker.util.Common;
import blogtracker.util.TrackerDialog;

/**
 * Servlet implementation class Datasource
 * @author msaadghouri
 */
@WebServlet("/Datasource")
public class Datasource extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public ArrayList<BlogSites2> bs;
	Common c = new Common();
	TrackerDialog trackerDialog = new TrackerDialog();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Datasource() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		if(request.getParameter("tracker")!=null){
			session.setAttribute("tracker",request.getParameter("tracker"));	
		}
		//		String tracker=request.getParameter("tracker");

		if(session.getAttribute("tracker")!=null){
			String userName = (String) session.getAttribute("user");
			String selectedSites=trackerDialog.getSelectedSites(userName,(String) session.getAttribute("tracker"));

			ArrayList<BeanAllSites> allSites=trackerDialog.getSiteNames(selectedSites);
//			System.out.println(allSites);
			if(session.getAttribute("bsName")!=null)
				session.removeAttribute("bsName");
			session.setAttribute("allSepSites", allSites);
		}
		response.setContentType("text/html");
		response.sendRedirect("data.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/////////////////////////////////////////
		request.setCharacterEncoding("UTF-8");
		/////////////////////////////////////////
		if(request.getParameter("Save")!=null){
			HttpSession session= request.getSession();
			String userName = (String) session.getAttribute("user");
			String trackerName=request.getParameter("title");
			if(!trackerName.trim().isEmpty()){

				String trackerDescription=request.getParameter("descr");
				String createdDate= getDateTime();
				String[] selectedSite = request.getParameterValues("table_records");
				String listString = "";
				if(selectedSite.length>0){
					for (int i = 0; i < selectedSite.length; i++) { 
						listString += selectedSite[i] + ",";
					}
					listString="blogsite_id in ("+listString.substring(0, listString.length()-1)+")";
				}else{
					listString="blogsite_id in (0)";
				}
				TrackerDialog dialog= new TrackerDialog();
				dialog.addTracker(userName, trackerName, createdDate, null, listString, trackerDescription, selectedSite.length);

				ArrayList<String> trackers = c.gettrackers(userName);
				session.setAttribute("trackers", trackers);
				session.removeAttribute("sites");
				session.removeAttribute("searched");
				Dashboard dashboard = new Dashboard();
				dashboard.doGet(request, response);
			}
			else{
				response.setContentType("text/html");
				response.sendRedirect("data.jsp");
			}
			//
			//			response.sendRedirect("Dashboard.jsp");
		}else if(request.getParameter("searchButton")!=null){
			HttpSession session= request.getSession();

			String searchText = request.getParameter("searchText");
//			System.out.println(searchText);
			if(!searchText.trim().isEmpty()){
				session.setAttribute("searched", "about "+searchText);
				StringTokenizer st = new StringTokenizer(searchText, ",");
				String s="";
				while (st.hasMoreElements()) {
					s=s+ "'"+ st.nextElement()+"',";
				}
				s = "("+s.substring(0,s.length()-1)+")";
				sitesDialog siteDialog = new sitesDialog();
				bs = siteDialog.getBlogSitesBasedOnKeyword(s);
				session.setAttribute("sites", bs);
			}
			response.setContentType("text/html");
			response.sendRedirect("data.jsp");
		}
	}

	private String getDateTime() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		return dateFormat.format(date);
	}
}
