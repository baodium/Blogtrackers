   <script type="text/javascript" src="assets/js/intro.js"></script>
   
<script>
 $('#trackerform').attr("action","Analytics");
 function trackerchanged() {
		$(".loader").removeClass("hidden");
		document.getElementById("trackerform").submit();
		}
 </script>