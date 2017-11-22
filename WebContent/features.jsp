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
					<a href="<%=request.getContextPath()%>/features.jsp"><i class="icon-home position-left"></i></a>
					<span class="text-semibold">Home</span> 
					<small class="display-block"><span>Welcome, </span><%=username %>
				</h4>
			</div>

			<!-- <div class="heading-elements">
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
		</div> -->
	</div>
	<!-- /page header -->
	
	<!-- Theme JS files -->
	<script type="text/javascript" src="assets/js/core/app.js"></script>

	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
	<!-- /theme JS files -->


	
	</div>
	<!-- /page header -->


	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">

			<!-- Main content -->
			<div class="content-wrapper">

				<!-- /search field -->


				<!-- Info blocks -->
				<div class="row">
					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-success text-success"><i class="icon-puzzle3"></i></div>
								<h5 class="text-semibold">Sentiments Analysis</h5>
								<p class="mb-15">Analyze the sentiment in a text</p>
								<a href="#" class="btn bg-success-400">Learn more</a>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-warning text-warning"><i class="icon-split"></i></div>
								<h5 class="text-semibold">Influence</h5>
								<p class="mb-15">Analyse the influence of text</p>
								<a href="#" class="btn bg-warning-400">Learn more</a>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-blue text-blue"><i class="icon-search4"></i></div>
								<h5 class="text-semibold">Keyword trend</h5>
								<p class="mb-15">Know the trend of a keyword</p>
								<a href="#" class="btn bg-blue">Learn more</a>
							</div>
						</div>
					</div>
				</div>
				<!-- /info blocks -->
				
				<!-- Info blocks -->
				<div class="row">
					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-success text-success"><i class="icon-share3"></i></div>
								<h5 class="text-semibold">Blog Network</h5>
								<p class="mb-15">Analyze network trend</p>
								<a href="#" class="btn bg-success-400">Learn more</a>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-warning text-warning"><i class="icon-comment"></i></div>
								<h5 class="text-semibold">Posting Frequency</h5>
								<p class="mb-15">Analyse the posting frequency</p>
								<a href="#" class="btn bg-warning-400">Learn more</a>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-blue text-blue"><i class="icon-database-export"></i></div>
								<h5 class="text-semibold">Data presentation</h5>
								<p class="mb-15">Export your work</p>
								<a href="#" class="btn bg-blue">Learn more</a>
							</div>
						</div>
					</div>
				</div>
				<!-- /info blocks -->

				<!-- Directory -->
				<h4 class="text-center content-group">
					Browse articles by category
					<small class="display-block">Articles and publications related to Blogtrackers</small>
				</h4>

				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-flat">
							<div class="panel-heading">
								<h6 class="panel-title">Browse articles</h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
				                		<li><a data-action="close"></a></li>
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
								<div class="row">
								
									<div class="col-md-4">
										<div class="content-group">
											<h6 class="text-semibold heading-divided"><i class="icon-folder6 position-left"></i> Documentation <small class="position-right">(56)</small></h6>
											<div class="list-group no-border">
												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> Jeepers therefore one
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> Near and ladybug forewent <span class="label label-success">Review</span>
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> Well much strove when stuck
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> Lorikeet much fantastic less
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-arrow-right22"></i> Show all articles (56)
												</a>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="content-group">
											<h6 class="text-semibold heading-divided"><i class="icon-folder6 position-left"></i> Cited publication on Blogtrackers <small class="position-right">(93)</small></h6>
											<div class="list-group no-border">
												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> And hello exotic staunch <span class="label label-primary">Popular</span>
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> That and well ecstatically
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> Sheared coasted so concurrent
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> Into darn intrepid belated
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-arrow-right22"></i> Show all articles (93)
												</a>
											</div>
										</div>
									</div>


									<div class="col-md-4">
										<div class="content-group">
											<h6 class="text-semibold heading-divided"><i class="icon-folder6 position-left"></i> Publication by Blogtrackers team <small class="position-right">(29)</small></h6>
											<div class="list-group no-border">
												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> Lackadaisical dear crude <span class="label label-danger">Closed</span>
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> Effortless one powerlessly
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> Some less hey and less <span class="label bg-indigo-300">Article</span>
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-file-text2"></i> Jeepers pill nonsensically
												</a>

												<a href="#" class="list-group-item">
													<i class="icon-arrow-right22"></i> Show all articles (29)
												</a>
											</div>
										</div>
									</div>
								</div>

								
							</div>
						</div>
					</div>
				</div>
				<!-- /directory -->


				<!-- Latest added -->
				


				

		
			<!-- Submit a ticket -->
				<div class="panel panel-body stack-media-on-mobile">
					<div class="media-left">
						<a href="#" class="btn btn-link btn-icon text-teal">
							<i class="icon-question7 icon-2x no-edge-top"></i>
						</a>
					</div>

					<div class="media-body media-middle">
						<h6 class="media-heading text-semibold">Can't find what you're looking for?</h6>
						Kindly submit a ticket for a feature you want to see and we will see how we can help.
					</div>

					<div class="media-right media-middle">
						<a href="#" class="btn bg-warning-400 btn-lg"><i class="icon-mail5 position-left"></i> Submit a ticket</a>
					</div>
				</div>
				<!-- /submit a ticket -->

			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->

<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
</body>
</html>
