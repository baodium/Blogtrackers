<%@page import="wrapper.*"%>
<%@page import="authentication.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Random.*"%>

<jsp:include page="include_top2.jsp"></jsp:include>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>
<%
Object term = (null == session.getAttribute("search_term")) ? "" : session.getAttribute("search_term");
Object search_result = (null == session.getAttribute("search_result")) ? "" : session.getAttribute("search_result");
Object total_result = (null == session.getAttribute("total_result")) ? "" : session.getAttribute("total_result");
Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
ArrayList trackers = new ArrayList();
if(term!="" && username==""){
	session.setAttribute("initiated_search_term", term);
}

try{
	   trackers = (ArrayList)session.getAttribute("trackers");
 }catch(Exception e){}



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
					<%=total_result %> results found for <%= term %>					
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
					<div class="search-results-list"><br/><br/><br/><br/>						
						<div class="row grid" id="appendee">
						<%  
							if(search_result!="" ){
								
								try{
								ArrayList resultss = (ArrayList)search_result;
								if(resultss.size()>0){
									for(int j=0; j<resultss.size(); j++){
										ArrayList tracker = (ArrayList)resultss.get(j);
										
						%>
							
							<div class="col-sm-3 grid-item item-<%=tracker.get(0)%>">
								<div class="panel panel-body">
									<div class="media">
										<div class="media-left">
											<img src="img/b.png" class="img-circle img-lg" alt="">
										</div>
										
										<div class="media-body">
											<h6 class="media-heading"><b><%=tracker.get(1)%></b> <input type="checkbox" onclick="select_blog();"  class="blog-list" name="blog" style="float:right" value="<%=tracker.get(0) %>"  /></h6>
											<span class="text-muted"><%=tracker.get(2)%> post(s)</span>
											<span><br/><br/>
											<%=tracker.get(3)%>
											</span>
										</div>
										<span class="divider"></span>
										<div class="heading-btn-group">
									
										
											<% if(username!=""){ %>
											<a href="#" onclick="favorIt('<%=tracker.get(0)%>');" class="btn btn-link btn-float has-text" title="Add to favourite"><i class="icon-stars text-primary"></i></a>								
											<a href="#"  class="btn btn-link btn-float dropdown-toggle" data-toggle="dropdown"  title="Add to tracker"><i class="icon-stack text-primary"></i></a>
											<ul class="dropdown-menu dropdown-menu-right">
												<li class="divider"></li>
												<% 
												if(trackers.size()>0){
												String tracker_id = tracker.get(0).toString();
												for(int i=0; i<trackers.size(); i++){
													if(i<6){
													ArrayList tr = (ArrayList)trackers.get(i);
													String ids = tr.get(5).toString();
													String test1 = tracker_id+",";
													String test2 = tracker_id+")";
												%>
														<li><a target="#" style="padding:0 8px" ><input class="tracker-<%=tracker.get(0)%>" <% if(ids.indexOf(test1)>0 || ids.indexOf(test2)>0){%> checked <% } %>type="checkbox" onchange="removeFromTracker('<%=tracker.get(0)%>','<%=tr.get(0)%>');" value="<%=tr.get(0)%>"/><%=tr.get(2)%></a></li>											
												<% }} %>
												<!--  <li><input type="text" style="height:10px; padding-left:5px" class="form-control input-xlg" id="tracker-name-<%=tracker.get(0)%>" /></li>	-->		
												
												<li class="divider"></li>
												<li><a href="#" onclick="addToTracker('<%=tracker.get(0)%>');" id="add-tracker-<%=tracker.get(0)%>" class="btn btn-link" style="padding:0 8px"><i class="icon-paperplane text-primary"></i> <span>Add To Selected</span> </a></li>																			
												<% } %>
												<!--  <li><a id="create-tracker-<%=tracker.get(0)%>" onclick="createTracker('<%=tracker.get(0)%>');" class="btn" style="padding:3px 8px"><i class="icon-plus2 text-primary"></i> <span>create tracker</span> </a></li>	-->		
											</ul>
											<% }else{ %>
											<a href="<%=request.getContextPath()%>/login"  class="btn btn-link btn-float has-text" title="Add to favourite"><i class="icon-stars text-primary"></i></a>
											
											<a href="<%=request.getContextPath()%>/login"  class="btn btn-link btn-float has-text"  title="Add to tracker"><i class="icon-stack text-primary"></i></a>
											
											<% } %>
										
										</div>	
												
									</div>
								</div>
							</div>
							<% }}else{ %>
							No result found
							<% }}catch(Exception e){ %>
								
							<% }} %>	
							
																
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
	<script type="text/javascript" src="assets/js/toastr.js?v=1"></script>

	<link href="assets/css/toastr.css" rel="stylesheet">
	
<script>

$(document).ready(function(){
var container = document.querySelector('.grid');
var msnry = new Masonry( container, {
 // columnWidth: 0,
  itemSelector: '.grid-item'
});


});
</script>
	<script>
	
	/* Masnory grid*/
	function initialiaze_masonry(){
		$('.grid').masonry({
			  // options
			  itemSelector: '.grid-item',
			  columnWidth: 5
			});
	}
	//initialiaze_masonry();
	</script>
	
 <script>
	$(window).scroll(function() {
		if($(window).scrollTop() + $(window).height() > $(document).height() - 200) {
			loadMoreResult();
		}
	});
	
	
	
	function select_blog(){
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
	
	

	function favorIt(id){
		
	}
	
	function createTracker(id){
		var name = $("#tracker-name-"+id).val();
		console.log(id);
		console.log($("#tracker-name-"+id));
		if(name==""){
			$("#tracker-name-"+id).focus();
		}
		return false;
	}
	
	function addToTracker(id){
		var trackers = $(".tracker-"+id);
		//var blog_id = $(".tracker-"+id);
		var selected='';
		for(var l=0; l<trackers.length; l++){
				var is_checked = $(trackers[l]).is(':checked');
				if(is_checked){
					var valu = $(trackers[l]).val();
					selected+= valu+",";
				}
		}
		
		if(selected!=""){
			console.log(selected);
			
			$.ajax({
		        url: app_url+'setup_tracker',
				method:'POST',
				async: true,
				data:{tracker_ids:selected,blog_id:id,add_blog:"yes"},
		        success: function(response)
		        {	
		        	console.log(response);
		        	if(response=="success"){
		        		toastr.success('Blog successfully added!', 'Success')

		        	}

		        }
		    });	
			
		}
		return false;
	}

	
	function removeFromTracker(blog_id,tracker_id){
		var checked = $(".tracker-"+blog_id).is(':checked');
		console.log(checked);
		
		if(blog_id=="" || tracker_id=="" || !checked)
			return false;
		
			
			$.ajax({
		        url: app_url+'setup_tracker',
				method:'POST',
				async: true,
				data:{blog_id:blog_id,tracker_id:tracker_id,action:"remove_blog_from_tracker"},
		        success: function(response)
		        {	
		        	console.log(response);
					if(response=="success"){

						toastr.success('Blog successfully removed!', 'Success')

		        	}

		        	
		        }
		    });	


	}
</script>

	<!-- Footer -->
	 <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->

</body>
</html>
