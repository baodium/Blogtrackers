<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="authentication.DBConnector"%>
<%@page import="blogtracker.util.Common"%>
<%@page import="blogtracker.gui.blogtrackers.*"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%

    int perpage =10;


   PrintWriter pww = response.getWriter();
	try {
		
		String submitted = request.getParameter("search");

	    if(submitted!=null && submitted.equals("yes")){	
	        String term = request.getParameter("term");
	        String cpage = request.getParameter("page");
	        int from = Integer.parseInt(cpage)*perpage;;
			int to = (from+perpage);
	       
	       String query_string ="SELECT * FROM trackers WHERE tracker_name LIKE  '%"+term+"%' LIMIT "+from+", "+to+" ";
	       ArrayList trackers = new DBConnector().query(query_string); 
	              
	       if(trackers.size()>0){ 
	    		 for(int k=0; k<trackers.size(); k++){
	    			ArrayList item = (ArrayList)trackers.get(k);
	    	%>
	    			<div class="col-sm-3">
								<div class="panel panel-body">
									<div class="media">
										<div class="media-left">
											<img src="assets/images/placeholder.jpg" class="img-circle img-lg" alt="">
										</div>									
										<div class="media-body">
											<h6 class="media-heading"><%=item.get(2)%></h6>
											<span class="text-muted"><%=item.get(7)%> post(s)</span>
										</div>										
									</div>
								</div>
							</div>
	    	<% }}else{ 
	    		pww.write("empty");
	    	}
	    }
	} catch (Exception ex) {}
%>            