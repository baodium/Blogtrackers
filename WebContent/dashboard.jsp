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
					<span class="text-semibold">Home</span> - Dashboard
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

			<!--  <div class="heading-elements">
				<div class="heading-btn-group">
					<a href="#" class="btn btn-link btn-float has-text text-size-small"><i class="icon-bars-alt text-indigo-400"></i><span>Statistics</span></a>
					<a href="#" class="btn btn-link btn-float has-text text-size-small"><i class="icon-calendar5 text-indigo-400"></i> <span>Schedule</span></a>
				</div>
			</div>-->
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
				<!--  <div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Set Up Tracker<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
				                		<li><a data-action="close"></a></li>
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							<div class="form-group">
							<label class="col-lg-2 control-label">Search For Tracker:</label>
							<div class="col-lg-7">
							<input type="text" class="form-control" placeholder="Search for Tracker">
							</div>
							<div class="col-lg-3">
							<div class="text-right">
							<button type="submit" class="btn btn-primary legitRipple">Search Now <i class="icon-arrow-right14 position-right"></i></button>
							</div>
							</div>		
										
							</div>
							
							
							
							</div>
					</div>
					</div>-->
				<div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Dashboard Statistics<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
				                		
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body" align="center">
							<div class="col-md-1">

</div>
							<div class="col-md-2 col-sm-6">

								<!-- Available hours -->
								<div class="panel text-center">
									<div class="panel-body">
									

					                	<!-- Progress counter -->
										<div class="content-group-sm svg-center position-relative" id="hours-available-progress"><svg width="76" height="76"><g transform="translate(38,38)"><path class="d3-progress-background" d="M0,38A38,38 0 1,1 0,-38A38,38 0 1,1 0,38M0,36A36,36 0 1,0 0,-36A36,36 0 1,0 0,36Z" style="fill: rgb(238, 238, 238);"></path><path class="d3-progress-foreground" filter="url(#blur)" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); stroke: rgb(240, 98, 146);"></path><path class="d3-progress-front" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); fill-opacity: 1;"></path></g></svg><h2 class="mt-15 mb-5">${nblogs}</h2><i class="icon-book text-pink-400 counter-icon" style="top: 22px"></i><div>Blogs</div></div>
										<!-- /progress counter -->


										

									</div>
								</div>
								<!-- /available hours -->

							</div>
							
						<div class="col-md-2 col-sm-6">

								<!-- Productivity goal -->
								<div class="panel text-center">
									<div class="panel-body">
										

										<!-- Progress counter -->
										<div class="content-group-sm svg-center position-relative" id="goal-progress"><svg width="76" height="76"><g transform="translate(38,38)"><path class="d3-progress-background" d="M0,38A38,38 0 1,1 0,-38A38,38 0 1,1 0,38M0,36A36,36 0 1,0 0,-36A36,36 0 1,0 0,36Z" style="fill: rgb(238, 238, 238);"></path><path class="d3-progress-foreground" filter="url(#blur)" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.3834279937087,-16.179613079472855L-32.573773888776664,-15.328054496342704A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(92, 107, 192); stroke: rgb(92, 107, 192);"></path><path class="d3-progress-front" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.3834279937087,-16.179613079472855L-32.573773888776664,-15.328054496342704A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(92, 107, 192); fill-opacity: 1;"></path></g></svg><h2 class="mt-15 mb-5">${nbloggers}</h2><i class="icon-earth text-indigo-400 counter-icon" style="top: 22px"></i><div>Bloggers</div></div>
										<!-- /progress counter -->

										

									</div>
								</div>
								<!-- /productivity goal -->

							</div>
							
								<div class="col-md-2">

								<!-- Available hours -->
								<div class="panel text-center">
									<div class="panel-body">
									

					                	<!-- Progress counter -->
										<div class="content-group-sm svg-center position-relative" id="hours-available-progress"><svg width="76" height="76"><g transform="translate(38,38)"><path class="d3-progress-background" d="M0,38A38,38 0 1,1 0,-38A38,38 0 1,1 0,38M0,36A36,36 0 1,0 0,-36A36,36 0 1,0 0,36Z" style="fill: rgb(238, 238, 238);"></path><path class="d3-progress-foreground" filter="url(#blur)" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); stroke: rgb(240, 98, 146);"></path><path class="d3-progress-front" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); fill-opacity: 1;"></path></g></svg><h2 class="mt-15 mb-5">${nblogposts}</h2><i class="icon-comment text-pink-400 counter-icon" style="top: 22px"></i><div>Blogs</div></div>
										<!-- /progress counter -->


										

									</div>
								</div>
								<!-- /available hours -->

							</div>

  
                        
                    	<div class="col-md-2 col-sm-6">

								<!-- Productivity goal -->
								<div class="panel text-center">
									<div class="panel-body">
										

										<!-- Progress counter -->
										<div class="content-group-sm svg-center position-relative" id="goal-progress"><svg width="76" height="76"><g transform="translate(38,38)"><path class="d3-progress-background" d="M0,38A38,38 0 1,1 0,-38A38,38 0 1,1 0,38M0,36A36,36 0 1,0 0,-36A36,36 0 1,0 0,36Z" style="fill: rgb(238, 238, 238);"></path><path class="d3-progress-foreground" filter="url(#blur)" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.3834279937087,-16.179613079472855L-32.573773888776664,-15.328054496342704A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(92, 107, 192); stroke: rgb(92, 107, 192);"></path><path class="d3-progress-front" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.3834279937087,-16.179613079472855L-32.573773888776664,-15.328054496342704A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(92, 107, 192); fill-opacity: 1;"></path></g></svg><h2 class="mt-15 mb-5">${npsenti}</h2><i class="icon-plus-circle2 text-indigo-400 counter-icon" style="top: 22px"></i><div>Positive Sentiments</div></div>
										<!-- /progress counter -->

										

									</div>
								</div>
								<!-- /productivity goal -->

							</div>
							
								<div class="col-md-2 col-sm-6">

								<!-- Available hours -->
								<div class="panel text-center">
									<div class="panel-body">
									

					                	<!-- Progress counter -->
										<div class="content-group-sm svg-center position-relative" id="hours-available-progress"><svg width="76" height="76"><g transform="translate(38,38)"><path class="d3-progress-background" d="M0,38A38,38 0 1,1 0,-38A38,38 0 1,1 0,38M0,36A36,36 0 1,0 0,-36A36,36 0 1,0 0,36Z" style="fill: rgb(238, 238, 238);"></path><path class="d3-progress-foreground" filter="url(#blur)" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); stroke: rgb(240, 98, 146);"></path><path class="d3-progress-front" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); fill-opacity: 1;"></path></g></svg><h2 class="mt-15 mb-5">${npsenti}</h2><i class="icon-minus-circle2 text-pink-400 counter-icon" style="top: 22px"></i><div>Negative Sentiments</div></div>
										<!-- /progress counter -->


										

									</div>
								</div>
								<!-- /available hours -->

							</div>
							
							<div class="col-md-1">
</div>
							
				
				       
					
							</div>
						</div>
					</div>
				
				
				      
					
				</div>
				<!-- /main charts -->


				<!-- Dashboard content -->
				<div class="row">
				<div class="col-lg-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h5 class="panel-title">Blogsites Location Distribution</h5>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="reload"></a></li>
<!--		                		<li><a data-action="close"></a></li>-->
		                	</ul>
	                	</div>
					</div>

					<div class="panel-body">
					<div class="col-md-4" style="overflow-y: scroll;">
											<table class="countries_list">
												<tbody>
													<c:forEach items="${nloc}" var="v1" begin="0" end="5">
														<tr>
															<td class="fs15 fw700 text-right">${v1[1]}</td>
															<td>${v1[0]}%</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
										
<!--						<p class="content-group">Example of a <code>choropleth</code> world map. A choropleth map is a thematic map in which areas are shaded or patterned in proportion to the measurement of the statistical variable being displayed on the map. The choropleth map provides an easy way to visualize how a measurement varies across a geographic area or it shows the level of variability within a region. This example displays GDP by country, data stored in <code>json</code> file.</p>-->
						
						
						
						<div id="world-map-gdp" class="col-md-8 col-sm-12 col-xs-12"
											style="height: 420px;"></div>
					</div>
				</div>
				
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h5 class="panel-title">Blogsites Language Distribution</h5>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="reload"></a></li>
<!--		                		<li><a data-action="close"></a></li>-->
		                	</ul>
	                	</div>
					</div>

					<div class="panel-body">
<!--						<p class="content-group">Example of a <code>choropleth</code> world map. A choropleth map is a thematic map in which areas are shaded or patterned in proportion to the measurement of the statistical variable being displayed on the map. The choropleth map provides an easy way to visualize how a measurement varies across a geographic area or it shows the level of variability within a region. This example displays GDP by country, data stored in <code>json</code> file.</p>-->
						
					
					
					<div class="bubble" style="width: 70%; clear: all; float: right; padding-left:150px"></div>

										</div>
					</div>
				</div>
				</div>
				
				</div>
				<!-- /dashboard content -->
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->


	<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
	
	<!-- Dependencies -->
  <jsp:include page="pagedependencies/dashboard.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
