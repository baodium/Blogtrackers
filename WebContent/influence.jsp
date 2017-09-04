<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
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
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Blogtrackers | Influence</title>

<link
	href="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/vendors/nprogress/nprogress.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/build/css/custom.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/vendors/jQCloud-master/jqcloud/jqcloud.css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.js"></script>

<style>
div.scroll {
	overflow: scroll;
}
</style>
<body class="nav-md">
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
		});
	</script>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
	<script type="text/javascript"
		src="http://arrow.scrolltotop.com/arrow6.js"></script>
	<noscript>
		Not seeing a <a href="http://www.scrolltotop.com/">Scroll to Top
			Button</a>? Go to our FAQ page for more info.
	</noscript>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<jsp:include page="new_sidebar.jsp"></jsp:include>
			<!-- </div> -->
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
								action="InfluenceServlet" method="post">
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
										href="${pageContext.request.contextPath}/test_logout.jsp"><i
											class="fa fa-sign-out pull-right"></i> Log Out</a></li>
								</ul></li>
							<li role="presentation" class="dropdown"><a
								href="javascript:;" class="dropdown-toggle info-number"
								data-toggle="dropdown" aria-expanded="false"> </a>
								<ul id="menu1" class="dropdown-menu list-unstyled msg_list"
									role="menu">
									<li><a> <span class="image"></span> <span> <span>Sender
													1</span> <span class="time">3 mins ago</span>
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
					<div class="row top_tiles"></div>

					<div class="row">
						<div class="col-md-12 col-sm-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Influential Bloggers<small><span
											class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
											data-original-title="Give Text here!"></span> <font
											color="red">${errorMessage}</font> </small>
									</h2>
									<form name="dateform" id="dateform" action="InfluenceServlet"
										method="post">
										<div class="filter">
											<div id="reportrange" class="pull-right"
												style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
												<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
												<span>December 30, 2014 - January 28, 2018</span> <input
													id="datepicked" name="datepicked" type="hidden"
													onchange="datechanged()"> <b class="caret"></b>
											</div>
										</div>
									</form>
									<div class="clearfix"></div>
								</div>

								<div class="x_content">
									<div class="row">
										<div class="col-md-12 col-sm-12 col-xs-12">
											<div>
												<div class="x_title">
													<div class="x_panel">
														<div class="clearfix"></div>
														<div class="scroll" style="height: 343px;">
															<div class="x_content">
																<table class="table table-hover" id="ib_table_id">
																	<thead>
																		<tr>
																			<th>Blogger <i class="fa fa-sort"></i></th>
																			<th>Blog <i class="fa fa-sort"></i></th>
																			<th>Score (Blogger) <i class="fa fa-sort"></i></th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr>
																			<td scope="row">Average</td>
																			<td></td>
																			<td>${topBScore}</td>
																		</tr>

																		<c:set var="i" value="0" />
																		<c:set var="eo" value="1" />


																		<c:forEach items="${INFBlScz}" var="s12" begin="${i}">
																			<tr>
																				<td scope="row"><a class="title"
																					href="<%=request.getContextPath()%>
																		/AdditionalBlogger?authorName=${s12.bloggerName}">${s12.bloggerName}</a></td>
																				<td>${s12.blogName}</td>
																				<td>${s12.influenceScore}</td>

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

										<div class="col-md-12 col-xs-12">
											<div class="demo-container">
												<div id="chartContainer" style="height: 350px; width: 100%;"></div>
												<form action="InfluenceServlet" method="post">
													<div style="text-align: center; margin-bottom: 15px;">
														<div class="btn-group" role="group"
															aria-label="First group">
															<span id="spanform">
																<button type="submit" name="dayFreq"
																	class="btn btn-default btn-sm">Day</button>
																<button type="submit" name="weekFreq"
																	class="btn btn-default btn-sm">Week</button>
																<button type="submit" name="monthFreq"
																	class="btn btn-default btn-sm">Month</button>
																<button type="submit" name="yearFreq"
																	class="btn btn-default btn-sm">Year</button>
															</span>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Blog Post<small><span
											class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
											data-original-title="Give Text here!"></span></small>
									</h2>
									<ul class="nav navbar-right panel_toolbox">
										<li><a class="collapse-link"><i
												class="fa fa-chevron-up"></i></a></li>
									</ul>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="clearfix"></div>
									<div class="col-md-12 col-xs-12">
										<div class="x_panel">
											<div class="x_content">
												<div class="scroll" id="alert" style="height: 200px;">
													<c:out value="${inflBlogPost}" />
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Influential Blog Posts<small><span
											class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
											data-original-title="Give Text here!"></span></small>
									</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="clearfix"></div>
									<div class="col-md-6 col-xs-12">
										<div class="x_panel">
											<div class="x_content">
												<div class="x_title">
													<div class="clearfix"></div>
													<div class="scroll" style="height: 343px;">
														<div class="x_content">
															<table class="table table-hover">
																<thead>
																	<tr>
																		<th>Blog Post Title</th>
																		<th style="display: none;">Type</th>
																		<th></th>
																	</tr>
																</thead>
																<tbody>
																	<c:set var="i" value="0" />
																	<c:set var="eo" value="1" />


																	<c:forEach items="${INFBlSc}" var="s12" begin="${i}">
																		<tr>
																			<th scope="row">${s12.title}</th>
																			<td style="display: none;">${s12.postContent}</td>
																			<td>
																				<button type="button" class="use-address">
																					<span class="glyphicon glyphicon-arrow-right"></span>
																				</button>
																			</td>
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

									<div class="col-md-6 col-xs-12">
										<div class="x_panel">
											<div class="clearfix"></div>
											<div class="scroll" style="height: 350px;">
												<div class="x_content">
													<table class="table table-hover">
														<thead>
															<tr>
																<th>Blog Post Content</th>
															</tr>
														</thead>
													</table>
													<div id="blogpostContent"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Bloggers Activity Vs Influence <small><span
											class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
											data-original-title="Give Text here!"></span></small>
									</h2>
									<div class="clearfix"></div>
								</div>
								<div class="col-md-6 col-xs-12">
									<div class="x_panel">
										<div class="x_content">
											<div class="clearfix"></div>
											<div class="demo-container">
												<div id="chartscatter" style="height: 460px;"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6 col-xs-12">
									<div class="x_panel">
										<div class="clearfix"></div>
										<div class="x_content">
											<div id="my_words" class="col-md-12 col-sm-12 col-xs-12"
												style="height: 460px;"></div>
										</div>
									</div>
								</div>
								<div class="clearfix"></div>

							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /top navigation -->
			<!-- footer content -->

			<!-- </div> -->

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
					$("#ib_table_id").dataTable({
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
				$(".use-address").click(
						function() {
							var $row = $(this).closest("tr"), $tds = $row
									.find("td:nth-child(2)");

							$.each($tds, function() {
								console.log($(this).text());
								$('#blogpostContent').text($(this).text());
							});

						});
			</script>


			<script type="text/javascript">
				window.onload = function() {

					var tabData1 = '${INFBlScz}';
					tabData = JSON.parse(tabData1);

					var gr1 = '${inflGraph0}';
					var f1 = [];

					var gr2 = '${inflGraph1}';
					var f2 = [];

					var gr3 = '${inflGraph2}';
					var f3 = [];

					var gr4 = '${inflGraph3}';
					var f4 = [];

					var gr5 = '${inflGraph4}';
					var f5 = [];
					if (gr1.length != 0 || gr2.length != 0 || gr3.length != 0
							|| gr4.length != 0 || gr5.length != 0) {

						graph1 = JSON.parse(gr1);
						graph2 = JSON.parse(gr2);
						graph3 = JSON.parse(gr3);
						graph4 = JSON.parse(gr4);
						graph5 = JSON.parse(gr5);

						for (var i = 0; i < graph1.length; i++) {
							var firstdate = graph1[i].startDate;
							var res = firstdate.split('-');
							f1.push({
								x : new Date(res[0], res[1] - 1, res[2]),
								y : parseInt(graph1[i].totalInfluence)
							});
						}

						for (var i = 0; i < graph2.length; i++) {
							var firstdate = graph2[i].startDate;
							var res = firstdate.split('-');
							f2.push({
								x : new Date(res[0], res[1] - 1, res[2]),
								y : parseInt(graph2[i].totalInfluence)
							});
						}

						for (var i = 0; i < graph3.length; i++) {
							var firstdate = graph3[i].startDate;
							var res = firstdate.split('-');
							f3.push({
								x : new Date(res[0], res[1] - 1, res[2]),
								y : parseInt(graph3[i].totalInfluence)
							});
						}

						for (var i = 0; i < graph4.length; i++) {
							var firstdate = graph4[i].startDate;
							var res = firstdate.split('-');
							f4.push({
								x : new Date(res[0], res[1] - 1, res[2]),
								y : parseInt(graph4[i].totalInfluence)
							});
						}

						for (var i = 0; i < graph5.length; i++) {
							var firstdate = graph5[i].startDate;
							var res = firstdate.split('-');
							f5.push({
								x : new Date(res[0], res[1] - 1, res[2]),
								y : parseInt(graph5[i].totalInfluence)
							});
						}
						console.log("F%" + f5);
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
									intervalType : "${inflCalScale}",

								},
								axisY : {
									labelFontSize : 12
								},
								exportEnabled : true,
								data : [
										{
											click : function(e) {
												alert(e.dataPoint.x + " "
														+ e.dataSeries.name);
											},

											type : "line",
											showInLegend : true,
											name : tabData[0].bloggerName,
											color : "#96CA59",
											dataPoints : f1
										},
										{
											click : function(e) {
												alert(e.dataPoint.x + " "
														+ e.dataSeries.name);
											},

											type : "line",
											color : "#20B2AA",
											showInLegend : true,
											name : tabData[1].bloggerName,
											dataPoints : f2
										},
										{
											click : function(e) {
												alert(e.dataPoint.x + " "
														+ e.dataSeries.name);
											},

											type : "line",
											color : "#F08080",
											showInLegend : true,
											name : tabData[2].bloggerName,
											dataPoints : f3
										},
										{
											click : function(e) {
												alert(e.dataPoint.x + " "
														+ e.dataSeries.name);
											},

											type : "line",
											color : "#9368AE",
											showInLegend : true,
											name : tabData[3].bloggerName,
											dataPoints : f4
										},
										{
											click : function(e) {
												alert(e.dataPoint.x + " "
														+ e.dataSeries.name);
											},

											type : "line",
											color : "#0000ff",
											showInLegend : true,
											name : tabData[4].bloggerName,
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
										chart.render();
									}
								}
							});
					chart.render();
					window.alert = function(title, message) {
						$.post('InfluenceServlet', {
							inflPost : title
						}, function(inflPost) {

							location.reload();

						});
					}

					var tabData1 = '${scatterPlotData}';
					tabData = JSON.parse(tabData1);
					var finals = [];
					for (var i = 0; i < tabData.length; i++) {
						var firstdate = tabData[i].influenceScore;
						var res = tabData[i].activityScore;
						var tooltip = "\"" + tabData[i].bloggerName
								+ "\<br/> Influence {y} <br/> Activity {x}";
						finals.push({
							x : parseInt(tabData[i].activityScore),
							y : parseInt(tabData[i].influenceScore),
							toolTipContent : tooltip
						});
					}

					var chart1 = new CanvasJS.Chart("chartscatter", {
						title : {
							text : "",
							fontSize : 20
						},
						animationEnabled : true,
						axisX : {
							title : "Activity",
							titleFontSize : 20,
							stripLines : [ {
								value : '${averageA}',
								color : "#CDD7DE",
								showOnTop : true,
							} ],
						},
						axisY : {
							title : "Influence",
							titleFontSize : 20,
							gridThickness : 0,
							stripLines : [ {
								value : '${averageI}',
								label : "Average",
								color : "#CDD7DE",
								showOnTop : true,
							} ],
						},
						data : [ {
							click : function(e) {
								popup(e.dataPoint.toolTipContent);
							},

							type : "scatter",
							markerType : "triangle",
							dataPoints : finals
						} ]
					});
					chart1.render();
				}
				window.popup = function(title, message) {
					$.post('InfluenceServlet', {
						scatterClick : title
					}, function(scatterClick) {
						location.reload();
					});
				}
			</script>

			<script>
				var tabData1 = '${scatWordList}';
				tabData = JSON.parse(tabData1);
				var finalz = new Array();
				for (var i = 0; i < tabData.length; i++) {
					finalz.push({
						text : tabData[i].term,
						weight : tabData[i].frequency
					});
				}
				$(function() {
					$("#my_words").jQCloud(finalz);
				});
			</script>

			<script type="text/javascript">
				$(document)
						.ready(
								function() {

									var cb = function(start, end, label) {
										console.log(start.toISOString(), end
												.toISOString(), label);
										$('#reportrange span')
												.html(
														start
																.format('MMMM D, YYYY')
																+ ' - '
																+ end
																		.format('MMMM D, YYYY'));
										$('#reportrange input')
												.val(
														start
																.format('MMMM D, YYYY')
																+ ' - '
																+ end
																		.format('MMMM D, YYYY'))
												.trigger('change');

									};

									var optionSet1 = {
										startDate : moment().subtract(29,
												'days'),
										endDate : moment(),
										minDate : '01/01/1990',
										maxDate : '12/31/2045',

										showDropdowns : true,
										showWeekNumbers : true,
										timePicker : false,
										timePickerIncrement : 1,
										timePicker12Hour : true,
										ranges : {
											'This Year' : [
													moment().startOf('year'),
													moment() ],
											'Last Year' : [
													moment()
															.subtract(1, 'year')
															.startOf('year'),
													moment()
															.subtract(1, 'year')
															.endOf('year') ]
										},
										opens : 'left',
										buttonClasses : [ 'btn btn-default' ],
										applyClass : 'btn-small btn-primary',
										cancelClass : 'btn-small',
										format : 'MM/DD/YYYY',
										separator : ' to ',
										locale : {
											applyLabel : 'Submit',
											cancelLabel : 'Close',
											fromLabel : 'From',
											toLabel : 'To',
											customRangeLabel : 'Custom',
											daysOfWeek : [ 'Su', 'Mo', 'Tu',
													'We', 'Th', 'Fr', 'Sa' ],
											monthNames : [ 'January',
													'February', 'March',
													'April', 'May', 'June',
													'July', 'August',
													'September', 'October',
													'November', 'December' ],
											firstDay : 1
										}
									};
									if ('${datepicked}' == '')
										$('#reportrange span')
												.html(
														moment().subtract(29,
																'days').format(
																'MMMM D, YYYY')
																+ ' - '
																+ moment()
																		.format(
																				'MMMM D, YYYY'));
									else
										$('#reportrange span').html(
												'${datepicked}');
									$('#reportrange').daterangepicker(
											optionSet1, cb);
									$('#reportrange')
											.on(
													'show.daterangepicker',
													function() {
														console
																.log("show event fired");
													});
									$('#reportrange')
											.on(
													'hide.daterangepicker',
													function() {
														console
																.log("hide event fired");
													});
									$('#reportrange')
											.on(
													'apply.daterangepicker',
													function(ev, picker) {
														console
																.log("apply event fired, start/end dates are "
																		+ picker.startDate
																				.format('MMMM D, YYYY')
																		+ " to "
																		+ picker.endDate
																				.format('MMMM D, YYYY'));
													});
									$('#reportrange')
											.on(
													'cancel.daterangepicker',
													function(ev, picker) {
														console
																.log("cancel event fired");
													});
									$('#options1').click(
											function() {
												$('#reportrange').data(
														'daterangepicker')
														.setOptions(optionSet1,
																cb);
											});
									$('#options2').click(
											function() {
												$('#reportrange').data(
														'daterangepicker')
														.setOptions(optionSet2,
																cb);
											});
									$('#destroy').click(
											function() {
												$('#reportrange').data(
														'daterangepicker')
														.remove();
											})

								});
			</script>
			<script type="text/javascript">
				function trackerchanged() {
					$(".loader").removeClass("hidden");
					document.getElementById("trackerform").submit();
				}
				function datechanged() {
					$(".loader").removeClass("hidden");
					document.getElementById("dateform").submit();
				}
			</script>
			<script>
				$(document).ready(function() {
					$('[data-toggle="tooltip"]').tooltip();
				});
			</script>
</body>
</html>
