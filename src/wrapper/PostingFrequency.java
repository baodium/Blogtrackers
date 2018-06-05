package wrapper;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import blogtracker.gui.blogtrackers.BeanAllSites;
import blogtracker.gui.blogtrackers.BeanBlogTitlePost;
import blogtracker.gui.blogtrackers.BeanTopBlogger;
import blogtracker.gui.blogtrackers.BeanTopEntities;
import blogtracker.gui.blogtrackers.BeanTopKeywords;
import blogtracker.gui.blogtrackers.DataPoint;
import blogtracker.gui.blogtrackers.getGraphData;
import blogtracker.util.BloggerInfoDialog;
import blogtracker.util.Common;
import blogtracker.util.PostingFrequencyDialog;
import blogtracker.util.TrackerDialog;

/**
 * Servlet implementation class PostingFrequency
 * @author msaadghouri
 */
@WebServlet("/PostingFrequency")
public class PostingFrequency extends HttpServlet {
	private static final long serialVersionUID = 1L;
	PostingFrequencyDialog pfDialog= new PostingFrequencyDialog();
	Common common= new Common();
	TrackerDialog trackerDialog = new TrackerDialog();
	BloggerInfoDialog biDialog= new BloggerInfoDialog();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PostingFrequency() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session= request.getSession();
		if(session.getAttribute("tracker")!=null && session.getAttribute("datepicked")!=null)
		{
			String scale=null;
			if(session.getAttribute("calScale")!=null){
				scale=(String) session.getAttribute("calScale");	
			}else{
				String date=(String) session.getAttribute("datepicked");
				List<String> aa=common.returnDates(date);
				scale=common.returnScale(aa);
			}
			session.setAttribute("errorMessage", "");

			String userName = (String) session.getAttribute("user");
			String trackerName = (String) session.getAttribute("tracker");
			String datePicked = (String) session.getAttribute("datepicked");
			TrackerDialog dialog= new TrackerDialog();
			String selectedSites=dialog.getSelectedSites(userName,trackerName);
			getRequestedData(scale,selectedSites,datePicked,session);
		}

		response.setContentType("text/html");
		response.sendRedirect("posting_frequency.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session= request.getSession();

		if(request.getParameter("tracker")!=null){
			String tracker = request.getParameter("tracker");
			session.setAttribute("tracker", tracker);
			String userName = (String) session.getAttribute("user");
			String selectedSites=trackerDialog.getSelectedSites(userName,tracker);

			ArrayList<JSONObject> brNameList = biDialog.getBloggerNames(selectedSites);
			session.setAttribute("brNameList", brNameList);

			ArrayList<BeanAllSites> allSites=trackerDialog.getSiteNames(selectedSites);
			if(session.getAttribute("bsName")!=null)
				session.removeAttribute("bsName");
			session.setAttribute("allSepSites", allSites);
			//session.setAttribute("errorMessage",session.getAttribute("tracker") );
		}
		
		else if(request.getParameter("datepicked")!= null){	
			String date =request.getParameter("datepicked");
			session.setAttribute("datepicked", date);
			List<String> aa=common.returnDates(date);
			String scale=common.returnScale(aa);
			//session.setAttribute("errorMessage",aa );
			if(session.getAttribute("tracker")!=null){
				session.setAttribute("errorMessage", "");
				String userName = (String) session.getAttribute("user");
				String trackerName = (String) session.getAttribute("tracker");
				String datePicked = (String) session.getAttribute("datepicked");
				//session.setAttribute("errorMessage", userName);
				TrackerDialog dialog = new TrackerDialog();
				String selectedSites = dialog.getSelectedSites(userName,trackerName);
				
				//session.setAttribute("errorMessage",userName+ " "+trackerName );
				getRequestedData(scale,selectedSites,datePicked,session);
				
			}
			else{
				session.setAttribute("errorMessage", "Please Select Tracker then Date");
			}
			
			
		}

		else if(request.getParameter("options")!=null){
			String scale=request.getParameter("options");
//			System.out.println(request.getParameter("options"));

			session.setAttribute("calScale", scale);
			if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null){
				session.setAttribute("errorMessage", "");
				//				session.removeAttribute("errorMessage");


				String userName = (String) session.getAttribute("user");
				String trackerName = (String) session.getAttribute("tracker");
				String datePicked = (String) session.getAttribute("datepicked");
				TrackerDialog dialog= new TrackerDialog();
				String selectedSites=dialog.getSelectedSites(userName,trackerName);
				getRequestedData(scale,selectedSites,datePicked,session);

			}
			else{
				session.setAttribute("errorMessage", "Please Select Tracker or Date");
			}

		}
		else{

			String incomingDate = request.getParameter("data");
			String type=(String) session.getAttribute("calScale");

			incomingDate=incomingDate.substring(0, 15);
			DateFormat df = new SimpleDateFormat("EEE MMM dd yyyy"); 
			DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd"); 
			Calendar c = Calendar.getInstance();
			Date date;
			String newStartDate = null;
			String newEndDate;
			try {
				date = df.parse(incomingDate);
				newStartDate = df1.format(date);
				c.setTime(df1.parse(newStartDate));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if(type.equalsIgnoreCase("day")){
				c.add(Calendar.DATE, 1);	
			}else if (type.equalsIgnoreCase("week")) {
				c.add(Calendar.DATE, 7);
			}else if (type.equalsIgnoreCase("month")) {
				c.add(Calendar.MONTH, 1);
			}else if (type.equalsIgnoreCase("year")) {
				c.add(Calendar.YEAR, 1);
			}

			newEndDate = df1.format(c.getTime()); 	
//			System.out.println("start date"+newStartDate);
//			System.out.println("end date"+newEndDate);

			String userName = (String) session.getAttribute("user");
			String trackerName = (String) session.getAttribute("tracker");
			TrackerDialog dialog= new TrackerDialog();
			String selectedSites=dialog.getSelectedSites(userName,trackerName);

			ArrayList<BeanBlogTitlePost> blogpost = pfDialog.fillblogpost(newStartDate, newEndDate, selectedSites);
			ArrayList<BeanTopKeywords> wordList=pfDialog.getTopKeywords(newStartDate, newEndDate, selectedSites);
			ArrayList<BeanTopEntities> entity=pfDialog.getTopEntities(newStartDate, newEndDate, selectedSites);
			session.setAttribute("blogTitlePost", blogpost);
			session.setAttribute("topEntity", entity);
			session.setAttribute("wordList", wordList);

		}
		response.setContentType("text/html");
//		if(request.getParameter("is_request")!= null) {
//			request.getRequestDispatcher("../webtemplates/postingfrequencey_loader.jsp").include(request,response);
//		}else {
		 response.sendRedirect("posting_frequency.jsp");
//		}
	}


	/**
	 * @param scale
	 * @param selectedSites
	 * @param datePicked
	 * @param session
	 */
	public void getRequestedData(String calScale, String selectedSites, String datePicked, HttpSession currentSession) {
//		System.out.println(datePicked);
		List<String> aa=common.returnDates(datePicked);
		String d1 = aa.get(0);
		String d2 = aa.get(1);
//		System.out.println(d1+" "+d2);
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
		Date startdate = null;
		Date enddate=null;
		try{
			startdate = df.parse(d1);
			enddate = df.parse(d2);
		}
		catch(ParseException e){
			e.printStackTrace();
		}
		getGraphData graphData= new getGraphData();
		List<DataPoint> dataPoints= graphData.getPosts(startdate,enddate, 1, calScale, selectedSites);
		ArrayList<BeanTopBlogger> blogger=pfDialog.getTopBlogger(d1,d2,selectedSites);
		currentSession.setAttribute("frequency", dataPoints);
		currentSession.setAttribute("topBloggers", blogger);
		currentSession.setAttribute("calScale", calScale);
	}
	
	
}
