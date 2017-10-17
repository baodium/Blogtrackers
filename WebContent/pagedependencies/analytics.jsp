<script>
 $('#trackerform').attr("action","Analytics");
 function trackerchanged() {
		$(".loader").removeClass("hidden");
		document.getElementById("trackerform").submit();
		}
 </script>