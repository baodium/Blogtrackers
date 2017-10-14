package wrapper;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import blogtracker.gui.blogtrackers.JSONEntities;
import blogtracker.util.Common;
import blogtracker.util.ExportJSONDialog;
import blogtracker.util.TrackerDialog;

/**
 * Servlet implementation class ExportJSON. This class is used for exporting required fields to JSON file
 * based on selected tracker and date range.
 * @author Kiran
 */
@WebServlet("/ExportJSON")
public class ExportJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ExportJSONDialog exportJSONDialog = new ExportJSONDialog();
	TrackerDialog tDialog = new TrackerDialog();
	
	public ExportJSON() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		response.sendRedirect("data_presentation.jsp");

	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * 
	 * This is overridden method for getting parameters and setting the values in session based on 
	 * request/response to display count of records to the screen based on selected tracker and date range.
	 * Also, this method returns to "data_presentation.jsp" page with count of records and if user wants
	 * to download/export the data into a JSON File format.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session= request.getSession();
		if(request.getParameter("tracker")!=null){
			session.setAttribute("errorMessage", "");
			String tracker = request.getParameter("tracker");
			session.setAttribute("tracker", tracker);
			response.setContentType("text/html");
			session.setAttribute("errorMessage", "Adekunle");
			response.sendRedirect("data_presentation.jsp");
		}
		else if(request.getParameter("datepicked")!= null && session.getAttribute("tracker")!=null){
			session.setAttribute("errorMessage", "");
			String datePicked = request.getParameter("datepicked");
			session.setAttribute("datepicked", datePicked);
			String userName = (String) session.getAttribute("user");
			String trackerName = (String) session.getAttribute("tracker");
			String queryTracker = tDialog.getSelectedSites(userName, trackerName);
			getRequestedCount(queryTracker,datePicked,session);
			response.setContentType("text/html");
			session.setAttribute("errorMessage", datePicked);
			response.sendRedirect("data_presentation.jsp");
			}

		 else if(request.getParameter("exportJSON")!= null && session.getAttribute("tracker")!=null && session.getAttribute("datepicked")!=null)
		{

			session.setAttribute("errorMessage", "");
			String userName = (String) session.getAttribute("user");
			String trackerName = (String) session.getAttribute("tracker");
			String datePicked = (String) session.getAttribute("datepicked");
			String queryTracker = tDialog.getSelectedSites(userName, trackerName);

			ArrayList<JSONEntities> jEntities = getRequestedData(queryTracker,datePicked,session);
			
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
	        String json = gson.toJson(jEntities);
			String filename = "tracker.json";   
			
			/* 	Note, both calls in below code(resp.setCharacterEncoding("UTF-8"); resp.setContentType("text/xml"); PrintWriter out = resp.getWriter();)and
			 *  (resp.setContentType("text/html; charset=UTF-8"); PrintWriter out = resp.getWriter();) 
			 * 	need to be called before the getWriter() method. Once the getWriter() method is called, 
			 * 	the charset can't be changed. When setting the contentType without the charset property, 
				the OS's default charset will be used, such as ISO-8859-4 */		
			
		response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();
			response.setHeader("X-Download-Options", "noopen");
			response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");
			out.write(json);
			out.close();
		}
		else{
			if(request.getParameter("tracker")==null)
				session.setAttribute("errorMessage", "Please Select a Tracker");
			if(request.getParameter("datepicked")== null && session.getAttribute("tracker")!=null)
				session.setAttribute("errorMessage", "Please Select a Date Range");
			response.setContentType("text/html");
			response.sendRedirect("data_presentation.jsp");
		}
	} 
	
	/**
	 * Makes a DB call to fetch/save count of records in session and then pass to the screen 
	 *
	 * @param  queryTracker the blogid's for selected tracker
	 * @param  datePicked 	user selected date range
	 * @param  currentSession 
	 * @return void
	 */
	private void getRequestedCount(String queryTracker, String datePicked, HttpSession currentSession) {
		Common common= new Common();
		List<String> aa=common.returnDates(datePicked);
		String d1 = aa.get(0);
		String d2 = aa.get(1);
		int recordsCount=exportJSONDialog.getCount(queryTracker,d1,d2);
		currentSession.setAttribute("records", recordsCount);
	}
	
	/**
	 * Makes a DB call to fetch/save an ArrayList of JSONEntities type objects
	 * that can be saved to JSON File. 
	 *
	 * @param  queryTracker the blogid's for selected tracker
	 * @param  datePicked 	user selected date range
	 * @param  currentSession 
	 * @return ArrayList<JSONEntities>
	 */
	private ArrayList<JSONEntities> getRequestedData(String queryTracker, String datePicked, HttpSession currentSession) {
		Common common= new Common();
		List<String> aa=common.returnDates(datePicked);
		String d1 = aa.get(0);
		String d2 = aa.get(1);
		ArrayList<JSONEntities> jEntities = exportJSONDialog.getFieldsJSON(queryTracker, d1, d2);
		return jEntities;
	}
}