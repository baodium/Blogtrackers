<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
<%@page import="authentication.DBConnector"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

   int perpage =12;
   PrintWriter pww = response.getWriter();
   String s="";
	try {
		
		String submitted = request.getParameter("search");

	    if(submitted!=null && submitted.equals("yes")){	
	        String term = request.getParameter("term");
	        String cpage = request.getParameter("page");
	        int from = Integer.parseInt(cpage)*perpage;;
			int to = (from+perpage);
	       
	       //String query_string ="SELECT * FROM trackers WHERE tracker_name LIKE  '%"+term+"%' LIMIT "+from+", "+to+" ";
	       //ArrayList trackers = new DBConnector().query(query_string); 
	       StringTokenizer st = new StringTokenizer(term, ",");			
			while (st.hasMoreElements()) {
				//bloglist.add(st.nextElement());
				s=s+ "'"+ st.nextElement()+"',";
			}
			s = "("+s.substring(0,s.length()-1)+")";
			//bloglist = new DBConnector().query("select blogsite_id,blogsite_name,totalposts from blogsites where blogsite_id in (select distinct blogsiteid from terms where term in " +s+" LIMIT 12) LIMIT "+from+", "+to+" ");				
			  
			ArrayList trackers = new DBConnector().query("select blogsite_id,blogsite_name,totalposts, description from blogsites where blogsite_id in (select distinct blogsiteid from terms where term in "+s+" ) limit "+from+", "+to+" ");				
			        
	       if(trackers.size()>0){ 
	    		 for(int k=0; k<trackers.size(); k++){
	    			ArrayList item = (ArrayList)trackers.get(k);
	    	%>
	    			<div  class="col-sm-3 grid-item item-<%=item.get(0)%>">
								<div class="panel panel-body">
									<div class="media">
										<div class="media-left">
											<img src="img/b.png" class="img-circle img-lg" alt="">
										</div>									
										<div class="media-body">
											<h6 class="media-heading"><b><%=item.get(1)%></b> <input type="checkbox" onclick="select_blog()"  class="blog-list" name="blog" style="float:right" value="<%=item.get(0) %>"  /></h6>
											<span class="text-muted"><%=item.get(2)%> post(s)</span>
											<span><br/><br/>
											<%=item.get(3)%>
											</span>
										</div>	
										
										<div class="heading-btn-group">
										<center>
											<a href="#" onclick="favorIt('<%=item.get(0)%>');" class="btn btn-link btn-float has-text" title="Add to favourite"><i class="icon-stack text-primary"></i></a>
											<a href="#" onclick="trackIt('<%=item.get(1)%>');" class="btn btn-link btn-float has-text"  title="Add to tracker"><i class="icon-plus3 text-primary"></i></a>
										</center>
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
