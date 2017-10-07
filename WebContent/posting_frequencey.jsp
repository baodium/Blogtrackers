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
					<span class="text-semibold">Posting Frequency</span>
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
				<div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Posting Frequency<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<form name="dateform" id="dateform" method="post">
									<div class="heading-elements" id="reportrange" action="PostingFrequency">
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" /><b class="caret"></b>
									</button>
			                	</div>
								</form>
							</div>

							<div class="panel-body">
							
							<div class="col-lg-8 col-md-8 col-sm-12">
								<div class="chart-container">
							<div class="chart" id="c3-line-regions-chart"></div>
						</div>						
							</div>
					
								<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
		<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Top Bloggers<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						
<table class="table text-nowrap">
									<thead>
										<tr>
											<th>Blogger Name</th>
											
											<th>Blog Count</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">S</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="#" class="letter-icon-title">Wolnemedia</a>
													</div>

													<div class="text-muted text-size-small"><i class="icon-checkmark3 text-size-mini position-left"></i>US</div>
												</div>
											</td>
											
											<td>
												<h6 class="text-semibold no-margin">1306</h6>
											</td>
										</tr>

										<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-danger-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">A</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="#" class="letter-icon-title">AdNovum</a>
													</div>

													<div class="text-muted text-size-small"><i class="icon-spinner11 text-size-mini position-left"></i>Russia</div>
												</div>
											</td>
											<td>
												<h6 class="text-semibold no-margin">279</h6>
											</td>
										</tr>

										<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-indigo-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">D</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="#" class="letter-icon-title">brusek</a>
													</div>

													<div class="text-muted text-size-small"><i class="icon-lifebuoy text-size-mini position-left"></i>Germany</div>
												</div>
											</td>
											
											<td>
												<h6 class="text-semibold no-margin">249</h6>
											</td>
										</tr>

										<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-success-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">O</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="#" class="letter-icon-title">Steve Marinucci</a>
													</div>

													<div class="text-muted text-size-small"><i class="icon-lifebuoy text-size-mini position-left"></i>US</div>
												</div>
											</td>
											
											<td>
												<h6 class="text-semibold no-margin">10</h6>
											</td>
										</tr>

										<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-danger-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">A</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="#" class="letter-icon-title">Steven Ruygrok</a>
													</div>

													<div class="text-muted text-size-small"><i class="icon-spinner11 text-size-mini position-left"></i>US</div>
												</div>
											</td>
											
											<td>
												<h6 class="text-semibold no-margin">5</h6>
											</td>
										</tr>
									</tbody>
								</table>
   
							</div>
						</div>
					
				</div>				
							
							</div>
								
							
										
																
							
							
							
							
							</div>
					</div>
					</div>
				<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Browser<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Post<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						
	
						<table class="table datatable-basic">
						<thead>
							<tr>
								<th>Blog Post Title</th>
								<th class="hidden" width="0%" >Frequency</th>
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Choosing sandals that meet the corporate casual dress code <a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right"
													>
														<span class="letter-icon icon-eye2"></span>
													</a></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
							</tbody>
							</table>
   
							</div>
						</div>
					</div>
						
<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Content<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<textarea disabled class="form-control" rows="12">Celebrated South Florida Chef Lindsay Autry is close to opening the doors of The Regional Kitchen & Public House at CityPlace in West Palm Beach. Over the past couple of months, construction has transformed the blank, open space into the vision Chef Autry & Thierry Beaud have of an open pantry kitchen, with a main dining room tastefully partitioned to create a warm and intimate ambiance. The restaurant will have outdoor seating on the refinished patio, significant private dining space and a distinct elaborate bar and lounge area. “As a chef that has built a home and career in the Palm Beach area over the past several years, the launch of this amazing project excites me both personally and professionally,” Autry said. Continuing to be inspired by consciously sourced ingredients, Autry has spent close to a decade working closely with South Florida’s most fundamental industry professionals - fisherman, farmers, and culinary artisans. Her intimate knowledge of regional product, as well as that of the exceptional product sourced beyond Florida’s borders, is matched only by the extraordinary culinary talents that have earned her industry celebrity and continued national acclaim. During her most recent visit to Kai-Kai Farm in Indiantown, Fla., Autry began to choose some of the selections of the best local ingredients for The Regional Kitchen & Public House’s new and evolving menu. “We toured the farm, ate warm strawberries right off the vine, and got our hands dirty. Knowing where our food comes from, seeing it through the whole process from ground to plate, those are the things I’ve dreamed of for this project,” Autry said. The Regional Kitchen & Public House, Autry said, intends to present a unique perspective on America’s time-honored cuisine through local ingredients, seasonally influenced dishes and the soulful inspiration of a chef-driven kitchen. “We are very excited to become a part of the Okeechobee corridor rebirth along with brands like Restoration Hardware and large new developments such as the beautiful convention center hotel.” said restaurateur Thierry Beaud. The Regional Kitchen & Public House will become the fifth restaurant concept for the TITOU Hospitality Group under Beaud’s leadership. Some of The Region’s fresh menu items will include: * Florida Sweet Corn & Heirloom Tomato Salad: butter lettuce, crispy okra, buttermilk ranch * House Chorizo & Key Clams: trofie pasta, spinach, braised fennel * Boneless Half Chicken: lemony orzo risotto, brussel leaves, feta & pepperoncini * Local Snapper in Banana Leaf: salsa verde, roasted tomatoes & radishes Autry’s culinary skills have earned her the opportunity to work alongside some of the best chefs in at prominent restaurants along the East Coast and in Mexico. A graduate of Johnson & Wales University, Autry honed her skill under James Beard Award winning Chef Michelle Bernstein, working as sous, then executive chef at a number of Bernstein’s top restaurants before headlining as a “Top Chef” finalist. Autry was Executive Chef of the historic Sundy House in Delray Beach, Fla., with whom she also traveled to New York City to cook at the prestigious James Beard House, and in Spring 2015, Autry won the Miami leg in the traveling culinary battle COCHON 555, which allowed her to compete against the country’s best in the final Grand COCHON competition during the 2015 Aspen Food & Wine.
   
						</textarea>
                        
							</div>
						</div>
					</div>
   
							</div>
						</div>
					
					</div>
					
					
					
				
				
				      
				      
				      
				      
				      
				    
			      
			      
				      
					
					
						<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">List of Domains<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<table class="table datatable-basic">
						<thead>
							<tr>
								<th>URL</th>
								<th>Frequency</th>
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Marth</td>
								<td><a href="#">Enright</a></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
							</tbody>
							</table>

   
							</div>
						</div>
					</div>
					
					
					
					
						<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Top Entities<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<table class="table datatable-basic">
						<thead>
							<tr>
								<th>Name</th>
								<th> Type</th>
								<th > Frequency</th>
								<th >Positive</th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>GTX</td>
								<td >Automobile</td>
								<td >1</td>
								<td>0.5205</td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
							</tbody>
							</table>

   
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
	<!-- /page container -->


    <!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
	<!-- Dependencies -->
  <jsp:include page="pagedependencies/postingfrequency.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
