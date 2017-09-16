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

<title>Blogtrackers | Posting Frequency</title>

<link href="vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="vendors/nprogress/nprogress.css" rel="stylesheet">
<link
	href="vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css"
	rel="stylesheet" />
<link rel="stylesheet" type="text/css"
	href="vendors/canvasjs/examples/03-area_chart/bootstrap/css/bootstrap.min.css">
<link href="build/css/custom.min.css" rel="stylesheet">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.js"></script>
<link rel="stylesheet" type="text/css"
	href="vendors/jQCloud-master/jqcloud/jqcloud.css" />
<style>
div.scroll {
	overflow: scroll;
}
</style>

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

</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript"
	src="http://arrow.scrolltotop.com/arrow6.js"></script>
<noscript>
	Not seeing a <a href="http://www.scrolltotop.com/">Scroll to Top
		Button</a>? Go to our FAQ page for more info.
</noscript>


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
								action="PostingFrequency" method="post">
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
									<li><a> <span class="image"> <!-- <img src="images/img.jpg"
												alt="Profile Image" /> -->
										</span> <span> <span>Sender 1</span> <span class="time">3
													mins ago</span>
										</span> <span class="message"> Message.... </span>
									</a></li>

								</ul></li>
						</ul>
					</nav>
				</div>
			</div>
			<!-- /top navigation -->
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="row top_tiles"></div>

					<div class="row">
						<div class="col-md-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Posting Frequency<small><span
											class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
											data-original-title="Posting activity for selected time period"></span>
											<font color="red">${errorMessage}</font> </small>
									</h2>

									<form name="dateform" id="dateform" action="PostingFrequency"
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
								<form name="pf_spanForm" id="pf_spanForm"
									action="PostingFrequency" method="post">
									<div class="x_content">
										<div class="col-md-9 col-sm-12 col-xs-12">
											<div class="demo-container">
												<div id="chartContainer" style="height: 350px"></div>
												<div style="text-align: center; margin-bottom: 15px;">
													<jsp:include page="spanchecker.jsp"></jsp:include>
													<!-- <div class="btn-group" role="group" aria-label="First group">
														<button type="submit" name="dayFreq" class="btn btn-default btn-sm">Day</button>
														<button type="submit" name="weekFreq" class="btn btn-default btn-sm">Week</button>
														<button class="btn btn-default btn-sm" type="submit" name="monthFreq">Month</button>
														<button type="submit" name="yearFreq" class="btn btn-default btn-sm">Year</button>
													</div> -->
												</div>

											</div>
										</div>

										<div class="col-md-3 col-sm-12 col-xs-12">
											<div>
												<div class="x_title">
													<h2>
														Top Bloggers<small><span
															class="glyphicon glyphicon-info-sign"
															data-toggle="tooltip"
															data-original-title="Active bloggers for selected time period"></span></small>
													</h2>
													<div class="clearfix"></div>
												</div>
												<div class="scroll">
													<ul class="list-unstyled top_profiles scroll-view">


														<c:set var="i" value="0" />
														<c:set var="eo" value="1" />


														<c:forEach items="${topBloggers}" var="s1" begin="${i}">
															<li class="media event"><a
																class="pull-left border-green profile_thumb"> <i
																	class="fa fa-user green"></i>
															</a>
																<div class="media-body">
																	<a class="title"
																		href="<%=request.getContextPath()%>
																		/AdditionalBlogger?authorName=${s1.bloggerName}">${s1.bloggerName}</a>
																	<p>
																		Blog Post Count: <strong>${s1.blogCount}</strong>
																	</p>
																</div></li>
														</c:forEach>
													</ul>
												</div>
											</div>
										</div>

									</div>
								</form>
							</div>
						</div>
						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Blog Browser<small><span
											class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
											data-original-title="List of blog posts for selected time-period"></span></small>
									</h2>
									<ul class="nav navbar-right panel_toolbox">
										<li><a class="collapse-link"><i
												class="fa fa-chevron-up"></i></a></li>
									</ul>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="clearfix"></div>
									<div class="col-md-6 col-xs-12">
										<div class="x_panel">
											<div class="x_content">
												<div class="scroll" id="alert" style="height: 345px;">
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


																<c:forEach items="${blogTitlePost}" var="s12"
																	begin="${i}">
																	<tr>
																		<td>${s12.blogTitle}</td>
																		<td style="display: none;">${s12.blogContent}</td>
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
													<div id="blogpost"></div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="clearfix"></div>
					<div class="row">

						<div class="col-md-6 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Top Keyword <small><span
											class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
											data-original-title="Top words extracted for selected time-period"></span></small>
									</h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div id="my_words_cloud" class="col-md-12 col-sm-12 col-xs-12"
										style="height: 335px;"></div>
								</div>
							</div>
						</div>

						<div class="col-md-6 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Top Entities <small><span
											class="glyphicon glyphicon-info-sign" data-toggle="tooltip"
											data-original-title="Top entities extracted for selected time-period"></span></small>
									</h2>
									<div class="clearfix"></div>
								</div>
								<div class="scroll" style="height: 343px;">
									<div class="x_content">
										<table class="table table-hover" id="pf_table_id">
											<thead>
												<tr>
													<th>Name <i class="fa fa-sort"></i></th>
													<th>Type <i class="fa fa-sort"></i></th>
													<th>Frequency <i class="fa fa-sort"></i></th>
													<th>Positive <i class="fa fa-sort"></i></th>
													<th>Negative <i class="fa fa-sort"></i></th>
												</tr>
											</thead>
											<tbody>
												<c:set var="i" value="0" />
												<c:set var="eo" value="1" />


												<c:forEach items="${topEntity}" var="s1" begin="${i}">
													<tr>
														<td>${s1.entityName}</td>
														<td>${s1.entityType}</td>
														<td>${s1.entityFrequency}</td>
														<td>${s1.posSentiment}</td>
														<td>${s1.negSentiment}</td>
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
				<div class="clearfix"></div>
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
					src="${pageContext.request.contextPath}/vendors/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.pie.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.time.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.stack.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.resize.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/jQCloud-master/jqcloud/jqcloud-1.0.4.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/flot/jquery.flot.orderBars.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/flot/date.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/flot/jquery.flot.spline.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/flot/curvedLines.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
				<script
					src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
				<script
					src="//cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
				<script type="text/javascript">
					window.onload = function() {
						var tabData1 = '${frequency}';
						var finals = [];
						if (tabData1.length != 0) {
							tabData = JSON.parse(tabData1);
							for (var i = 0; i < tabData.length; i++) {
								var firstdate = tabData[i].startDate;
								var res = firstdate.split('-');
								finals.push({
									x : new Date(res[0], res[1] - 1, res[2]),
									y : parseInt(tabData[i].noofposts)
								});
							}
						}
						var chart = new CanvasJS.Chart("chartContainer", {
							title : {
								text : ""
							},
							legend : {
								horizontalAlign : "Right",
								verticalAlign : "top",
								fontSize : 15
							},
							animationEnabled : true,
							axisX : {
								interlacedColor : "#F0F8FF",
								labelFontSize : 12,
								interval : 1,
								intervalType : "${calScale}",
							},
							axisY : {
								labelFontSize : 12
							},
							exportEnabled : true,
							data : [ {
								click : function(e) {
									$(".loader").removeClass("hidden");
									alert(e.dataPoint.x);
								},
								type : "area",
								showInLegend : true,
								legendMarkerType : "circle",
								legendText : "Number of Blog Posts",
								color : "#96CA59",
								fillOpacity : .2,
								dataPoints : finals
							} ]
						});
						chart.render();
					}
					window.alert = function(title, message) {
						$.post('PostingFrequency', {
							data : title
						}, function(data) {
							var dataa = '${blogTitlePost}';
							console.log("Dataaa" + dataa);
							location.reload();
						});
					}
				</script>

				<script>
					var tabData1 = '${wordList}';
					var finalz = new Array();
					if (tabData1.length != 0) {
						tabData = JSON.parse(tabData1);
						for (var i = 0; i < tabData.length; i++) {
							finalz.push({
								text : tabData[i].term,
								weight : tabData[i].frequency
							});
						}
					}
					$(function() {
						$("#my_words_cloud").jQCloud(finalz);
					});
				</script>

				<script type="text/javascript">
					$(".use-address").click(
							function() {
								var $row = $(this).closest("tr"), $tds = $row
										.find("td:nth-child(2)");
								$.each($tds, function() {
									console.log($(this).text());
									$('#blogpost').text($(this).text());
								});
							});
				</script>
				<!-- bootstrap-daterangepicker (Fahad) -->
				<script type="text/javascript">
					$(document)
							.ready(
									function() {
										var cb = function(start, end, label) {
											console.log(start.toISOString(),
													end.toISOString(), label);
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
														moment()
																.startOf('year'),
														moment() ],
												'Last Year' : [
														moment()
																.subtract(1,
																		'year')
																.startOf('year'),
														moment().subtract(1,
																'year').endOf(
																'year') ]
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
												daysOfWeek : [ 'Su', 'Mo',
														'Tu', 'We', 'Th', 'Fr',
														'Sa' ],
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
															moment()
																	.subtract(
																			29,
																			'days')
																	.format(
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
															.setOptions(
																	optionSet1,
																	cb);
												});
										$('#options2').click(
												function() {
													$('#reportrange').data(
															'daterangepicker')
															.setOptions(
																	optionSet2,
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
					$(function() {
						$("#pf_table_id").dataTable({
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
					function trackerchanged() {
						$(".loader").removeClass("hidden");
						document.getElementById("trackerform").submit();

					}
					function datechanged() {
						$(".loader").removeClass("hidden");
						document.getElementById("dateform").submit();
					}
					function spanChanged() {
						document.getElementById("pf_spanForm").submit();
					}
				</script>
</body>
</html>