
package wrapper;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import blogtracker.gui.blogtrackers.BlogSites2;
import blogtracker.util.Common;
import authentication.DBConnector;

/**
 * Servlet implementation class Login
 * @author mukti
 */
@SuppressWarnings("unused")
@WebServlet("/validate")
public class Validate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Validate() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {           
            response.sendRedirect("app_url");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		//authentication.Login auth = new authentication.Login();

                String field = request.getParameter("field");
                String value = request.getParameter("value");
                String validate = request.getParameter("validate");
                 
		PrintWriter pww = response.getWriter();

		if(validate.equals("yes")){			
                        boolean exist = false;
                        if(field.equals("email")){
                            exist = new DBConnector().emailExists(value);
                        }else if(field.equals("username")){
                            exist = new DBConnector().usernameExists(value);
                        }
			//if(s.verified)
			if(exist){	
                                response.setContentType("text/html");
				pww.write("yes");
                               
			}else{
				response.setContentType("text/html");
				pww.write("no");
			}
		}


	}
}
