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
	


 
		
	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
	
	<script
				src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
			<!-- NProgress -->
			<script src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
			<!-- Chart.js -->
			<script src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>
			<script src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
			<!-- bootbox code -->
			<script
				src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>
			<script src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
			<!-- Ion.RangeSlider -->
			<!--  <script
				src="${pageContext.request.contextPath}/vendors/bootstrap-slider-master/src/bootstrap-slider.js"></script>
				-->
			<!-- CSS dependencies for canvasjs -->
			<script src="${pageContext.request.contextPath}/vendors/vis/dist/vis.js"></script>
			<script
				src="${pageContext.request.contextPath}/vendors/Tags-Input-master/src/jquery.tagsinput.js"></script>
	
	
	<script>
	

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
	       intervalType: '',
	        valueFormatString: "DD MMM YYYY"   // "DD MMM" for date and month, "MMM" for month only , "YYYY" year only (fahad)
	         
	      },
	      axisY:{
	        labelFontSize: 12
	      },
	       exportEnabled: true,
	        data: [
	        	
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
		
			$(function() {
				$('#tags').tagsInput({width:'auto'});	
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
	}
	
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
    $('#trackerform').attr("action","KeywordTrendsServlet");
    $('#dateform').attr("action","KeywordTrendsServlet"); 
    
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
				
				$(".loader").removeClass("hidden");
				$(".searchBar").addClass("hidden");
				// alert("Enter was pressed was presses");
			}
		}

   </script>
	 
	 
	 
	 
			
	 