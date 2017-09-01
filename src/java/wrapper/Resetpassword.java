
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

/**
 * Servlet implementation class Login
 * @author mukti
 */
@SuppressWarnings("unused")
@WebServlet("/resetpassword")
public class Resetpassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Resetpassword() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		response.setContentType("text/html");
		String nextjsp = "passwordreset.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextjsp);
		dispatcher.forward(request,response);
		*/
		response.setContentType("text/html");
		response.sendRedirect("recover_password.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		//authentication.Login auth = new authentication.Login();
		String password = request.getParameter("password");
		String password2 = request.getParameter("new_password");
		String password3 = request.getParameter("new_password2");
		response.sendRedirect("data.jsp");
		
	}
}
