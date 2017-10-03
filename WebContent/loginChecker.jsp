<%-- 
    Document   : checker
    Created on : Jan 25, 2017, 5:28:03 AM
    Author     : Obadimu
--%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="authentication.DBConnector"%>
<%@page import="blogtracker.util.Common"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
	DBConnector conn = new DBConnector();
	try {
		//
		String submitted = request.getParameter("check_user");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		Common c = new Common();
		ArrayList found = conn.login(email, password);
		//System.out.println(found);
		if (found.size() > 1) {
			conn.setCurrentUser(found.get(0).toString());
			// conn.setCurrentUserType(userdata.get(3).toString());
		//	System.out.println("User data"+found);
			ArrayList<String> trackers = c.gettrackers(found.get(0).toString());
			System.out.println(trackers);
			session.setAttribute("trackers", trackers);
			session.setAttribute("user", found.get(0));
			session.setAttribute("email", found.get(2));

			response.sendRedirect("data.jsp");
		}
%>
<%=(found)%>
<%
	} catch (Exception ex) {
%>
<%="acess denied" + ex%>
<%
	//System.out.println("access denied");
	}
	//   System.out.println("access denied");
%>
