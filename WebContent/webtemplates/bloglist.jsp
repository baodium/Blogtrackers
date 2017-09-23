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
					<div class="table-responsive pre-scrollable">
						<table class="table">
							<thead>
								<tr>
									<th>#</th>
									<th>Blog Name</th>
									
								</tr>
							</thead>
							<tbody>
							<% if(bloglist.size()>0){ 
								for(int k=0; k<bloglist.size(); k++){
									ArrayList item = (ArrayList)bloglist.get(k);
							%>
								<tr >
									<td>
									
										<%=(k+1)%>
									</td>
									<td>
										<input type="checkbox" onclick="select_blog()" class="blog-list" name="blog" value="<%=item.get(0) %>"  /><%=item.get(1) %> (<%=item.get(2) %> posts)
									</td>
								</tr>
							<% }}else{ %>
							<tr >
							<td colspan="2">No matching blog</td>
							</tr>
							<% } %>
								
							</tbody>
						</table>
						<input type="hidden" name="search-blog" id="search-blog" value="yes" />
					</div>
				</div>
