<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
<%@page import="java.util.*"%>
<%@page import="wrapper.*"%>
<%@page import="authentication.DBConnector"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String selected =  (null == request.getParameter("all-selected-blogs")) ? "" : request.getParameter("all-selected-blogs");
	String pre_selected = (null == session.getAttribute("pre-selected-blogs")) ? "" : session.getAttribute("pre-selected-blogs").toString();
	String term = (null == session.getAttribute("initiated_search_term")) ? "" : session.getAttribute("initiated_search_term").toString();
	
	ArrayList bloglist = new ArrayList();
	ArrayList selected_blog = new ArrayList();
	 
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	
	
	
	if(selected!=""){
		session.setAttribute("pre-selected-blogs", selected);
	}
	
	if (username == null || username == "") {
		response.sendRedirect("login.jsp");
	}
	
	if(selected.equals("") && !pre_selected.equals("")){
		selected = pre_selected;
	}
	
	
	
	if(!selected.equals("")){
		selected = pre_selected;
		//bloglist = new Tracker().getTrackers(selected.replaceAll(",$|^x", ""));
		String [] listed = selected.split(","); 		
		if(listed.length>0){
			for(int l=0; l<listed.length; l++){
				selected_blog.add(l,listed[l]);
			}
		}
	}
	
	
	if(!term.equals("")){
		bloglist = new Tracker().searchTrackers(term);
	}
	
	
    ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
    //session.setAttribute("pre-selected-blogs", "");
	
%>
 <jsp:include page="include_top.jsp"></jsp:include>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<!-- Page header -->
	<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
				<a href="<%=request.getContextPath()%>/features.jsp"><i class="icon-arrow-left52 position-left"></i></a> 
				<span class="text-semibold">Setup Tracker</span> </h4>

				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li class="active">Setup Tracker</li>
				</ul>
				
			</div>

		<!-- 	<div class="heading-elements">
				<button id="google_translate_element" class="btn btn-default"><script type="text/javascript">
				function googleTranslateElementInit() {
				  new google.translate.TranslateElement({pageLanguage: 'ar', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
				}
			</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
				
				</button>
			</div> -->
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
		                		
		                	</ul>
	                	</div>
					</div>

                	<form class="steps-basic" action="#" id="tracker-setter">
                	<input type="hidden" name="select_ed" id="select_ed" value="<%=selected%>" />
							
                	  <% if(selected.equals("")){ %>
						<h6>Blog keyword</h6>
						<fieldset>
							
						<h4 class="text-center content-group-lg">
							Welcome to our knowledge base
							<small class="display-block">Type the keyword of the blog that you wish to track and click next to proceed </small>
						</h4>
							<div class="input-group content-group">
								<div class="has-feedback has-feedback-left">
									<input type="text" class="form-control input-xlg" id="keyword" onchange="reset_tracker();" required placeholder="Blog keyword">
									<div class="form-control-feedback">
										<i class="icon-search4 text-muted text-size-base"></i>
									</div>
								</div>

								<div class="input-group-btn">
									
								</div>
							</div>
						</fieldset>
						<% } %>
						
						<h6>Search result</h6>
						<% if(bloglist.size()>0){ %>
						<fieldset >
							<div id="result-set"></div>
						<div id="tracking-blog">
						<% for(int k=0; k<bloglist.size(); k++){
								ArrayList item = (ArrayList)bloglist.get(k);
							%>
							<div class="col-sm-3">
								<div class="panel panel-body">
									<div class="media">
										<div class="media-left">
											<img src="img/b.png" class="img-circle img-lg" alt="">
										</div>									
										<div class="media-body">
											<h6 class="media-heading"><%=item.get(1) %> <input type="checkbox" <%=(selected_blog.contains(item.get(0))?"checked":"") %> onclick="select_blog()" class="blog-list" name="blog" style="float:right" value="<%=item.get(0) %>"  />
											</h6>
											<span class="text-muted"><%=item.get(2) %> post(s)</span>
										</div>	
									</div>
								</div>
							</div>
						<% } %>
						</div>
						<%  if(bloglist.size()>0){%><br/>
							<input type="hidden" name="search-blog" id="search-blog" value="yes" />
							<input type="hidden" name="search-keyword" id="search-keyword" value="<%=term%>" />
							<div class="loadmoreimg" id="loading-img" style="text-align:center"><br/><br/><img src='assets/images/preloader.gif' /><br/></div>	
												
						<% } %>	
						<input type="hidden" name="selected_result" id="selected_result" value="yes" />	
						</fieldset>
						<% }else{ %>
						<fieldset >
						<div id="result-set">
							The result should be displayed in a table and each cell should have a means of selection like a checkbox or something fancier							
						</div>					
						</fieldset>
						<% } %>
						
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
	<textarea name="all-selected-blogs" id="all-selected-blogs" rows="5" cols="5" style="display:none" ><%=(!selected.equals("")?selected:"")%></textarea>

	</div>
	<!-- /page container -->
	
	
<%  if(bloglist.size()>0){%><br/>
	<form name="page_form" id="page_form" method="post" action="">
    <input type="hidden" id="page_id" name="page_id" value="0" />
	<input type="hidden" name="negative_page" id="negative_page" value="1" />
	<input type="hidden" id="hasmore" name="hasmore" value="1" />
	<input type="hidden" id="current_page" name="current_page" value="setup_tracker" />	
    </form>
	<!-- /page container -->
	 <script>
	$(window).scroll(function() {
		if($(window).scrollTop() + $(window).height() > $(document).height() - 200) {
			loadMoreBlogs();
		}
	});
</script>
<% } %>

	<script>
	
	<% if(!selected.equals("")){%>
	populate_selected_trackers();
	<%}%>
	function set_tracker(source){
		var keyword = $("#keyword").val();
		var searched = $("#search-blog").val();
		var tracker = $("#tracker-name").val();
		var selected  = $("#selected_result").val();
		var ref = $(source).attr('href');
		if(ref=="#previous"){
			return false;
		}
		
		//console.log(tracker);
		
		//$("#result-set").html("<center><img src='assets/images/preloader.gif' /></center>");
		//console.log(keyword);
		if(keyword !="" && (searched==null || searched!="yes")){
			$("#result-set").html("<center><img src='assets/images/preloader.gif' /></center>");
			$('#next-click').attr('disabled',true);
			$.ajax({
		        url: app_url+'webtemplates/bloglist2.jsp',
				method:'POST',
				async: true,
				data:{keyword:keyword},
		        success: function(response)
		        {	
		        	$("#search-blog").val("yes");
		        	$("#result-set").html(response);
		        }
		    });	
		}
		
		if(searched=="yes" && ref=="#next" ){
			populate_selected_trackers();
		}
		
		if(ref=="#finish"){
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
				async: true,
				data:{title:tracker_name,descr:tracker_desc,sites:bloggs,save:"yes",keyword:keyword},
		        success: function(response)
		        {		
		        	console.log(response);
		        	if(response==="success"){
		        		
		        		 window.location.href = app_url+"Analytics?tracker="+tracker_name;
		        	}else if(response==="exist"){
		        		$("#error-box").html("tracker name already exists");
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
					$('#next-click').attr('disabled',true);
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
			async: true,
			data:{ids:selected},
	        success: function(response)
	        {	
	        	//console.log(response);
	        	$("#searched-trackers").html(response);
	        }
	    });	
	}
	
	
	</script>

	<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
	<!-- Dependencies -->
  <jsp:include page="pagedependencies/setuptracker.jsp"></jsp:include>
  <!-- End of Dependencies -->
</body>
</html>
