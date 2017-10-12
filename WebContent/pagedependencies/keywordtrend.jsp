<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
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
	
<script type="text/javascript" src="assets/js/pages/datatables_basic.js"></script>

 
		
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
minDate: '01/01/2000',
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
   			$(".loader").removeClass("hidden");
   			document.getElementById("xyform").submit();
   		}
   		
   		function searchTracker() {
			$(".loader").removeClass("hidden");
		}
   		
   		function getRandomRolor() {
   		    var letters = '0123456789'.split('');
   		    var color = '#';
   		    for (var i = 0; i < 6; i++) {
   		        color += letters[Math.round(Math.random() * 10)];
   		    }
   		    return color;
   		}
   	
   		function searchTextVerify(e) {

			var value = $.trim($("#searchBar").val());
			if (value.length > 0) {
				$("#searchButton").prop('disabled', false);
			} else {
				$("#searchButton").prop('disabled', true);
			}
			if (e.keyCode === 13) {
				e.preventDefault();
				$(".loader").removeClass("hidden");
				$(".searchBar").addClass("hidden");
				// alert("Enter was pressed was presses");
			}
		}
   		function searchTracker() {
			$(".loader").removeClass("hidden");
		}
   		
   		   		
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
        interlacedColor: "#F0F8FF",
        labelFontSize: 12, 
         interval: 1,
       intervalType: ${span},
        valueFormatString: "DD MMM YYYY"   // "DD MMM" for date and month, "MMM" for month only , "YYYY" year only (fahad)
         
      },
      axisY:{
        labelFontSize: 12
      },
       exportEnabled: true,
        data: [
        	<c:forEach items="${trend}" var="l">
        	{
        	  click: function(e){
        	  xychange( "dataSeries Event => Type: "+ e.dataSeries.type+ ", dataPoint { x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y + " }");
              $('#chartpoint input').val(" x:" + e.dataPoint.x + ", y: "+ e.dataPoint.y+","+"${l.key}").trigger('change');
             },
      
        type: "line",
        showInLegend: true,
        legendMarkerType: "circle",
        legendText: "${l.key}",
        color: getRandomRolor(),
        name:"${l.key}",
        fillOpacity: .3,
        lineThickness: 3,
        dataPoints: ${l.value}
      },
      </c:forEach>
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




			<script>			
    var nodes = null;
    var edges = null;
    var network = null;
	var id =0;
	
		
    var  nodes = [
    	<c:forEach items="${idlist}" var="l"  varStatus="status">
    	{id:  ${l.value},  value: 1,  label: '${l.key}' },
    	</c:forEach>
        ];
    var edges = [
    	<c:forEach items="${netlist}" var="l"  varStatus="status">
    	<c:set var="parts" value="${fn:split(l.key, '~')}" />
    		<c:set var="s1" value="${parts[0]}"/>
    			<c:set var="s2" value="${parts[1]}"/>
    				<c:set var="s3" value="${idlist[s1]}"/>
    					<c:set var="s4" value="${idlist[s2]}"/>
    	    				
    				<c:if test="${not empty s3 && not empty s4}">
    	  	 			{from: ${idlist[s1]}, to: ${idlist[s2]}, value: ${l.value}, title: '${l.value}'},
    	    	  	</c:if>
    	 </c:forEach>
    	 ];
    // create a network
    var container = document.getElementById('mynetwork');
    var data = {
        nodes: nodes,
        edges: edges
    };
    
    var options = {
    interaction:{hover:true},
    hover: true,
    tooltipDelay: 3,
        nodes: {
          shape: 'dot',
          scaling:{
            label: {
              min:8,
              max:20
            }
          }
        }
      };
    network = new vis.Network(container, data, options);
    network.on("click", function (params) {
        params.event = "[original event]";
        document.getElementById('eventSpan').innerHTML = '<h2>Click event:</h2>' + JSON.stringify(params, null, 4);
    });
</script>

			<script type="text/javascript">
				$(".use-address").click(
						function() {
						var $row = $(this).closest("tr"), $tds = $row
								.find("td:nth-child(2)");

						$.each($tds, function() {
						console.log($(this).text());
						$('#blogpost').text($(this).text());
						});

						});
				
				
			</script>

			
			
	 