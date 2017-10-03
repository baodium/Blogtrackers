<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="authentication.DBConnector"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
	DBConnector conn = new DBConnector();
//
	try {
		String submitted = request.getParameter("check_user");
		String userName = request.getParameter("userName");
		String trackerName = request.getParameter("trackerName");
		System.out.println(userName + "==" + trackerName);
		boolean found = conn.trackerExists(userName, trackerName);
		System.out.println("access " + found);
%>
<%=(found)%>

<%
	} catch (Exception ex) {
%>
<%="acess denied"%>
<%
	System.out.println("access denied");
	}
	//   System.out.println("access denied");
%>