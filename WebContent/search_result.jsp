<%@page import="wrapper.*"%>
<%@page import="java.util.*"%>
<jsp:include page="include_top2.jsp"></jsp:include>
<%
Object term = (null == session.getAttribute("search_term")) ? "" : session.getAttribute("search_term");
Object search_result = (null == session.getAttribute("search_result")) ? "" : session.getAttribute("search_result");
Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");

if(term!="" && username==""){
	session.setAttribute("initiated_search_term", term);
}
%>
	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">

			<!-- Main content -->
			<div class="content-wrapper">

				<!-- Search field -->
				<div class="panel panel-flat">
					<div class="panel-heading">
						<h5 class="panel-title">Search results</h5>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="close"></a></li>
		                	</ul>
	                	</div>
					</div>

					<div class="panel-body">
						<form action="<%=request.getContextPath()%>/search" method="post" class="main-search">
							<div class="input-group content-group">
								<div class="has-feedback has-feedback-left">
									<input type="text" name="term" id="term" class="form-control input-xlg" value="<%=term%>">
									<div class="form-control-feedback">
										<i class="icon-search4 text-muted text-size-base"></i>
									</div>
								</div>
								<input type="hidden" name="search" value="yes">
								<div class="input-group-btn">
									<button type="submit" class="btn btn-primary btn-xlg">Search</button>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- /search field -->


				<!-- Search results -->
				<div class="content-group">
					<%  
						if(search_result!=""){
					%>
					<p class="text-muted text-size-large content-group">				
					Search results for <%= term %>					
					</p>
					
					<div class="col-lg-12 mt-20">
							<div class="text-right">
							<form name="" method="post" action="<%=request.getContextPath()%>/setup_tracker.jsp">
							<input type="hidden" name="from" value="search" />
							<input type="hidden" name="keyword" value="<%=term%>" />
							<textarea name="all-selected-blogs" id="all-selected-blogs" rows="5" cols="5" style="display:none" ></textarea>
							<button type="submit" class="btn btn-primary legitRipple">Continue</button>
							<br/><br/>
							</form>
							</div>
					</div>
					<% } %>
					<div class="search-results-list">
						
						<div class="row" id="appendee">
						<%  
							if(search_result!=""){
								ArrayList resultss = (ArrayList)search_result;
								if(resultss.size()>0){
									for(int j=0; j<resultss.size(); j++){
										ArrayList tracker = (ArrayList)resultss.get(j);
						%>
							
							<div class="col-sm-3">
								<div class="panel panel-body">
									<div class="media">
										<div class="media-left">
											<img src="img/b.png" class="img-circle img-lg" alt="">
										</div>
										
										<div class="media-body">
											<h6 class="media-heading"><%=tracker.get(1)%> <input type="checkbox" onclick="select_blog();"  class="blog-list" name="blog" style="float:right" value="<%=tracker.get(0) %>"  /></h6>
											<span class="text-muted"><%=tracker.get(2)%> post(s)</span>
										</div>
										
									</div>
								</div>
							</div>
							<% }}} %>											
						</div>
						<%  
						if(search_result!=""){
							%>
							<div class="loadmoreimg" id="loading-img" style="text-align:center"><br/><br/><img src='assets/images/preloader.gif' /><br/></div>						
						<% } %>			
                    </div>
				</div>
			</div>

			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	
	<form name="page_form" id="page_form" method="post" action="">
    <input type="hidden" id="page_id" name="page_id" value="0" />
	<input type="hidden" name="negative_page" id="negative_page" value="1" />
	<input type="hidden" id="hasmore" name="hasmore" value="1" />
	<input type="hidden" id="current_page" name="current_page" value="search" />
	
    </form>
	<!-- /page container -->
 <script>
	$(window).scroll(function() {
		if($(window).scrollTop() + $(window).height() > $(document).height() - 200) {
			loadMoreResult();
		}
	});
	
	
	
	function select_blog(){
		//alert("hello");
		var blogs = $(".blog-list");
		var selected='';
		for(var l=0; l<blogs.length; l++){
				var is_checked = $(blogs[l]).is(':checked');
				if(is_checked){
					var valu = $(blogs[l]).val();
					selected+= valu+",";
				}
		}
		$("#all-selected-blogs").val(selected);
	}
	
</script>

	<!-- Footer -->
	 <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->

</body>
</html>
