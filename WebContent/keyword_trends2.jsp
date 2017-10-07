
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
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Blogtrackers | Keyword Trends</title>

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
<link href="${pageContext.request.contextPath}/build/css/custom.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/vendors/vis/dist/vis.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap-slider-master/dist/css/bootstrap-slider.min.css"
	rel="stylesheet" type="text/css" />

<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>


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
								action="KeywordTrendsServlet" method="post">
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
									alt=""> --><%=username%> <span class=" fa fa-angle-down"></span>
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
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="title">
									<div
										class="col-md-12 col-sm-12 col-xs-12 form-group pull-right top_search">
										<form name="tagform" id="tagform"
											action="KeywordTrendsServlet" method="post">
											<div class="input-group">

												<c:choose>
													<c:when test="${tags != null}">
														<input type="text" class="form-control" name="searchText"
															id="searchBar" placeholder="${tags}"
															onkeyup="searchTextVerify()"
															style="height: 45px; border: 1.2px solid gray">
													</c:when>

													<c:when test="${tags == null}">
														<input type="text" class="form-control" name="searchText"
															id="searchBar" placeholder="Search for..."
															onkeyup="searchTextVerify()"
															style="height: 45px; border: 1.2px solid gray">
													</c:when>
												</c:choose>
												<!--  keywords searched  <input type="text" class="form-control"  name="searchText" id="searchBar" placeholder="Search for..." 
												 onkeyup="searchTextVerify()" style="height: 45px; border: 1.2px solid gray"> -->
												<span class="input-group-btn">
													<button class="btn btn-default" onclick="showGif()"
														type="submit" name="searchButton" id="searchButton"
														style="height: 45px; border: 1.2px solid grey">Go!</button>
												</span>
											</div>
										</form>
									</div>
									<script type="text/javascript">
									function showGif() {
										$(".loader").removeClass("hidden");
									}
									</script>
									<div class="x_title">
										<h2>
											Keyword Trendline<small></small>
										</h2>
										<form name="dateform" id="dateform"
											action="KeywordTrendsServlet" method="post">
											<div class="filter">
												<div id="reportrange" class="pull-right"
													style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
													<i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
													<span>December 30, 2014 - January 28, 2018</span><input
														id="datepicked" name="datepicked" type="hidden"
														onchange="datechanged()"><b class="caret"></b>
												</div>
											</div>
										</form>
										<div class="clearfix"></div>
									</div>
									<div class="col-md-12 col-xs-12">
										<div class="x_panel">
											<div class="x_content">
												<div class="clearfix"></div>
												<div class="demo-container">
													<div id="chartContainer" style="height: 350px;"></div>
													<div style="text-align: center; margin-bottom: 15px;">
														<form name="kt_spanform" id="kt_spanform" action="KeywordTrendsServlet"
																method="post">
														<%
															Object span = (null == session.getAttribute("kt_span")) ? "" : session.getAttribute("kt_span");
															if (span != null && (span.toString()).equalsIgnoreCase("month")) {
														%>

														<div class="btn-group colors" role="group"
															aria-label="First group" data-toggle="buttons">
															<label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="day"
																autocomplete="off" onchange="spanChanged()"> Day
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="week"
																autocomplete="off" onchange="spanChanged()">
																Week
															</label> <label class="btn btn-default btn-sm active"> <input
																type="radio" name="options" value="month"
																autocomplete="off" checked onchange="spanChanged()">
																Month
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="year"
																autocomplete="off" onchange="spanChanged()">
																Year
															</label>
														</div>
														<%
															} else if (span != null && (span.toString()).equalsIgnoreCase("day")) {
														%>
														<div class="btn-group colors" data-toggle="buttons">
															<label class="btn btn-default btn-sm active"> <input
																type="radio" name="options" value="day"
																autocomplete="off" checked onchange="spanChanged()">
																Day
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="week"
																autocomplete="off" onchange="spanChanged()">
																Week
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="month"
																autocomplete="off" onchange="spanChanged()">
																Month
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="year"
																autocomplete="off" onchange="spanChanged()">
																Year
															</label>
														</div>
														<%
															} else if (span != null && (span.toString()).equalsIgnoreCase("year")) {
														%>
														<div class="btn-group colors" data-toggle="buttons">
															<label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="day"
																autocomplete="off" onchange="spanChanged()"> Day
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="week"
																autocomplete="off" onchange="spanChanged()">
																Week
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="month"
																autocomplete="off" onchange="spanChanged()">
																Month
															</label> <label class="btn btn-default btn-sm active"> <input
																type="radio" name="options" value="year"
																autocomplete="off" checked onchange="spanChanged()">
																Year
															</label>
														</div>
														<%
															} else if (span != null && (span.toString()).equalsIgnoreCase("week")) {
														%>

														<div class="btn-group colors" data-toggle="buttons">
															<label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="day"
																autocomplete="off" onchange="spanChanged()"> Day
															</label> <label class="btn btn-default btn-sm active"> <input
																type="radio" name="options" value="week"
																autocomplete="off" checked onchange="spanChanged()">
																Week
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="month"
																autocomplete="off" onchange="spanChanged()">
																Month
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="year"
																autocomplete="off" onchange="spanChanged()">
																Year
															</label>
														</div>
														<%
															} else {
														%>
														<div class="btn-group colors" data-toggle="buttons">
															<label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="day"
																autocomplete="off" onchange="spanChanged()"> Day
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="week"
																autocomplete="off" onchange="spanChanged()">
																Week
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="month"
																autocomplete="off" onchange="spanChanged()">
																Month
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="year"
																autocomplete="off" onchange="spanChanged()">
																Year
															</label>
														</div>

														<%
															}
														%>
													</form>

														<!-- <div class="btn-group" role="group" aria-label="First group">
															<form name="spanform" id="spanform" action="KeywordTrendsServlet"
																method="post">
																<button type="submit" name="spandaily" value="daily"
																	id="addDataPoint" class="btn btn-default btn-sm">Day</button>
																<button type="submit" name="spanweekly" value="weekly"
																	class="btn btn-default btn-sm">Week</button>
																<button type="submit" name="spanmonthly" value="monthly"
																	class="btn btn-default btn-sm">Month</button>
																<button type="submit" name="spanyearly" value="yearly"
																	class="btn btn-default btn-sm">Year</button>
															</form>
														 </div> -->
														<div id="chartpoint">
															<form name="xyform" id="xyform"
																action="KeywordTrendsServlet" method="post">
																<input id="xychange" name="xychange" type="hidden"
																	onchange="xychanged()">
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

						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Blog Browser<small></small>
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
															<c:forEach items="${key_names}" var="s" begin="${i}">
																<tr>
																	<td><c:out value="${s[1]}" /></td>
																	<td style="display: none;"><c:out value="${s[2]}" /></td>
																	<td>
																		<button type="button" class="use-address">
																			<span class="glyphicon glyphicon-arrow-right"></span>
																		</button>
																	</td>
																</tr>
																<c:set var="i" value="${i+1}" />
															</c:forEach>
														</tbody>
													</table>
												</div>

												<div class="scroll" id="eventSpan"></div>
											</div>
										</div>

									</div>
									<div class="col-md-6 col-xs-12">
										<div class="x_panel">
											<div class="clearfix"></div>
											<div class="scroll" id="alert" style="height: 345px;">
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

						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Entity Network <small></small>
									</h2>
									<div class="clearfix"></div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-10 col-xs-12" style="width: 100%">
									<div class="x_panel">
										<div class="x_content">
											<div class="clearfix"></div>
											<div class="demo-container">
												<div id="mynetwork" style="height: 400px"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-1 col-xs-12">
									<div class="clearfix"></div>
									<div class="x_content"></div>
								</div>
								<div class="col-md-1 col-xs-12">
									<div class="clearfix"></div>
									<!-- <div class="x_content">
										<h2>100%</h2>
										<input id="ex4" type="text" data-slider-min="0" data-slider-max="100"
											data-slider-value="100" data-slider-orientation="vertical" />
										<h2>0%</h2>
									</div> -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- footer content -->

			<!-- /footer content -->
			<!-- jQuery -->
			<!-- jQuery -->
			<script
				src="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.min.js"></script>
			<!-- Bootstrap -->
			<script
				src="${pageContext.request.contextPath}/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
			<!-- FastClick -->
			<script
				src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
			<!-- NProgress -->
			<script
				src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
			<!-- Chart.js -->
			<script
				src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>
			<script
				src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
			<script
				src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
			<!-- Custom Theme Scripts -->
			<script
				src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
			<!-- bootbox code -->
			<script
				src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>
			<script
				src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
			<!-- Ion.RangeSlider -->
			<script
				src="${pageContext.request.contextPath}/vendors/bootstrap-slider-master/dist/bootstrap-slider.min.js"></script>
			<!-- CSS dependencies for canvasjs -->
			<script
				src="${pageContext.request.contextPath}/vendors/vis/dist/vis.js"></script>
			<script
				src="${pageContext.request.contextPath}/vendors/Tags-Input-master/src/jquery.tagsinput.js"></script>

			<script>			
    var nodes = null;
    var edges = null;
    var network = null;
	var id =0;
	
		
    var  nodes = [
    	<c:forEach items="${idlist}" var="l"  varStatus="status">
    	{id:  ${l.value},  value: 1,  label: '${l.key}' },
    	</c:forEach>
        ];
    var edges = [
    	<c:forEach items="${netlist}" var="l"  varStatus="status">
    	<c:set var="parts" value="${fn:split(l.key, '~')}" />
    		<c:set var="s1" value="${parts[0]}"/>
    			<c:set var="s2" value="${parts[1]}"/>
    				<c:set var="s3" value="${idlist[s1]}"/>
    					<c:set var="s4" value="${idlist[s2]}"/>
    	    				
    				<c:if test="${not empty s3 && not empty s4}">
    	  	 			{from: ${idlist[s1]}, to: ${idlist[s2]}, value: ${l.value}, title: 'Amount ${l.value}'},
    	    	  	</c:if>
    	 </c:forEach>
    	 ];
    // create a network
    var container = document.getElementById('mynetwork');
    var data = {
        nodes: nodes,
        edges: edges
    };
    
    var options = {
    interaction:{hover:true},
    hover: true,
    tooltipDelay: 3,
        nodes: {
          shape: 'dot',
          scaling:{
            label: {
              min:8,
              max:20
            }
          }
        }
      };
    network = new vis.Network(container, data, options);
    network.on("click", function (params) {
        params.event = "[original event]";
        document.getElementById('eventSpan').innerHTML = '<h2>Click event:</h2>' + JSON.stringify(params, null, 4);
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

			<script type="text/javascript">
		$(function() {
			$('#tags').tagsInput({width:'auto'});	
		});

	</script>
			<script type="text/javascript">
  window.onload = function () {
    var chart = new CanvasJS.Chart("chartContainer",
    {
      title: {
        text: ""
      },
      legend: {
       horizontalAlign: "right", // "center" , "right" (fahad)
       verticalAlign: "bottom",
       fontSize: 15
       },
       animationEnabled: true,
       axisX:{
        interlacedColor: "#F0F8FF",
        labelFontSize: 12, 
         interval: 1,
       intervalType: '${kt_span}',
        valueFormatString: "DD MMM YYYY"   // "DD MMM" for date and month, "MMM" for month only , "YYYY" year only (fahad)
         
      },
      axisY:{
        labelFontSize: 12
      },
       exportEnabled: true,
        data: [
        	<c:forEach items="${trend}" var="l">
        	{
        	  click: function(e){
        	  xychange( "dataSeries Event => Type: "+ e.dataSeries.type+ ", dataPoint { x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y + " }");
              $('#chartpoint input').val(" x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y+","+"${l.key}").trigger('change');
             },
      
        type: "line",
        showInLegend: true,
        legendMarkerType: "circle",
        legendText: "${l.key}",
        //color: getRandomRolor(),
        color:'#'+Math.floor(Math.random()*16777215).toString(16),
        name:"${l.key}",
        fillOpacity: .3,
        lineThickness: 3,
        dataPoints: ${l.value}
      },
      </c:forEach>
      ],
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
    }
     window.xychange = function(title, message){
    var myElementToShow = document.getElementById("xychange");
    myElementToShow.innerHTML = title + "</br>" + message; 
}
</script>

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
            cancelLabel: 'Close',
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

			<script> 
   		function datechanged()
       	{
   			$(".loader").removeClass("hidden");
             document.getElementById("dateform").submit();
        }
   		function trackerchanged()
   	   	{
   			$(".loader").removeClass("hidden");
   	     		document.getElementById("trackerform").submit();
   	   	}
   		function xychanged()
   		{
   			document.getElementById("xyform").submit();
   		}
   		
   		function searchTracker() {
			$(".loader").removeClass("hidden");
		}
   		
   		function getRandomRolor() {
   		    var letters = '0123456789'.split('');
   		    var color = '#';
   		    for (var i = 0; i < 6; i++) {
   		        color += letters[Math.round(Math.random() * 10)];
   		    }
   		    return color;
   		}
   		/* function tagfunction()
   		{
   		    
   			   			 
   			var spans = document.getElementById('tags_tagsinput').getElementsByTagName('span');//returns node-list of spans
   			var s="";
   			for (var i=0;i<=spans.length;i++)
   			{
   				
   			 if (i%2!=0) {
   				 var test = spans[i].innerHTML;
   				 var test1 = test.replace(/&nbsp/g, "");
   				 test1 = test1.replace(/\;/g,"");
   				 console.log(spans[i].innerHTML);
   				 s=s+","+test1;
             }
   			    
   			
   			document.getElementById('tagsname').value = s;
   			document.getElementById("tagform").submit();
   			}
   		} */
   		function searchTextVerify(e) {

			var value = $.trim($("#searchBar").val());
			if (value.length > 0) {
				$("#searchButton").prop('disabled', false);
			} else {
				$("#searchButton").prop('disabled', true);
			}
			if (e.keyCode === 13) {
				e.preventDefault();
				$(".loader").removeClass("hidden");
				$(".searchBar").addClass("hidden");
				// alert("Enter was pressed was presses");
			}
		}
   		function searchTracker() {
			$(".loader").removeClass("hidden");
		}
   		function spanChanged() {
			document.getElementById("kt_spanform").submit();
		}
   		
   		   		
   </script>
			<script>
      var slider = new Slider("#ex4", {
	reversed : true,
	ticks_snap_bounds: 30
});
        </script>

			<!-- JQVMap -->
</body>
</html>








<%--  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"
	isELIgnored="false"%>
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

<title>Blogtrackers | Keyword Trends</title>

<!-- Bootstrap -->
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="${pageContext.request.contextPath}/vendors/nprogress/nprogress.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet">
<!-- Custom Theme Style -->
<link href="${pageContext.request.contextPath}/build/css/custom.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/vendors/vis/dist/vis.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap-slider-master/dist/css/bootstrap-slider.min.css"
	rel="stylesheet" type="text/css" />
<style>
div.scroll {
	overflow: scroll;
}
</style>
</head>
<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a class="site_title"><img src="production/images/cosmos.jpg"></i> <span>Blogtrackers</span></a>
					</div>

					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile">
						<div class="profile_pic">
							<img src="production/images/profile.png" alt="..."
								class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>Welcome,</span>
							<h2><%=session.getAttribute("user")%></h2>
						</div>
					</div>
					<!-- /menu profile quick info -->

					<br />
					<jsp:include page="sidebar.jsp"></jsp:include>

					<!-- /menu footer buttons -->
				</div>
			</div>

			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<nav>
						<div class="nav toggle">
							<a id="menu_toggle"><i class="fa fa-bars"></i></a>
						</div>
						<div class="nav toggle" style="position: absolute; right: 35%; width: 30%;">
							<form name="trackerform" id="trackerform" action="KeywordTrendsServlet"
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
										<c:if test="${tracker ne item}">
											<option value="${item}"><c:out value="${item}" /></option>
										</c:if>c:if>
									</c:forEach>
								</select>
							</form>
						</div>

						<ul class="nav navbar-nav navbar-right">
							<li class=""><a href="javascript:;" class="user-profile dropdown-toggle"
								data-toggle="dropdown" aria-expanded="false"> <!-- <img src="images/img.jpg"
									alt=""> -->User <span class=" fa fa-angle-down"></span>
							</a>
								<ul class="dropdown-menu dropdown-usermenu pull-right">
									<li><a href="javascript:;"> Profile</a></li>
									<li><a href="javascript:;"> <span class="badge bg-red pull-right"></span>
											<span>Settings</span>
									</a></li>
									<li><a href="javascript:;">Help</a></li>
									<li><a href="${pageContext.request.contextPath}/test_logout.jsp"><i
											class="fa fa-sign-out pull-right"></i> Log Out</a></li>
								</ul></li>
							<li role="presentation" class="dropdown"><a href="javascript:;"
								class="dropdown-toggle info-number" data-toggle="dropdown"
								aria-expanded="false"> <i class="fa fa-envelope-o"></i> <span
									class="badge bg-green">6</span>
							</a>
								<ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
									<li><a> <span class="image">
												<!-- <img src="images/img.jpg"
												alt="Profile Image" /> -->
										</span> <span> <span>Sender 1</span> <span class="time">3 mins ago</span>
										</span> <span class="message"> Message.... </span>
									</a></li>

									<li>
										<div class="text-center">
											<a> <strong>See All Alerts</strong> <i class="fa fa-angle-right"></i>
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
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="title">
									<div class="col-md-12 col-sm-12 col-xs-12 form-group pull-right top_search">
										<form name="tagform" id="tagform" action="KeywordTrendsServlet"
											method="post">
											<div class="input-group">
												<input type="hidden" id="tagsname" name="tagsname" value=""> <input
													type="text" class="tags" id="tags"> <span
													class="input-group-btn">
													<button class="btn btn-default" type="button" onclick="tagfunction();"
														style="height: 45px; border: 1.2px solid grey">Go!</button>
												</span>
											</div>
										</form>
									</div>
									<div class="x_title">
										<h2>
											Keyword Trendline<small></small>
										</h2>
										<form name="dateform" id="dateform" action="KeywordTrendsServlet"
											method="post">
											<div class="filter">
												<div id="reportrange" class="pull-right"
													style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
													<i class="glyphicon glyphicon-calendar fa fa-calendar"></i> <span>December
														30, 2014 - January 28, 2018</span><input id="datepicked" name="datepicked"
														type="hidden" onchange="datechanged()"><b class="caret"></b>
												</div>
											</div>
										</form>
										<div class="clearfix"></div>
									</div>
									<div class="col-md-12 col-xs-12">
										<div class="x_panel">
											<div class="x_content">
												<div class="clearfix"></div>
												<div class="demo-container">
													<div id="chartContainer" style="height: 350px;"></div>


													<div style="text-align: center; margin-bottom: 15px;">
														<div class="btn-group" role="group" aria-label="First group">
															<form name="spanform" id="spanform" action="KeywordTrendsServlet"
																method="post">
																<button type="submit" name="spandaily" value="daily"
																	id="addDataPoint" class="btn btn-default btn-sm">Day</button>
																<button type="submit" name="spanweekly" value="weekly"
																	class="btn btn-default btn-sm">Week</button>
																<button type="submit" name="spanmonthly" value="monthly"
																	class="btn btn-default btn-sm">Month</button>
																<button type="submit" name="spanyearly" value="yearly"
																	class="btn btn-default btn-sm">Year</button>
															</form>
															<div id="chartpoint">
																<form name="xyform" id="xyform" action="KeywordTrendsServlet"
																	method="post">
																	<input id="xychange" name="xychange" type="hidden"
																		onchange="xychanged()">
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
						</div>

						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Blog Browser<small></small>
									</h2>
									<ul class="nav navbar-right panel_toolbox">
										<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
									</ul>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<div class="clearfix"></div>
									<div class="col-md-6 col-xs-12">
										<div class="x_panel">
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
															<c:forEach items="${names}" var="s" begin="${i}">
																<tr>
																	<td><c:out value="${s[1]}" /></td>
																	<td style="display: none;"><c:out value="${s[2]}" /></td>
																	<td>
																		<button type="button" class="use-address">
																			<span class="glyphicon glyphicon-arrow-right"></span>
																		</button>
																	</td>
																</tr>
																<c:set var="i" value="${i+1}" />
															</c:forEach>
														</tbody>
													</table>
												</div>

												<div class="scroll" id="eventSpan"></div>
											</div>
										</div>

									</div>
									<div class="col-md-6 col-xs-12">
										<div class="x_panel">
											<div class="clearfix"></div>
											<div class="scroll" id="alert" style="height: 345px;">
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

						<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Entity Network <small></small>
									</h2>
									<div class="clearfix"></div>
								</div>
								<div class="clearfix"></div>
								<div class="col-md-10 col-xs-12" style="width:100%">
									<div class="x_panel">
										<div class="x_content">
											<div class="clearfix"></div>
											<div class="demo-container">
												<div id="mynetwork" style="height: 400px"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-1 col-xs-12">
									<div class="clearfix"></div>
									<div class="x_content"></div>
								</div>
								<div class="col-md-1 col-xs-12">
									<div class="clearfix"></div>
									<!-- <div class="x_content">
										<h2>100%</h2>
										<input id="ex4" type="text" data-slider-min="0" data-slider-max="100"
											data-slider-value="100" data-slider-orientation="vertical" />
										<h2>0%</h2>
									</div> -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- footer content -->
			<div class="footer_fixed">
				<footer>
					<div class="pull-right" style="height: 6px;">
						Blogtrackers <a href="https://www.facebook.com/cosmographers/">COSMOS</a>
					</div>
					<div class="clearfix"></div>

				</footer>
			</div>
			<!-- /footer content -->
			<!-- jQuery -->
			<!-- jQuery -->
			<script src="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.min.js"></script>
			<!-- Bootstrap -->
			<script
				src="${pageContext.request.contextPath}/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
			<!-- FastClick -->
			<script
				src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
			<!-- NProgress -->
			<script src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
			<!-- Chart.js -->
			<script src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>
			<script
				src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
			<script
				src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
			<!-- Custom Theme Scripts -->
			<script src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
			<!-- bootbox code -->
			<script
				src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>
			<script src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
			<!-- Ion.RangeSlider -->
			<script
				src="${pageContext.request.contextPath}/vendors/bootstrap-slider-master/dist/bootstrap-slider.min.js"></script>
			<!-- CSS dependencies for canvasjs -->
			<script src="${pageContext.request.contextPath}/vendors/vis/dist/vis.js"></script>
			<script
				src="${pageContext.request.contextPath}/vendors/Tags-Input-master/src/jquery.tagsinput.js"></script>
			<script type="text/javascript">
    var nodes = null;
    var edges = null;
    var network = null;
	var id =0;
	
		
    var  nodes = [
    	<c:forEach items="${idlist}" var="l"  varStatus="status">
    	{id:  ${l.value},  value: 1,  label: '${l.key}' },
    	</c:forEach>
        ];
    var edges = [
    	<c:forEach items="${netlist}" var="l"  varStatus="status">
    	<c:set var="parts" value="${fn:split(l.key, '-')}" />
    		<c:set var="s1" value="${parts[0]}"/>
    			<c:set var="s2" value="${parts[1]}"/>
    				<c:set var="s3" value="${idlist[s1]}"/>
    					<c:set var="s4" value="${idlist[s2]}"/>
    	    				
    				<c:if test="${not empty s3 && not empty s4}">
    	  	 			{from: ${idlist[s1]}, to: ${idlist[s2]}, value: ${l.value}, title: 'Amount ${l.value}'},
    	    	  	</c:if>
    	 </c:forEach>
    	 ];
    // create a network
    var container = document.getElementById('mynetwork');
    var data = {
        nodes: nodes,
        edges: edges
    };
    
    var options = {
    interaction:{hover:true},
    hover: true,
    tooltipDelay: 3,
        nodes: {
          shape: 'dot',
          scaling:{
            label: {
              min:8,
              max:20
            }
          }
        }
      };
    network = new vis.Network(container, data, options);
    network.on("click", function (params) {
        params.event = "[original event]";
        document.getElementById('eventSpan').innerHTML = '<h2>Click event:</h2>' + JSON.stringify(params, null, 4);
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

			<script type="text/javascript">
		$(function() {
			$('#tags').tagsInput({width:'auto'});	
		});
	</script>
			<script type="text/javascript">
  window.onload = function () {
    var chart = new CanvasJS.Chart("chartContainer",
    {
      title: {
        text: ""
      },
      legend: {
       horizontalAlign: "right", // "center" , "right" (fahad)
       verticalAlign: "bottom",
       fontSize: 15
       },
       animationEnabled: true,
       axisX:{
        interlacedColor: "#F0F8FF",
        labelFontSize: 12, 
         interval: 1,
       intervalType: ${span},
        valueFormatString: "DD MMM YYYY"   // "DD MMM" for date and month, "MMM" for month only , "YYYY" year only (fahad)
         
      },
      axisY:{
        labelFontSize: 12
      },
       exportEnabled: true,
        data: [
        	<c:forEach items="${trend}" var="l">
        	{
        	  click: function(e){
        	  xychange( "dataSeries Event => Type: "+ e.dataSeries.type+ ", dataPoint { x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y + " }");
              $('#chartpoint input').val(" x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y+","+"${l.key}").trigger('change');
             },
      
        type: "line",
        showInLegend: true,
        legendMarkerType: "circle",
        legendText: "${l.key}",
        color: '#'+Math.floor(Math.random()*16777215).toString(16),
        name:"${l.key}",
        fillOpacity: .2,
        dataPoints: ${l.value}
      },
      </c:forEach>
      ],
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
    }
     window.xychange = function(title, message){
    var myElementToShow = document.getElementById("xychange");
    myElementToShow.innerHTML = title + "</br>" + message; 
}
</script>

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
            cancelLabel: 'Close',
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

			<script> 
   		function datechanged()
       	{
             document.getElementById("dateform").submit();
        }
   		function trackerchanged()
   	   	{
   	     		document.getElementById("trackerform").submit();
   	   	}
   		function xychanged()
   		{
   			document.getElementById("xyform").submit();
   		}
   		function tagfunction()
   		{
   		    
   			   			 
   			var spans = document.getElementById('tags_tagsinput').getElementsByTagName('span');//returns node-list of spans
   			var s="";
   			for (var i=0;i<=spans.length;i++)
   			{
   				
   			 if (i%2!=0) {
   				 var test = spans[i].innerHTML;
   				 var test1 = test.replace(/&nbsp/g, "");
   				 test1 = test1.replace(/\;/g,"");
   				 console.log(spans[i].innerHTML);
   				 s=s+","+test1;
             }
   			    
   			
   			document.getElementById('tagsname').value = s;
   			document.getElementById("tagform").submit();
   			}
   		}
   </script>
			<script>
      var slider = new Slider("#ex4", {
	reversed : true,
	ticks_snap_bounds: 30
});
        </script>

			<!-- JQVMap -->
</body>
</html> --%>