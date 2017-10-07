<script type="text/javascript" src="assets/js/plugins/visualization/d3/d3.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/visualization/d3/d3_tooltip.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/moment/moment.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/pickers/daterangepicker.js"></script>


    <script type="text/javascript" src="assets/js/plugins/maps/jvectormap/jvectormap.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/maps/jvectormap/map_files/world.js"></script>
	<script type="text/javascript" src="assets/js/plugins/maps/jvectormap/map_files/countries/usa.js"></script>
	<script type="text/javascript" src="assets/js/plugins/maps/jvectormap/map_files/countries/germany.js"></script>
	<script type="text/javascript" src="assets/demo_data/maps/vector/gdp_demo_data.js"></script>

	<script type="text/javascript" src="assets/js/core/app.js"></script>
		<script type="text/javascript" src="assets/js/maps/vector/vector_maps_demo.js"></script>
	<script type="text/javascript" src="assets/js/pages/dashboard.js"></script>
		

	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
	
	<script>
	 $('#trackerform').attr("action","Dashboard");

	    
	    function trackerchanged() {
			$(".loader").removeClass("hidden");
			document.getElementById("trackerform").submit();
			}
			function datechanged() {
				$(".loader").removeClass("hidden");
			document.getElementById("dateform").submit();
			}
	    
	    
	</script>
	