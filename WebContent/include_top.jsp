<%@page import="java.io.File"%>
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="authentication.DBConnector"%>
<%@page import="blogtracker.util.Common" %>
<!DOCTYPE html>
<%

	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	String tracker_id = (null == session.getAttribute("tid")) ? "" : session.getAttribute("tid").toString();
	
	try{
    	ArrayList trackers = new DBConnector().query("SELECT * FROM trackers WHERE userid='"+username.toString()+"' ORDER BY tid DESC");
    	session.setAttribute("trackers", trackers);
    	
    	
    }catch(Exception ex){}
	
	ArrayList userinfo = new ArrayList();
	ArrayList trackers = new ArrayList();

    String path=application.getRealPath("/").replace('\\', '/')+"profile_images/";
    path = path.replace("build/", "");
    String filename = path+session.getAttribute("username")+".jpg";
    String pimage = "assets/images/placeholder.jpg";
    File f = new File(filename);
    if(f.exists() && !f.isDirectory()) { 
       pimage = "profile_images/"+session.getAttribute("username")+".jpg?v=1";
   }
    
    try{
	   userinfo = (ArrayList)session.getAttribute("userinfo");
	   trackers = (ArrayList)session.getAttribute("trackers");
	   //System.out.println(trackers.size());
    }catch(Exception e){}
    
   /*  if(session.getAttribute("tracker") == null)
    { 
   response.sendRedirect("index.jsp");
   
     } */ 
     %>
   
    

     
     
     
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Blogtrackers</title>

	<!-- Global stylesheets -->
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
            background-color: #eeeded;
        }

</style>

<script type="text/javascript" src="dist/vis.js"></script>
    <link href="dist/vis-network.min.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="styles/vendor.css"/>
	
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"/>
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" rel="stylesheet" type="text/css">
	<link href="assets/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
	<link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="assets/css/core.css" rel="stylesheet" type="text/css">
	<link href="assets/css/components.css" rel="stylesheet" type="text/css">
	<link href="assets/css/colors.css" rel="stylesheet" type="text/css">
	<link href="assets/css/introjs.css" rel="stylesheet" type="text/css">
	<link href="assets/css/jquery-ui.css" rel="stylesheet" type="text/css">
	
	<link href="assets/css/mystyle2.css" rel="stylesheet" type="text/css">

	
	<!-- /global stylesheets -->
	
	<!-- Style from old -->
	<link href="vendors/nprogress/nprogress.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css"
	href="vendors/jQCloud-master/jqcloud/jqcloud.css" />
	
<link href="${pageContext.request.contextPath}/vendors/vis/dist/vis.css"
	rel="stylesheet" type="text/css" />
	
	<link
	href="${pageContext.request.contextPath}/vendors/jqvmap/dist/jqvmap.min.css"
	rel="stylesheet" />
	<!-- NProgress -->
<link
	href="${pageContext.request.contextPath}/vendors/nprogress/nprogress.css"
	rel="stylesheet">
	
	<link
	href="${pageContext.request.contextPath}/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet">
	
	<!-- bootstrap-progressbar -->
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css"
	rel="stylesheet">
		
	<style>
	
	<style>
/*div.scroll {
	overflow: scroll;
}*/
</style>
	</style>

	<!-- Core JS files -->
	
	
	<script type="text/javascript" src="assets/js/plugins/loaders/pace.min.js"></script>
	 <script type="text/javascript" src="assets/js/core/libraries/jquery.min.js"></script> 
	 	
	
	<script type="text/javascript" src="assets/js/core/libraries/bootstrap.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/loaders/blockui.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/nicescroll.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/drilldown.js"></script>
	
	<script src="https://d3js.org/d3.v3.min.js"></script>
	
<script type="text/javascript" src="assets/js/plugins/extensions/cookie.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/validation/validate.min.js"></script>


	
<script type="text/javascript">
$(window).load(function() {
	$("#pageloader").addClass("hidden");
	//$(".loader").fadeOut("slow");
})
</script>
<script type="text/javascript">
		function showGif() {
				$("#pageloader").removeClass("hidden");
			}
</script>

<!-- /core JS files -->
		<!-- <script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>-->
	 <script>
           var app_url ='${pageContext.request.contextPath}/'; 
      </script>
      
     <!--  <script type="text/javascript" src="assets/js/pages/login_validation.js"></script> -->
	<!-- /theme JS files -->
	       
	       
	       
	       
	<!-- <link href="assets/css/mystyle.css" rel="stylesheet" type="text/css"> -->

	<script type="text/javascript" src="assets/js/functions.js?v=0"></script>
	
	<!-- /global stylesheets -->
</head>

<body>

        <div id="pageloader">
			<div class="loader-item">
                <img src="assets/img/logo/Loading-data.gif" alt="page loader">
            </div>
		</div>
		
	<!-- Main navbar -->
	<div class="navbar navbar-inverse" style="background-color:#2A6ADF">
		<div class="navbar-header">
			<a class="navbar-brand" href="features.jsp"><span style="font-size:18px">Blogtrackers</span></a>
						
			<ul class="nav navbar-nav pull-right visible-xs-block">
				<li><a data-toggle="collapse" data-target="#navbar-mobile" class="collapsed" aria-expanded="false"><i class="icon-tree5"></i></a></li>
			</ul>
		</div>

		
		
			<div class="navbar-collapse collapse" id="navbar-mobile">
			<!-- <p class="navbar-text mt-5"><span class="label bg-success-400">BASIC USER</span></p> -->
			<% 
			String Selectedtracker  = (String)session.getAttribute("tracker"); 

			%>

				<ul class="nav navbar-nav navbar-right">
			<% if(username!=""){ %>
			<li class="language-switch2" >
				<button style="margin-top: 2px; text-transform:capitalize;" data-intro="Click here to create a new tracker" data-step="1" type="button" onclick="location.href='setup_tracker.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-plus2"></i></b> Setup a new tracker</button>
		        </li>
			<li id="tourpage" class="language-switch2  hidden-md"><button style="border:2px solid #2196F3" type="button" href="javascript:void(0);" onclick="javascript:introJs().start();" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple" ><b><i class="icon-reading "></i></b> Tour Page</button></li>
				<li style="display:none;" class="language-switch" data-intro="Select a tracker" data-step="1">
			<form name="trackerform" id="trackerform" action="" method="post">

			<select  id="tracker" name="tracker" onchange="trackerchanged()" class="form-control" value="${item}">
					                    
				                    <c:choose>
										<c:when test="${tracker != null}">
											<option selected value="">${tracker} </option>
										</c:when>

										<c:when test="${tracker == null}">
											<option value="">Select Tracker</option>
										</c:when>
									</c:choose>
									<c:forEach items="${trackers}" var="item">
										<c:if test="${tracker ne item}">
											<option value="${item.get(2)}"><c:out value="${item.get(2)}" /></option>
										</c:if>
									</c:forEach>
									
									</select>
									</form>
									</li>
			


				
				<li class="dropdown dropdown-user">
					<a class="dropdown-toggle" data-toggle="dropdown">
						<img src="<%=pimage%>" width="34" height="34" alt="">
						<span><%=session.getAttribute("username")%></span>
						<i class="caret"></i>
					</a>

					<ul class="dropdown-menu dropdown-menu-right">
						<li><a href="<%=request.getContextPath()%>/profile"><i class="icon-user-plus"></i> My profile</a></li>
						<li class="divider"></li>
			<!-- 			<li><a target="_blank" onclick="alert('We are still working on the section')"><i class="icon-paperplane spinner"></i>Upgrade Plan</a></li> -->
						<li><a href="<%=request.getContextPath()%>/features.jsp"><i class="icon-cog5"></i> Features</a></li>
						<li><a href="<%=request.getContextPath()%>/help.jsp"><i class="icon-help"></i> Help</a></li>
						<li><a href="<%=request.getContextPath()%>/logout"><i class="icon-switch2"></i> Logout</a></li>			
					</ul>
				</li>
				<% }else{ %>
				<li><a href="<%=request.getContextPath()%>/login"><i class="icon-switch2"></i> Login</a></li>			
				
				<% } %>

			</ul>
			
		</div>
			
	
		</div>
	</div>
	<!-- /main navbar -->

<%
String uri = request.getRequestURI();
String pageName = uri.substring(uri.lastIndexOf("/")+1);	

//System.out.println(pageName);
%>
	

	<!--  <div class="navbar navbar-default" id="navbar-second">
	
	<div class="navbar-collapse collapse" id="navbar-second-toggle">
		<ul class="nav navbar-nav navbar-nav-material">
			<li class=""><a href="<%=request.getContextPath()%>/dashboard.jsp"><i class="icon-display4 position-left"></i> Dashboard</a></li>
			<li onclick="location.href='basic.jsp'">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">
					<i class="icon-chart position-left"></i> Basic Analytics
				</a>
				
			</li>
			<li><a href="<%=request.getContextPath()%>/PostingFrequency"><i class="fa fa-line-chart"></i>Posting
						Frequency<span class="fa fa-chevron-right"></span></a></li>
			<li onclick="location.href='advance.jsp'">
				<a class="">
					<i class="icon-stats-bars2 position-left"></i> Advanced Analytics
				</a>
				
				
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
		
	</div>
</div>  -->
<% 
if (username == null || username == "") {
	
	
} else{
	%>

  <!-- <div class="navbar navbar-default" id="navbar-second">
		<ul class="nav navbar-nav no-border visible-xs-block">
			<li><a class="text-center collapsed" data-toggle="collapse" data-target="#navbar-second-toggle"><i class="icon-menu7"></i></a></li>
		</ul>
		<div class="navbar-collapse collapse" id="navbar-second-toggle">
			<ul class="nav navbar-nav navbar-nav-material">
				<li class=""><a href="<%=request.getContextPath()%>/trackerlist.jsp"><i class="icon-list position-left"></i> Tracker List</a></li>
		 -->		
				
				<%-- <li >
					<a href="<%=request.getContextPath()%>/analytics.jsp" class="">
						<i class="icon-stats-bars2 position-left"></i> Analytics
					</a>
					
					
				</li> --%>
				
				
				
								 <!--   <li class="dropdown">
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
				</li>-->
			
			<!-- </ul>
				
		</div>
			
	</div>   -->
	<% } %>
	