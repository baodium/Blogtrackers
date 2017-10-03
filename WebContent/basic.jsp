<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="authentication.DBConnector"%>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
        
        //try{
        ArrayList userinfo = new DBConnector().query("SELECT *  FROM usercredentials WHERE UserName='"+username+"'");          
        userinfo = (ArrayList)userinfo.get(0);
        //}catch(Exception e){
          //  response.sendRedirect("index.jsp");
        //}
%>
  <jsp:include page="include_top.jsp"></jsp:include>
	<!-- Page header -->
        <style>
            input[type="file"] {
    display: block;
}

.btn-file > input {
    position: absolute;
    top: 0;
    right: 0;
    margin: 0;
    opacity: 0;
    filter: alpha(opacity=0);
    font-size: 23px;
    direction: ltr;
    border:1px solid #ccc !important;
    cursor: pointer;
}
 .fileinput-exists .fileinput-new, .fileinput-new .fileinput-exists {
    display: none;
}

.btn{
    margin:5px;
}
.fileinput .btn {
    vertical-align: middle;
}

.btn-orange {
    color: #ffffff;
    background-color: #ff9600;
    border-color: #ff9600;
}

.btn-white {
    color: #303641;
    background-color: #ffffff;
    border-color: #ffffff;
    border-color: #ebebeb;
}

.fileinput .btn {
    vertical-align: middle;
}

.btn-white {
    color: #303641;
    background-color: #ffffff;
    border-color: #ccc;
    border-color: #ebebeb;
} 
        </style>
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>

					<span class="text-semibold">Basic analytics</span>
					<small class="display-block"><span> Hi, </span><%=username %>
				</h4>
			</div>

				<div class="heading-elements">
				<div class="heading-btn-group">
					<button type="button" onclick="location.href='setup_tracker.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-reading"></i></b> Proceed to setup Tracker</button>
					<button type="button" onclick="location.href='dashboard.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-statistics position-left"></i></b> Proceed to Dashboard</button>
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

				<!-- Main charts -->
				<div class="row">
				<div class="col-md-12">
					
							
							<div class="col-lg-3 col-md-6">
						<div class="thumbnail">
							<div class="thumb thumb-slide">
								<img src="img/postingfrequency.jpg" alt="">
								<div class="caption">
									<span style="font-size: 18px;">
									Check the frequency of a particular blog post and analyze some basic Information
								   </span>
								</div>
							</div>
						
					    	<div class="caption text-center">
					    		<h6 class="text-semibold no-margin">Posting Frequency 
<!--					    		<small class="display-block">Network engineer</small>-->
					    		
					    		</h6>
				    			<ul class="icons-list mt-15">
			                    	<li><a href="#" data-popup="tooltip" title="" data-container="body" data-original-title="Posting Frequency">
			                    	<button type="button" class="btn btn-primary btn-icon btn-float btn-float-lg btn-rounded legitRipple"><i class="icon-pie-chart8"></i></button>
			                    	</a></li>
			                    	
		                    	</ul>
					    	</div>
				    	</div>
					</div>
					
					
					
					
					<div class="col-lg-3 col-md-6">
						<div class="thumbnail">
							<div class="thumb thumb-slide">
								<img src="img/additional.jpg" alt="">
								<div class="caption">
									<span style="font-size: 18px;">
									Check the frequency of a particular blog post and analyze some basic Information
								   </span>
								</div>
							</div>
						
					    	<div class="caption text-center">
					    		<h6 class="text-semibold no-margin">Additional Information 
<!--					    		<small class="display-block">Network engineer</small>-->
					    		
					    		</h6>
				    			<ul class="icons-list mt-15">
			                    	<li><a href="#" data-popup="tooltip" title="" data-container="body" data-original-title="Posting Frequency">
			                    	<button type="button" class="btn btn-primary btn-icon btn-float btn-float-lg btn-rounded legitRipple"><i class="icon-info3"></i></button>
			                    	</a></li>
			                    	
		                    	</ul>
					    	</div>
				    	</div>
					</div>
					
					
					<div class="col-lg-3 col-md-6">
						<div class="thumbnail">
							<div class="thumb thumb-slide">
								<img src="img/postingfrequency.jpg" alt="">
								<div class="caption">
									<span style="font-size: 18px;">
									Check the frequency of a particular blog post and analyze some basic Information
								   </span>
								</div>
							</div>
						
					    	<div class="caption text-center">
					    		<h6 class="text-semibold no-margin">Posting Frequency 
<!--					    		<small class="display-block">Network engineer</small>-->
					    		
					    		</h6>
				    			<ul class="icons-list mt-15">
			                    	<li><a href="#" data-popup="tooltip" title="" data-container="body" data-original-title="Posting Frequency">
			                    	<button type="button" class="btn btn-primary btn-icon btn-float btn-float-lg btn-rounded legitRipple"><i class="icon-pie-chart8"></i></button>
			                    	</a></li>
			                    	
		                    	</ul>
					    	</div>
				    	</div>
					</div>
					
					
					<div class="col-lg-3 col-md-6">
						<div class="thumbnail">
							<div class="thumb thumb-slide">
								<img src="img/postingfrequency.jpg" alt="">
								<div class="caption">
									<span class="text-size-large" style="font-size: 18px;">
									Check the frequency of a particular blog post and analyze some basic Information
								   </span>
								</div>
							</div>
						
					    	<div class="caption text-center">
					    		<h6 class="text-semibold no-margin">Posting Frequency 
<!--					    		<small class="display-block">Network engineer</small>-->
					    		
					    		</h6>
				    			<ul class="icons-list mt-15">
			                    	<li><a href="#" data-popup="tooltip" title="" data-container="body" data-original-title="Posting Frequency">
			                    	<button type="button" class="btn btn-primary btn-icon btn-float btn-float-lg btn-rounded legitRipple"><i class="icon-pie-chart8"></i></button>
			                    	</a></li>
			                    	
		                    	</ul>
					    	</div>
				    	</div>
					</div>


				
					
					</div>
			
				      
					
				</div>
				<!-- /main charts -->


			

			
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	
	</div>
	<!-- /page container -->


	<!-- Footer -->
	<div class="footer text-muted">
		&copy; 2017. <a href="#">Blogtracker</a> All Right Reserved
	</div>
	<!-- /footer -->

</body>
</html>
