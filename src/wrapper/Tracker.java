
package wrapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import blogtracker.gui.blogtrackers.BlogSites2;
import blogtracker.util.Common;
import blogtracker.util.TrackerDialog;
import authentication.DBConnector;

/**
 * Servlet implementation class Login
 * @author mukti
 */
@SuppressWarnings("unused")
@WebServlet("/setup_tracker")
public class Tracker extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Tracker() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {           
            response.setContentType("text/html");
            response.sendRedirect("setup_tracker.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		PrintWriter pww = response.getWriter();
		HttpSession session= request.getSession();
		String savetracker = (null == request.getParameter("save")) ? "" : request.getParameter("save");
		String selectracker = (null == request.getParameter("select")) ? "" : request.getParameter("select");
		String action = (null == request.getParameter("action")) ? "" : request.getParameter("action");
		
		if(savetracker.equals("yes")){
			
			String userName = (String) session.getAttribute("username");
			String userid = (String) session.getAttribute("user");
			     	
			String keyword = request.getParameter("keyword");
			String trackerName=request.getParameter("title");
			if(!trackerName.trim().isEmpty()){

				String trackerDescription=request.getParameter("descr");
				String createdDate= getDateTime();
				String selected = request.getParameter("sites");
				session.setAttribute("searched", "about "+keyword);
				//selected = selected.tr
				String[] selectedSite = selected.split(","); 
				String listString = "";
				if(selectedSite.length>0){
					for (int i = 0; i < selectedSite.length; i++) { 
						listString += selectedSite[i] + ",";
					}
					listString="blogsite_id in ("+listString.substring(0, listString.length()-1)+")";
				}else{
					listString="blogsite_id in (0)";
				}
				//TrackerDialog dialog= new TrackerDialog();
				//dialog.addTracker(userName, trackerName, createdDate, null, listString, trackerDescription, selectedSite.length);
				ArrayList prev = new DBConnector().query("SELECT * FROM trackers WHERE tracker_name='"+trackerName+"'");
				
				if(prev!=null && prev.size()>0) {
					pww.write("exist");
				}else {	
					String query="INSERT INTO trackers(userid,tracker_name,date_created,date_modified,query,description,blogsites_num) VALUES('"+userName+"', '"+trackerName+"', '"+createdDate+"', "+ null+", '"+listString+"', '"+trackerDescription+"', '"+selectedSite.length+"')";
					boolean done = new DBConnector().updateTable(query);
					if(done) {
					  	ArrayList trackers = new DBConnector().query("SELECT * FROM trackers WHERE userid='"+userid+"'");
	                	session.setAttribute("trackers", trackers+"");
	                	session.setAttribute("initiated_search_term", "");
						response.setContentType("text/html");
						pww.write("success");
					}else {
						response.setContentType("text/html");
						pww.write("full failure");
					}
				}
			}
			else{
				response.setContentType("text/html");
				pww.write("failure");
			}
			//
			//			response.sendRedirect("Dashboard.jsp");
		}
		
		
		if(selectracker.equals("yes")) {
			String tid = request.getParameter("tracker_id");
			ArrayList tracker = new DBConnector().query("SELECT * FROM trackers WHERE tid='"+tid+"'");		
			if(tracker.size()>0){
				session.setAttribute("tracker", tid);
				pww.write("success");
			}
		}
		
		if(action.equals("delete_tracker")) {
			try {
			String tid = request.getParameter("tracker_id");
			new DBConnector().updateTable("DELETE FROM trackers WHERE  tid='"+tid+"'");	
			
			String userid = (String) session.getAttribute("user");
			ArrayList trackers = new DBConnector().query("SELECT * FROM trackers WHERE userid='"+userid+"'");
        	session.setAttribute("trackers", trackers);
       	
			}catch(Exception ex) {}
			pww.write("success");
		}
		
		if(action.equals("edit_tracker")) {
			try {
				String tid = request.getParameter("tracker_id");
				String name = request.getParameter("title");
				String desc = request.getParameter("descr");
				new DBConnector().updateTable("UPDATE trackers SET tracker_name='"+name+"', description='"+desc+"' WHERE  tid='"+tid+"'");	
				
				String userid = (String) session.getAttribute("user");
				ArrayList trackers = new DBConnector().query("SELECT * FROM trackers WHERE userid='"+userid+"'");
	        	session.setAttribute("trackers", trackers);
	        	session.setAttribute("edited_tracker", tid+"");
	        	response.sendRedirect("edittracker.jsp");
			}catch(Exception ex) {
				  response.sendRedirect("edittracker.jsp");
			}			 
		}
		

		if(action.equals("add_blog_to_tracker")) {
			try {
				ArrayList tracker =null;
				String tid = request.getParameter("tracker_ids");
				String blog_id = request.getParameter("blog_id");
				String[] tracker_ids = tid.split(",");
				DBConnector db = new DBConnector();
				for(int i=0; i<tracker_ids.length; i++) {
					String addendum = "";
						
					if(!tracker_ids[i].equals("")) {
					 tracker = db.query("SELECT query FROM trackers WHERE tid='"+tracker_ids[i]+"'");
					 if(tracker.size()>0){
						 	ArrayList hd = (ArrayList)tracker.get(0);
							String que = hd.get(0).toString();
							
							System.out.println(que+" here");
							String[] qt = que.split(",");
							for(int j=0; j<qt.length; j++) {
								if(!qt[j].equals("blogsite_id in \\(\\)")) {
									qt[j] = qt[j].replaceAll("blogsite_id in \\(", "");
									qt[j] = qt[j].replaceAll("\\)", "");
									if(!qt[j].equals("")) {				
										addendum+=qt[j]+",";
									}
								}
							}
							
							addendum = "blogsite_id in ("+addendum+blog_id+")";
							//listString="blogsite_id in ("+listString.substring(0, listString.length()-1)+")";
							//pww.write(addendum);
							db.updateTable("UPDATE trackers SET query='"+addendum+"' WHERE  tid='"+tracker_ids[i]+"'");	
						
					 }
					}
				}
				
				String userid = (String) session.getAttribute("user");
				ArrayList trackers = new DBConnector().query("SELECT * FROM trackers WHERE userid='"+userid+"'");
	        	session.setAttribute("trackers", trackers);
	        	pww.write("success");
	        	
			}catch(Exception ex) {
				pww.write(ex+"");
				  //response.sendRedirect("edittracker.jsp");
				  pww.write("error here");
			}			 
		}
		

		if(action.equals("remove_blog_from_tracker")) {
			try {
				ArrayList tracker =null;
				String blog_id = request.getParameter("blog_id");
				String tracker_id = request.getParameter("tracker_id");
				
				
				tracker = new DBConnector().query("SELECT tid,query FROM trackers WHERE tid ='"+tracker_id+"'");
					 if(tracker.size()>0){
						 for(int i=0; i<tracker.size(); i++) {
							 String addendum = "";
								
							 ArrayList hd = (ArrayList)tracker.get(0);
							 String que = hd.get(1).toString();
							 
							 String tid = tracker.get(0).toString();
							System.out.println(que);
							String[] qt = que.split(",");
							for(int j=0; j<qt.length; j++) {
								if(!qt[j].equals("blogsite_id in \\(\\)")) {
									qt[j] = qt[j].replaceAll("blogsite_id in \\(", "");
									qt[j] = qt[j].replaceAll("\\)", "");
									if(!qt[j].equals(blog_id)) {
										addendum+=qt[j];
									}
								}
							}
							
							//pww.write(que);
							addendum = "blogsite_id in ("+addendum+")";
							//pww.write(addendum);
							new DBConnector().updateTable("UPDATE trackers SET query='"+addendum+"' WHERE  tid='"+tid+"'");	
						 }
					 }
			
				
				String userid = (String) session.getAttribute("user");
				ArrayList trackers = new DBConnector().query("SELECT * FROM trackers WHERE userid='"+userid+"'");
	        	session.setAttribute("trackers", trackers);
	        	pww.write("success");
	        	
			}catch(Exception ex) {
				  pww.write("error");
			}			 
		}
		
		if(action.equals("remove_blog")) {
			try {
				String tid = request.getParameter("tracker_id");
				String blog_id = request.getParameter("blog_id");
				String query="blogsite_id in \\("+blog_id+"\\)";
				new DBConnector().updateTable("UPDATE trackers SET query='"+query+"' WHERE  tid='"+tid+"'");	
				
				String userid = (String) session.getAttribute("user");
				ArrayList trackers = new DBConnector().query("SELECT * FROM trackers WHERE userid='"+userid+"'");
	        	session.setAttribute("trackers", trackers);
	        	session.setAttribute("edited_tracker", tid+"");
	        	//response.sendRedirect("edittracker.jsp");
			}catch(Exception ex) {
				 //response.sendRedirect("edittracker.jsp");
			}			 
		}
		
	}
	
	private String getDateTime() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		return dateFormat.format(date);
	}
	
	public ArrayList<?> getTrackers(String selected) {
		ArrayList<?> bloglist = new ArrayList<String>();
		try {
			if(!selected.trim().isEmpty()){
				String s = "("+selected+")";
				bloglist = new DBConnector().query("select blogsite_id,blogsite_name,totalposts from blogsites where blogsite_id in "+s+"");			
			}
		} catch (Exception ex) {}
		
		return bloglist;
	}
	
	
	public ArrayList<?> getTopTrackers(String username) {
		ArrayList<?> bloglist = new ArrayList<String>();
		
		try {
			bloglist = new DBConnector().query("SELECT * FROM trackers WHERE userid <> '"+username+"' ORDER BY date_created DESC LIMIT 0,10");			
		} catch (Exception ex) {}
		
		return bloglist;
	}
	
	
	public ArrayList<?> getTracker(String tracker_id) {
		ArrayList<?> bloglist = new ArrayList<String>();
		try {
			String query_string ="SELECT * FROM trackers WHERE tid ='"+tracker_id+"' ";
			bloglist = new DBConnector().query(query_string);			
		} catch (Exception ex) {}
		
		return bloglist;
	}
	
	public ArrayList searchTrackers(String term) {
		ArrayList bloglist = new ArrayList();
		 String s="";
		try {
			if(!term.trim().isEmpty()){
				//String query_string ="SELECT * FROM trackers WHERE tracker_name LIKE  '%"+term+"%' LIMIT 0,12 ";
			    //bloglist =new DBConnector().query(query_string); 
			    
					StringTokenizer st = new StringTokenizer(term, ",");			
					while (st.hasMoreElements()) {
						//bloglist.add(st.nextElement());
						s=s+ "'"+ st.nextElement()+"',";
					}
					s = "("+s.substring(0,s.length()-1)+")";

				   bloglist = new DBConnector().query("select blogsite_id,blogsite_name,totalposts from blogsites where blogsite_id in (select distinct blogsiteid from terms where term in "+s+" ) limit 0,12 ");				
			}
		} catch (Exception ex) {}
		
		return bloglist;
	}
	
	
	public ArrayList<?> getBloglist(String blog_ids) {
		ArrayList<?> bloglist = new ArrayList<String>();
		try {
			bloglist = new DBConnector().query("select * from blogsites where blogsite_id in ("+blog_ids+") ");									
		} catch (Exception ex) {}
		
		return bloglist;
	}
}
