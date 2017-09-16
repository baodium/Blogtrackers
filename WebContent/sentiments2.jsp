<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
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

<title>Blogtrackers | Sentiments</title>

<!-- <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
 -->
 <!-- <link rel="stylesheet" 

href="https://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" 

href="https://cdn.datatables.net/plug-ins/9dcbecd42ad/integration/jqueryui/dataTables.jqueryui.css">
  -->
  
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.css">
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
<link href="${pageContext.request.contextPath}/build/css/grid.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.js"></script>
<style>
div.scroll {
	overflow: scroll;
}
</style>
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
							<form name="trackerform" id="trackerform" action="Sentiments"
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
						<div class="col-md-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										Timeline of Sentiments<small></small>
									</h2>
									<form name="dateform" id="dateform" action="Sentiments"
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
									<div class="col-md-12 col-sm-12 col-xs-12">
										<div class="demo-container">

											<div id="chartContainer" style="height: 350px"></div>
											<div style="text-align: center; margin-bottom: 15px;">

												<div class="btn-group" role="group" aria-label="First group">
													<form name="spanform" id="spanform" action="Sentiments"
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
													<br>
													<form name="trendtype" id="trendtype" action="Sentiments"
														method="post">
														<c:choose>
															<c:when test="${radio eq 'aggregate'}">
																<input type="radio" name="aggr_norm" value="aggregate"
																	checked="checked"> Aggregate 
															<input type="radio" name="aggr_norm" value="normalized"
																	onchange="aggr_norm_changed()"> Normalized
													    </c:when>
															<c:otherwise>

																<input type="radio" name="aggr_norm" value="aggregate"
																	onchange="aggr_norm_changed()"> Aggregate 
															<input type="radio" name="aggr_norm" value="normalized"
																	checked="checked"> Normalized
													    
    												</c:otherwise>
														</c:choose>
													</form>
													<div id="chartpoint">
														<form name="xyform" id="xyform" action="Sentiments"
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


							<div class="clearfix"></div>
							<div class="row">
								<div class="col-md-12 col-sm-12 col-xs-12">
									<div class="x_panel">
										<div class="x_title">
											<h3>
												Sentiments <small></small>
											</h3>
											<div class="clearfix"></div>
										</div>
										<div class="x_content">
											<form action="Sentiments" method="post">
												<div class="row">
													<div class="col-md-2 col-sm-12 col-xs-12" >
														<div>
															<div class="x_title">
																<h2>Blog Posts</h2>
																&nbsp&nbsp&nbsp&nbsp
																<button type="submit" name="go">Go</button>
																<div class="clearfix"></div>
															</div>
															<div class="scroll" style="height: 700px;">
																<div class="table-responsive" >

																	<table id="sentitable"
																		class="table table-striped jambo_table bulk_action">
																		<thead>
																			<tr class="headings">
																				<th><input type="checkbox" id="check-all"
																					class="flat"></th>
																				<th class="column-title">Select All</th>
																			
																				<th class="bulk-actions" colspan="7"><a
																					class="antoo"
																					style="color: #fff; font-weight: 500;"> ( <span
																						class="action-cnt"> </span> ) <i
																						class="fa fa-chevron-down"></i></a></th>
																			</tr>
																		</thead>
																		<tbody>
																			<%--   <tr class="even pointer">
                            <td class="a-center ">
                              <input type="checkbox" class="flat" name="table_records">
                            </td>
                            <td class=" "><b>Average</b></td>
                          </tr> --%>

																			<c:set var="i" value="0" />
																			<c:set var="eo" value="1" />
																			<c:forEach items="${names}" var="s1" begin="${i}">
																				<c:if test="${eo==1 || eo%2 ==1 }">
																					<tr class="odd pointer">
																						<c:forEach items="${names}" var="s1" begin="${i}"
																							end="${i}">
																							<td class="a-center "><input type="checkbox"
																								class="flat" name="table_records"
																								value="${s1[1]}"></td>
																							<td class=" "><c:out value="${s1[0]}" /></td>

																						</c:forEach>
																					</tr>
																					<c:set var="i" value="${i+1}" />
																				</c:if>
																				<c:if test="${eo%2 ==0}">
																					<tr class="even pointer">
																						<c:forEach items="${names}" var="s1" begin="${i}"
																							end="${i}">
																							<td class="a-center "><input type="checkbox"
																								class="flat" name="table_records"></td>
																							<td class=" "><c:out value="${s1[0]}" /></td>
																						</c:forEach>
																					</tr>
																					<c:set var="i" value="${i+1}" />
																				</c:if>
																				<c:set var="eo" value="${eo+2}" />
																			</c:forEach>




																		</tbody>
																	</table>

																</div>
															</div>
														</div>
											</form>
										</div>

										<div class="col-md-10 col-sm-12 col-xs-12">
											<div class="clearfix"></div>
											<div class="x_content">
												<form id="frmData" onsubmit="return false">
													<div class="buttons">
														<button class="list pull-right btn btn-default btn-sm">
															<i class="glyphicon glyphicon-th-list"></i> List View
														</button>
														<button class="grid pull-right btn btn-default btn-sm">
															<i class="glyphicon glyphicon-th"></i> Grid View
														</button>
													</div>
												</form>
												<div id="container">
													<ul class="grid">
														<div class="x_content">
															<li>
																<div class="clearfix"></div>
																<div class="col-md-12 col-sm-12 col-xs-12">
																	<div class="x_panel">
																		<h2>Personal Concerns</h2>
																		<div class="clearfix"></div>
																		<div class="x_content">
																			<canvas id="canvasRadar"></canvas>
																		</div>
																	</div>
																</div>
															</li>
															<li>
																<div class="col-md-12 col-xs-12">
																	<div class="x_panel">
																		<h2>Time Orientation</h2>
																		<div class="clearfix"></div>
																		<div class="x_content">
																			<canvas id="canvasRadar1"></canvas>
																		</div>
																	</div>
																</div>
															</li>
															<li>
																<div class="clearfix"></div>
																<div class="col-md-12 col-xs-12">
																	<div class="x_panel">
																		<h2>Core Drives and Needs</h2>
																		<div class="clearfix"></div>
																		<div class="x_content">
																			<canvas id="canvasRadar2"></canvas>
																		</div>
																	</div>
																</div>
															</li>
															<li>
																<div class="col-md-12 col-xs-12">
																	<div class="x_panel">
																		<h2>Cognitive Process</h2>
																		<div class="clearfix"></div>
																		<div class="x_content">
																			<canvas id="canvasRadar3"></canvas>
																		</div>
																	</div>
																</div>
															</li>
															<li>
																<div class="clearfix"></div>
																<div class="col-md-12 col-xs-12">
																	<div class="x_panel">
																		<h2>Summary Variable</h2>
																		<div class="clearfix"></div>
																		<div class="x_content">
																			<canvas id="canvasRadar4"></canvas>
																		</div>
																	</div>
																</div>
															</li>

															<li>
																<div class="col-md-12 col-xs-12">
																	<div class="x_panel">
																		<h2>Sentiment/Emotion</h2>
																		<div class="clearfix"></div>
																		<div class="x_content">
																			<canvas id="canvasRadar5"></canvas>
																		</div>
																	</div>
																</div>
															</li>
													</ul>
												</div>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>
					</div>


					<!-- /page content -->

					<!-- footer content -->
					<div class="footer_fixed">
						<footer>
							<div class="pull-right" style="height: 6px;"></div>
							<div class="clearfix"></div>

						</footer>
					</div>


					<!-- /footer content -->

					<!-- jQuery -->
					
					<script
						src="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.min.js"></script>
					<script
						src="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.js"></script>
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
						src="${pageContext.request.contextPath}/vendors/Chart.js/dist/Chart.min.js"></script>
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
					<!-- <script type="text/javascript" charset="utf8"
						src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script> -->
						
						
<!-- <script 

src="https://cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
<script 

src="https://cdn.datatables.net/plug-ins/9dcbecd42ad/integration/jqueryui/dataTables.jqueryui.js">
</script> -->
						
						<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.js"></script>
						
					<!-- Chart.js -->

					<script>
        Chart.defaults.global.legend = {
        enabled: false
      };
      
      
      // Radar chart
      var ctx = document.getElementById("canvasRadar");
      var data = {
        labels: ["Work", "Leisure", "Home", "Money", "Religion", "Death"],
        datasets: ${radar}
    };
      var canvasRadar = new Chart(ctx, {
        type: 'radar',
        data: data,
      });
      
    
       var ctx = document.getElementById("canvasRadar1");
      var data = {
        labels: ["Past focus", "Present focus", "Future focus"],
        datasets:${radar1}
       };


      var canvasRadar1 = new Chart(ctx, {
        type: 'radar',
        data: data,
      });
      
      
      var ctx = document.getElementById("canvasRadar2");
      var data = {
        labels: ["Affiliation", "Achievement", "Power", "Reward focus", "Risk/prevention focus"],
        datasets: ${radar2}
      };

      var canvasRadar2 = new Chart(ctx, {
        type: 'radar',
        data: data,
      });
      
      
      var ctx = document.getElementById("canvasRadar3");
      var data = {
        labels: ["Insight", "Cause", "Discrepancies", "Tentativeness", "Certainty", "Differentiation"],
        datasets: ${radar3}
      };

      var canvasRadar3 = new Chart(ctx, {
        type: 'radar',
        data: data,
      });
      
      var ctx = document.getElementById("canvasRadar4");
      var data = {
        labels: ["Analytical Thinking", "Clout", "Authentic", "Emotional Tone"],
        datasets: ${radar4}
      };


      var canvasRadar4 = new Chart(ctx, {
        type: 'radar',
        data: data,
      });
      
      
      var ctx = document.getElementById("canvasRadar5");
      var data = {
        labels: ["Positive emotion", "Negative emotion", "Anxiety", "Anger", "Sadness"],
        datasets: ${radar5}
      };

      var canvasRadar5 = new Chart(ctx, {
        type: 'radar',
        data: data,
      });

    
      
    </script>
					<script>
    $('button').on('click',function(e) {
    if ($(this).hasClass('grid')) {
        $('#container ul').removeClass('list').addClass('grid');
    }
    
    else if ($(this).hasClass('list')) {
        $('#container ul').removeClass('grid').addClass('list');
    }
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
        
        labelFontSize: 12, 
         interval: 1,
       intervalType: "${span}",
        valueFormatString: "DD MMM YYYY"   // "DD MMM" for date and month, "MMM" for month only , "YYYY" year only (fahad)
         
      },
      axisY:{
        labelFontSize: 12
      },
       exportEnabled: true,
        data: [
            {
          click: function(e){
         xychange( "dataSeries Event => Type: "+ e.dataSeries.type+ ", dataPoint { x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y + " }");
         $('#chartpoint input').val(" x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y).trigger('change');
        },
      
        type: "line",
        showInLegend: true,
        legendMarkerType: "circle",
        legendText: "Positive Sentiments",
        color: "green",
        fillOpacity: 0,
        name : "Positve Sentiments",
        dataPoints: //array
        	${trendpos}     
         
      },
      
      { 
          click: function(e){
         xychange( "dataSeries Event => Type: "+ e.dataSeries.type+ ", dataPoint { x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y + " }");
         $('#chartpoint input').val(" x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y).trigger('change');
        
        },
      
        type: "line",
        showInLegend: true,
        legendMarkerType: "circle",
        legendText: "Negative Sentiments",
        color: "red",
        fillOpacity: 0,
        name:"Negative Sentiments",
        dataPoints: //array
		${trendneg}
        
     }
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
        })
        
      });
      
      
    
    </script>

					<script type="text/javascript">
    $(function(){
		    $("#sentitable").dataTable({
		    	"bPaginate": false,
			    "bLengthChange": false,
			    "bFilter": true,
			    "bSort": true,
			    "bInfo": false,
			    "bAutoWidth": false,
			    "asStripClasses": null,
			    "sDom": '<"right"f>',
			    "order": [[ 1, 'asc' ]],
			    "columnDefs": [
			        { "orderable": false, "targets": 0 }
			      ]
			    });
		  })
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
   		function aggr_norm_changed()
   		{
   			document.getElementById("trendtype").submit();
   		}
   		
   	    
   </script>
</body>
</html>
