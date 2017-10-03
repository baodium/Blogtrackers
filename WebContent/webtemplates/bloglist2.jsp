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
    String keyword = "";
    String s="";
    int from =0;
    int to = 10;
   ArrayList bloglist = new ArrayList();
	try {
		
			keyword = request.getParameter("keyword");
			System.out.println(keyword);
			if(!keyword.trim().isEmpty()){
				StringTokenizer st = new StringTokenizer(keyword, ",");			
				while (st.hasMoreElements()) {
					//bloglist.add(st.nextElement());
					s=s+ "'"+ st.nextElement()+"',";
				}
				s = "("+s.substring(0,s.length()-1)+")";
				//sitesDialog siteDialog = new sitesDialog();
				//bs = siteDialog.getBlogSitesBasedOnKeyword(s);
				bloglist = new DBConnector().query("select blogsite_id,blogsite_name,totalposts from blogsites where blogsite_id in (select distinct blogsiteid from terms where term in " +s+") order by blogsite_name LIMIT "+from+", "+to+" ");
				
			}

	} catch (Exception ex) {

	}
%>            

				
		<div class="panel panel-flat">
					<div class="panel-heading">
						<h5 class="panel-title"><input type="checkbox" id="check-all" onclick="check_all();" > Blogs about "<%=keyword%>"</span></h5>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="reload"></a></li>
		                		<li><a data-action="close"></a></li>
		                	</ul>
	                	</div>
					</div>
				<div class="panel-body">
					<% if(bloglist.size()>0){ 
								for(int k=0; k<bloglist.size(); k++){
									ArrayList item = (ArrayList)bloglist.get(k);
							%>			
				<div class="col-lg-3 col-md-6">
						<div class="panel panel-body">
							<div class="media">
								<div class="media-left">
									<a href="#" data-popup="lightbox">
										<img src="img/b.png" class="img-circle img-lg" alt="">
									</a>
								</div>

								<div class="media-body">
									<h6 class="media-heading"><%=item.get(1) %></h6>
									<span class="text-muted"><%=item.get(2) %> posts</span>
								</div>

								<div class="media-right media-middle">
									<ul class="icons-list icons-list-vertical">
				                    	<li class="dropdown">
					                    	<a href="#"> <input type="checkbox" onclick="select_blog()" class="control-primary blog-list" value="<%=item.get(0) %>"  name="blog" ></a>
					                    	
				                    	</li>
			                    	</ul>
								</div>
							</div>
						</div>
					</div>
					
					<% }}else{ %>
					
					
					<% } %>
					</div>
					
					</div>
					
