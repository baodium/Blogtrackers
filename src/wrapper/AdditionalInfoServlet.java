package wrapper;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import blogtracker.gui.blogtrackers.AddnGraph;
import blogtracker.gui.blogtrackers.BeanAllSites;
import blogtracker.gui.blogtrackers.BeanDoughnut;
import blogtracker.gui.blogtrackers.BlogSiteInfo;
import blogtracker.gui.blogtrackers.ChartPoint;
import blogtracker.gui.blogtrackers.DataPoint;
import blogtracker.gui.blogtrackers.DomainLink;
import blogtracker.util.BloggerInfoDialog;
import blogtracker.util.TrackerDialog;

/**
 * Servlet implementation class AdditionalInfoServlet
 * @author msaadghouri
 */
@WebServlet("/AdditionalInfoServlet")
public class AdditionalInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	TrackerDialog trackerDialog = new TrackerDialog();
	BloggerInfoDialog biDialog= new BloggerInfoDialog();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdditionalInfoServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.sendRedirect("additional_blog_info.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session= request.getSession();
		if(request.getParameter("tracker")!=null)
		{
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
		else if(request.getParameter("allsitesid")!=null){
			String siteiDName= request.getParameter("allsitesid");
			String[] arr=siteiDName.split(",",2);
			String siteID = arr[0];   
			String siteName = arr[1];
			session.setAttribute("bsName", siteName);
			System.out.println(Integer.parseInt(siteID));

			BlogSiteInfo siteInfo= new BlogSiteInfo();
			String siteUrl=siteInfo.getBlogLink(Integer.parseInt(siteID));
			int maxScore= siteInfo.getMaxScore(Integer.parseInt(siteID));
			List<DataPoint> freqDays= siteInfo.getFrequentDays(Integer.parseInt(siteID));
			List<ChartPoint> avgMonthFreq = siteInfo.getAvgMonthlyFrequency(Integer.parseInt(siteID));
			List<BeanDoughnut> doughnut= siteInfo.getSentiments(Integer.parseInt(siteID));
			List<DomainLink> mostDomains= siteInfo.getMostFrequentDomains(Integer.parseInt(siteID));
			List<DomainLink> mostLinks= siteInfo.getMostFrequentLinks(Integer.parseInt(siteID));

			getAvgMonthFreq(avgMonthFreq,session);

			session.setAttribute("freqDays", freqDays);
			session.setAttribute("mostLinks", mostLinks);
			session.setAttribute("mostDomains", mostDomains);
			session.setAttribute("doughnut", doughnut);
			session.setAttribute("siteUrl", siteUrl);
			session.setAttribute("maxScore", maxScore);

		}
		response.setContentType("text/html");
		response.sendRedirect("additional_blog_info.jsp");
	}

	/**
	 * @param avgMonthFreq
	 * @param session
	 */
	@SuppressWarnings("unchecked")
	private boolean getAvgMonthFreq(List<ChartPoint> avgMonthFreq, HttpSession curSession) {
		List<AddnGraph> list0= new ArrayList<>();
		List<AddnGraph> list1= new ArrayList<>();
		List<AddnGraph> list2= new ArrayList<>();
		List<AddnGraph> list3= new ArrayList<>();
		List<AddnGraph> avgList= new ArrayList<>();

		for(int i=0;i<avgMonthFreq.size();i++){
			AddnGraph addnGraph0= new AddnGraph();
			AddnGraph addnGraph1= new AddnGraph();
			AddnGraph addnGraph2= new AddnGraph();
			AddnGraph addnGraph3= new AddnGraph();
			AddnGraph addnGraphAvg= new AddnGraph();

			String month = avgMonthFreq.get(i).getInterval();

			int index = avgMonthFreq.get(i).getNoofposts0();
			int index1 = avgMonthFreq.get(i).getNoofposts1();
			int index2 = avgMonthFreq.get(i).getNoofposts2();
			int index3 = avgMonthFreq.get(i).getNoofposts3();
			int avg = (int) avgMonthFreq.get(i).getAvg();

			addnGraph0.setMonth(month);
			addnGraph0.setPostCount(index);

			addnGraph1.setMonth(month);
			addnGraph1.setPostCount(index1);

			addnGraph2.setMonth(month);
			addnGraph2.setPostCount(index2);

			addnGraph3.setMonth(month);
			addnGraph3.setPostCount(index3);

			addnGraphAvg.setMonth(month);
			addnGraphAvg.setPostCount(avg);

			list0.add(addnGraph0);
			list1.add(addnGraph1);
			list2.add(addnGraph2);
			list3.add(addnGraph3);
			avgList.add(addnGraphAvg);
		}
		Calendar currentCal = Calendar.getInstance();
		int year = currentCal.get(Calendar.YEAR);
		JSONObject jsonObject= new JSONObject();

		jsonObject.put("year3", year);
		jsonObject.put("year2", year-1);
		jsonObject.put("year1", year-2);
		jsonObject.put("year", year-3);
		jsonObject.put("average", "Average");

		curSession.setAttribute("allYears", jsonObject);
		curSession.setAttribute("list0", list0);
		curSession.setAttribute("list1", list1);
		curSession.setAttribute("list2", list2);
		curSession.setAttribute("list3", list3);
		curSession.setAttribute("avgList", avgList);

		return true;
	}

}
