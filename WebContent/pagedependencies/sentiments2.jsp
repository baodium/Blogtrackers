  
<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/styling/switch.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
<script
					src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
<script
						src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
<script type="text/javascript" src="assets/js/plugins/tables/datatables/datatables.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/selects/select2.min.js"></script>

<script type="text/javascript" src="assets/js/pages/datatables_basic.js"></script>


	<script type="text/javascript" src="assets/js/core/app.js"></script>
	
   <script type="text/javascript" src="assets/js/intro.js"></script>
   
	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
   <script>
   $(document).ready(function(){
	// trigger the check box dynamically
	$('.individualspan').each(function(index,element){
	// generic checkbox checker	
	$('.individualspan:eq('+index+')').click(function(e){
	//$('.mylabel:eq('+index+')').append("test");	
	$('individualcheckbox:eq('+index+')').click();
	});	
	});
	   
   });
   
 
   </script>
	<!-- FastClick -->
							<script
								src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
							<!-- NProgress -->
							<script
								src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
							<!-- Chart.js -->
							<script
								src="${pageContext.request.contextPath}/vendors/Chart.js/dist/Chart.min.js"></script>
							<!--  <script
								src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>-->
					
					<!-- bootbox code -->
							<script
								src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>

							<script
								src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
								
	<script>
        Chart.defaults.global.legend = {
        enabled: false
      };
        
        var radarOptions = {

        	    title: {
        	        display: false,
        	        text: 'Custom Chart Title'
        	    },

        	    scale: {
        	        angleLines:{
        	            lineWidth: 5
        	        },
        	        pointLabels:{
        	            fontSize: 15,
        	            fontColor: 'ff0000'
        	        },

        	    }


        	}; 
      
      
      // Radar chart
      var ctx = document.getElementById("canvasRadar");
      var data = {
        	labels: ["Work", "Leisure", "Home", "Money", "Religion", "Death"], 
<<<<<<< HEAD
        	datasets: ${radar}
=======
        	datasets: '${radar}'
>>>>>>> 515d11c5b8f60a316491f02c514b92f888da56e2
    		}
      var canvasRadar = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: radarOptions
      });
      
    
      var ctx = document.getElementById("canvasRadar1");
      var data = {  		 
    	labels: ["Past focus", "Present focus", "Future focus"],
        datasets:${radar1}
       };


      var canvasRadar1 = new Chart(ctx, {
        type: 'radar',
        data: data,
        
        options: radarOptions
      });
      
      
      var ctx = document.getElementById("canvasRadar2");
      var data = {
        labels: ["Affiliation", "Achievement", "Power", "Reward focus", "Risk/prevention focus"],
        datasets: ${radar2}
      };

      var canvasRadar2 = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: radarOptions
      });
      
      
      var ctx = document.getElementById("canvasRadar3");
      var data = {
        labels: ["Insight", "Cause", "Discrepancies", "Tentativeness", "Certainty", "Differentiation"],
<<<<<<< HEAD
        datasets: ${radar3}
=======
        datasets: '${radar3}'
>>>>>>> 515d11c5b8f60a316491f02c514b92f888da56e2
      };

      var canvasRadar3 = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: radarOptions
      });
      
      var ctx = document.getElementById("canvasRadar4");
      var data = {
        labels: ["Analytical Thinking", "Clout", "Authentic", "Emotional Tone"],
<<<<<<< HEAD
        datasets: ${radar4}
=======
        datasets: '${radar4}'
>>>>>>> 515d11c5b8f60a316491f02c514b92f888da56e2
      };


      var canvasRadar4 = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: radarOptions
      });
      
      
      var ctx = document.getElementById("canvasRadar5");
      var data = {
        labels: ["Positive emotion", "Negative emotion", "Anxiety", "Anger", "Sadness"],
<<<<<<< HEAD
        datasets: ${radar5}
=======
        datasets: '${radar5}'
>>>>>>> 515d11c5b8f60a316491f02c514b92f888da56e2
      };

      var canvasRadar5 = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: radarOptions
      });

    
      
    </script>

					<script type="text/javascript">
  //window.onload = 
$(document).ready(function () {
    var chart = new CanvasJS.Chart("chartContainer",
    {
			      title: {
			        text: ""
			      },
			      legend: {
			       horizontalAlign: "right", // "center" , "right" (fahad)
			       verticalAlign: "bottom",
			       fontSize: 25
			       },
			       animationEnabled: true,
			       axisX:{
			        
			        labelFontSize: 12, 
			         interval: 1,
			       intervalType: '${span}',
			        valueFormatString: "DD MMM YYYY"   // "DD MMM" for date and month, "MMM" for month only , "YYYY" year only (fahad)
			         
			      },
			      axisY:{
			        labelFontSize: 12
			      },
       exportEnabled: true,
        data: [
            {
		          click: function(e){
		        	  $(".loader").removeClass("hidden");
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
<<<<<<< HEAD
		        dataPoints: ${trendpos},          //array
=======
		        dataPoints: "${trendpos}",          //array
>>>>>>> 515d11c5b8f60a316491f02c514b92f888da56e2
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
<<<<<<< HEAD
		        dataPoints: ${trendneg},
        	},
=======
		        dataPoints: '${trendneg}',
        	}],
>>>>>>> 515d11c5b8f60a316491f02c514b92f888da56e2
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
		}]
    });
    chart.render();
  });
  
  window.xychange = function(title, message){
    var myElementToShow = document.getElementById("xychange");
    myElementToShow.innerHTML = title + "</br>" + message; 
}

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
    	      {   
    		  	  startDate: moment().subtract('days', 29),
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
    $('#trackerform').attr("action","Sentiments");
    $('#dateform').attr("action","Sentiments"); 
	 </script>
	 
	 	<script type="text/javascript">
    /*$(function(){
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
		  })*/
    </script>
	 				<script> 
					
   		function datechanged()
       	{
       	$(".loader").removeClass("hidden");
            // document.getElementById("dateform").submit();
       	var datepicked = $("#datepicked").val();
			$(".demo-container").html("<div style='text-align:center; padding:150px'><img src='assets/images/preloader.gif' /><br/></div>");
			
			$.ajax({
		        url: app_url+'webtemplates/sentiment_loader.jsp',
				method:'POST',
				//async: true,
				data:{datepicked:datepicked,is_request:true},
		        success: function(response)
		        {	
		        	$(".demo-container").html(response);
		        }
		    });
             
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
   			//document.getElementById("xyform").submit();
   			var xy = $("#xychange").val();
			$(".demo-container").html("<div style='text-align:center; padding:150px'><img src='assets/images/preloader.gif' /><br/></div>");
		       
			$.ajax({
		        url: app_url+'webtemplates/sentiment_loader.jsp',
				method:'POST',
				//async: true,
				data:{xychange:xy,is_request:true},
		        success: function(response)
		        {	
		        	// console.log(response);
		        	$(".demo-container").html(response);
		        }
		    });
   		}
   		function aggr_norm_changed()
   		{
   		 $(".loader").removeClass("hidden");
   			//document.getElementById("trendtype").submit();
   		//var xy = $("#xychange").val();
   		var aggr = document.forms['trendtype'].aggr_norm.value;//$("#xychange").val();
		$(".demo-container").html("<div style='text-align:center; padding:150px'><img src='assets/images/preloader.gif' /><br/></div>");
	       
		$.ajax({
	        url: app_url+'webtemplates/sentiment_loader.jsp',
			method:'POST',
			//async: true,
			data:{aggr_norm:aggr,is_request:true},
	        success: function(response)
	        {	
	        	$(".demo-container").html(response);
	        }
	    });
   		}
   		function spanChanged() {
			//document.getElementById("st_spanform").submit();
   			var stspan = document.forms['st_spanform'].options.value;//$("#xychange").val();
			$(".demo-container").html("<div style='text-align:center; padding:150px'><img src='assets/images/preloader.gif' /><br/></div>");
		       
			$.ajax({
		        url: app_url+'webtemplates/sentiment_loader.jsp',
				method:'POST',
				//async: true,
				data:{options:stspan,is_request:true},
		        success: function(response)
		        {	
		        	$(".demo-container").html(response);
		        	
		        	
		        	$.getScript("pagedependencies/sentiments.jsp", function( data, textStatus, jqxhr ) {
						
					});
		        	
		        }
		    });
		}
   		
   	    
   </script>
