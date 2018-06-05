package wrapper;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.simple.JSONObject;

import blogtracker.gui.blogtrackers.AddnGraph;
import blogtracker.gui.blogtrackers.BeanAllSites;
import blogtracker.gui.blogtrackers.BeanBloggerDetails;
import blogtracker.gui.blogtrackers.BeanDoughnut;
import blogtracker.gui.blogtrackers.ChartPoint;
import blogtracker.gui.blogtrackers.DataPoint;
import blogtracker.gui.blogtrackers.DomainLink;
import blogtracker.util.BloggerInfoDialog;
import blogtracker.util.TrackerDialog;

/**
 * Servlet implementation class TestingServlet
 */
@WebServlet("/AdditionalBlogger")
public class AdditionalBlogger extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BloggerInfoDialog biDialog= new BloggerInfoDialog();
	TrackerDialog trackerDialog = new TrackerDialog();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdditionalBlogger() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session= request.getSession();

		String userName = (String) session.getAttribute("user");
		String trackerName = (String) session.getAttribute("tracker");
		TrackerDialog dialog= new TrackerDialog();
		String selectedSites=dialog.getSelectedSites(userName,trackerName);

		if(request.getParameter("authorName")!=null){
			
			String authorName = request.getParameter("authorName").toString();
			
			ArrayList<BeanBloggerDetails> bloggerDetails= new ArrayList<>();
			try {
				bloggerDetails = biDialog.getBloggerDetails(authorName, selectedSites);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			ArrayList<Integer> postIDList = biDialog.getPostID(authorName,selectedSites);
			String list = postIDList.toString().replace("[", "(").replace("]", ")");
			ArrayList<DomainLink> bloggerDomains = biDialog.getMostFrequentDomains(list);
			ArrayList<DomainLink> bloggerLinks = biDialog.getMostFrequentLinks(list);
			List<BeanDoughnut> bloggerSentiments = biDialog.getSentiments(list);
			List<DataPoint> bloggerDays = biDialog.getFrequentDays(list);
			List<ChartPoint> avgMonthFreq = biDialog.getAvgMonthlyFrequency(list);
			getAvgMonthFreq(avgMonthFreq,session);

			session.setAttribute("bloggerDetails", bloggerDetails);
			session.setAttribute("bloggerDays", bloggerDays);
			session.setAttribute("bloggerSentiments", bloggerSentiments);
			session.setAttribute("bloggerLinks", bloggerLinks);
			session.setAttribute("bloggerDomains", bloggerDomains);
//			System.out.println(bloggerDetails);
		}
		response.setContentType("text/html");
		response.sendRedirect("additional_blogger_info.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		
		if(request.getParameter("search_blogger")!=null){
			PrintWriter pww = response.getWriter();
			String term = request.getParameter("term");
			String result = "";
			ArrayList<JSONObject> brNameList = biDialog.searchBlogger(term);
			if(brNameList!=null && brNameList.size()>0) {
				for(int i=0; i<brNameList.size(); i++) {
					result+=brNameList.get(i)+"|";
				}
			}
			
			pww.write(result+"");
			
			
		}else if(request.getParameter("get_detail")!=null){
				PrintWriter pww = response.getWriter();
				String blogger = request.getParameter("blogger");
				ArrayList<BeanBloggerDetails> bloggerDetails= new ArrayList<>();
				try {
					bloggerDetails = biDialog.searchBloggerDetails(blogger);
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
					pww.write(bloggerDetails+"");	
	
		}else {
		 response.setContentType("text/html");
		 response.sendRedirect("additional_blogger_info.jsp");
		}
	}

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

		curSession.setAttribute("ballYears", jsonObject);
		curSession.setAttribute("blist0", list0);
		curSession.setAttribute("blist1", list1);
		curSession.setAttribute("blist2", list2);
		curSession.setAttribute("blist3", list3);
		curSession.setAttribute("bavgList", avgList);

		return true;

	}

}
