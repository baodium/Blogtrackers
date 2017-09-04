<%-- 
    Document   : checker
    Created on : Jan 25, 2017, 5:28:03 AM

--%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="authentication.DBConnector"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


 <%
     DBConnector conn=new DBConnector();
     try{
        String submitted = request.getParameter("check_user"); 
        String email=request.getParameter("email");
        
        boolean found = conn.userExists(email);
        if(found){
        	//System.out.println("found");
        }else{ %>
        	<%="not found"%>
       <% } %>
     <% }catch(Exception ex){ %>
     <%="acess denied"%>
     <% } %>