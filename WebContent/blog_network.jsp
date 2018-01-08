<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
	
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
        ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
%>

 <jsp:include page="include_top.jsp"></jsp:include>
<% ArrayList mytrackers = new ArrayList();
mytrackers = (ArrayList)session.getAttribute("trackers");
int trackerSize = mytrackers.size();
    if(trackerSize == 0)
    {%>
    <c:redirect url="setup_tracker.jsp"/>	
  <% } %> 
	<!-- Page header -->
	<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<a href="<%=request.getContextPath()%>/analytics.jsp"><i class="icon-arrow-left52 position-left"></i></a>
					<span class="text-semibold">Blog Network</span>
			<%-- <small class="display-block"><span>Welcome, </span><%=username %> <font color="red">${errorMessage}</font></small> --%>
			
				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List </a><a href="edittracker.jsp" title="Edit <%=session.getAttribute("tracker")%> Tracker">(<%=session.getAttribute("tracker")%>)</a></li>
					<li> <a href="analytics.jsp">Analytics</a></li>
					<li class="active">Blog Network </li>
				</ul>
			</div>
				<!-- <div class="heading-elements">
				<div class="heading-btn-group">
						<button type="button" onclick="location.href='setup_tracker.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-plus2"></i></b> Setup a new tracker</button>
					<button type="button" href="javascript:void(0);" onclick="javascript:introJs().start();" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-reading "></i></b> Tour Page</button>
				 
					<button id="google_translate_element" class="btn btn-default"><script type="text/javascript">
function googleTranslateElementInit() {
  new google.translate.TranslateElement({pageLanguage: 'ar', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
}
</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
				
				</button>
			</div>
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

				<!-- Main charts -->
				<div class="row">
				<div class="col-md-12" >
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Network<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
								<form name="dateform" id="dateform" method="post">
									<div data-intro="Select a date range " data-step="2" id="reportrange">
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					<b class="caret"></b>
									</button>
									<input type="hidden" name="is_request" value="yes">
									<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" />
			                	</div>
								</form>

			                	</div>
							</div>

							<div class="panel-body" style="min-height: 800px;">
							<div class="col-md-12">
	<div id="mynetwork" style="background-color:#ffffff; min-height: 780px;"></div>
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
    ]   */
 
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
                color: '#000000'
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
	 
  <jsp:include page="footer.jsp"></jsp:include>
	
	<!-- /footer -->


<!-- Dependencies -->
  <jsp:include page="pagedependencies/blog_network.jsp"></jsp:include>
  <!-- End of Dependencies -->
	
</body>
</html>
