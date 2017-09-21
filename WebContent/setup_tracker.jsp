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
				<div class="heading-btn-group">
						<div id="google_translate_element"></div><script type="text/javascript">
function googleTranslateElementInit() {
  new google.translate.TranslateElement({pageLanguage: 'ar', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
}
</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>	</div>
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
	            <div class="panel panel-white">
					<div class="panel-heading">
						<h6 class="panel-title">Setup tracker</h6>
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
							<div class="row">
								<div class="col-md-6">
									<div class="col-md-6">
									<div class="form-group">
										<label>Tracker name</label>
	                                   <input type="text" name="name" id="tracker-name" class="form-control" placeholder="E.g. My Nato Tracker">
                                    </div>
								</div>
								</div>


							<div class="row">
								
								<div class="col-md-6">
									<div class="form-group">
										<label>Additional information:</label>
	                                    <textarea name="additional-info" id="additional-info" rows="5" cols="5" placeholder="If you want to add a short description for your tracker, do it here." class="form-control"></textarea>
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

	</div>
	<!-- /page container -->
	<script>
	function set_tracker(source){
		var keyword = $("#keyword").val();
		$("#result-set").html(keyword);
		//console.log(keyword);
		if(keyword !=""){
			$.ajax({
		        url: app_url+'webtemplates/bloglist.jsp',
				method:'POST',
				data:{keyword:keyword},
		        success: function(response)
		        {		
		        	$("#result-set").html(response);
		        }
		    });	
		}
	}
	
	
	
	</script>

	<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->

</body>
</html>
