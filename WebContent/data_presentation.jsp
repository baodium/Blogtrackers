<%-- 
    Document   : data_presentation
    Created on : Feb 25, 2017, 11:35:37 PM
    Author     : Kiran
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%
	Object username = (null == session.getAttribute("user")) ? "" : session.getAttribute("user");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");

	if (username == null) {
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

<title>Blog Trackers&reg; | COSMOS</title>

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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript" src="http://arrow.scrolltotop.com/arrow6.js"></script>
<noscript>Not seeing a <a href="http://www.scrolltotop.com/">Scroll to Top Button</a>? Go to our FAQ page for more info.</noscript>


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
								<form name="trackerform" id="trackerform" action="ExportJSON"
							method="post">
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
										<option value="${item}"><c:out value="${item}" /></option>
									</c:forEach>
								</select>
							
						</form>
						</div>

						<ul class="nav navbar-nav navbar-right">
							<li class=""><a href="javascript:;"
								class="user-profile dropdown-toggle" data-toggle="dropdown"
								aria-expanded="false"> 
									<span class=" fa fa-angle-down"></span>
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
								data-toggle="dropdown" aria-expanded="false"> 
							</a>
								<ul id="menu1" class="dropdown-menu list-unstyled msg_list"
									role="menu">
									<li><a> <span class="image"><img
												src="images/img.jpg" alt="Profile Image" /></span> <span> <span>Sender
													1</span> <span class="time">3 mins ago</span>
										</span> <span class="message"> Message.... </span>
									</a></li>
									<li><a> <span class="image"><img
												src="images/img.jpg" alt="Profile Image" /></span> <span> <span>Sender
													2</span> <span class="time">20 mins ago</span>
										</span> <span class="message"> Message.... </span>
									</a></li>
									<li><a> <span class="image"><img
												src="images/img.jpg" alt="Profile Image" /></span> <span> <span>Sender
													3</span> <span class="time">45 mins ago</span>
										</span> <span class="message"> Message.... </span>
									</a></li>
									<li><a> <span class="image"><img
												src="images/img.jpg" alt="Profile Image" /></span> <span> <span>Sender
													4</span> <span class="time">24 hours ago</span>
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
										Data Export<small> <font color="red">${errorMessage}</font>
										</small>
									</h2>
									<form name="dateform" id="dateform" action="ExportJSON"
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
								</div>
								<div class="clearfix"></div>
								<div class="x_content">
									<div class="clearfix"></div>
									<div class="col-md-12 col-xs-12">
										<div class="x_panel">
											<div class="x_content">
												<div class="clearfix"></div>
												<div class="demo-container">
													<div class="col-md-12 col-sm-12 col-xs-12">
														<div class="pricing">
															<form action="ExportJSON" id="records" method="post">
																<div class="title" style="height: 130px;">
																	<h3>Export Data from your Current Tracker to JSON</h3>
																	<h2>Total Number of records selected</h2>
																	<input id="records" name="records" type="hidden"
																		onchange="recordsChanged()">

																	<c:if test="${records==null}">
																		<c:set var="records" scope="session" value="0" />
																	</c:if>
																	<h1>${records}</h1>
																</div>
															</form>
															<div class="x_content">
																<div class="">
																	<div class="pricing_features">
																		<ul class="list-unstyled text-left">
																		</ul>
																	</div>
																</div>
																<div class="pricing_footer">
																	<form name="exportJSON" id="exportJSON"
																		action="ExportJSON" method="post">
																		<div>
																			<input id="exportJSON" name="exportJSON"
																				type="hidden" onchange="exportJSON()">
																			<button onclick="showGif()" type="submit"
																				class="btn btn-primary btn-block"
																				data-toggle="modal"
																				data-target=".bs-example-modal-lg">
																				Download <span> now!</span>
																			</button>
																		</div>
																	</form>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<script type="text/javascript">
									function showGif() {
										$(".loader").removeClass("hidden");
									}
								</script>
								
								<div style="height: 350px;"></div>

							</div>
						</div>

						<!-- /page content -->
						<!-- footer content -->
						
						<!-- /footer content -->
					</div>
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

					<!-- bootstrap-daterangepicker (Fahad) -->
					<script type="text/javascript">
      $(document).ready(function() {

        var cb = function(start, end, label) {
          console.log(start.toISOString(), end.toISOString(), label);
          $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
          $('#reportrange input').val(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY')).trigger('change');
        };

        var optionSet1 = {
          startDate: moment().subtract(29, 'days'),
          endDate: moment(),
          minDate: '01/01/1990',
          maxDate: '12/31/2045',
         
          showDropdowns: true,
          showWeekNumbers: true,
          timePicker: false,
          timePickerIncrement: 1,
          timePicker12Hour: true,
          ranges: {
              'This Year' : [
                  moment().startOf('year'),
                  moment() ],
         	 'Last Year' : [
                  moment().subtract(1, 'year')
                          .startOf('year'),
                  moment().subtract(1, 'year')
                          .endOf('year') ]
      			},
          opens: 'left',
          buttonClasses: ['btn btn-default'],
          applyClass: 'btn-small btn-primary',
          cancelClass: 'btn-small',
          format: 'MM/DD/YYYY',
          separator: ' to ',
          locale: {
            applyLabel: 'Submit',
            cancelLabel: 'Clear',
            fromLabel: 'From',
            toLabel: 'To',
            customRangeLabel: 'Custom',
            daysOfWeek: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
            monthNames: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
            firstDay: 1
          }
        };
        if('${datepicked}' == '')
        	$('#reportrange span').html(moment().subtract(29, 'days').format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));
        else
        $('#reportrange span').html('${datepicked}');
        $('#reportrange').daterangepicker(optionSet1, cb);
        $('#reportrange').on('show.daterangepicker', function() {
          console.log("show event fired");
        });
        $('#reportrange').on('hide.daterangepicker', function() {
          console.log("hide event fired");
        });
        $('#reportrange').on('apply.daterangepicker', function(ev, picker) {
          console.log("apply event fired, start/end dates are " + picker.startDate.format('MMMM D, YYYY') + " to " + picker.endDate.format('MMMM D, YYYY'));
        });
        $('#reportrange').on('cancel.daterangepicker', function(ev, picker) {
          console.log("cancel event fired");
        });
        $('#options1').click(function() {
          $('#reportrange').data('daterangepicker').setOptions(optionSet1, cb);
        });
        $('#options2').click(function() {
          $('#reportrange').data('daterangepicker').setOptions(optionSet2, cb);
        });
        $('#destroy').click(function() {
          $('#reportrange').data('daterangepicker').remove();
        });
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
						function exportJSON() {
							document.getElementById("exportJSON").submit();
						}
						function recordsChanged() {
							document.getElementById("records").submit();
						}
					</script>
				</div>
			</div>
		</div>
	</div>
</body>
</html>