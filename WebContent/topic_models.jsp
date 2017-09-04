<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Blog Trackers&reg; |</title>

<!-- Bootstrap -->
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link
	href="${pageContext.request.contextPath}/vendors/nprogress/nprogress.css"
	rel="stylesheet">
<!-- iCheck -->
<link
	href="${pageContext.request.contextPath}/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet">
<!-- bootstrap-progressbar -->
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css"
	rel="stylesheet">
<!-- JQVMap -->
<link
	href="${pageContext.request.contextPath}/vendors/jqvmap/dist/jqvmap.min.css"
	rel="stylesheet" />
<!-- jQuery custom content scroller -->
<link
	href="${pageContext.request.contextPath}/vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css"
	rel="stylesheet" />


<!-- Custom Theme Style -->
<link href="${pageContext.request.contextPath}/build/css/custom.min.css"
	rel="stylesheet">
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="index.html" class="site_title"><img
							src="images/cosmos.jpg"></i> <span>Blogtrackers</span></a>
					</div>

					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile">
						<div class="profile_pic">
							<img src="images/img.jpg" alt="..."
								class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>Welcome,</span>
							<h2>User Name</h2>
						</div>
					</div>
					<!-- /menu profile quick info -->

					<br />


					<!-- sidebar menu -->
					<div id="sidebar-menu"
						class="main_menu_side hidden-print main_menu">
						<div class="menu_section">
							<h3>Plan Name</h3>
							<ul class="nav side-menu">
								<li><a><i class="fa fa-home"></i> Home <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="<%=request.getContextPath()%>/Datasource">
												Setup Tracker </a></li>
										<li><a href="<%=request.getContextPath()%>/Dashboard">
												Dashboard </a></li>
									</ul></li>
								<ul class="nav side-menu">
									<li><a
										href="${pageContext.request.contextPath}/posting_frequencey.jsp"><i
											class="fa fa-line-chart"></i>Posting Frequencey<span
											class="fa fa-chevron-right"></span></a></li>
								</ul>
								<ul class="nav side-menu">
									<li><a
										href="${pageContext.request.contextPath}/keyword_trends.jsp"><i
											class="fa fa-key"></i>Keyword Trends<span
											class="fa fa-chevron-right"></span></a></li>
								</ul>
								<ul class="nav side-menu">
									<li><a
										href="${pageContext.request.contextPath}/additional_blog_info.jsp"><i
											class="fa fa-edit"></i>Additional Blog Info<span
											class="fa fa-chevron-right"></span></a></li>
								</ul>
								<ul class="nav side-menu">
									<li><a
										href="${pageContext.request.contextPath}/topic_models.jsp"><i
											class="fa fa-language"></i>Topic Models<span
											class="fa fa-chevron-right"></span></a></li>
								</ul>
								<ul class="nav side-menu">
									<li><a
										href="${pageContext.request.contextPath}/sentiments.jsp"><i
											class="fa fa-puzzle-piece"></i>Sentiments<span
											class="fa fa-chevron-right"></span></a></li>
								</ul>
								<ul class="nav side-menu">
									<li><a
										href="${pageContext.request.contextPath}/influence.jsp"><i
											class="fa fa-newspaper-o"></i>Influence<span
											class="fa fa-chevron-right"></span></a></li>
								</ul>
								<ul class="nav side-menu">
									<li><a
										href="${pageContext.request.contextPath}/cyber_forensics.jsp"><i
											class="fa fa-code-fork"></i>Cyber Forensics<span
											class="fa fa-chevron-right"></span></a></li>
								</ul>
								<ul class="nav side-menu">
									<li><a><i class="fa fa-desktop"></i> Network Analysis
											<span class="fa fa-chevron-down"></span></a>
										<ul class="nav child_menu">
											<li><a
												href="${pageContext.request.contextPath}/blog_network.jsp">Blog
													Network</a></li>
											<li><a href="${pageContext.request.contextPath}/x.jsp">Network
													Structural Measures</a></li>
											<li><a href="${pageContext.request.contextPath}/x.jsp">Blogger-blog
													Network</a></li>
											<li><a href="${pageContext.request.contextPath}/x.jsp">Blog-cited
													domains</a></li>
										</ul></li>
									<li><a><i class="fa fa-bar-chart-o"></i> Data
											Presentation <span class="fa fa-chevron-down"></span></a>
										<ul class="nav child_menu">
											<li><a href="${pageContext.request.contextPath}/x.jsp"></a></li>
											<li><a href="${pageContext.request.contextPath}/x.jsp"></a></li>
											<li><a href="${pageContext.request.contextPath}/x.jsp"></a></li>
											<li><a href="${pageContext.request.contextPath}/x.jsp"></a></li>
										</ul></li>
								</ul>
						</div>
						<div class="menu_section">
							<h3>Services</h3>
							<ul class="nav side-menu">
								<li><a><i class="fa fa-windows"></i> Upgrade Options <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="${pageContext.request.contextPath}/x.jsp">Plans</a></li>
										<li><a href="${pageContext.request.contextPath}/x.jsp">testimonials</a></li>
									</ul></li>
								<li><a><i class="fa fa-video-camera"></i> Training <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a
											href="${pageContext.request.contextPath}/video.jsp">Video
												Tutorials</a></li>
										<li><a
											href="${pageContext.request.contextPath}/page_404.jsp">Download
												PDF</a></li>
									</ul></li>
								<li><a><i class="fa fa-sitemap"></i> Customer Support <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="${pageContext.request.contextPath}/x.jsp"></a>
									</ul>
						</div>

					</div>
					<!-- /sidebar menu -->

					<!-- /menu footer buttons -->
					<div class="sidebar-footer hidden-small">
						<a data-toggle="tooltip" data-placement="top" title="Settings">
							<span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="FullScreen">
							<span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="Lock"> <span
							class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
						</a> <a data-toggle="tooltip" data-placement="top" title="Logout">
							<span class="glyphicon glyphicon-off" aria-hidden="true"></span>
						</a>
					</div>
					<!-- /menu footer buttons -->
				</div>
			</div>

			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<nav>
						<div class="nav toggle">
							<a id="menu_toggle"><i class="fa fa-bars"></i></a>
						</div>
						<div class="nav toggle"
							style="position: absolute; right: 35%; width: 300px;"></div>
						<select id="heard" class="form-control" required>
							<option value="">Name of Tracker</option>
							<option value="">Name of Tracker 2</option>
							<option value="">Name of Tracker 3</option>
							<option value="">Name of Tracker 4</option>
						</select>
				</div>

				<ul class="nav navbar-nav navbar-right">
					<li class=""><a href="javascript:;"
						class="user-profile dropdown-toggle" data-toggle="dropdown"
						aria-expanded="false"> <img src="images/img.jpg" alt="">User
							<span class=" fa fa-angle-down"></span>
					</a>
						<ul class="dropdown-menu dropdown-usermenu pull-right">
							<li><a href="javascript:;"> Profile</a></li>
							<li><a href="javascript:;"> <span
									class="badge bg-red pull-right"></span> <span>Settings</span>
							</a></li>
							<li><a href="javascript:;">Help</a></li>
							<li><a
								href="${pageContext.request.contextPath}/test_logout.jsp"><i
									class="fa fa-sign-out pull-right"></i> Log Out</a></li>
						</ul></li>
					<li role="presentation" class="dropdown"><a
						href="javascript:;" class="dropdown-toggle info-number"
						data-toggle="dropdown" aria-expanded="false"> <i
							class="fa fa-envelope-o"></i> <span class="badge bg-green">6</span>
					</a>
						<ul id="menu1" class="dropdown-menu list-unstyled msg_list"
							role="menu">
							<li><a> <span class="image"><img
										src="images/img.jpg" alt="Profile Image" /></span> <span> <span>Sender
											1</span> <span class="time">3 mins ago</span>
								</span> <span class="message"> Message.... </span>
							</a></li>
							<li><a> <span class="image"><img
										src="images/img.jpg" alt="Profile Image" /></span> <span> <span>Sender
											2</span> <span class="time">20 mins ago</span>
								</span> <span class="message"> Message.... </span>
							</a></li>
							<li><a> <span class="image"><img
										src="images/img.jpg" alt="Profile Image" /></span> <span> <span>Sender
											3</span> <span class="time">45 mins ago</span>
								</span> <span class="message"> Message.... </span>
							</a></li>
							<li><a> <span class="image"><img
										src="images/img.jpg" alt="Profile Image" /></span> <span> <span>Sender
											4</span> <span class="time">24 hours ago</span>
								</span> <span class="message"> Message.... </span>
							</a></li>
							<li>
								<div class="text-center">
									<a> <strong>See All Alerts</strong> <i
										class="fa fa-angle-right"></i>
									</a>
								</div>
							</li>
						</ul></li>
				</ul>
				</nav>
			</div>
		</div>
		<div class="right_col" role="main">
			<div class="row">
				<div class="col-md-12 col-sm-12 col-xs-12">
					<div class="dashboard_graph">


						<div class="x_panel">
							<div class="x_title">
								<h3>
									Topic Models <small> daily/weekly/monthly/yearly </small>
								</h3>

								<div class="clearfix"></div>
							</div>
							<div class="x_content"></div>
						</div>
					</div>
				</div>

				<div class="col-md-12 col-sm-12 col-xs-12">
					<div class="dashboard_graph">


						<div class="x_panel">
							<div class="x_title">
								<h3>
									Blog browser <small> </small>
								</h3>

								<div class="clearfix"></div>
							</div>
							<div class="x_content"></div>
						</div>
					</div>
				</div>
				<div class="col-md-12 col-sm-12 col-xs-12">
					<div class="dashboard_graph">


						<div class="x_panel">
							<div class="x_title">
								<h3>
									Tree Map <small> </small>
								</h3>

								<div class="clearfix"></div>
							</div>
							<div class="x_content"></div>
						</div>
					</div>
				</div>
				<!-- /top navigation -->
				<!-- footer content -->
				<div class="footer_fixed">
					<footer>
						<div class="pull-right" style="height: 6px;">
							
						</div>
						<div class="clearfix"></div>

					</footer>
				</div>
				<!-- /footer content -->
				<!-- jQuery -->
				<script
					src="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.min.js"></script>
				<!-- Bootstrap -->
				<script
					src="${pageContext.request.contextPath}/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
				<!-- FastClick -->
				<script
					src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
				<!-- NProgress -->
				<script
					src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
				<!-- Chart.js -->
				<script
					src="${pageContext.request.contextPath}/vendors/Chart.js/dist/Chart.min.js"></script>
				<!-- gauge.js -->
				<script
					src="${pageContext.request.contextPath}/vendors/gauge.js/dist/gauge.min.js"></script>
				<!-- bootstrap-progressbar -->
				<script
					src="${pageContext.request.contextPath}/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
				<!-- iCheck -->
				<script
					src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>
				<!-- Skycons -->
				<script
					src="${pageContext.request.contextPath}/vendors/skycons/skycons.js"></script>
				<!-- Flot -->
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.pie.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.time.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.stack.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.resize.js"></script>
				<!-- Flot plugins -->
				<script
					src="${pageContext.request.contextPath}/production/js/flot/jquery.flot.orderBars.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/flot/date.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/flot/jquery.flot.spline.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/flot/curvedLines.js"></script>
				<!-- JQVMap -->
				<script
					src="${pageContext.request.contextPath}/vendors/jqvmap/dist/jquery.vmap.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
				<!-- bootstrap-daterangepicker -->
				<script
					src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>




				<script
					src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>


				<!-- JQVMap -->
</body>
</html>
