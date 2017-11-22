<!-- Theme JS files -->
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/switch.min.js"></script>

	<script type="text/javascript" src="assets/js/core/app.js"></script>
<!--	<script type="text/javascript" src="assets/js/pages/form_checkboxes_radios.js"></script>-->

	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
	<!-- /theme JS files --><!-- /theme JS files -->
<!--<script type="text/javascript" src="assets/js/pages/form_select2.js"></script>-->

	<!--<script src="code.js"></script>-->
	<script>
	$(document).ready(function(e)
	{
	$('#features').click(function(e)
    {
	$('.features-tab').slideToggle(500);	
	});	
	
	$('.checker input[type=checkbox]').each(function(index,element){
	$('.checker input[type=checkbox]:eq('+index+')').click(function(){
	$('.checkbox .checker span:eq('+index+')').toggleClass('checked'); 
	//$('.checker input[type=checkbox]:eq('+index+')').trigger('click');		
   });
	});	
   
	});
	</script>