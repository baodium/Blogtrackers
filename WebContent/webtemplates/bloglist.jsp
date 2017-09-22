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
   ArrayList bloglist = new ArrayList();
	try {
		
			keyword = request.getParameter("keyword");
			System.out.println(keyword);
			if(!keyword.trim().isEmpty()){
				StringTokenizer st = new StringTokenizer(keyword, ",");
				String s="";
				while (st.hasMoreElements()) {
					//bloglist.add(st.nextElement());
					s=s+ "'"+ st.nextElement()+"',";
				}
				s = "("+s.substring(0,s.length()-1)+")";
				sitesDialog siteDialog = new sitesDialog();
				bs = siteDialog.getBlogSitesBasedOnKeyword(s);
				bloglist = new DBConnector().query("select blogsite_id,blogsite_name,totalposts from blogsites where blogsite_id in (select distinct blogsiteid from terms where term in " +s+") order by blogsite_name");
				
			}

	} catch (Exception ex) {

	}
%>

	<div >

			<table class="table table-striped jambo_table bulk_action">
				<thead>
					<tr class="headings">
							<th><input type="checkbox" id="check-all" class="flat"> Blogs about "<%=keyword%>"</span></th>
							<th class="column-title"></th>
							<th class="column-title"></th>

							<th class="bulk-actions" colspan="7"><a class="antoo" style="color: #fff; font-weight: 500;"> <span
																class="action-cnt"> </span></a></th>
				</thead>

				<tbody>
				<% if(bloglist.size()>0){ 
					for(int k=0; k<bloglist.size(); k++){
						ArrayList item = (ArrayList)bloglist.get(k);
				%>
					<tr class="even pointer">
						<td class="a-center ">
							<input type="checkbox" class="flat" name="table_records" value=""  />
																<%=item.get(1) %>
																</td>
													</tr>
				<% }}else{ %>
				<tr class="even pointer">
				<td class="a-center ">No matching blog</td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>