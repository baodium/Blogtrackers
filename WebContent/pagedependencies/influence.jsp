   <script type="text/javascript" src="assets/js/intro.js"></script>

<script type="text/javascript" src="assets/js/plugins/visualization/d3/d3.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/visualization/d3/d3_tooltip.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
	<script
					src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
	<script
						src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
<script type="text/javascript" src="assets/js/plugins/tables/datatables/datatables.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/selects/select2.min.js"></script>

<script type="text/javascript" src="assets/js/pages/datatables_basic.js"></script>
<!--   <script type="text/javascript" src="assets/js/charts/d3/bars/bars_basic_vertical.js"></script>-->
   <script type="text/javascript" src="assets/js/plugins/visualization/c3/c3.min.js"></script>

		<script type="text/javascript" src="assets/js/charts/c3/c3_lines_areas.js"></script>

	<script type="text/javascript" src="assets/js/core/app.js"></script>
	

<script type="text/javascript" src="assets/js/pages/datatables_basic.js"></script>
 
		
	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
	
				<script
				src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
			<script
				src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
			<script
				src="${pageContext.request.contextPath}/vendors/Chart.js/dist/Chart.min.js"></script>
			<script
				src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>
	
<script
				src="${pageContext.request.contextPath}/vendors/jQCloud-master/jqcloud/jqcloud-1.0.4.js"></script>
			<script
				src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
			<script
				src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>
			<script
				src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
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
								//console.log($(this).text());
								$('#blogpostContent').text($(this).text());
							});

						});
			</script>


			<script type="text/javascript">
				//window.onload = 
					$(document).ready(function() {
					try{
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
						//console.log("F%" + f5);
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
					}catch(e){}
				});
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
				try{
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
				}catch(Exception){}
			</script>
			
<script>
	    	
	$(document)
	.ready(
			function() {
var cb = function(start, end, label) {
//console.log(start.toISOString(), end.toISOString(), label);
$('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
$('#reportrange input').val(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY')).trigger('change');
};

var optionSet1 =
{   startDate: moment().subtract('days', 29),
endDate: moment(),
minDate: '01/01/1947',
maxDate: moment(),
showDropdowns: true,
showWeekNumbers: true,
timePicker : false,
timePickerIncrement : 1,
timePicker12Hour : true,
   ranges: {
  
'This Year' : [
	moment()
			.startOf('year'),
	moment() ],
'Last Year' : [
	moment()
			.subtract(1,'year').startOf('year'),
	moment().subtract(1,'year').endOf('year') ]
/* 
'Last Year': [moment().subtract('years', 1).startOf('year'), moment().subtract('years', 1).endOf('year')],
'This Year': [moment().startOf('year'), moment()]*/
},
opens: 'left',
applyClass: 'btn-small bg-slate-600 btn-block',
cancelClass: 'btn-small btn-default btn-block',
format: 'MM/DD/YYYY',
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
{ 
$('#reportrange span').html(moment().subtract('days', 500).format('MMMM D') + ' - ' + moment().format('MMMM D'));
$('#reportrange').daterangepicker(optionSet1, cb);
}

else{ 
$('#reportrange span').html('${datepicked}');
$('#reportrange').daterangepicker(optionSet1, cb);
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
});
}
			});

     // set attribute for the form 
    $('#trackerform').attr("action","InfluenceServlet");
    $('#dateform').attr("action","InfluenceServlet"); 
	 </script>
	 <script type="text/javascript">
				function trackerchanged() {
					$(".loader").removeClass("hidden");
					document.getElementById("trackerform").submit();
				}
				
				function datechanged() {
					$(".loader").removeClass("hidden");
					//document.getElementById("dateform").submit();
					var datepicked = $("#datepicked").val();
					$("#body-result").html("<div style='text-align:center; padding:150px'><img src='assets/images/preloader.gif' /><br/></div>");
				       
					$.ajax({
				        url: app_url+'webtemplates/influence_loader.jsp',
						method:'POST',
						//async: true,
						data:{datepicked:datepicked,is_request:true},
				        success: function(response)
				        {	
				        	$("#body-result").html(response);
				        }
				    });
				}
				function spanChanged() {
					document.getElementById("pf_spanForm").submit();
				}
			</script>
			<script>
				$(document).ready(function() {
					$('[data-toggle="tooltip"]').tooltip();
				});
			</script>
