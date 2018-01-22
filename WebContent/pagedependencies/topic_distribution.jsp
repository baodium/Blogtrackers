   <script type="text/javascript" src="assets/js/intro.js"></script>
   

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


	<script type="text/javascript" src="assets/js/core/app.js"></script>
	
 
		
	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
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
			<!--  	<script
					src="${pageContext.request.contextPath}/production/js/flot/date.js"></script>-->
				<script
					src="${pageContext.request.contextPath}/production/js/flot/jquery.flot.spline.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/flot/curvedLines.js"></script>
					<script
					src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
					
					<script>
	$('.daterange-ranges').daterangepicker(
        {
            startDate: moment().subtract('days', 29),
            endDate: moment(),
            minDate: '01/01/2006',
            maxDate: moment(),
			showDropdowns: true,
          showWeekNumbers: true,
            dateLimit: { days: 30000 },
            ranges: {
                //'Today': [moment(), moment()],
                //'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
				'Last Year': [moment().subtract('years', 1).startOf('year'), moment().subtract('years', 1).endOf('year')],
				//'Last 7 Days': [moment().subtract('days', 6), moment()],
                //'Last 30 Days': [moment().subtract('days', 29), moment()],
                'This Year': [moment().startOf('year'), moment()]
                //'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
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
        },
        function(start, end) {
            $('.daterange-ranges span').html(start.format('MMMM D') + ' - ' + end.format('MMMM D'));
        }
    );

    $('.daterange-ranges span').html(moment().subtract('days', 29).format('MMMM D') + ' - ' + moment().format('MMMM D'));
	</script>
	
			<script type="text/javascript">
					//window.onload = 
						$(document).ready(function() {
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
								legendText : "Topic Distribution",
								color : "#96CA59",
								fillOpacity : .2,
								dataPoints : finals
							} ]
						});
						chart.render();
					});
</script>