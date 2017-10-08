<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
<%@page import="java.util.*"%>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
        ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
%>

 <jsp:include page="include_top.jsp"></jsp:include>

	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
			<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Home</span> - Tracker List
					<small class="display-block"><span>Welcome, </span><%=username %>
			</h4>
				
				<div class="form-group">
				<div class="col-md-12">
				
				<div class="input-group">
				<input type="text" class="form-control" placeholder="Enter a keyword to search" id="searchtextbox" autocomplete="off">
											<span class="input-group-btn" style="padding-left:0px;"><button type="button" class="btn btn-primary">Search</button></span>
											
										</div>
										</div>
										</div>
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
								<h6 class="panel-title">Tracker Details<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
								<table class="table text-nowrap">
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
														<a href="#" class="letter-icon-title">Tracker Name</a>
													</div>

													<div class="text-muted text-size-small" id="trackername"><i class="icon-target text-size-mini position-left"></i> Tracker 1</div>
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

													<div class="text-muted text-size-small" id="createddate"><i class="icon-calendar text-size-mini position-left"></i> July 17, 2016</div>
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

													<div class="text-muted text-size-small" id="noofblog"><i class="text-size-mini position-left icon-angle"></i>1200</div>
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

													<div class="text-muted text-size-small" id="description"><i class="text-size-mini position-left icon-info22"></i>Tracking about nato</div>
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
					
					<div class="col-lg-4 col-md-6 eachtracker">
							<div class="thumbnail">
								<div class="thumb thumb-rounded">
									<img src="img/datapresentation.jpg" alt="">

								</div>
							
						    	<div class="caption text-center">
						    		<h6 class="text-semibold no-margin">James Alexander <small class="display-block">Lead developer</small></h6>
					    			<ul class="icons-list mt-15">
				                    	<li><button type="button" class="btn btn-primary btn-float btn-float-md btn-rounded legitRipple"><i class="icon-target"></i></button></li>
				                    		</ul>
						    	</div>
					    	</div>
						</div>		
							
							
							<div class="col-lg-4 col-md-6 eachtracker">
							<div class="thumbnail">
								<div class="thumb thumb-rounded">
									<img src="img/datapresentation.jpg" alt="">
								
								</div>
							
						    	<div class="caption text-center">
						    		<h6 class="text-semibold no-margin">James Alexander <small class="display-block">Lead developer</small></h6>
					    			<ul class="icons-list mt-15">
				                    	<li><button type="button" class="btn btn-primary btn-float btn-float-md btn-rounded legitRipple"><i class="icon-target"></i></button></li>
				                    	</ul>
						    	</div>
					    	</div>
						</div>	
						
						
						<div class="col-lg-4 col-md-6 eachtracker">
							<div class="thumbnail">
								<div class="thumb thumb-rounded">
									<img src="img/datapresentation.jpg" alt="">
									
								</div>
							
						    	<div class="caption text-center">
						    		<h6 class="text-semibold no-margin">James Alexander <small class="display-block">Lead developer</small></h6>
					    			<ul class="icons-list mt-15">
				                    	<li><button type="button" class="btn btn-primary btn-float btn-float-md btn-rounded legitRipple"><i class="icon-target"></i></button></li>
				                    	</ul>
						    	</div>
					    	</div>
						</div>	

				<div class="col-lg-4 col-md-6 eachtracker">
							<div class="thumbnail">
								<div class="thumb thumb-rounded">
									<img src="img/datapresentation.jpg" alt="">
									
								</div>
							
						    	<div class="caption text-center">
						    		<h6 class="text-semibold no-margin">James Alexander <small class="display-block">Lead developer</small></h6>
					    			<ul class="icons-list mt-15">
				                    	<li><button type="button" class="btn btn-primary btn-float btn-float-md btn-rounded legitRipple"><i class="icon-target"></i></button></li>
				                    		</ul>
						    	</div>
					    	</div>
						</div>	

				<div class="col-lg-4 col-md-6 eachtracker">
							<div class="thumbnail">
								<div class="thumb thumb-rounded">
									<img src="img/datapresentation.jpg" alt="">
									
								</div>
							
						    	<div class="caption text-center">
						    		<h6 class="text-semibold no-margin">James Alexander <small class="display-block">Lead developer</small></h6>
					    			<ul class="icons-list mt-15">
				                    	<li><button type="button" class="btn btn-primary btn-float btn-float-sm btn-rounded legitRipple"><i class="icon-pencil"></i></button> <button type="button" class="btn btn-primary btn-float btn-float-sm btn-rounded legitRipple"><i class="icon-dashboard"></i></button></li>
				                    				                    	</ul>
						    	</div>
					    	</div>
						</div>	

				
				<div class="col-lg-4 col-md-6">
							<div class="thumbnail">
								<div class="thumb thumb-rounded">
									<img src="img/plus.jpg" alt="">
								
								</div>
							
						    	<div class="caption text-center">
						    		<h6 class="text-semibold no-margin"> Add New Tracker<small class="display-block"> Set up a New tracker</small></h6>
					    			<ul class="icons-list mt-15">
				                    	
				                    	<li><a href="#" data-popup="tooltip" title="" data-container="body" data-original-title="Set Up Tracker"><button type="button" class="btn btn-primary btn-float btn-float-md btn-rounded legitRipple"><i class="icon-plus-circle2"></i></button></a></li>
			                    	
			                    	
					    	</ul>
						    	</div>
					    	</div>
						</div>	

					
					</div>
			<div class="col-md-3">
				<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Top Trackers from Community<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 1</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 2</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 3</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 4</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 5</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 6</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 7</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 8</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 9</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 10</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 11</a>
							<a href="#" class="list-group-item"><i class="icon-paperplane"></i>Tracker 12</a>
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
	<div class="footer text-muted">
		&copy; 2017. <a href="#">Blogtracker</a> All Right Reserved
	</div>
	<!-- /footer -->


<!-- handles the dynamic updatee of content-->
<script>
	$(document).ready(function(e){
	$('.eachtracker').each(function(index,element){
	$('.eachtracker:eq('+index+')').click(function(f){
	$('#trackername').html('<i class="icon-target text-size-mini position-left"></i> Tracker Default');	
	$('#createddate').html('<i class="icon-calendar text-size-mini position-left"></i> July 12, 208');
	$('#noofblog').html('<i class="text-size-mini position-left icon-angle"></i>560');
	$('#description').html('<i class="text-size-mini position-left icon-info22"></i>Tracking about wale');
	
	});
	});	
	});
	</script>
</body>
</html>