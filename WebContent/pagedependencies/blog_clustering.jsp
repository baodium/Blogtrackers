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
	 <script src="${pageContext.request.contextPath}/js/plotly-latest.min.js"></script>
	<script>
	var trace1 = {
			  x: [1, 2, 3, 4, 5],
			  y: [1, 6, 3, 6, 1],
			  mode: 'markers',
			  type: 'scatter',
			  name: 'Cluster 1',
			  text: ['A-1', 'A-2', 'A-3', 'A-4', 'A-5'],
			  marker: { size: 12 }
			};

			var trace2 = {
			  x: [1.5, 2.5, 3.5, 4.5, 5.5],
			  y: [4, 1, 7, 1, 4],
			  mode: 'markers',
			  type: 'scatter',
			  name: 'Cluster 2',
			  text: ['B-a', 'B-b', 'B-c', 'B-d', 'B-e'],
			  marker: { size: 12 }
			};
			
			var trace3 = {
					  x: [1, 2, 3, 3, 2],
					  y: [3, 1.5, 7, 2, 5],
					  mode: 'markers',
					  type: 'scatter',
					  name: 'Cluster 3',
					  text: ['C-a', 'C-b', 'C-c', 'C-d', 'C-e'],
					  marker: { size: 12 }
					};


			var data = [ trace1, trace2, trace3 ];

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
				