
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
import blogtracker.util.*;
import authentication.DBConnector;

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
                HttpSession session = request.getSession();
                session.setAttribute("error_message","");
                session.setAttribute("success_message","");
		response.setContentType("text/html");
		response.sendRedirect("recover_password.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		
		//authentication.Login auth = new authentication.Login();
		String submitted = request.getParameter("recover");
		PrintWriter pww = response.getWriter();
        HttpSession session = request.getSession();
		String app_url = request.getContextPath();
                //pww.write(email+":"+username+":"+pass+":"+submitted);
                    if(submitted!=null && submitted.equals("yes")){
                    	try {
			String email = request.getParameter("email");
                        ArrayList prev = new DBConnector().query("SELECT * FROM usercredentials WHERE Email = '"+email+"'");
                        prev = (ArrayList)prev.get(0);
                        String[] receivers = {email,"oaadedayo@gmail.com","baodium@gmail.com"};
                        if(prev.size()>0){
                            double ran = Math.random();
                            String pass = new DBConnector().md5Funct(ran+"");
                            pass = pass.substring(0,8);
                            boolean updated = new DBConnector().updateTable("UPDATE usercredentials SET password  = '"+pass+"' WHERE Email = '"+email+"'");
                                if(updated){
                                session.setAttribute("success_message","A mail has been sent to "+email+" containing your login information");
                                try{
                                    new Mailing().postMail(receivers, "Blogtrackers password change request", "Hello "+prev.get(0)+", Please note that your password has been changed to <b>"+pass+"</b>. <br/>You are strongly advised to change your password after first login. <br/>Kindly login at <a href='"+app_url+"'>"+app_url+"</a><br/><br/> Thanks for using Blogtrackers"); 
                                }catch(Exception e){
                                    
                                }
                            }else{
                                 session.setAttribute("error_message","invalid operation");
                                
                            }
                        }else{
                            session.setAttribute("error_message","invalid email address");
 
                        }
                        
                    	}catch(Exception e) {
                    		session.setAttribute("error_message","invalid operation");
                    		response.setContentType("text/html");
                            response.sendRedirect("recover_password.jsp");
                    	}
                        
                    }
		
	}
}
