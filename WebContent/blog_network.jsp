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
