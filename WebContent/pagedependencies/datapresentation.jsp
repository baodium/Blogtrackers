
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/moment/moment.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/pickers/daterangepicker.js"></script>

	<script type="text/javascript" src="assets/js/core/app.js"></script>
 <!-- <script type="text/javascript" src="assets/js/pages/dashboard.js"></script> -->  
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
 <script>
	    	
    	var cb = function(start, end, label) {
              console.log(start.toISOString(), end.toISOString(), label);
              $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
              $('#reportrange input').val(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY')).trigger('change');
            };
    	
    	$('#reportrange').daterangepicker(
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
                $('#reportrange span').html(start.format('MMMM D') + ' - ' + end.format('MMMM D'));
            }
        );
    if('${datepicked}' == '')
        $('#reportrange span').html(moment().subtract('days', 29).format('MMMM D') + ' - ' + moment().format('MMMM D'));
    	else 
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
     // set attribute for the form 
    $('#trackerform').attr("action","ExportJSON");
    $('#dateform').attr("action","ExportJSON"); 
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
 