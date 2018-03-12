<%-- 
    Document   : Topic Distribution
    Created on : 21-January-2018
    Author     : Adigun Adekunle
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*"%>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
	else
	{    ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
        if(session.getAttribute("tracker") == null || session.getAttribute("tracker") =="")
        { 
       		response.sendRedirect("trackerlist.jsp");
        }
	}
%>



 <jsp:include page="include_top.jsp"></jsp:include>
<%

 %>

	<!-- Page header -->
	<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<a href="<%=request.getContextPath()%>/analytics.jsp"><i class="icon-arrow-left52 position-left"></i></a>
					<span class="text-semibold">Topic Distribution</span>

				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List  </a></li>
					<li><a href="edittracker.jsp" title="Edit <%=session.getAttribute("tracker")%> Tracker"><%=session.getAttribute("tracker")%></a></li>
					<li><a href="analytics.jsp">Analytics</a></li>
						<li class="active">Topic Distribution</li>
				</ul>
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
				
				<div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Topic Trends<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
								<form name="dateform" id="dateform" method="post">
									<div data-intro="Select a date range " data-step="2" id="reportrange">
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					<b class="caret"></b>
									</button>
									<input type="hidden" name="is_request" value="yes">
									<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" />
			                	</div>
								</form>

			                	</div>
							</div>

							<div class="panel-body">

							

<div class="chart-container">
							<div class="chart" id="d3-streamgraph"></div>
						</div>

						
							</div>








							</div>
					</div>
					
					
						<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Topic words<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
								<th>Topics</th>
								<th>Words</th>
								<th></th>
								<th></th>
								<th></th>
								
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Topic 1</td>
								<td>Word 1</td>
								<td>Word 2</td>
								<td>Word 3</td>
								<td>Word 4</td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
								<tr>
								<td>Topic 2</td>
								<td>Word 1</td>
								<td>Word 2</td>
								<td>Word 3</td>
								<td>Word 4</td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
								<tr>
								<td>Topic 3</td>
								<td>Word 1</td>
								<td>Word 2</td>
								<td>Word 3</td>
								<td>Word 4</td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
								<tr>
								<td>Topic 4</td>
								<td>Word 1</td>
								<td>Word 2</td>
								<td>Word 3</td>
								<td>Word 4</td>
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



				<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Topic Document<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
						<div class="panel panel-default">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Post Title<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
								<th>Post Title</th>
								<th class="hidden" width="0%" ></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
							
							<tr>
		<td>Title 1 <a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right">
														<span class="letter-icon icon-eye2 view"></span>
													</a></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
							<tr>
								<td>Title 2 <a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right"
													>
														<span class="letter-icon icon-eye2 view"></span>
													</a></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
								<tr>
								<td>Title 3 <a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right"
													>
														<span class="letter-icon icon-eye2 view"></span>
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
						<div class="panel panel-default">
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
						<textarea disabled class="form-control" id="contentfill" rows="12">Celebrated South Florida Chef Lindsay Autry is close to opening the doors of The Regional Kitchen & Public House at CityPlace in West Palm Beach. Over the past couple of months, construction has transformed the blank, open space into the vision Chef Autry & Thierry Beaud have of an open pantry kitchen, with a main dining room tastefully partitioned to create a warm and intimate ambiance. The restaurant will have outdoor seating on the refinished patio, significant private dining space and a distinct elaborate bar and lounge area. “As a chef that has built a home and career in the Palm Beach area over the past several years, the launch of this amazing project excites me both personally and professionally,” Autry said. Continuing to be inspired by consciously sourced ingredients, Autry has spent close to a decade working closely with South Florida’s most fundamental industry professionals - fisherman, farmers, and culinary artisans. Her intimate knowledge of regional product, as well as that of the exceptional product sourced beyond Florida’s borders, is matched only by the extraordinary culinary talents that have earned her industry celebrity and continued national acclaim. During her most recent visit to Kai-Kai Farm in Indiantown, Fla., Autry began to choose some of the selections of the best local ingredients for The Regional Kitchen & Public House’s new and evolving menu. “We toured the farm, ate warm strawberries right off the vine, and got our hands dirty. Knowing where our food comes from, seeing it through the whole process from ground to plate, those are the things I’ve dreamed of for this project,” Autry said. The Regional Kitchen & Public House, Autry said, intends to present a unique perspective on America’s time-honored cuisine through local ingredients, seasonally influenced dishes and the soulful inspiration of a chef-driven kitchen. “We are very excited to become a part of the Okeechobee corridor rebirth along with brands like Restoration Hardware and large new developments such as the beautiful convention center hotel.” said restaurateur Thierry Beaud. The Regional Kitchen & Public House will become the fifth restaurant concept for the TITOU Hospitality Group under Beaud’s leadership. Some of The Region’s fresh menu items will include: * Florida Sweet Corn & Heirloom Tomato Salad: butter lettuce, crispy okra, buttermilk ranch * House Chorizo & Key Clams: trofie pasta, spinach, braised fennel * Boneless Half Chicken: lemony orzo risotto, brussel leaves, feta & pepperoncini * Local Snapper in Banana Leaf: salsa verde, roasted tomatoes & radishes Autry’s culinary skills have earned her the opportunity to work alongside some of the best chefs in at prominent restaurants along the East Coast and in Mexico. A graduate of Johnson & Wales University, Autry honed her skill under James Beard Award winning Chef Michelle Bernstein, working as sous, then executive chef at a number of Bernstein’s top restaurants before headlining as a “Top Chef” finalist. Autry was Executive Chef of the historic Sundy House in Delray Beach, Fla., with whom she also traveled to New York City to cook at the prestigious James Beard House, and in Spring 2015, Autry won the Miami leg in the traveling culinary battle COCHON 555, which allowed her to compete against the country’s best in the final Grand COCHON competition during the 2015 Aspen Food & Wine.

						</textarea>

							</div>
						</div>
					</div>

							</div>
						</div>

					</div>




















				</div>
				<!-- /main charts -->





			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>

	
	<!-- /page container -->


	
	<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
	
<!-- Dependencies -->
  <jsp:include page="pagedependencies/topic_distribution.jsp"></jsp:include>
  <!-- End of Dependencies -->
</body>
</html>
