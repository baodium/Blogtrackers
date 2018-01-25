package wrapper;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import blogtracker.gui.blogtrackers.BeanAllSites;
import blogtracker.gui.blogtrackers.BeanInfluenceScatter;
import blogtracker.gui.blogtrackers.BeanTopKeywords;
import blogtracker.gui.blogtrackers.InfluentialBlogPost;
import blogtracker.gui.blogtrackers.getInfluentialBlogPosts;
import blogtracker.gui.blogtrackers.getInfluentialBloggers;
import blogtracker.util.BloggerInfoDialog;
import blogtracker.util.Common;
import blogtracker.util.InfluenceDialog;
import blogtracker.util.InfluentialBlogger;
import blogtracker.util.TestMT;
import blogtracker.util.TrackerDialog;

/**
 * Servlet implementation class InfluenceServlet
 * @author msaadghouri
 */
@WebServlet("/InfluenceServlet")
public class InfluenceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	InfluenceDialog iflDialog= new InfluenceDialog();
	TrackerDialog trackerDialog= new TrackerDialog();
	Common common= new Common();
	BloggerInfoDialog biDialog= new BloggerInfoDialog();
	private static final int MYTHREADS = 15;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public InfluenceServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session= request.getSession();
		if(session.getAttribute("tracker")!=null && session.getAttribute("datepicked")!=null )
		{
			String scale=null;
			if(session.getAttribute("inflCalScale")!=null){
				scale=(String) session.getAttribute("inflCalScale");	
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
			this.getRequestedData(scale,selectedSites,datePicked,session);
		}
		response.setContentType("text/html");
		response.sendRedirect("influence.jsp");
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
		}
		else if(request.getParameter("datepicked")!= null){	
			String date =request.getParameter("datepicked");
			session.setAttribute("datepicked", date);
			List<String> aa=common.returnDates(date);
			String scale=common.returnScale(aa);
			if(session.getAttribute("tracker")!=null){
				session.setAttribute("errorMessage", "");
				String userName = (String) session.getAttribute("user");
				String trackerName = (String) session.getAttribute("tracker");
				String datePicked = (String) session.getAttribute("datepicked");
				TrackerDialog dialog= new TrackerDialog();
				String selectedSites=dialog.getSelectedSites(userName,trackerName);
				getRequestedData(scale,selectedSites,datePicked,session);
			}else{
				session.setAttribute("errorMessage", "Please Select Tracker then Date");
			}
		}

		else if(request.getParameter("infl_option")!=null){
			String scale=request.getParameter("infl_option");
//			System.out.println(request.getParameter("infl_option"));

			session.setAttribute("inflCalScale", scale);
			if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null){
				session.setAttribute("errorMessage", "");
				//				session.removeAttribute("errorMessage");


				String userName = (String) session.getAttribute("user");
				String trackerName = (String) session.getAttribute("tracker");
				String datePicked = (String) session.getAttribute("datepicked");
				String selectedSites=trackerDialog.getSelectedSites(userName,trackerName);
				getRequestedData(scale,selectedSites,datePicked,session);

			}
			else{
				session.setAttribute("errorMessage", "Please Select Tracker or Date");
			}

		}

		//		else if(request.getParameter("monthFreq")!=null || request.getParameter("dayFreq")!=null 
		//				|| request.getParameter("weekFreq")!=null || request.getParameter("yearFreq")!=null){
		//
		//			if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null){
		//				session.setAttribute("errorMessage", "");
		//				String scale=null;
		//				if(request.getParameter("dayFreq")!=null){ scale="day"; }
		//				else if(request.getParameter("weekFreq")!=null){ scale="week"; }
		//				else if(request.getParameter("monthFreq")!=null){ scale="month"; }
		//				else if(request.getParameter("yearFreq")!=null){ scale="year"; }
		//
		//				String userName = (String) session.getAttribute("user");
		//				String trackerName = (String) session.getAttribute("tracker");
		//				String datePicked = (String) session.getAttribute("datepicked");
		//				String selectedSites=trackerDialog.getSelectedSites(userName,trackerName);
		//				getRequestedData(scale,selectedSites,datePicked,session);
		//
		//			}else{
		//				session.setAttribute("errorMessage", "Please Select Tracker or Date");
		//			}
		//
		//		}

		else if (request.getParameter("inflPost")!=null){
			String incomingName = request.getParameter("inflPost");
//			System.out.println("onClick -"+incomingName);
			String type=(String) session.getAttribute("inflCalScale");
			String extractedDate=incomingName.substring(0, 15);
			String bloggerName=incomingName.substring(incomingName.lastIndexOf(')') + 2, incomingName.length());
			DateFormat df = new SimpleDateFormat("EEE MMM dd yyyy"); 
			DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd"); 
			Calendar c = Calendar.getInstance();
			Date date;
			String newStartDate = null;
			String newEndDate;
			try {
				date = df.parse(extractedDate);
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
			String userName = (String) session.getAttribute("user");
			String trackerName = (String) session.getAttribute("tracker");
			String selectedSites=trackerDialog.getSelectedSites(userName,trackerName);

			String inflBlogPost=iflDialog.getInfluentialPost(newStartDate, newEndDate, selectedSites, bloggerName);
			session.setAttribute("inflBlogPost", inflBlogPost);

		}else{
			String scatClickData = request.getParameter("scatterClick");
			String bloggerName=scatClickData.substring(1, scatClickData.indexOf("<"));

			String userName = (String) session.getAttribute("user");
			String trackerName = (String) session.getAttribute("tracker");
			String datePicked = (String) session.getAttribute("datepicked");
			String selectedSites=trackerDialog.getSelectedSites(userName,trackerName);

			Common common= new Common();
			List<String> aa=common.returnDates(datePicked);
			String d1 = aa.get(0);
			String d2 = aa.get(1);

			ArrayList<BeanTopKeywords> scatWordList=iflDialog.getTopKeywords(bloggerName,selectedSites,d1,d2); 
//			System.out.println(scatWordList);
			session.setAttribute("scatWordList", scatWordList);
		}

		response.setContentType("text/html");
		response.sendRedirect("influence.jsp");

	}

	/**
	 * @param curScale
	 * @param selectedSites
	 * @param datePicked
	 * @param curSession
	 */
	public void getRequestedData(String curScale, String selectedSites, String datePicked, HttpSession curSession) {
		ExecutorService executor = Executors.newFixedThreadPool(MYTHREADS);
		getInfluentialBloggers infBlogger= new getInfluentialBloggers();
		getInfluentialBlogPosts inflBlogPost= new getInfluentialBlogPosts();

		try {
//			System.out.println(curScale);

			Common common= new Common();
			List<String> aa=common.returnDates(datePicked);
			String d1 = aa.get(0);
			String d2 = aa.get(1);

			DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
			Date startdate = null;
			Date enddate=null;

			startdate = df.parse(d1);
			enddate = df.parse(d2);

			List<InfluentialBlogger> inflBloggerScore = infBlogger.getinflbloggers(0.6, 0.7, 0.3, startdate, enddate, selectedSites);
			int topScores=0;

			//////
			int topBScore=0;
			if(inflBloggerScore.size()>0){
				if(inflBloggerScore.size()>0 && inflBloggerScore.size()<=5){
					for(int k=0;k<inflBloggerScore.size();k++)
					{
						topScores+=inflBloggerScore.get(k).getInfluenceScore();
						Runnable runnable= new TestMT(startdate, enddate, inflBloggerScore.get(k).getBloggerName(), 1, curScale, selectedSites,curSession,k);
						executor.execute(runnable);
					}
					topBScore = topScores/inflBloggerScore.size();
				}else if(inflBloggerScore.size()>=5){
					for(int i=0;i<5;i++)
					{
						topScores+=inflBloggerScore.get(i).getInfluenceScore();
						Runnable runnable= new TestMT(startdate, enddate, inflBloggerScore.get(i).getBloggerName(), 1, curScale, selectedSites,curSession,i);
						executor.execute(runnable);
					}
					topBScore = topScores/inflBloggerScore.size();
				}

			}
			executor.shutdown();
			while (!executor.isTerminated()) {

			}

			List<InfluentialBlogPost> inflBlogPostData = inflBlogPost.getinflblogposts(0.6, 0.7, 0.3, startdate, enddate, selectedSites);
			List<BeanInfluenceScatter> scatterData=iflDialog.inflActScatterGraph(d1, d2, selectedSites);
			int aScore=0,iScore=0,avgA=0,avgI=0;
			if(scatterData.size()>0){
				for(int i=0;i<scatterData.size();i++){
					aScore+=scatterData.get(i).getActivityScore();
					iScore+=scatterData.get(i).getInfluenceScore();
				}
				avgA = aScore/scatterData.size();
				avgI = iScore/scatterData.size();
			}
			curSession.setAttribute("topBScore", topBScore);
			curSession.setAttribute("averageA", avgA);
			curSession.setAttribute("averageI", avgI);
			curSession.setAttribute("scatterPlotData", scatterData);
			curSession.setAttribute("INFBlScz", inflBloggerScore);
			curSession.setAttribute("INFBlSc", inflBlogPostData);
			curSession.setAttribute("inflCalScale", curScale);
		} catch (ParseException ex) {
			ex.printStackTrace();
		}	


	}

}
