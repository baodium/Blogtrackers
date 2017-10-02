
package wrapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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
				
                //pww.write(email+":"+username+":"+pass+":"+submitted);
                    if(submitted!=null && submitted.equals("yes")){	
                        String term = request.getParameter("term");
                        session.setAttribute("search_term",term);

                       String query_string ="SELECT * FROM trackers WHERE tracker_name LIKE  '%"+term+"%' LIMIT 0,10 ";
                       ArrayList trackers =new DBConnector().query(query_string); 
                       	session.setAttribute("search_result",trackers);
                        response.setContentType("text/html");
                        response.sendRedirect("search_result.jsp");
                    }
               
                 
                
	}
}
