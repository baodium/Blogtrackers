<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
<%@page import="java.util.*"%>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
        ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

 <jsp:include page="include_top.jsp"></jsp:include>

	<!-- Page header -->
	<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<a href="<%=request.getContextPath()%>/analytics.jsp"><i class="icon-arrow-left52 position-left"></i></a>
					<span class="text-semibold">Additional Blog Information</span>
<%-- <small class="display-block"><span>Welcome, </span><%=username %></small> --%>
				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List  </a></li>
					<li><a href="edittracker.jsp" title="Edit <%=session.getAttribute("tracker")%> Tracker"><%=session.getAttribute("tracker")%></a></li>
					<li><a href="analytics.jsp">Analytics</a></li>
						<li class="active">Additional Blog Information</li>
				</ul>
				<!-- <div class="form-group">
				<div class="col-md-12">
				
				<div class="input-group">
				<input type="text" class="form-control" placeholder="Enter a keyword to search" id="searchtextbox" autocomplete="off">
											<span class="input-group-btn" style="padding-left:0px;"><button type="button" class="btn btn-primary">Search</button></span>
											
										</div>
										</div>
										</div> -->
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
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Site Information <a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							
							<div class="col-lg-6">
							<div class="form-group">
							<label class="col-lg-12 control-label">Select a Blog Site to view the Additional Information:</label>
							<div class="col-lg-12">
							<form name="sitesform" id="sitesform"
											action="AdditionalInfoServlet" method="post">
							<select class="select-search select2-hidden-accessible"  id="allsitesid" name="allsitesid" value="${item}" onchange="siteChanged()">
								<c:choose>
													<c:when test="${bsName != null}">
														<option value="">${bsName}</option>
													</c:when>

													<c:when test="${bsName == null}">
														<option value="">Select Blogsite</option>
													</c:when>
												</c:choose>

												<c:forEach items="${allSepSites}" var="item">
													<c:if test="${bsName ne item.siteName}">
														<option value="${item.siteID},${item.siteName}"><c:out
																value="${item.siteName}" /></option>
													</c:if>
												</c:forEach>
										
							</select>
							</form>
							</div>
							
							<div class="col-lg-3 mt-20">
							<div class="text-right">
							<a href="${siteUrl}">
							<button type="submit" class="btn btn-primary legitRipple">VISIT BLOG SITE<i class="icon-eye position-right"></i></button>
							</a>
							</div>
							</div>	
							
							</div>
					
							
								
							
							</div>
								
							
										
						<div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
					<div class="dashboard-stat blue-madison animated bounce">
						<div class="visual">
							<i class="icon-circle2"></i>
						</div>
						<div class="details">
							<div class="number cus p10">${maxScore}</div>
							<div class="desc">
								Max Influence Score
							</div>
						</div>
						<a class="more" href="#">
						Max Influence Score <i class="m-icon-swapright m-icon-white"></i>
						</a>
					</div>
					
				</div>										
							
							
							
							
							</div>
					</div>
					</div>
				<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Daily Average<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<!--  <div class="chart-container">
							<div class="chart" id="d3-bar-vertical"></div>
						</div> -->
<div class="demo-container">
													<div id="BarchartContainer" style="height: 350px"></div>
												</div>
   
							</div>
						</div>
					</div>
					
					
					<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Monthly Average<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<!--  <div class="chart-container">
							<div class="chart" id="c3-line-regions-chart"></div>
						</div> -->
<div class="demo-container">
													<div id="chartContainer" style="height: 350px"></div>
												</div>
   
							</div>
						</div>
					</div>
				
				
				      
				      
				      
				      
				      
				    
			      
			      
			      <div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Average sentiments<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						
   <!--  <div class="col-md-4"><div class="chart-container text-center">
									<div class="display-inline-block" id="c3-donut-chart"></div>
								</div></div> -->
								<div class="row" style="text-align: center;">
													<div class="col-md-4">
														<canvas id="canvas1i" height="210" width="210"
															style="margin: 5px 10px 10px 0"></canvas>
														<h4 style="margin: 0">${doughnut[2].year}</h4>
													</div>
													<div class="col-md-4">
														<canvas id="canvas1i2" height="210" width="210"
															style="margin: 5px 10px 10px 0"></canvas>
														<h4 style="margin: 0">${doughnut[1].year}</h4>
													</div>
													<div class="col-md-4">
														<canvas id="canvas1i3" height="210" width="210"
															style="margin: 5px 10px 10px 0"></canvas>
														<h4 style="margin: 0">${doughnut[0].year}</h4>
													</div>
												</div>
							</div>
						</div>
					</div>
				      
					
					
						<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">List of Domains<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body scroll2">
						<table class="table datatable-basic" style="min-height:500px;">
						<thead>
							<tr>
								<th>URL</th>
								<th>Frequency</th>
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
						<c:set var="i" value="0" />
																			<c:forEach items="${mostDomains}" var="s2"
																				begin="${i}">
																				<tr>
																					<td scope="row"><a href="${s2.link}"
																						target="_blank">${s2.link}</a></td>
																					<td scope="row">${s2.rank}</td>
																					<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">
																				</tr>
																			</c:forEach>
							
							</tbody>
							</table>

   
							</div>
						</div>
					</div>
					
					
					
					
						<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">List of URLs<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body scroll2">
						<table class="table datatable-basic" style="min-height:500px;">
						<thead>
							<tr>
								<th>URL</th>
								<th>Frequency</th>
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
						<c:set var="i" value="0" />
																			<c:forEach items="${mostLinks}" var="s1" begin="${i}">
																				<tr>
																					<td scope="row"><a href="${s1.link}"
																						target="_blank">${s1.link}</a></td>
																					<td scope="row">${s1.rank}</td>
																					<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">
																				</tr>
																			</c:forEach>
							
							</tbody>
							</table>

   
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
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
	<!-- Dependencies -->
  <jsp:include page="pagedependencies/additional_blog_info.jsp"></jsp:include>
  <!-- End of Dependencies -->


</body>
</html>