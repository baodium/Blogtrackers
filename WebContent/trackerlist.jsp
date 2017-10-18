<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
<%@page import="java.util.*"%>
<%@page import="wrapper.*"%>

<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	ArrayList trackers = new ArrayList();
	ArrayList top_trackers = new ArrayList();
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
	
	try{
     trackers = (ArrayList)session.getAttribute("trackers");
     top_trackers = new Tracker().getTopTrackers(username.toString());//new DBConnector().query("SELECT * FROM trackers WHERE userid <> '"+username+"' ORDER BY date_created DESC LIMIT 0,10");
	}catch(Exception e){}
	
	
%>



 <jsp:include page="include_top.jsp"></jsp:include>	
	<!-- Page header -->
	   <script type="text/javascript" src="assets/js/intro.js"></script>
 
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
			<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Home</span> - Tracker List
					<small class="display-block"><span>Welcome, </span><%=username %>
			</h4>
			<div class="heading-elements">
				<div class="heading-btn-group">
					<button data-intro="Click here to create a new tracker" data-step="1" type="button" onclick="location.href='setup_tracker.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-plus2"></i></b> Setup a new tracker</button>
					<button type="button" href="javascript:void(0);" onclick="javascript:introJs().start();" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-reading "></i></b> Tour Page</button>
				 
					<button id="google_translate_element" class="btn btn-default"><script type="text/javascript">
function googleTranslateElementInit() {
  new google.translate.TranslateElement({pageLanguage: 'ar', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
}
</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
				
				</button>
			</div>
		</div>
		<!-- 	<form class="inline-form" action="<%=request.getContextPath()%>/search" method="post" >
					<div class="form-group">
					<div class="col-md-12">
					<div class="input-group">
					<input type="hidden" name="search" value="yes">
					<input type="text" class="form-control" name="term" placeholder="Enter a keyword to search" id="searchtextbox" autocomplete="off">
					<span class="input-group-btn" style="padding-left:0px;"><button type="button" class="btn btn-primary">Search</button></span>
												
					</div>
					</div>
					</div>
				</form>
				-->
			</div>


		</div>
	</div>
	<!-- /page header -->


	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">

			<!-- Main content -->
			<div class="content-wrapper">

				<!-- Main charts -->
				<div class="row">
				<div class="col-md-3">
					<div class="panel panel-primary">
							<div class="panel-heading">
							
								<h6 class="panel-title">Tracker Details <a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							<div class="table-responsive">
								<table class="table ">
									<tbody>
										<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">T</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="#" class="letter-icon-title">Tracker Name </a>
													</div>

													<div class="text-muted text-size-small" ><i class="icon-target text-size-mini position-left"></i><span id="trackername"></span> </div>
												</div>
											</td>
											
											
										</tr>
											<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">C</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="#" class="letter-icon-title">Created Date</a>
													</div>

													<div class="text-muted text-size-small" ><i class="icon-calendar text-size-mini position-left"></i><span id="createddate" ></span></div>
												</div>
											</td>
											
											
										</tr>
										
												<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">N</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="#" class="letter-icon-title">Number of Blogs</a>
													</div>

													<div class="text-muted text-size-small"><i class="text-size-mini position-left icon-angle"></i><span id="noofblog"></span></div>
												</div>
											</td>
											
											
										</tr>
																	<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">D</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="#" class="letter-icon-title">Description</a>
													</div>
													<div class="text-muted text-size-small" ><i class="text-size-mini position-left icon-info22"></i><span style="height:auto; width:180px !important;" id="description"></span></div>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>				
					</div>
					</div>
				</div>
				<div class="col-md-6">
					<% if(trackers != null && trackers.size()>0){ 
						for(int i=0; i<trackers.size(); i++){
							ArrayList tracker = (ArrayList)trackers.get(i);
							Object blogs = tracker.get(5);
					%>
					<form name="form_<%= tracker.get(0)%>" id="form_<%= tracker.get(0)%>" method="post" action="edittracker.jsp">
					<div  class="col-lg-4 col-md-6 eachtracker">
					
							<div class="thumbnail">
							
							<div data-intro="Click here to delete an existing tracker" data-step="2" title="Delete Tracker" class="text-muted text-size-medium" style="position:absolute; cursor:pointer;"><a href="#" onclick="delete_this('<%= tracker.get(0)%>');"><i class="icon-trash text-size-medium position-left"></i></a></div>
					
					
								<div class="thumb thumb-rounded">
									<img src="img/datapresentation.jpg" alt="">
								</div>
						    	<div class="caption text-center">
						    		<h6 class="text-semibold no-margin"><a data-intro="Click here to view metadata information about your tracker" data-step="5" onclick="loadTrackerr('<%= tracker.get(0)%>');"><%=tracker.get(2) %></a> <small class="display-block"><%=tracker.get(1) %></small></h6>
					    			<ul class="icons-list mt-15">
				                    	<li><a class="pull-left" href="<%=request.getContextPath()%>/Analytics?tracker=<%= tracker.get(2)%>"><button data-intro="Click here to perform analytical operations such as sentiments, keyword trends, posting frequency and data export" data-step="3" type="button" title="Proceed to Analytics"  class="btn btn-primary btn-float btn-float-md btn-rounded legitRipple"><i class="icon-statistics"></i></button></a>    <a class="pull-right"  onclick="edit_this('<%= tracker.get(0)%>');" style="margin-left:4px;"><button data-intro="Click here to modify existing tracker and view blogsites" data-step="4" type="button" title="Edit Tracker"  class="btn btn-primary btn-float btn-float-md btn-rounded legitRipple"><i class="icon-pencil"></i></button></a></li>
				                    </ul>
						    	</div>
					    	</div>
						</div>	
						<input type="hidden" name="" id="tracker_name_<%=tracker.get(0)%>" value="<%=tracker.get(2) %>" />	
						<input type="hidden" name="" id="date_created_<%=tracker.get(0)%>" value="<%=tracker.get(3) %>" />	
						<input type="hidden" name="" id="tracker_desc_<%=tracker.get(0)%>" value="<%=tracker.get(6) %>" />	
						<input type="hidden" name="" id="tracker_blogs_<%=tracker.get(0)%>" value="<%=blogs %>" />	
						<input type="hidden" name="tracker_id"  value="<%=tracker.get(0)%>" />
					</form>
					<% }} %>
					<div class="col-lg-4 col-md-6 eachtracker">
							<div class="thumbnail">
								<div class="thumb thumb-rounded">
									<a href="<%=request.getContextPath()%>/setup_tracker.jsp"><img src="img/plus.jpg" alt=""></a>
								</div>
						    	<div class="caption text-center">
						    		<h6 class="text-semibold no-margin"><a href="<%=request.getContextPath()%>/setup_tracker.jsp" >Add New Tracker</a> <small class="display-block">Set Up Tracker</small></h6>
					    			<ul class="icons-list mt-15">
				                    	<li><a href="<%=request.getContextPath()%>/setup_tracker.jsp"><button type="button" title="Add New Tracker"  class="btn btn-primary btn-float btn-float-md btn-rounded legitRipple"><i class="icon-plus2"></i></button></a></li>
				                    </ul>
						    	</div>
					    	</div>
						</div>	
				</div>
			<div class="col-md-3">
				<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Top Trackers From Communities<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							<div class="list-group no-border no-padding-top">
							<% if(top_trackers != null && top_trackers.size()>0){ 
								for(int i=0; i<top_trackers.size(); i++){
									ArrayList trackee = (ArrayList)top_trackers.get(i);
							%>
							<a onclick="alert('still working on this feature')" class="list-group-item"><i class="icon-paperplane"></i><%=trackee.get(2)%></a>
							<% }}else{ %>
								Not tracker found
							<%} %>
							</div>
					</div>
					</div>					
				</div>
				<!-- /main charts -->
			<!-- /main content -->
		</div>
		<!-- /page content -->

	</div>	
	</div>	
	</div>
	<!-- /page container -->
		   <!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
	<!-- Dependencies -->
  <jsp:include page="pagedependencies/trackerlist.jsp"></jsp:include>
  <!-- End of Dependencies -->
  



</body>
</html>
