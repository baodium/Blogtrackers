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
        ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
        if(session.getAttribute("tracker") == null || session.getAttribute("tracker") =="")
        { 
       		response.sendRedirect("trackerlist.jsp");
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
								<!--<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span> <b class="caret"></b>
									</button>-->
			                	</div>
							</div>

							<div class="panel-body">

							<button onclick="transition()">
<script src="//d3js.org/d3.v4.min.js"></script>
<script>

var n = 20, // number of layers
    m = 200, // number of samples per layer
    stack = d3.stack().keys(d3.range(n).map(function (d) { return "layer"+d; })).offset(d3.stackOffsetWiggle);

// Create empty data structures
var matrix0 = d3.range(m).map(function (d) { return { x:d }; });
var matrix1 = d3.range(m).map(function (d) { return { x:d }; });

// Fill them with random data
d3.range(n).map(function(d) { bumpLayer(m, matrix0, d); });
d3.range(n).map(function(d) { bumpLayer(m, matrix1, d); });

var layers0 = stack(matrix0),
    layers1 = stack(matrix1);

var width = 960,
    height = 500;

var x = d3.scaleLinear()
    .domain([0, m - 1])
    .range([0, width]);

var y = d3.scaleLinear()
    .domain([d3.min(layers0.concat(layers1), function(layer) { return d3.min(layer, function(d) { return d[0]; }); }), d3.max(layers0.concat(layers1), function(layer) { return d3.max(layer, function(d) { return d[1]; }); })])
    .range([height, 0]);

var color = d3.scaleLinear()
    .range(["#aad", "#556"]);

var area = d3.area()
    .x(function(d,i) { return x(d.data.x); })
    .y0(function(d) { return y(d[0]); })
    .y1(function(d) { return y(d[1]); });

var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);

svg.selectAll("path")
    .data(layers0)
  .enter().append("path")
    .attr("d", area)
    .style("fill", function() { return color(Math.random()); });

function transition() {
  d3.selectAll("path")
      .data(function() {
        var d = layers1;
        layers1 = layers0;
        return layers0 = d;
      })
    .transition()
      .duration(2500)
      .attr("d", area);
}

// Inspired by Lee Byron's test data generator.
function bumpLayer(n, matrix, layer) {

  function bump(a) {
    var x = 1 / (.1 + Math.random()),
        y = 2 * Math.random() - .5,
        z = 10 / (.1 + Math.random());
    for (var i = 0; i < n; i++) {
      var w = (i / n - y) * z;
      a[i] += x * Math.exp(-w * w);
    }
  }

  var a = [], i;
  var i;
  for (i = 0; i < n; ++i) a[i] = 0;
  for (i = 0; i < 5; ++i) bump(a);
  return a.forEach(function(d, i) { matrix[i]["layer"+layer]=Math.max(0, d)+1; });
}

</script>

						
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
