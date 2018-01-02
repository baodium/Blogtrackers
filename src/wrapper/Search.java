
package wrapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import authentication.DBConnector;
import java.io.File;
import javax.servlet.http.Part;

/**
 * Servlet implementation class Login
 * @author mukti
 */
@SuppressWarnings("unused")
@WebServlet("/search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Search() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {           
			HttpSession session = request.getSession();	
			session.setAttribute("search_result",null);
			session.setAttribute("total_result",null);
			response.setContentType("text/html");
            response.sendRedirect("search_result.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
                String submitted = request.getParameter("search");
                PrintWriter pww = response.getWriter();
                HttpSession session = request.getSession();
				String s="";
                //pww.write(email+":"+username+":"+pass+":"+submitted);
                    if(submitted!=null && submitted.equals("yes")){	
                        String term = request.getParameter("term");
                        session.setAttribute("search_term",term);

                       //String query_string ="SELECT * FROM trackers WHERE tracker_name LIKE  '%"+term+"%' LIMIT 0,12 ";
                       // ArrayList trackers =new DBConnector().query(query_string); 
                        StringTokenizer st = new StringTokenizer(term, ",");			
    					while (st.hasMoreElements()) {
    						//bloglist.add(st.nextElement());
    						s=s+ "'"+ st.nextElement()+"',";
    					}
    					s = "("+s.substring(0,s.length()-1)+")";
    					//System.out.println(s);
    					ArrayList trackerz = new DBConnector().query("select blogsite_id from blogsites where blogsite_id in (select distinct blogsiteid from terms where term in "+s+" )");				                     	
    					ArrayList trackers = new DBConnector().query("select blogsite_id,blogsite_name,totalposts, description from blogsites where blogsite_id in (select distinct blogsiteid from terms where term in "+s+" ) limit 0,12 ");				                     	
                       session.setAttribute("search_result",trackers);
                       if(trackerz!=null) {
                    	   session.setAttribute("total_result",trackerz.size());
                       }
                        response.setContentType("text/html");
                        response.sendRedirect("search_result.jsp");
                    }
          
	}
}
