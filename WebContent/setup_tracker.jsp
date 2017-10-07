<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
<%@page import="java.util.*"%>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
    ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
    String selected = request.getParameter("all-selected-blogs");
	
%>
 <jsp:include page="include_top.jsp"></jsp:include>
 
	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<h4><i class="icon-arrow-left52 position-left"></i> <span class="text-semibold">Setup Tracker</span> </h4>

				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="index.html">Home</a></li>
					<li class="active">Setup tracker</li>
				</ul>
			</div>

			<div class="heading-elements">
				<button id="google_translate_element" class="btn btn-default"><script type="text/javascript">
				function googleTranslateElementInit() {
				  new google.translate.TranslateElement({pageLanguage: 'ar', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
				}
			</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
				
				</button>
			</div>
		</div>
	</div>
	<!-- /page header -->


	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">

			<!-- Main content -->
			<div class="content-wrapper">

				<!-- Basic setup -->
	            <div class="panel panel-primary">
					<div class="panel-heading">
						<h6 class="panel-title">Setup tracker &nbsp;<span id="error-box" style="color:red"></span></h6>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="reload"></a></li>
		                		<li><a data-action="close"></a></li>
		                	</ul>
	                	</div>
					</div>

                	<form class="steps-basic" action="#" id="tracker-setter">
						<h6>Blog Keyword</h6>
						<fieldset>
							
						<h4 class="text-center content-group-lg">
							Welcome to our knowledge base
							<small class="display-block">Type the keyword of the blog that you wish to track and click next to proceed </small>
						</h4>
							<div class="input-group content-group">
								<div class="has-feedback has-feedback-left">
									<input type="text" class="form-control input-xlg" id="keyword" required placeholder="Blog keyword">
									<div class="form-control-feedback">
										<i class="icon-search4 text-muted text-size-base"></i>
									</div>
								</div>

								<div class="input-group-btn">
									
								</div>
							</div>
						</fieldset>

						<h6>Search result</h6>
						<fieldset >
						<div id="result-set">
							The result should be displayed in a table and each cell should have a means of selection like a checkbox or something fancier
							
						</div>
						
						</fieldset>

						

						<h6>Additional info</h6>
						<fieldset>
						
						<div class="search-results-list">
						
						<div class="row" id="searched-trackers">
						
																
						</div>
	                   	</div>
						
						
							<div class="row">
								<div class="col-md-6">
									<div class="col-md-6">
									<div class="form-group">
										<label>Tracker name</label>
	                                   <input type="text" name="name" id="tracker-name" required class="form-control" placeholder="E.g. My Nato Tracker">

                                    </div>
								</div>
								</div>


							<div class="row">
								
								<div class="col-md-6">
									<div class="form-group">
										<label>Additional information:</label>
	                                    <textarea name="additional-info" id="additional-info" required rows="5" cols="5" placeholder="If you want to add a short description for your tracker, do it here." class="form-control"></textarea>
                                    </div>
								</div>
							</div>
						</fieldset>
						</form>
	            </div>
	            <!-- /basic setup -->


	            
			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->
	<textarea name="all-selected-blogs" id="all-selected-blogs" rows="5" cols="5" style="display:none"><%=selected%></textarea>

	</div>
	<!-- /page container -->
	<script>
	<% if(!selected.equals("")){%>
	populate_selected_trackers();
	<%}%>
	function set_tracker(source){
		var keyword = $("#keyword").val();
		var searched = $("#search-blog").val();
		var tracker = $("#tracker-name").val();
		var selected  = $("#selected_result").val();
		console.log(searched);

		console.log(tracker);
		$("#result-set").html("<center><img src='assets/images/preloader.gif' /></center>");
		//console.log(keyword);
		if(keyword !="" && searched==null){
			$.ajax({
		        url: app_url+'webtemplates/bloglist2.jsp',
				method:'POST',
				data:{keyword:keyword},
		        success: function(response)
		        {		
		        	$("#result-set").html(response);
		        }
		    });	
		}
		
		if(searched=="yes" && tracker=="" && selected!="yes" ){
			populate_selected_trackers();
		}
		
		if(selected=="yes"){
			if(tracker==""){
				$("#tracker-name").focus();
				return false;
			}
			
			var more_info = $("#additional-info").val();
			if(more_info==""){
				$("#additional-info").focus();
				return false;
			}

			var bloggs = $("#all-selected-blogs").val();
			bloggs= bloggs.trim(",");
			var tracker_name = $("#tracker-name").val();
			var tracker_desc = $("#additional-info").val();
			$('#next-click').html('submitting...');
			$('#next-click').attr('disabled',true);

			$.ajax({
		        url: app_url+'setup_tracker',
				method:'POST',
				data:{title:tracker_name,descr:tracker_desc,sites:bloggs,save:"yes",keyword:keyword},
		        success: function(response)
		        {		
		        	console.log(response);
		        	if(response==="success"){
		        		 window.location.href = app_url+"dashboard.jsp";
		        	}else{
		        		$("#error-box").html("Error adding tracker");
		        	}
		        }
		    });	
			console.log("submitted");
		}
	}
	
	function check_all(){
		//console.log(keyword);
		var is_checked = $("#check-all").is(':checked');
		if(is_checked){
			$(".blog").prop('checked', true);
		}else{
			$(".blog").prop('checked', false);
		}
	}
	
	function select_blog(){
		var blogs = $(".blog-list");
		var selected='';
		for(var l=0; l<blogs.length; l++){
				var is_checked = $(blogs[l]).is(':checked');
				if(is_checked){
					var valu = $(blogs[l]).val();
					selected+= valu+",";
				}
		}
		$("#all-selected-blogs").val(selected);
	}
	
	function populate_selected_trackers(){
		var selected = $("#all-selected-blogs").val();
		selected = selected.substring(0,(selected.length-1));
		$("#searched-trackers").html("<center><img src='assets/images/preloader.gif' /></center>");
		console.log(selected);
		$.ajax({
	        url: app_url+'webtemplates/searched_trackers.jsp',
			method:'POST',
			data:{ids:selected},
	        success: function(response)
	        {	
	        	//console.log(response);
	        	$("#searched-trackers").html(response);
	        }
	    });	
	}
	
	
	
	function loadMoreBlogs(){
		
		if (!isRunning) {
	      isRunning = true;	
		//var url=back_url;
		var url = app_url+'webtemplates/trackerloader.jsp'
		var $form = $("#page_form"),
			page_no = $form.find( "input[name='page_id']" ).val();
		var	hasmore= document.forms["page_form"].hasmore.value;
		var	term= $("#search-keyword").val();
		
		if(hasmore=="0" || hasmore==""){
			$("#loading-img").addClass("hidden");
			return false;
		}
			
		page_no=parseInt(page_no);
		page_no++;

		$form.find("input[name='page_id']").val(page_no);
		z++;
				requests[z] = $.ajax({ type: "POST",
					url:url,
					data:{page:page_no,term:term,search:"yes"},
					//async: true,
					success : function(data){	
					isRunning = false;
					//$.get(url+"/"+page_no,function(data){
					var pos=$(window).height()-200;
					if(data.trim()=="empty"){
						document.forms["page_form"].hasmore.value="0";
						$("#loading-img").html("");
						return false;
					}else{
						try{
							$(".loader-box").addClass("hidden");
						}catch(err){}
						console.log(data);
						$("#tracking-blog").append(data);				
					}
				}
		});
		return false;
		}
	}

	</script>

	<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->

</body>
</html>
