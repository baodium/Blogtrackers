<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Blog Network</title>
<style>

.links line {
  stroke: #999;
  stroke-opacity: 0.6;
}

.nodes circle {
  stroke: #fff;
  stroke-width: 1.5px;
}
	#mynetwork {
            width: 100%;
            height: 500px;
            border: 1px solid #444444;
            background-color: #000000;
        }

</style>

<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/dist/vis.js"></script>
    <link href="${pageContext.request.contextPath}/vendors/blog_network/dist/vis-network.min.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	<!-- Global stylesheets -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/vendors/blog_network/assets/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/vendors/blog_network/assets/css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/vendors/blog_network/assets/css/core.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/vendors/blog_network/assets/css/components.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/vendors/blog_network/assets/css/colors.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/vendors/blog_network/assets/css/mystyle.css" rel="stylesheet" type="text/css">
	<!-- /global stylesheets -->
	<link href="style.css" rel="stylesheet" />

	<!-- Core JS files -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/loaders/pace.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/core/libraries/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/core/libraries/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/loaders/blockui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/ui/nicescroll.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/ui/drilldown.js"></script>
	<!-- /core JS files -->

	<!--  before Theme JS files -->



<!-- Core JS files -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/loaders/pace.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/core/libraries/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/core/libraries/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/loaders/blockui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/ui/nicescroll.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/ui/drilldown.js"></script>
	<!-- /core JS files -->

	<!-- Theme JS files -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/forms/styling/switch.min.js"></script>

	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/core/app.js"></script>
<!--	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/pages/form_checkboxes_radios.js"></script>-->

	<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/plugins/ui/ripple.min.js"></script>
	<!-- /theme JS files --><!-- /theme JS files -->
<!--<script type="text/javascript" src="${pageContext.request.contextPath}/vendors/blog_network/assets/js/pages/form_select2.js"></script>-->

</head>

<body>

	<!-- Main navbar -->
	<div class="navbar navbar-inverse bg-indigo">
		<div class="navbar-header">
			<a class="navbar-brand" href="index.html"><img src="${pageContext.request.contextPath}/vendors/blog_network/assets/images/logo_light.png" alt=""></a>

			<ul class="nav navbar-nav pull-right visible-xs-block">
				<li><a data-toggle="collapse" data-target="#navbar-mobile"><i class="icon-tree5"></i></a></li>
			</ul>
		</div>

		<div class="navbar-collapse collapse" id="navbar-mobile">

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown language-switch">
					<a class="dropdown-toggle" data-toggle="dropdown">
						Select Tracker
						<span class="caret"></span>
					</a>

					<ul class="dropdown-menu">
						<li><a class="deutsch"> Wale</a></li>
						<li><a class="ukrainian">Test</a></li>
<!--
						<li><a class="english"><img src="${pageContext.request.contextPath}/vendors/blog_network/assets/images/flags/gb.png" alt=""> English</a></li>
						<li><a class="espana"><img src="${pageContext.request.contextPath}/vendors/blog_network/assets/images/flags/es.png" alt=""> España</a></li>
						<li><a class="russian"><img src="${pageContext.request.contextPath}/vendors/blog_network/assets/images/flags/ru.png" alt=""> Русский</a></li>
-->
					</ul>
				</li>

				<li class="dropdown dropdown-user">
					<a class="dropdown-toggle" data-toggle="dropdown">
						<img src="${pageContext.request.contextPath}/vendors/blog_network/assets/images/placeholder.jpg" alt="">
						<span>Victoria</span>
						<i class="caret"></i>
					</a>

					<ul class="dropdown-menu dropdown-menu-right">
						<li><a href="#"><i class="icon-user-plus"></i> My profile</a></li>
<!--						<li><a href="#"><i class="icon-coins"></i> My balance</a></li>-->
<!--						<li><a href="#"><span class="badge badge-warning pull-right">58</span> <i class="icon-comment-discussion"></i> Messages</a></li>-->
						<li class="divider"></li>
<!--
						<li><a href="#"><i class="icon-cog5"></i> Account settings</a></li>
						<li><a href="#"><i class="icon-help"></i> Help</a></li>
-->
						<li><a href="#"><i class="icon-switch2"></i> Logout</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<!-- /main navbar -->


	<!-- Second navbar -->
	<div class="navbar navbar-default" id="navbar-second">
		<ul class="nav navbar-nav no-border visible-xs-block">
			<li><a class="text-center collapsed" data-toggle="collapse" data-target="#navbar-second-toggle"><i class="icon-menu7"></i></a></li>
		</ul>

		<div class="navbar-collapse collapse" id="navbar-second-toggle">
			<ul class="nav navbar-nav navbar-nav-material">
				<li class="active"><a href=""><i class="icon-display4 position-left"></i> Dashboard</a></li>





				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<i class="icon-chart position-left"></i> Basic Analytics<span class="caret"></span>
					</a>

					<ul class="dropdown-menu width-250">
						<li class="dropdown-header">Basic Analytics</li>
						<li>
							<a href="#"><i class="icon-pie-chart8"></i>Posting Frequency</a>
						</li>
						<li>
							<a href="#"><i class="icon-info3"></i>Additional Information</a>
						</li>

						</ul>
				</li>

				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<i class="icon-stats-bars2 position-left"></i> Advanced Analytics<span class="caret"></span>
					</a>
					<ul class="dropdown-menu width-250">
						<li class="dropdown-header">Advance Analytics</li>
						<li>
							<a href="#"><i class="icon-search4"></i>Keyword Trend</a>
						</li>
						<li>
							<a href="#"><i class="icon-puzzle3"></i>Sentiments</a>
						</li>
						<li>
							<a href="#"><i class="icon-newspaper"></i>Influence</a>

						</li>
						<li class="dropdown-submenu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-file-spreadsheet"></i>Data Presentation</a>
						<ul class="dropdown-menu width-200">
						<li class="dropdown-header highlight">Options</li>
						<li><a href="http://blogtrackers.host.ualr.edu" target="_blank"><i class="icon-circle-css spinner"></i>Data Export in JSON</a></li>

						</ul>
						</li>
						</ul>

				</li>

				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<i class="icon-stars position-left"></i> Services<span class="caret"></span>
					</a>
					<ul class="dropdown-menu width-200">
					<li class="dropdown-header">Services</li>
					<li class="dropdown-submenu">
							<a href="#"><i class="icon-circle2"></i> Upgrade Options</a>
							<ul class="dropdown-menu width-200">
								<li class="dropdown-header highlight">Options</li>
								<li><a href="http://blogtrackers.host.ualr.edu" target="_blank"><i class="icon-paperplane spinner"></i>Plans</a></li>
								<li><a href="http://blogtrackers.host.ualr.edu" target="_blank"><i class="icon-comments spinner"></i>Testimonials</a></li>

							</ul>

					</li>
					<li class="dropdown-submenu">
					<a href="#"><i class="icon-video-camera2"></i> Training</a>
							<ul class="dropdown-menu width-200">
								<li class="dropdown-header highlight">Options</li>
								<li><a> <i class="icon-video-camera-slash spinner"></i>Video Tutorials</a></li>
								<li ><a ><i class="icon-file-pdf spinner"></i>Download PDF</a></li>

							</ul>
							</li>
							<li>
					<a href="#"><i class="icon-headphones"></i> Support</a>

						</li>
					</ul>
				</li>
			</ul>


			<ul class="nav navbar-nav navbar-nav-material navbar-right">
				<li>
					<a>
						<i class="icon-history position-left"></i>
						Blogtrackers
						<span class="label label-inline position-right bg-success-400">1.4</span>
					</a>
				</li>

				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<i class="icon-cog3"></i>
						<span class="visible-xs-inline-block position-right">Share</span>
						<span class="caret"></span>
					</a>

					<ul class="dropdown-menu dropdown-menu-right">
						<li><a href="#"><i class="icon-user-lock"></i> Account security</a></li>
						<li><a href="#"><i class="icon-statistics"></i> Analytics</a></li>
						<li><a href="#"><i class="icon-accessibility"></i> Accessibility</a></li>
						<li class="divider"></li>
						<li><a href="#"><i class="icon-gear"></i> All settings</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<!-- /second navbar -->


	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Blog Network</span>
<!--					<small class="display-block">Good morning, Victoria Baker!</small>-->
				</h4>
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
				<div class="col-md-12" >
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Network<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
<!--
								<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span> <b class="caret"></b>
									</button>
-->
			                	</div>
							</div>

							<div class="panel-body" style="min-height: 500px;">
							<div class="col-md-12">
	<div id="mynetwork"></div>
<script type="text/javascript">
    /*   var nodes = [
        {id: 0, label: "0", group: 'source'},
        {id: 1, label: "1", group: 'icons'},
        {id: 2, label: "2", group: 'icons'},
        {id: 3, label: "3", group: 'icons'},
        {id: 4, label: "4", group: 'icons'},
        {id: 5, label: "5", group: 'icons'},
        {id: 6, label: "6", group: 'icons'},
        {id: 7, label: "7", group: 'icons'},
        {id: 8, label: "8", group: 'icons'},
        {id: 9, label: "9", group: 'icons'},
        {id: 10, label: "10", group: 'mints'},
        {id: 11, label: "11", group: 'mints'},
        {id: 12, label: "12", group: 'mints'},
        {id: 13, label: "13", group: 'mints'},
        {id: 14, label: "14", group: 'mints'},
        {id: 15, group: 'dotsWithLabel'},
        {id: 16, group: 'dotsWithLabel'},
        {id: 17, group: 'dotsWithLabel'},
        {id: 18, group: 'dotsWithLabel'},
        {id: 19, group: 'dotsWithLabel'},
        {id: 20, label: "diamond", group: 'diamonds'},
        {id: 21, label: "diamond", group: 'diamonds'},
        {id: 22, label: "diamond", group: 'diamonds'},
        {id: 23, label: "diamond", group: 'diamonds'},
				{id: 24, label: "facebook", group: 'facebook'},
				{id: 25, label: "twitter", group: 'twitter'},
				{id: 26, label: "youtube", group: 'youtube'},
				{id: 27, label: "socialmedia", group: 'socialmedia'},
				{id: 28, label: "tumblr", group: 'tumblr'},
				{id: 29, label: "linkedin", group: 'linkedin'},
				{id: 30, label: "entities", group: 'entities'},
    ];
     var edges = [
        {from: 1, to: 0,},
        {from: 2, to: 0,},
        {from: 4, to: 3, arrows:'to, from'},
        {from: 5, to: 4},
        {from: 4, to: 0},
        {from: 7, to: 6},
        {from: 8, to: 7},
        {from: 7, to: 0},
        {from: 10, to: 9},
        {from: 11, to: 10, arrows:'to'},
        {from: 10, to: 4},
        {from: 13, to: 12},
        {from: 14, to: 13},
        {from: 13, to: 0},
        {from: 16, to: 15},
        {from: 17, to: 15, arrows:'from'},
        {from: 15, to: 10},
        {from: 19, to: 18},
        {from: 20, to: 19},
        {from: 19, to: 4},
        {from: 22, to: 21},
        {from: 23, to: 22},
        {from: 23, to: 0},
				{from: 24, to: 1, arrows:'from'},
				{from: 25, to: 1, arrows:'from'},
				{from: 26, to: 1, arrows:'from'},
				{from: 27, to: 22},
				{from: 28, to: 23},
				{from: 29, to: 10},
				{from: 30, to: 16},
    ] 
   */
 
   var nodes = [
 	
 	<c:forEach items="${nodes}" var="l" >
     {id: ${l[0]}, label: "${l[1]}", group: '${l[2]}'},
     </c:forEach>
 ];
 
 var edges = [
 	<c:forEach items="${edges}" var="l" >
     {from: ${l[0]}, to: ${l[1]}, ${l[2]}},
     </c:forEach>
 ]  
 
    // create a network
    var container = document.getElementById('mynetwork');
    var data = {
        nodes: nodes,
        edges: edges
    };
    var options = {
        nodes: {
            shape: 'dot',
            size: 20,
            font: {
                size: 15,
                color: '#ffffff'
            },
            borderWidth: 2
        },
        edges: {
            width: 2
        },
        groups: {
            diamonds: {
                color: {background:'red',border:'white'},
                shape: 'diamond'
            },
            dotsWithLabel: {
                label: "I'm a dot!",
                shape: 'dot',
                color: 'cyan'
            },
            mints: {color:'rgb(0,255,140)'},
            icons: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf0c0',
                    size: 50,
                    color: 'orange'
                }
            },
						facebook: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf09a',
                    size: 50,
                    color: 'orange'
                }
            },
						twitter: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf099',
                    size: 50,
                    color: 'orange'
                }
            },
						youtube: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf16a',
                    size: 50,
                    color: 'orange'
                }
            },
						tumblr: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf173',
                    size: 50,
                    color: 'orange'
                }
            },
						linkedin: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf08c',
                    size: 50,
                    color: 'orange'
                }
            },
						socialmedia: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf1e0',
                    size: 50,
                    color: 'orange'
                }
            },
						entities: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf111',
                    size: 50,
                    color: 'orange'
                }
            },
            source: {
                color:{border:'white'}
            }
        }
    };
    var network = new vis.Network(container, data, options);

</script>
</div>
							<div style="position: absolute;  top:20px; display:none;" class="col-lg-3 col-md-3 col-sm-12 col-xs-12 features-tab">
		<div class="panel panel-default">
							<div class="panel-heading">
								<h6 class="panel-title">Features<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
<!--				                		<li><a data-action="reload"></a></li>-->
				                		<li><a data-action="close"></a></li>
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">

<div class="checkbox">
<label><div class="checker"><span class="">
<input type="checkbox" value="blogtoblog" class="styled"></span></div>
Blog - Blog
</label>
	</div>
 <div class="checkbox">
<label><div class="checker"><span class="">
<input type="checkbox" value="bloggertoblogger" class="styled"></span></div>
Blogger - Blogger
</label>
	</div>
<div class="checkbox">
<label><div class="checker"><span class="">
<input type="checkbox" value="facebook" class="styled"></span></div>
Facebook
</label>
	</div>
<div class="checkbox">
<label><div class="checker"><span class="">
<input type="checkbox" value="linkedin" class="styled"></span></div>
LinkedIn
</label>
	</div>
<div class="checkbox">
<label><div class="checker"><span class="">
<input type="checkbox" value="twitter" class="styled"></span></div>
Twitter
</label>
	</div>


							</div>
						</div>

				</div>

								<!--<div><div id="cy" ></div></div>-->




							<div style="position:absolute; bottom:10px;" class="col-md-12 text-center"><div class="btn-group">
								<button type="button" id="features" class="btn btn-primary btn-rounded legitRipple">Features</button>
								<button type="button" class="btn btn-primary btn-rounded legitRipple">Statistics</button>
								<!--<button type="button" class="btn btn-primary legitRipple">Right</button>-->
							</div></div>
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




	<!-- /page container -->


	<!-- Footer -->
	<div class="footer text-muted">
		&copy; 2017. <a href="#">Blogtracker</a> All Right Reserved
	</div>
	<!-- /footer -->


	<!--<script src="code.js"></script>-->
	<script>
	$(document).ready(function(e)
	{
	$('#features').click(function(e)
    {
	$('.features-tab').slideToggle(500);
	});

	$('.checker input[type=checkbox]').each(function(index,element){
	$('.checker input[type=checkbox]:eq('+index+')').click(function(){
	$('.checkbox .checker span:eq('+index+')').toggleClass('checked');
	//$('.checker input[type=checkbox]:eq('+index+')').trigger('click');
   });
	});

	});
	</script>
</body>
</html>
