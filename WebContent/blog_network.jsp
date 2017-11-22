<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@page import="java.util.*"%>
<%
	Object username = (null == session.getAttribute("user")) ? "" : session.getAttribute("user");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	String tracker = (null == session.getAttribute("tracker")) ? "" : session.getAttribute("tracker").toString();
	if (username == null) {
		response.sendRedirect("index.jsp");
	}
%>
<% ArrayList mytrackers = new ArrayList();
mytrackers = (ArrayList)session.getAttribute("trackers");
int trackerSize = mytrackers.size();
    if(trackerSize == 0)
    {%>
    <c:redirect url="setup_tracker.jsp"/>	
  <% } %> 
 <jsp:include page="include_top.jsp"></jsp:include>


	<!-- Page header -->
		<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<a href="<%=request.getContextPath()%>/analytics.jsp"><i class="icon-arrow-left52 position-left"></i></a>
					<span class="text-semibold">Blog Network</span>
					
				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List </a></li>
					<li> <a href="analytics.jsp">Analytics</a></li>
					<li class="active">Blog Network (Current Tracker: <%=session.getAttribute("tracker")%>)</li>
				</ul>
		
				
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
    var nodes = [
        {id: 0, label: "0", group: 'source'},
        {id: 1, label: "1", group: 'blogger'},
        {id: 2, label: "2", group: 'blogger'},
        {id: 3, label: "3", group: 'blogger'},
        {id: 4, label: "4", group: 'blogger'},
        {id: 5, label: "5", group: 'blogger'},
        {id: 6, label: "6", group: 'blogger'},
        {id: 7, label: "7", group: 'blogger'},
        {id: 8, label: "8", group: 'blogger'},
        {id: 9, label: "9", group: 'blogger'},
        {id: 10, label: "10", group: 'mints'},
        {id: 11, label: "11", group: 'mints'},
        {id: 12, label: "12", group: 'mints'},
        {id: 13, label: "13", group: 'mints'},
        {id: 14, label: "14", group: 'mints'},
        {id: 15, group: 'dotsWithLabel'},
        {id: 16, group: 'dotsWithLabel'},
        {id: 17, group: 'dotsWithLabel'},
        {id: 18, group: 'linkedin'},
        {id: 19, group: 'facebook'},
        {id: 20, label: "twitter", group: 'twitter'},
        {id: 21, label: "diamond", group: 'diamonds'},
        {id: 22, label: "diamond", group: 'diamonds'},
        {id: 23, label: "diamond", group: 'diamonds'},
    ];
    var edges = [
        {from: 1, to: 0},
        {from: 2, to: 0},
        {from: 4, to: 3},
        {from: 5, to: 4},
        {from: 4, to: 0},
        {from: 7, to: 6},
        {from: 8, to: 7},
        {from: 7, to: 0},
        {from: 10, to: 9},
        {from: 11, to: 10},
        {from: 10, to: 4},
        {from: 13, to: 12},
        {from: 14, to: 13},
        {from: 13, to: 0},
        {from: 16, to: 15},
        {from: 17, to: 15},
        {from: 15, to: 10},
        {from: 19, to: 18},
        {from: 20, to: 19},
        {from: 19, to: 4},
        {from: 22, to: 21},
        {from: 23, to: 22},
        {from: 23, to: 0},
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
            size: 25,
            font: {
                size: 15,
                color: '#2196F3'
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
            blogger: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf0c0',
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
                    color: '#1da1f2'
                }
            },
            facebook: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf09a',
                    size: 50,
                    color: '#4267b2'
                }
            },
            linkedin: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf08c',
                    size: 50,
                    color: '#0077B5'
                }
            },
            blog: {
                shape: 'icon',
                icon: {
                    face: 'FontAwesome',
                    code: '\uf086',
                    size: 50,
                    color: '#0077B5'
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
				                		<!-- <li><a data-action="close"></a></li> -->
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
