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
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
        ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
%>

<%
	ArrayList<BlogSites2> bs =  new ArrayList<BlogSites2>();
	DBConnector conn = new DBConnector();
    String tracker_ids = "";
    String s="";
    int from =0;
    int to = 10;
   ArrayList bloglist = new ArrayList();

	try {
		
			tracker_ids = request.getParameter("ids");
			s = tracker_ids;
			//System.out.println(keyword);
			if(!tracker_ids.trim().isEmpty()){
				//String[] ids = tracker_ids.split(",");
				
				s = "("+tracker_ids+")";
				bloglist = new DBConnector().query("select blogsite_id,blogsite_name,totalposts from blogsites where blogsite_id in "+s+"");
				
			}

	} catch (Exception ex) {

	}
%>            

<% if(bloglist.size()>0){ 
	 for(int k=0; k<bloglist.size(); k++){
		ArrayList item = (ArrayList)bloglist.get(k);
%>
		<div class="col-sm-3">
								<div class="panel panel-body">
									<div class="media">
										<div class="media-left">
											<img src="img/b.png" class="img-circle img-lg" alt="">
										</div>									
										<div class="media-body">
											<h6 class="media-heading"><%=item.get(1).toString().toLowerCase() %> <input type="checkbox" checked onclick="select_blog()" class="blog-list" name="blog" style="float:right" value="<%=item.get(0) %>"  />
											</h6>
											<span class="text-muted"><%=item.get(2) %> post(s)</span>
										</div>	
									</div>
								</div>
		</div>
<% }} %>
				
<input type="hidden" name="selected_result" id="selected_result" value="yes" />											
