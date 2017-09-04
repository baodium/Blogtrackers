<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@page import="java.util.*"%>
<%
	Object username = (null == session.getAttribute("user")) ? "" : session.getAttribute("user");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");

	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">



<title>Blogtrackers | Additional Info</title>

<!-- Bootstrap -->
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link
	href="${pageContext.request.contextPath}/vendors/nprogress/nprogress.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet">
<!-- Custom Theme Style -->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<link href="${pageContext.request.contextPath}/build/css/custom.min.css"
	rel="stylesheet">
<!-- <link href="build/css/grid.css" rel="stylesheet"> -->
<style>
div.scroll {
	overflow: scroll;
}
</style>
</head>

<div class="loader"></div>
<style>
.loader {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 9999;
	background: url('Resources/img/gif/Loading-data.gif') 50% 50% no-repeat
		rgb(249, 249, 249);
}
</style>

<script type="text/javascript">
	$(window).load(function() {
		$(".loader").addClass("hidden");
		//$(".loader").fadeOut("slow");
	})
</script>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">

			<jsp:include page="new_sidebar.jsp"></jsp:include>


			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<nav>
						<div class="nav toggle">
							<a id="menu_toggle"><i class="fa fa-bars"></i></a>
						</div>

						<div class="nav toggle"
							style="position: absolute; right: 35%; width: 30%;">
							<form name="trackerform" id="trackerform"
								action="AdditionalInfoServlet" method="post">
								<select id="tracker" name="tracker" onchange="trackerchanged()"
									value="${item}" class="form-control" required>
									<c:choose>
										<c:when test="${tracker != null}">
											<option value="">${tracker}</option>
										</c:when>

										<c:when test="${tracker == null}">
											<option value="">Select Tracker</option>
										</c:when>
									</c:choose>

									<c:forEach items="${trackers}" var="item">
										<c:if test="${tracker ne item}">
											<option value="${item}"><c:out value="${item}" /></option>
										</c:if>c:if>
									</c:forEach>
								</select>
							</form>

						</div>


						<ul class="nav navbar-nav navbar-right">
							<li class=""><a href="javascript:;"
								class="user-profile dropdown-toggle" data-toggle="dropdown"
								aria-expanded="false"> <!-- <img src="images/img.jpg"
									alt=""> --> <span class=" fa fa-angle-down"></span>
							</a>
								<ul class="dropdown-menu dropdown-usermenu pull-right">
									<li><a href="javascript:;"> Profile</a></li>
									<li><a href="javascript:;"> <span
											class="badge bg-red pull-right"></span> <span>Settings</span>
									</a></li>
									<li><a href="javascript:;">Help</a></li>
									<li><a
										href="${pageContext.request.contextPath}/test_logout.jsp""><i
											class="fa fa-sign-out pull-right"></i> Log Out</a></li>
								</ul></li>
							<li role="presentation" class="dropdown"><a
								href="javascript:;" class="dropdown-toggle info-number"
								data-toggle="dropdown" aria-expanded="false"> </a>
								<ul id="menu1" class="dropdown-menu list-unstyled msg_list"
									role="menu">
									<li><a> <span class="image"> <!-- <img src="images/img.jpg"
												alt="Profile Image" /> -->
										</span> <span> <span>Sender 1</span> <span class="time">3
													mins ago</span>
										</span> <span class="message"> Message.... </span>
									</a></li>
									<li>
										<div class="text-center">
											<a> <strong>See All Alerts</strong> <i
												class="fa fa-angle-right"></i>
											</a>
										</div>
									</li>
								</ul></li>
						</ul>
					</nav>
				</div>
			</div>

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="row top_tiles">
						<div class="form-group">
							<div class="col-md-5 col-sm-4 col-xs-12">
								<div class="col-md-12 col-sm-12 col-xs-12">
									<div style="height: 15px;"></div>
									<div class="col-md-12 col-sm-12 col-xs-12">
										<form name="sitesform" id="sitesform"
											action="AdditionalInfoServlet" method="post">
											<select id="allsitesid" name="allsitesid" value="${item}"
												onchange="siteChanged()" class="form-control" required>

												<c:choose>
													<c:when test="${bsName != null}">
														<option value="">${bsName}</option>
													</c:when>

													<c:when test="${bsName == null}">
														<option value="">Select Blogsite</option>
													</c:when>
												</c:choose>

												<c:forEach items="${allSepSites}" var="item">
													<c:if test="${bsName ne item.siteName}">
														<option value="${item.siteID},${item.siteName}"><c:out
																value="${item.siteName}" /></option>
													</c:if>
												</c:forEach>


											</select> <br />
										</form>

									</div>
								</div>
							</div>

							<script
								src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
							<script type="text/javascript"
								src="http://arrow.scrolltotop.com/arrow6.js"></script>
							<noscript>
								Not seeing a <a href="http://www.scrolltotop.com/">Scroll to
									Top Button</a>? Go to our FAQ page for more info.
							</noscript>





							<div class="row tile_count">
								<div class="col-md-1 col-sm-1 col-xs-12"></div>
								<div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
									<span class="count_top">Max Influence score</span>
									<div class="count">${maxScore}</div>
								</div>
								<div class="col-md-1 col-sm-4 col-xs-6 tile_stats_count">
									<span class="count_top"></span>
									<div class="count" style="height: 65px;"></div>
									<span class="count_bottom"></span>
								</div>
								<div class="col-md-2 col-sm-2 col-xs-12">
									<div class="col-md-12 col-sm-12 col-xs-12">
										<div style="height: 15px;"></div>
										<div class="col-md-12 col-sm-12 col-xs-12">

											<a href="${siteUrl}" target="_blank"
												class="btn btn-round btn-primary">Visit Blog Site</a>

										</div>
									</div>
								</div>
							</div>
							<div class="clearfix"></div>
							<div class="row">
								<div class="col-md-5 col-sm-12 col-xs-12">
									<div class="x_panel">
										<div class="x_title">
											<h2>
												Daily Average<small><span
													class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
													data-original-title="Give Text here!"></span></small>
											</h2>
											<div class="clearfix"></div>
										</div>
										<div class="x_content">
											<div class="col-md-12 col-sm-12 col-xs-12">
												<div class="demo-container">
													<div id="BarchartContainer" style="height: 350px"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-7 col-sm-12 col-xs-12">
									<div class="x_panel">
										<div class="x_title">
											<h2>
												Monthly Average<small><span
													class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
													data-original-title="Give Text here!"></span></small>
											</h2>
											<div class="clearfix"></div>
										</div>
										<div class="x_content">
											<div class="col-md-12 col-sm-12 col-xs-12">
												<div class="demo-container">
													<div id="chartContainer" style="height: 350px"></div>
												</div>
											</div>
										</div>
									</div>
								</div>

								<div class="col-md-12 col-sm-12 col-xs-12">
									<div class="x_panel">
										<div class="x_title">
											<h2>
												Average Sentiments<small><span
													class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
													data-original-title="Give Text here!"></span></small>
											</h2>
											<div class="clearfix"></div>
										</div>
										<div class="x_content">
											<div class="col-md-12">
												<div class="row" style="text-align: center;">
													<div class="col-md-4">
														<canvas id="canvas1i" height="210" width="210"
															style="margin: 5px 10px 10px 0"></canvas>
														<h4 style="margin: 0">${doughnut[2].year}</h4>
													</div>
													<div class="col-md-4">
														<canvas id="canvas1i2" height="210" width="210"
															style="margin: 5px 10px 10px 0"></canvas>
														<h4 style="margin: 0">${doughnut[1].year}</h4>
													</div>
													<div class="col-md-4">
														<canvas id="canvas1i3" height="210" width="210"
															style="margin: 5px 10px 10px 0"></canvas>
														<h4 style="margin: 0">${doughnut[0].year}</h4>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>



								<div class="clearfix"></div>
								<div class="col-md-6 col-sm-12 col-xs-12">
									<div class="x_panel">
										<div class="x_title">
											<h2>
												List of Domains<small><span
													class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
													data-original-title="Give Text here!"></span></small>
											</h2>
											<div class="clearfix"></div>
										</div>
										<div class="x_content">
											<div class="clearfix"></div>
											<div class="col-md-12 col-xs-12">
												<div class="x_panel">
													<div class="x_content">
														<div class="x_title">
															<div class="clearfix"></div>
															<div class="scroll" style="height: 343px;">
																<div class="x_content">
																	<table class="table table-hover" id="domain_id">
																		<thead>
																			<tr>
																				<th>URL <i class="fa fa-sort"></i></th>
																				<th>Frequency <i class="fa fa-sort"></i></th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:set var="i" value="0" />
																			<c:forEach items="${mostDomains}" var="s2"
																				begin="${i}">
																				<tr>
																					<td scope="row"><a href="${s2.link}"
																						target="_blank">${s2.link}</a></td>
																					<td scope="row">${s2.rank}</td>
																				</tr>
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>


								<div class="col-md-6 col-sm-12 col-xs-12">
									<div class="x_panel">
										<div class="x_title">
											<h2>
												List of URLs<small><span
													class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
													data-original-title="Give Text here!"></span></small>
											</h2>
											<div class="clearfix"></div>
										</div>
										<div class="x_content">
											<div class="clearfix"></div>
											<div class="col-md-12 col-xs-12">
												<div class="x_panel">
													<div class="x_content">
														<div class="x_title">
															<div class="clearfix"></div>
															<div class="scroll" style="height: 343px;">
																<div class="x_content">
																	<table class="table table-hover" id="url_id">
																		<thead>
																			<tr>
																				<th>URL <i class="fa fa-sort"></i></th>
																				<th>Frequency <i class="fa fa-sort"></i></th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:set var="i" value="0" />
																			<c:forEach items="${mostLinks}" var="s1" begin="${i}">
																				<tr>
																					<td scope="row"><a href="${s1.link}"
																						target="_blank">${s1.link}</a></td>
																					<td scope="row">${s1.rank}</td>
																				</tr>
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- /top navigation -->
					<!-- footer content -->

					<!-- /footer content -->
					<script
						src="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.min.js"></script>
					<script
						src="${pageContext.request.contextPath}/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
					<script
						src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
					<script
						src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
					<script
						src="${pageContext.request.contextPath}/vendors/Chart.js/dist/Chart.min.js"></script>
					<script
						src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>
					<script
						src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
					<script
						src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
					<script
						src="${pageContext.request.contextPath}/vendors/jQCloud-master/jqcloud/jqcloud-1.0.4.js"></script>
					<script
						src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
					<script
						src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>
					<script
						src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
					<script
						src="//cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>


					<script type="text/javascript">
						$(function() {
							$("#domain_id").dataTable({
								"bPaginate" : false,
								"bLengthChange" : false,
								"bFilter" : false,
								"bSort" : true,
								"bInfo" : false,
								"bAutoWidth" : false,
								"asStripClasses" : null,
								"sDom" : '<"right"f>',
								"order" : [ [ 1, 'asc' ] ],

							});
						})
					</script>
					<script type="text/javascript">
						$(function() {
							$("#url_id").dataTable({
								"bPaginate" : false,
								"bLengthChange" : false,
								"bFilter" : false,
								"bSort" : true,
								"bInfo" : false,
								"bAutoWidth" : false,
								"asStripClasses" : null,
								"sDom" : '<"right"f>',
								"order" : [ [ 1, 'asc' ] ],

							});
						})
					</script>

					<script type="text/javascript">
						window.onload = function() {

							var gr1 = '${list0}';
							var f1 = [];

							var gr2 = '${list1}';
							var f2 = [];

							var gr3 = '${list2}';
							var f3 = [];

							var gr4 = '${list3}';
							var f4 = [];

							var gr5 = '${avgList}';
							var f5 = [];
							if (gr1.length != 0 || gr2.length != 0
									|| gr3.length != 0 || gr4.length != 0
									|| gr5.length != 0) {

								graph1 = JSON.parse(gr1);
								graph2 = JSON.parse(gr2);
								graph3 = JSON.parse(gr3);
								graph4 = JSON.parse(gr4);
								graph5 = JSON.parse(gr5);

								for (var i = 0; i < graph1.length; i++) {
									f1.push({
										label : graph1[i].month,
										y : parseInt(graph1[i].postCount)
									});
								}

								for (var i = 0; i < graph2.length; i++) {
									f2.push({
										label : graph2[i].month,
										y : parseInt(graph2[i].postCount)
									});
								}

								for (var i = 0; i < graph3.length; i++) {
									f3.push({
										label : graph3[i].month,
										y : parseInt(graph3[i].postCount)
									});
								}

								for (var i = 0; i < graph4.length; i++) {
									f4.push({
										label : graph4[i].month,
										y : parseInt(graph4[i].postCount)
									});
								}

								for (var i = 0; i < graph5.length; i++) {
									f5.push({
										label : graph5[i].month,
										y : parseInt(graph5[i].postCount)
									});
								}
							}
							var chart = new CanvasJS.Chart(
									"chartContainer",
									{
										title : {
											text : ""
										},
										legend : {
											verticalAlign : "center",
											horizontalAlign : "right"
										},
										animationEnabled : true,
										axisX : {
											interlacedColor : "#F0F8FF",
											labelFontSize : 12,
											interval : 1,
										},
										axisY : {
											labelFontSize : 12
										},
										exportEnabled : true,
										data : [ {

											type : "line",
											showInLegend : true,
											name : '${allYears.year}',
											color : "#96CA59",
											dataPoints : f1
										}, {
											type : "line",
											color : "#20B2AA",
											showInLegend : true,
											name : '${allYears.year1}',
											dataPoints : f2
										}, {
											type : "line",
											color : "#F08080",
											showInLegend : true,
											name : '${allYears.year2}',
											dataPoints : f3
										}, {
											type : "line",
											color : "#9368AE",
											showInLegend : true,
											name : '${allYears.year3}',
											dataPoints : f4
										}, {
											type : "line",
											color : "#0000ff",
											showInLegend : true,
											name : '${allYears.average}',
											dataPoints : f5
										} ],
										legend : {
											cursor : "pointer",
											itemclick : function(e) {
												if (typeof (e.dataSeries.visible) === "undefined"
														|| e.dataSeries.visible) {
													e.dataSeries.visible = false;
												} else {
													e.dataSeries.visible = true;
												}
												e.chart.render();
											}
										}
									});
							chart.render();

							var freqDays = '${freqDays}';
							var finals = [];
							if (freqDays.length != 0) {
								tabData = JSON.parse(freqDays);
								for (var i = 0; i < tabData.length; i++) {
									finals.push({
										label : tabData[i].interval,
										y : parseInt(tabData[i].noofposts)
									});
								}
							}
							var chart = new CanvasJS.Chart("BarchartContainer",
									{
										title : {
											text : "",
											fontSize : 20
										},

										animationEnabled : true,
										axisX : {
											labelFontSize : 12,
											interval : 1,
										},
										axisY : {
											labelFontSize : 12,
										},
										exportEnabled : true,

										data : [ {
											type : "column",
											fillOpacity : .9,
											color : "#1abc9c",
											dataPoints : finals
										}, ]

									});
							chart.render();

						}
					</script>

					<script>
						$(document)
								.ready(
										function() {
											var canvasDoughnut, options = {
												legend : false,
												responsive : false
											};

											new Chart(
													document
															.getElementById("canvas1i"),
													{
														type : 'doughnut',
														tooltipFillColor : "rgba(51, 51, 51, 0.55)",
														data : {
															labels : [
																	"Anxiety",
																	"Positive",
																	"Sad",
																	"Anger" ],
															datasets : [ {
																data : [
																		'${doughnut[2].anxSentiments}',
																		'${doughnut[2].posSentiments}',
																		'${doughnut[2].sadSentiments}',
																		'${doughnut[2].angSentiments}' ],
																backgroundColor : [
																		"#ff7b00",
																		"#26B99A",
																		"#3b3bff",
																		"#E74C3C" ],
																hoverBackgroundColor : [
																		"#ffae62",
																		"#36CAAB",
																		"#9d9dff",
																		"#E95E4F" ]

															} ]
														},
														options : options
													});

											new Chart(
													document
															.getElementById("canvas1i2"),
													{
														type : 'doughnut',
														tooltipFillColor : "rgba(51, 51, 51, 0.55)",
														data : {
															labels : [
																	"Anxiety",
																	"Positive",
																	"Sad",
																	"Anger" ],
															datasets : [ {
																data : [
																		'${doughnut[1].anxSentiments}',
																		'${doughnut[1].posSentiments}',
																		'${doughnut[1].sadSentiments}',
																		'${doughnut[1].angSentiments}' ],
																backgroundColor : [
																		"#ff7b00",
																		"#26B99A",
																		"#3b3bff",
																		"#E74C3C" ],
																hoverBackgroundColor : [
																		"#ffae62",
																		"#36CAAB",
																		"#9d9dff",
																		"#E95E4F" ]

															} ]
														},
														options : options
													});

											new Chart(
													document
															.getElementById("canvas1i3"),
													{
														type : 'doughnut',
														tooltipFillColor : "rgba(51, 51, 51, 0.55)",
														data : {
															labels : [
																	"Anxiety",
																	"Positive",
																	"Sad",
																	"Anger" ],
															datasets : [ {
																data : [
																		'${doughnut[0].anxSentiments}',
																		'${doughnut[0].posSentiments}',
																		'${doughnut[0].sadSentiments}',
																		'${doughnut[0].angSentiments}' ],
																backgroundColor : [
																		"#ff7b00",
																		"#26B99A",
																		"#3b3bff",
																		"#E74C3C" ],
																hoverBackgroundColor : [
																		"#ffae62",
																		"#36CAAB",
																		"#9d9dff",
																		"#E95E4F" ]

															} ]
														},
														options : options
													});
										});
					</script>
					<script type="text/javascript">
						function trackerchanged() {
							$(".loader").removeClass("hidden");
							document.getElementById("trackerform").submit();
						}
						function siteChanged(var1, var2) {
							/* $("#all_authors").removeClass("hidden"); 
							return false;*/
							document.getElementById("sitesform").submit();
						}
						function authorChanged(var1, var2) {
							document.getElementById("sitesform").submit();
						}
					</script>
</body>
</html>
