<!-- handles the dynamic updatee of content-->
<script>
/*
	$(document).ready(function(e){
	$('.eachtracker').each(function(index,element){
	$('.eachtracker:eq('+index+')').click(function(f){
	$('#trackername').html('<i class="icon-target text-size-mini position-left"></i> Tracker Default');	
	$('#createddate').html('<i class="icon-calendar text-size-mini position-left"></i> July 12, 208');
	$('#noofblog').html('<i class="text-size-mini position-left icon-angle"></i>560');
	$('#description').html('<i class="text-size-mini position-left icon-info22"></i>Tracking about wale');
	
	});
	});	
	});
*/	
	function loadTrackerr(tracker_id){
		
		var name = $("#tracker_name_"+tracker_id).val();
		var date_created =  $("#date_created_"+tracker_id).val();
		var noofblog = $("#tracker_blogs_"+tracker_id).val();
		//noofblog = noofblog.re(",");
		noofblog = noofblog.split(",");
		var det = $("#tracker_desc_"+tracker_id).val();
			
		$("#trackername").html(name);		
		$("#createddate").html(date_created);
		$("#noofblog").html((noofblog[0]=="blogsite_id in ()")?0:noofblog.length);
		$("#description").html(det);
		
	}
$('#trackerform').attr("action","Trackerlist");
	</script>
	
	<script type="text/javascript">

		function trackerchanged() {
			$(".loader").removeClass("hidden");
			document.getElementById("trackerform").submit();
		
		}
		function datechanged() {
			$(".loader").removeClass("hidden");
		document.getElementById("dateform").submit();
		}
		function spanChanged() {
			document.getElementById("pf_spanForm").submit();
		}
		
		function delete_this(id){
			//var promt = confirm("Are you sure you want to delete this tracker?");
			if (confirm('Are you sure you want to delete this tracker?')) {
				$.ajax({
			        url: app_url+'/setup_tracker',
					method:'POST',
					data:{tracker_id:id,action:"delete_tracker"},
			        success: function(response)
			        {	
			        	window.location.reload();
			        }
			    });	
			} else {
				return false;
			    //alert('Why did you press cancel? You should have confirmed');
			}
			
		}
		
		function edit_this(id){
			$("#form_"+id).submit();
		}
	</script>
	