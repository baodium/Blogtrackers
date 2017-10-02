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
	ArrayList<BlogSites2> bs =  new ArrayList<BlogSites2>();
	DBConnector conn = new DBConnector();
    String keyword = "";
    String s="";
    int from =0;
    int to = 12;
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
				bloglist = new DBConnector().query("select blogsite_id,blogsite_name,totalposts from blogsites where blogsite_id in (select distinct blogsiteid from terms where term in " +s+") order by blogsite_name LIMIT "+from+", "+to+" ");				
			}

	} catch (Exception ex) {}
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
					<!-- Search results -->
					<div class="search-results-list">
						
						<div class="row" id="tracking-blogs">
						<% if(bloglist.size()>0){ 
								for(int k=0; k<bloglist.size(); k++){
									ArrayList item = (ArrayList)bloglist.get(k);
							%>							
							<div class="col-sm-3">
								<div class="panel panel-body">
									<div class="media">
										<div class="media-left">
											<img src="assets/images/placeholder.jpg" class="img-circle img-lg" alt="">
										</div>										
										<div class="media-body">
											<h6 class="media-heading"><%=item.get(1) %> <input type="checkbox" onclick="select_blog()" class="blog-list" name="blog" style="float:right" value="<%=item.get(0) %>"  />
											</h6>
											<span class="text-muted"><%=item.get(2) %> post(s)</span>
										</div>										
									</div>
								</div>
							</div>
							<% }} %>												
						</div>
						<input type="hidden" name="search-blog" id="search-blog" value="yes" />
						<input type="hidden" name="search-keyword" id="search-keyword" value="<%=keyword%> %>" />
						
						<%  
						if(bloglist.size()>0){
							%>
							<div class="loadmoreimg" id="loading-img" style="text-align:center"><br/><br/><img src='assets/images/preloader.gif' /><br/></div>
						
						<% } %>
                    </div>
				</div>
				
				
	<form name="page_form" id="page_form" method="post" action="">
    <input type="hidden" id="page_id" name="page_id" value="0" />
	<input type="hidden" name="negative_page" id="negative_page" value="1" />
	<input type="hidden" id="hasmore" name="hasmore" value="1" />
	<input type="hidden" id="current_page" name="current_page" value="setup_tracker" />
	
    </form>
	<!-- /page container -->
 <script>
	$(window).scroll(function() {

		if($(window).scrollTop() + $(window).height() > $(document).height() - 200) {
			loadMoreBlogs();
		}

	});
</script>
