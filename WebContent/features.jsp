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
        //ArrayList userinfo = new DBConnector().query("SELECT *  FROM usercredentials WHERE UserName='"+username+"'");          
        //userinfo = (ArrayList)userinfo.get(0);
        //}catch(Exception e){
          //  response.sendRedirect("index.jsp");
        //}
        ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
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
					<small class="display-block"><span>Welcome, </span><%=username %>. <a href="trackerlist.jsp">Proceed to Tracker List</a>
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
								<div class="icon-object border-success text-success"><i class="icon-share3"></i></div>
								<h5 class="text-semibold">Dashboard</h5>
								<p class="mb-15">View Statistics such as Language Distribution</p>
								<a href="#" class="btn bg-success-400" data-toggle="modal" data-target="#dashboard">Learn more</a>
							</div>
						</div>
					</div>
					
					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-warning text-warning"><i class="icon-comment"></i></div>
								<h5 class="text-semibold">Posting Frequency</h5>
								<p class="mb-15">Analyze the posting frequency</p>
								<a href="#" class="btn bg-warning-400" data-toggle="modal" data-target="#postingfrequency">Learn more</a>
							</div>
						</div>
					</div>
					
					

					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-blue text-blue"><i class="icon-search4"></i></div>
								<h5 class="text-semibold">Keyword Trend</h5>
								<p class="mb-15">Know the trend of a keyword</p>
								<a href="#" class="btn bg-blue" data-toggle="modal" data-target="#keywordtrend">Learn more</a>
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
								<div class="icon-object border-success text-success"><i class="icon-puzzle3"></i></div>
								<h5 class="text-semibold">Sentiments Analysis</h5>
								<p class="mb-15">Analyze the sentiment in a text</p>
								<a href="#" class="btn bg-success-400" data-toggle="modal" data-target="#sentiments">Learn more</a>
							</div>
						</div>
					</div>
					

					
					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-warning text-warning"><i class="icon-split"></i></div>
								<h5 class="text-semibold">Influence</h5>
								<p class="mb-15">Analyze the influence of text</p>
								<a href="#" class="btn bg-warning-400" data-toggle="modal" data-target="#influence">Learn more</a>
							</div>
						</div>
					</div>
					
					

					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-blue text-blue"><i class="icon-database-export"></i></div>
								<h5 class="text-semibold">Data Presentation</h5>
								<p class="mb-15">Export your work</p>
								<a href="#" class="btn bg-blue" data-toggle="modal" data-target="#datapresentation">Learn more</a>
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
								<div class="icon-object border-success text-success"><i class="icon-info22"></i></div>
								<h5 class="text-semibold">Additional Blog Information</h5>
								<p class="mb-15">Get Additional Blog Information</p>
								<a href="#" class="btn bg-success-400" data-toggle="modal" data-target="#additionalblog">Learn more</a>
							</div>
						</div>
					</div>

					<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-warning text-warning"><i class="icon-user"></i></div>
								<h5 class="text-semibold">Additional Blogger Information</h5>
								<p class="mb-15">Get Additional Blogger Information</p>
								<a href="#" class="btn bg-warning" data-toggle="modal" data-target="#additionalblogger">Learn more</a>
							</div>
						</div>
					</div>
					
						<div class="col-md-4">
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-blue text-blue"><i class="icon-share3"></i></div>
								<h5 class="text-semibold">Blog Network</h5>
								<p class="mb-15">Analyze network trend</p>
								<a href="#" class="btn bg-blue-400" data-toggle="modal" data-target="#blognetwork">Learn more</a>
							</div>
						</div>
					</div>
					
				</div>
				<!-- /info blocks -->

				<!-- Directory -->
				<!-- <h4 class="text-center content-group">
					Browse articles by category
					<small class="display-block">Articles and publications related to Blogtrackers</small>
				</h4> -->

				<!-- <div class="row">
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
				</div> -->
				<!-- /directory -->


				<!-- Latest added -->
				


				

		
			<!-- Submit a ticket -->
			<!-- 	<div class="panel panel-body stack-media-on-mobile">
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
				</div> -->
				<!-- /submit a ticket -->


<div id="sentiments" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-primary">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h6 class="modal-title">Sentiment Analysis</h6>
							</div>

							<div class="modal-body">
								

								<h6 class="text-semibold">About Sentiment Analysis</h6>
								<p>It displays the trend of positive and negative sentiments of
blogs for any selected time-period. This helps in understanding the effect an
event has on the blogosphere. Additionally, data analyst can drill down by clicking on
any point of interest and view radar charts displaying tonality attributes such
as personal concerns, time orientation, core drives, cognitive process.</p>
									</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
								
							</div>
						</div>
					</div>
				</div>
				
				<div id="influence" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-primary">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h6 class="modal-title">Influence</h6>
							</div>

							<div class="modal-body">
								

								<h6 class="text-semibold">About Influence</h6>
								<p>This feature helps identify the influence a blogger or blog post has on
the blogosphere. Blogtrackers finds the posts that are authoritative by assigning a score calculated using the iFinder model.
This feature lists top 5 influential bloggers and displays a trend line to show the variation in bloggers' influence.</p>
									</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
								
							</div>
						</div>
					</div>
				</div>
				
				
				<div id="keywordtrend" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-primary">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h6 class="modal-title">Keyword Trend</h6>
							</div>

							<div class="modal-body">
								

								<h6 class="text-semibold">About Keyword Trend</h6>
								<p>It provides an overall trend of keywords of interest. It helps track
changes in topics of interest in the blogging community. An analyst can correlate
keyword trends with events to examine discussion topics and themes relating to that
event. The analyst can select any data point on the trend line to view all the blogs. </p>
									</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
								
							</div>
						</div>
					</div>
				</div>
		
		<div id="postingfrequency" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-primary">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h6 class="modal-title">Posting Frequency</h6>
							</div>

							<div class="modal-body">
								

								<h6 class="text-semibold">About Posting Frequency</h6>
								<p>It can be utilized to identify any unusual patterns in blog postings.
This aids in detecting real-time events that interested the blogging community. This
feature also displays a list of active bloggers with number of posts. User can click on
any data point on the graph to get a detailed list of the named-entities that were
mentioned in blogs during that time-period. </p>
									</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
								
							</div>
						</div>
					</div>
				</div>
		
				<div id="dashboard" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-primary">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h6 class="modal-title">Dashboard</h6>
							</div>

							<div class="modal-body">
								

								<h6 class="text-semibold">About Dashboard</h6>
								<p>The dashboard provides an overview of the selected tracker. It displays the number of blogs, bloggers, blog posts, total positive and negative sentiments. It also shows blog sites' hosting location and language distribution.</p>
									</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
								
							</div>
						</div>
					</div>
				</div>
								<div id="additionalblog" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-primary">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h6 class="modal-title">Additional Blog Information</h6>
							</div>

							<div class="modal-body">
								

								<h6 class="text-semibold">About Additional Blog Information</h6>
								<p>This feature provides more in-depth details about a blog. It displays the average trend of a blog that helps in determining if the blog is a professional blog or a hobby blog. Also provided are monthly posting trends and
sentiments for the past three years to determine the variation in activity and emotions.
A list of URLs and domains mentioned in the blog is provided to know the sources of
information.</p>
									</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
								
							</div>
						</div>
					</div>
				</div>
				
												<div id="additionalblogger" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-primary">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h6 class="modal-title">Additional Blogger Information</h6>
							</div>

							<div class="modal-body">
								

								<h6 class="text-semibold">About Additional Blogger Information</h6>
								<p>This feature provides more in-depth details about a blogger. It displays the
average trend of a blogger that helps in determining if the blogger is a professional. Also provided are monthly posting trends and
sentiments for the past three years to determine the variation in activity and emotions.
A list of URLs and domains mentioned in the blog is provided to know the sources of
information.</p>
									</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
								
							</div>
						</div>
					</div>
				</div>
				
														<div id="datapresentation" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-primary">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h6 class="modal-title">Data Presentation</h6>
							</div>

							<div class="modal-body">
								

								<h6 class="text-semibold">About Data Presentation</h6>
								<p>You can use the feature to export all your tracker information and download them in json format
								This will give you the flexibility to perform further computation using our dataset.</p>
									</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
								
							</div>
						</div>
					</div>
				</div>

<div id="blognetwork" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header bg-primary">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h6 class="modal-title">Blog Network</h6>
							</div>

							<div class="modal-body">
								

								<h6 class="text-semibold">About Blog Network</h6>
								<p>A blog network is a group of blogs that are owned by the same entity. A blog network can either be a group of loosely connected blogs, or a group of blogs that are owned by the same company.</p>
									</div>

							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
								
							</div>
						</div>
					</div>
				</div>

				
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
