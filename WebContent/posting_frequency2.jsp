<%@page import="java.io.File"%>
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");

	String tracker_id = (null == session.getAttribute("tid")) ? "" : session.getAttribute("tid").toString();
	

    String path=application.getRealPath("/").replace('\\', '/')+"profile_images/";
    path = path.replace("build/", "");
    String filename = path+session.getAttribute("username")+".jpg";
    String pimage = "assets/images/placeholder.jpg";
    File f = new File(filename);
    if(f.exists() && !f.isDirectory()) { 
       pimage = "profile_images/"+session.getAttribute("username")+".jpg";
   }
    
    ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
    ArrayList trackers = (ArrayList)session.getAttribute("trackers");
%>
<html lang="en">
<head>
<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" rel="stylesheet" type="text/css">
	<link href="assets/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
	<link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="assets/css/core.css" rel="stylesheet" type="text/css">
	<link href="assets/css/components.css" rel="stylesheet" type="text/css">
	<link href="assets/css/colors.css" rel="stylesheet" type="text/css">
	<link href="assets/css/mystyle.css" rel="stylesheet" type="text/css">
	<!-- /global stylesheets -->

	<!-- Core JS files -->
	<script type="text/javascript" src="assets/js/plugins/loaders/pace.min.js"></script>
	<script type="text/javascript" src="assets/js/core/libraries/jquery.min.js"></script>
	<script type="text/javascript" src="assets/js/core/libraries/bootstrap.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/loaders/blockui.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/nicescroll.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/drilldown.js"></script>
	<!-- /core JS files -->

	<!--  before Theme JS files -->
	


	<script type="text/javascript" src="assets/js/plugins/visualization/d3/d3.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/visualization/d3/d3_tooltip.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/moment/moment.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/pickers/daterangepicker.js"></script>
<script type="text/javascript" src="assets/js/plugins/tables/datatables/datatables.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/selects/select2.min.js"></script>

<script type="text/javascript" src="assets/js/pages/datatables_basic.js"></script>
<!--   <script type="text/javascript" src="assets/js/charts/d3/bars/bars_basic_vertical.js"></script>-->
   <script type="text/javascript" src="assets/js/plugins/visualization/c3/c3.min.js"></script>

		<script type="text/javascript" src="assets/js/charts/c3/c3_lines_areas.js"></script>

	<script type="text/javascript" src="assets/js/core/app.js"></script>
	<script type="text/javascript" src="assets/js/pages/dashboard.js"></script>

 
		
	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
	<!-- /theme JS files -->
<!--<script type="text/javascript" src="assets/js/pages/form_select2.js"></script>-->
	<!-- /global stylesheets -->
</head>

<body>

	<!-- Main navbar -->
	<div class="navbar navbar-inverse" style="background-color:#2A6ADF">
		<div class="navbar-header">
			<a class="navbar-brand" href="features.jsp"><i class="icon-puzzle3 position-left"></i><span style="font-size:18px">Blogtrackers</span></a>
						
			
		</div>

		
		
			<div class="navbar-collapse collapse" id="navbar-mobile">
			<% 
			String Selectedtracker  = (String)session.getAttribute("tracker"); 

			%>
				<ul class="nav navbar-nav navbar-right">
			<% if(username!=""){ %>
				<li class="language-switch"">
			<form name="trackerform" id="trackerform" action="" method="post">
<!--  
<<<<<<< HEAD
			<select id="tracker" name="tracker" onchange="trackerchanger()" class="form-control">
								
			<% 
			
			String isselecttwo;
			if(trackers != null && trackers.size()>0){ 
			for(int i=0; i<trackers.size(); i++){
			String isselect = "";
			ArrayList tracker = (ArrayList)trackers.get(i);
			String name = tracker.get(0).toString(); 
			if(name.equals(Selectedtracker)){
				isselect = "selected";
				session.setAttribute("tracker",tracker.get(0));
			}
			%>
			<option <%=isselect%> value="<%=tracker.get(0)%>"><%=tracker.get(2)%></option>
			<% } }else{ %>
			<option value=""> no tracker created yet </option>
			<% } %>			
			</select>
			</form>
			</li>
				
=======
-->
			<select id="tracker" name="tracker" onchange="trackerchanged()" class="form-control" value="${item}">
					                    
				                    <c:choose>
										<c:when test="${tracker != null}">
											<option selected value="">${tracker} </option>
										</c:when>

										<c:when test="${tracker == null}">
											<option value="">Select Tracker</option>
										</c:when>
									</c:choose>

									<c:forEach items="${trackers}" var="item">
										<c:if test="${tracker ne item}">
											<option value="${item.get(2)}"><c:out value="${item.get(2)}" /></option>
										</c:if>c:if>
									</c:forEach>
									</select>
									</form>
									</li>
			


				
				<li class="dropdown dropdown-user">
					<a class="dropdown-toggle" data-toggle="dropdown">
						<img src="<%=pimage%>" width="34" height="34" alt="">
						<span><%=session.getAttribute("username")%></span>
						<i class="caret"></i>
					</a>

					<ul class="dropdown-menu dropdown-menu-right">
						<li><a href="<%=request.getContextPath()%>/profile"><i class="icon-user-plus"></i> My profile</a></li>
						<li class="divider"></li>
						<li><a href="<%=request.getContextPath()%>/features.jsp"><i class="icon-cog5"></i> Features</a></li>
						<li><a href="<%=request.getContextPath()%>/help.jsp"><i class="icon-help"></i> Help</a></li>
						<li><a href="<%=request.getContextPath()%>/logout"><i class="icon-switch2"></i> Logout</a></li>			
					</ul>
				</li>
				<% }else{ %>
				<li><a href="<%=request.getContextPath()%>/login"><i class="icon-switch2"></i> Login</a></li>			
				
				<% } %>

			</ul>
			
		</div>
			
	
		</div>
	</div>
	<!-- /main navbar -->

	
	
  <div class="navbar navbar-default" id="navbar-second">
		
		<div class="navbar-collapse collapse" id="navbar-second-toggle">
			<ul class="nav navbar-nav navbar-nav-material">
				<li class=""><a href="<%=request.getContextPath()%>/dashboard.jsp"><i class="icon-display4 position-left"></i> Dashboard</a></li>
				<li onclick="location.href='basic.jsp'">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<i class="icon-chart position-left"></i> Basic Analytics
					</a>
					
				</li>
				<li><a href="<%=request.getContextPath()%>/PostingFrequency"><i class="fa fa-line-chart"></i>Posting
							Frequency<span class="fa fa-chevron-right"></span></a></li>
				<li onclick="location.href='advance.jsp'">
					<a class="">
						<i class="icon-stats-bars2 position-left"></i> Advanced Analytics
					</a>
					
					
				</li>
								  <li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<i class="icon-stars position-left"></i> Services<span class="caret"></span>
					</a>
					<ul class="dropdown-menu width-200">
					<li class="dropdown-header">Services</li>
					<li class="dropdown-submenu">
							<a href="#"><i class="icon-circle2"></i> Upgrade Options</a>
							<ul class="dropdown-menu width-200">
								<li class="dropdown-header highlight">Options</li>
								<li><a href="http://blogtrackers.host.ualr.edu" target="_blank"><i class="icon-paperplane spinner"></i>Plans</a></li>
								<li><a href="http://blogtrackers.host.ualr.edu" target="_blank"><i class="icon-comments spinner"></i>Testimonials</a></li>
								
							</ul>
							
					</li>
					<li class="dropdown-submenu">
					<a href="#"><i class="icon-video-camera2"></i> Training</a>
							<ul class="dropdown-menu width-200">
								<li class="dropdown-header highlight">Options</li>
								<li><a> <i class="icon-video-camera-slash spinner"></i>Video Tutorials</a></li>
								<li ><a ><i class="icon-file-pdf spinner"></i>Download PDF</a></li>
								
							</ul>
							</li>
							<li>
					<a href="#"><i class="icon-headphones"></i> Support</a>
				
						</li>
					</ul>
				</li>
			
			</ul>
			
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
								<div class="heading-elements">
								<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span> <b class="caret"></b>
									</button>
			                	</div>
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

</body>
</html>
