<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="authentication.DBConnector"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");

    PrintWriter pww = response.getWriter();
    String keyword = "";
    String s="";

    int perpage =12;
   ArrayList bloglist = new ArrayList();
	try {		
			//keyword = request.getParameter("keyword");
			System.out.println(keyword);
			
	        keyword = request.getParameter("term");
	        String cpage = request.getParameter("page");
	        int from = Integer.parseInt(cpage)*perpage;;
			int to = (from+perpage);
			
			if(!keyword.trim().isEmpty()){
				StringTokenizer st = new StringTokenizer(keyword, ",");			
				while (st.hasMoreElements()) {
					//bloglist.add(st.nextElement());
					s=s+ "'"+ st.nextElement()+"',";
				}
				s = "("+s.substring(0,s.length()-1)+")";
			//	bloglist = new DBConnector().query("select blogsite_id,blogsite_name,totalposts from blogsites where blogsite_id in (select distinct blogsiteid from terms where term in " +s+") LIMIT "+from+", "+to+" ");				
				   String query_string ="SELECT * FROM trackers WHERE tracker_name LIKE  '%"+keyword+"%' LIMIT "+from+", "+to+" ";
                   bloglist =new DBConnector().query(query_string); 
			}
			
			if(bloglist.size()>0){ 
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
							<h6 class="media-heading"><%=item.get(1) %> <input type="checkbox" onclick="select_blog()" class="blog-list" name="blog" style="float:right" value="<%=item.get(0) %>"  />
							</h6>
							<span class="text-muted"><%=item.get(2) %> post(s)</span>
						</div>										
					</div>
				</div>
			</div>
			<% }}else{ 
				//pww.write(keyword);
				pww.write("empty");
			}												

	} catch (Exception ex) {}
%>            

