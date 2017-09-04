<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"
	isELIgnored="false"%>
<%
	Object username = (null == session.getAttribute("user")) ? "" : session.getAttribute("user");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");

	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="js/springy.js"></script>
<script src="js/springyui.js"></script>



<script type="text/javascript" src="js/function.js"></script>


<title>Blogtrackers | Keyword Trends</title>

<!-- Bootstrap -->
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link href="${pageContext.request.contextPath}/vendors/nprogress/nprogress.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet">
<!-- Custom Theme Style -->
<link href="${pageContext.request.contextPath}/build/css/custom.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/vendors/vis/dist/vis.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap-slider-master/dist/css/bootstrap-slider.min.css"
	rel="stylesheet" type="text/css" />
<style>
div.scroll {
	overflow: scroll;
}
</style>
</head>
<body class="nav-md">
<div class="loader"></div>
	<style>
.loader {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 9999;
	background: url('Resources/img/gif/Loading-data.gif') 50% 50% no-repeat
		rgb(249, 249, 249);
}
</style>

	<script type="text/javascript">
		$(window).load(function() {
			$(".loader").addClass("hidden");
			//$(".loader").fadeOut("slow");
		});
	
</script>
	<div class="container body">
		<div class="main_container">
			<jsp:include page="new_sidebar.jsp"></jsp:include>

			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<nav>
						<div class="nav toggle">
							<a id="menu_toggle"><i class="fa fa-bars"></i></a>
						</div>
						<div class="nav toggle" style="position: absolute; right: 35%; width: 30%;">
							<form name="trackerform" id="trackerform" action="KeywordTrendsServlet"
								method="post">
								<select id="tracker" name="tracker" onchange="trackerchanged()"
									value="${item}" class="form-control" required>
									<c:choose>
										<c:when test="${tracker != null}">
											<option value="">${tracker}</option>
										</c:when>

										<c:when test="${tracker == null}">
											<option value="">Select Tracker</option>
										</c:when>
									</c:choose>

									<c:forEach items="${trackers}" var="item">
										<c:if test="${tracker ne item}">
											<option value="${item}"><c:out value="${item}" /></option>
										</c:if>c:if>
									</c:forEach>
								</select>
							</form>
						</div>

						<ul class="nav navbar-nav navbar-right">
							<li class=""><a href="javascript:;" class="user-profile dropdown-toggle"
								data-toggle="dropdown" aria-expanded="false"> <!-- <img src="images/img.jpg"
									alt=""> --><%=username %> <span class=" fa fa-angle-down"></span>
							</a>
								<ul class="dropdown-menu dropdown-usermenu pull-right">
									<li><a href="javascript:;"> Profile</a></li>
									<li><a href="javascript:;"> <span class="badge bg-red pull-right"></span>
											<span>Settings</span>
									</a></li>
									<li><a href="javascript:;">Help</a></li>
									<li><a href="${pageContext.request.contextPath}/test_logout.jsp"><i
											class="fa fa-sign-out pull-right"></i> Log Out</a></li>
								</ul></li>
							<li role="presentation" class="dropdown"><a href="javascript:;"
								class="dropdown-toggle info-number" data-toggle="dropdown"
								aria-expanded="false"> 
							</a>
								<ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
									<li><a> <span class="image">
												<!-- <img src="images/img.jpg"
												alt="Profile Image" /> -->
										</span> <span> <span>Sender 1</span> <span class="time">3 mins ago</span>
										</span> <span class="message"> Message.... </span>
									</a></li>

									<li>
										<div class="text-center">
											<a> <strong>See All Alerts</strong> <i class="fa fa-angle-right"></i>
											</a>
										</div>
									</li>
								</ul></li>
						</ul>
					</nav>
				</div>
			</div>

			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="row top_tiles"></div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="title">
									<div class="col-md-12 col-sm-12 col-xs-12 form-group pull-right top_search">
										<form name="tagform" id="tagform" action="KeywordTrendsServlet"
											method="post">
											<div class="input-group">
												 <input type="text" class="form-control"  name="searchText" id="searchBar" placeholder="Search for..." 
												 onkeyup="searchTextVerify(event)" style="height: 45px; border: 1.2px solid gray"> <span
													class="input-group-btn">
													<button class="btn btn-default" onclick="showGif()" type="submit" name="searchButton"
												id="searchButton" style="height: 45px; border: 1.2px solid grey">Go!</button>
												</span>
											</div>
										</form>
									</div>
									<script type="text/javascript">
									function showGif() {
										$(".loader").removeClass("hidden");
									}
									</script>
									
		
									<div class="x_title">
										<h2>
											Blog network<small></small>
										</h2>
										<form name="dateform" id="dateform" action="KeywordTrendsServlet"
											method="post">
											<div class="filter">
												<div id="reportrange" class="pull-right"
													style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
													<i class="glyphicon glyphicon-calendar fa fa-calendar"></i> <span>December
														30, 2014 - January 28, 2018</span><input id="datepicked" name="datepicked"
														type="hidden" onchange="datechanged()"><b class="caret"></b>
												</div>
											</div>
										</form>
										<div class="clearfix"></div>
									</div>
								</div>
									<div class="clearfix"></div>
						<div class="col-md-12 col-sm-12 col-xs-12">
							
							
								<div class="x_content">
									<div class="clearfix"></div>
									<div class="col-md-3 col-xs-12">
							
	
<div id="contact-card" class="panel panel-default">
												  <div class="panel-heading">
													<h2 class="panel-title">Blog connection</h2>
												  </div>
												  <div class="panel-body">
												  <input type="search" class="" placeholder="Search for a node" style="width:100%">
														<br/>
														<br/>
													<div id="card" class="row">
														
		
														<span>
														
														
														<form name="checker">
                <input type="checkbox"  id="external_id" checked onclick="checkNode('external_id','external')" />External Sites
                <ul>
	<input type="checkbox" id="Blogger wale" class="external" checked onchange="changeNode('Blogger wale',0)" onmouseover="displayInfo('blogger wale')" onmouseout="eraseInfo()" />Blogger wale<br/>        	
                </ul>
                <input type="checkbox"  checked id="social_id" onclick="checkNode('social_id','social')" />Social Media
                		<ul>
            						
	
		<input type="checkbox" id="Twitter" class="social" onmouseover="displayInfo('twitter')" onmouseout="eraseInfo()" checked onclick="changeNode('Twitter',1)"  />Twitter<br/>
		<input type="checkbox" id="YouTube" class="social"  onmouseover="displayInfo('youtube')" onmouseout="eraseInfo()" checked onclick="changeNode('YouTube',2)" />YouTube<br/>
		<input type="checkbox" id="Facebook" class="social" onmouseover="displayInfo('facebook')" onmouseout="eraseInfo()" checked onclick="changeNode('Facebook',3)" />Facebook<br/>
	</form>
            						            		
            			
            	</li>
            </ul>
														</span>
														
													</div>
												  </div>
</div>

<div id="contact-card" class="panel panel-default">
												  <div class="panel-heading">
													<h2 class="panel-title">More Information</h2>
												  </div>
												  <div class="panel-body">
													<div id="card-info" class="row">
														
														
														<span>
													
<br/>
		</span>
														
													</div>
												  </div>
</div>

</div>
									
									<div class="col-md-9 col-xs-12">
										<div class="x_panel">
											<div class="clearfix"></div>
											<div class="scroll" id="alert" style="height: 400px;">
												<div class="x_content">

	
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
<script src="js/springy.js"></script>
<script src="js/springyui.js"></script>
<script>

jQuery(function(){
	changeNode("Blogger wale","0");
	
});
</script>


	<canvas id="springydemo" width="640" height="400" />
	
</div>
 <script>    
 
 function checkNode(element,classe){
	 var status = $("#"+element).is(":checked");
		if(status==false){
			$("."+classe).attr('checked', false);
		}else{
			$("."+classe).attr('checked', true);
		}
		
		var childre=$("."+classe);
		for(var j=0; j<childre.length; j++){
			console.log(childre[j].id);
			changeNode(childre[j].id,j);
		}
		//console.log(children);

 }
 
 function displayInfo(element){
	 $("#card-info").html(element);
 }
 
 function eraseInfo(){
	 $("#card-info").html("");
 }
 
 /*this function will remove every outbound link from the node*/
function changeNode(element,index){
	var graph = new Springy.Graph();
	var children = new Array();
	var names = ["Blogger wale","Twitter","YouTube","Facebook"];

	/* specify how the nodes are connected */
	children[0]  =["Twitter","Facebook"];
	children[1]  =["YouTube"];
	children[2]  =["Blogger wale"];
	children[3] = ["Blogger wale"];

	var nodes = new Array();
	for(var i=0; i<names.length; i++){
		var name=names[i];
		if(names[i]!=null){
			nodes[i] = graph.newNode({label: names[i]});
		}
	}
		
	var childrenn = children;
	var status = $("#"+element).is(":checked");
	if(status==false){
		childrenn[index]=null;
	
	}

	for(l=0; l<names.length; l++){
		if(childrenn[l]!==null){
			for(var m=0; m<childrenn[l].length; m++ ){			
				var position = names.indexOf(childrenn[l][m]);
				graph.newEdge(nodes[l], nodes[position], {color: '#00A0B0'});
			}
		}
	}
		
	var springy = window.springy = jQuery('#springydemo').springy({
			graph: graph,
			nodeSelected: function(node){
				//console.log(node);
				displayInfo(node.data.label);
		}
	});
		
}
</script>
	<div id="blogpost"></div>

												</div>
											</div>
										</div>
									</div>
								</div>
				
						</div>
							</div>
						</div>

					

						<div class="clearfix"></div>
						
					</div>
				</div>
			</div>
				
			<!-- /footer content -->
			<!-- jQuery -->
			<!-- jQuery -->
			
			<script
				src="${pageContext.request.contextPath}/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
			<!-- FastClick -->
			<script
				src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
			<!-- NProgress -->
			<script src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
			<!-- Chart.js -->
			<script src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>
			<script
				src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
			<script
				src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
			<!-- Custom Theme Scripts -->
			<script src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
			<!-- bootbox code -->
			<script
				src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>
			<script src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
			<!-- Ion.RangeSlider -->
			<script
				src="${pageContext.request.contextPath}/vendors/bootstrap-slider-master/dist/bootstrap-slider.min.js"></script>
			<!-- CSS dependencies for canvasjs -->
			<script src="${pageContext.request.contextPath}/vendors/vis/dist/vis.js"></script>
			<script
				src="${pageContext.request.contextPath}/vendors/Tags-Input-master/src/jquery.tagsinput.js"></script>
			<script type="text/javascript">
			