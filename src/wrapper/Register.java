
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
@WebServlet("/register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Register() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {           
            response.setContentType("text/html");
            response.sendRedirect("register.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		String email = request.getParameter("email");
                String username = request.getParameter("username");
		String pass = request.getParameter("password");
                String type = request.getParameter("user_type");
                String submitted = request.getParameter("register");
		PrintWriter pww = response.getWriter();
                //pww.write(email+":"+username+":"+pass+":"+submitted);
		if(submitted.equals("yes"))
		{			
			boolean register = new DBConnector().register(username, email,pass,type);
                        if(register){
                            response.setContentType("text/html");
                         response.sendRedirect("/");
                        }else{
                            response.setContentType("text/html");
                            response.sendRedirect("register");
                        }
		}
	}
}
