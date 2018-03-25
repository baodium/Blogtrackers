   <script type="text/javascript" src="assets/js/intro.js"></script>
   
	<!--  before Theme JS files -->
	<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
<script
					src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
	<script
						src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
<script type="text/javascript" src="assets/js/plugins/tables/datatables/datatables.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/selects/select2.min.js"></script>



	


 <script type="text/javascript" src="assets/js/core/app.js"></script>

	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
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
					/* console
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
    $('#trackerform').attr("action","BlogClustering");
    $('#dateform').attr("action","BlogClustering"); 
	 </script>
	<script type="text/javascript">
	 	//alert("here");
						function trackerchanged() {
							$(".loader").removeClass("hidden");
							document.getElementById("trackerform").submit();
						}
						function datechanged() {
							//alert("date picked");//$(".loader").removeClass("hidden");
							
							document.getElementById("dateform").submit();
						}
						
						
</script>
	 <script src="${pageContext.request.contextPath}/js/plotly-latest.min.js"></script>
	<script>
	var trace1 = {
			//  x: [1, 2, 3, 4, 5],
			//  y: [1, 6, 3, 6, 1],
			${cluster1}
			  mode: 'markers',
			  type: 'scatter',
			  name: 'Cluster 1',
			  text: ['A-1', 'A-2', 'A-3', 'A-4', 'A-5'],
			  marker: { size: 12 }
			};

			var trace2 = {
			 // x: [1.5, 2.5, 3.5, 4.5, 5.5],
			 // y: [4, 1, 7, 1, 4],
			 ${cluster2}
			  mode: 'markers',
			  type: 'scatter',
			  name: 'Cluster 2',
			  text: ['B-a', 'B-b', 'B-c', 'B-d', 'B-e'],
			  marker: { size: 12 }
			};
			
			/* var trace3 = {
					  x: [1, 2, 3, 3, 2],
					  y: [3, 1.5, 7, 2, 5],
					  mode: 'markers',
					  type: 'scatter',
					  name: 'Cluster 3',
					  text: ['C-a', 'C-b', 'C-c', 'C-d', 'C-e'],
					  marker: { size: 12 }
					}; */


			var data = [ trace1, trace2 ];

			var layout = {
			  xaxis: {
			    range: [ 0.75, 5.25 ]
			  },
			  yaxis: {
			    range: [0, 8]
			  },
			  title:'Scatter Plot'
			};

			Plotly.newPlot('clusterscatterplot', data, layout);
	</script>
				