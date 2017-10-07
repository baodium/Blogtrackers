<script type="text/javascript" src="assets/js/plugins/visualization/d3/d3.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/visualization/d3/d3_tooltip.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/moment/moment.min.js"></script>
<script
						src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
<script type="text/javascript" src="assets/js/plugins/tables/datatables/datatables.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/selects/select2.min.js"></script>

<script type="text/javascript" src="assets/js/pages/datatables_basic.js"></script>
<!--   <script type="text/javascript" src="assets/js/charts/d3/bars/bars_basic_vertical.js"></script>-->
   <script type="text/javascript" src="assets/js/plugins/visualization/c3/c3.min.js"></script>

		<script type="text/javascript" src="assets/js/charts/c3/c3_lines_areas.js"></script>

	<script type="text/javascript" src="assets/js/core/app.js"></script>
	<script type="text/javascript" src="assets/js/pages/dashboard.js"></script>
		
	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>

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
					
					<!-- bootbox code -->
							<script
								src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>

							<script
								src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
								
								
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
								
	<script>
	    	
	var cb = function(start, end, label) {
        console.log(start.toISOString(), end.toISOString(), label);
        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
        $('#reportrange input').val(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY')).trigger('change');
      };
	
	var optionSet1 = $('#reportrange').daterangepicker(
      {
          startDate: moment().subtract('days', 29),
          endDate: moment(),
          minDate: '01/01/2000',
          maxDate: moment(),
			showDropdowns: true,
        showWeekNumbers: true,
          dateLimit: { days: 50000 },
          ranges: {
              
				'Last Year': [moment().subtract('years', 1).startOf('year'), moment().subtract('years', 1).endOf('year')],
				'This Year': [moment().startOf('year'), moment()]
            
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
          $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
      }
  );
	if('${datepicked}' == '')
	{ $('#reportrange span').html(moment().subtract('days', 400).format('MMMM D') + ' - ' + moment().format('MMMM D'));
	$('#datepicked').val(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY')).trigger('change');}
	
	else{ 
		/*$('#reportrange').on('show.daterangepicker', function() {
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
      });*/
	$('#options1').click(function() {
        $('#reportrange').data('daterangepicker').setOptions(optionSet1, cb);
      });
   $('#options2').click(function() {
       $('#reportrange').data('daterangepicker').setOptions(optionSet2, cb);
      });
     /* $('#destroy').click(function() {
        $('#reportrange').data('daterangepicker').remove();
      });*/
	}

     // set attribute for the form 
    $('#trackerform').attr("action","Sentiments");
    $('#dateform').attr("action","Sentiments"); 
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
       	$(".loader").removeClass("hidden");
             document.getElementById("dateform").submit();
             
        }
   		function trackerchanged()
   	   	{
   	   	$(".loader").removeClass("hidden");
   	     		document.getElementById("trackerform").submit();
   	     	 $(".loader").removeClass("hidden");
   	   	}
   		function xychanged()
   		{
   		 $(".loader").removeClass("hidden");
   			document.getElementById("xyform").submit();
   		}
   		function aggr_norm_changed()
   		{
   		 $(".loader").removeClass("hidden");
   			document.getElementById("trendtype").submit();
   		}
   		function spanChanged() {
			document.getElementById("st_spanform").submit();
		}
   		
   	    
   </script>
	