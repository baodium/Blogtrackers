   <script type="text/javascript" src="assets/js/intro.js"></script>

	<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/moment/moment.min.js"></script>
<script
						src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
<script type="text/javascript" src="assets/js/plugins/tables/datatables/datatables.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/selects/select2.min.js"></script>
	<script type="text/javascript" src="assets/js/core/app.js"></script>
 <script type="text/javascript" src="assets/js/pages/datatables_basic.js"></script>

    

	

	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
	
	<!-- /theme JS files -->
<script type="text/javascript" src="assets/js/pages/form_select2.js"></script>

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
					//console.log("show event fired");
				});
$('#reportrange')
		.on(
				'hide.daterangepicker',
				function() {
					//console.log("hide event fired");
				});
$('#reportrange')
		.on(
				'apply.daterangepicker',
				function(ev, picker) {
				/* 	console
							.log("apply event fired, start/end dates are "
									+ picker.startDate
											.format('MMMM D, YYYY')
									+ " to "
									+ picker.endDate
											.format('MMMM D, YYYY')); */
				});
$('#reportrange')
		.on(
				'cancel.daterangepicker',
				function(ev, picker) {
					//console.log("cancel event fired");
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
    $('#trackerform').attr("action","PostingFrequency");
    $('#dateform').attr("action","PostingFrequency"); 
	 </script>
