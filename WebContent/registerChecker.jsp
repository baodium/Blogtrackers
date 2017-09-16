<%-- 
    Document   : checker
    Created on : Jan 25, 2017, 5:28:03 AM
    Author     : Blogeeria
--%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="authentication.DBConnector"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	DBConnector conn = new DBConnector();
	boolean registered = false;
	try {
		String submitted = request.getParameter("check_user");
		String email = request.getParameter("email");
		String name = request.getParameter("username");
		String password = request.getParameter("password");
		boolean found = conn.userExists(email);
		if (!found) {
			registered = conn.register(name, email, password);
		}
		//UserName, Email, Password
		//
%>
<%=(registered)%>

<%
	} catch (Exception ex) {
%>
<%="acess denied"%>
<%
	//System.out.println("access denied");
	}
	//   System.out.println("access denied");
%>


