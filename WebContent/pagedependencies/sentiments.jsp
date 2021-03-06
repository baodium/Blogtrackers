  
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
   function spanChanged() {
		document.getElementById("st_spanform").submit();
	}
 
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
								
								
<script type="text/javascript">



  window.onload = function () {
	  var trendpos, trendneg;
	  
	  // trend positive check
	  <%
	  if(session.getAttribute("trendpos") == null)
	  {
	  %>
	  trendpos ="";
	  <% 
	  }
	  else if(session.getAttribute("trendpos") != null)	
	  {
	  %>
	  trendpos = ${trendpos};
	  <% 
	  }
	  %>
	  
	  // trend negative check
	  <%
	  if(session.getAttribute("trendneg") == null)
	  {
	  %>
	  trendneg ="";
	  <% 
	  }
	  else if(session.getAttribute("trendneg") != null)	
	  {
	  %>
	  trendneg = ${trendneg};
	  <% 
	  }
	  %>
   var chart = new CanvasJS.Chart("chartContainer",
    {
      title: {
        text: "Sentiments",
        	fontSize: 15
      },
      legend: {
       horizontalAlign: "right", // "center" , "right" (fahad)
       verticalAlign: "bottom",
       fontSize: 12
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
        dataPoints: trendpos    
         
      },
      
      { 
          click: function(e){
         xychange( "dataSeries Event => Type: "+ e.dataSeries.type+ ", dataPoint { x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y + " }");
         $('#chartpoint input').val(" x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y).trigger('change');},
        type: "line",
        showInLegend: true,
        legendMarkerType: "circle",
        legendText: "Negative Sentiments",
        color: "red",
        fillOpacity: 0,
        name:"Negative Sentiments",
        dataPoints: trendneg
        
     }
      ]
      /* legend:{
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
		} */
    });
    chart.render();
  }
  window.xychange = function(title, message){
    var myElementToShow = document.getElementById("xychange");
    myElementToShow.innerHTML = title + "</br>" + message; 
}

	</script>
	
	<script>
	
	   // Radar chart
    var rad1, rad2, rad3, rad4, rad5, rad6;
	   // rad 1
     <%
     if(session.getAttribute("radar") == null)
     {	 
     %>
      rad1 = ""
     <%
     }
     else if(session.getAttribute("radar") != null)
     { 
	  %>
	  rad1  = ${radar};
	  <% 
     }
	  %>
	  // rad 2
	  <%
	     if(session.getAttribute("radar1") == null)
	     {	 
	     %>
	      rad2 = ""
	     <%
	     }
	     else if(session.getAttribute("radar1") != null)
	     { 
		  %>
		  rad2  = ${radar1};
		  <% 
	     }
		  %>
		  
		  // rad 3
		  <%
		  if(session.getAttribute("radar2") == null)
		     {	 
		     %>
		      rad3 = ""
		     <%
		     }
		     else if(session.getAttribute("radar2") != null)
		     { 
			  %>
			  rad3  = ${radar2};
			  <% 
		     }
			  %>
			  
			// rad 4
			  <%
			  if(session.getAttribute("radar3") == null)
			     {	 
			     %>
			      rad4 = ""
			     <%
			     }
			     else if(session.getAttribute("radar3") != null)
			     { 
				  %>
				  rad4  = ${radar3};
				  <% 
			     }
				  %>
				  
				// rad 5
				  <%
				  if(session.getAttribute("radar4") == null)
				     {	 
				     %>
				      rad5 = ""
				     <%
				     }
				     else if(session.getAttribute("radar4") != null)
				     { 
					  %>
					  rad5  = ${radar4};
					  <% 
				     }
					  %>
					  
					// rad 6
					  <%
					  if(session.getAttribute("radar5") == null)
					     {	 
					     %>
					      rad6 = ""
					     <%
					     }
					     else if(session.getAttribute("radar5") != null)
					     { 
						  %>
						  rad6  = ${radar5};
						  <% 
					     }
						  %>
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
      
      
   
      
      var ctx = document.getElementById("canvasRadar");
      var data = {
        labels: ["Work", "Leisure", "Home", "Money", "Religion", "Death"],
       
        datasets: rad1
    };
      var canvasRadar = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: radarOptions
      });
      
    
      var ctx = document.getElementById("canvasRadar1");
      var data = {    		 
    	labels: ["Past focus", "Present focus", "Future focus"],
        datasets:rad2
       };


      var canvasRadar1 = new Chart(ctx, {
        type: 'radar',
        data: data,
        
        options: radarOptions
      });
      
      
      var ctx = document.getElementById("canvasRadar2");
      var data = {
        labels: ["Affiliation", "Achievement", "Power", "Reward focus", "Risk/prevention focus"],
        datasets: rad3
      };

      var canvasRadar2 = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: radarOptions
      });
      
      
      var ctx = document.getElementById("canvasRadar3");
      var data = {
        labels: ["Insight", "Cause", "Discrepancies", "Tentativeness", "Certainty", "Differentiation"],
        datasets: rad4
      };

      var canvasRadar3 = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: radarOptions
      });
      
      var ctx = document.getElementById("canvasRadar4");
      var data = {
        labels: ["Analytical Thinking", "Clout", "Authentic", "Emotional Tone"],
        datasets: rad5
      };


      var canvasRadar4 = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: radarOptions
      });
      
      
      var ctx = document.getElementById("canvasRadar5");
      var data = {
        labels: ["Positive emotion", "Negative emotion", "Anxiety", "Anger", "Sadness"],
        datasets: rad6
      };

      var canvasRadar5 = new Chart(ctx, {
        type: 'radar',
        data: data,
        options: radarOptions
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
					/* console
							.log("show event fired"); */
				});
$('#reportrange')
		.on(
				'hide.daterangepicker',
				function() {
					/* console
							.log("hide event fired"); */
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
					/* console
							.log("cancel event fired"); */
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
    /* $(function(){
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
		  }) */
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
   		
   		
   	    
   </script>