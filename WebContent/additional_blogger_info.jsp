<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			<div class="page-title mb-20">
				<h4>
					<a href="<%=request.getContextPath()%>/analytics.jsp"><i class="icon-arrow-left52 position-left"></i></a>
					<span class="text-semibold">Additional Blogger Information</span>
<%-- <small class="display-block"><span>Welcome, </span><%=username %> (Current Tracker: <%=session.getAttribute("tracker")%>) --%>
				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List </a></li>
					<li> <a href="analytics.jsp">Analytics</a></li>
					<li class="active">Additional Blogger Info (Current Tracker: <%=session.getAttribute("tracker")%>)</li>
				</ul>	
				
				
			</div>
			<div class="form-group ">
			<form name="search-author" method="get" action="<%=request.getContextPath()%>/AdditionalBlogger">
				<div class="col-md-12 mb-20">
				
				<div class="input-group">
				<input type="text" name="authorName" class="form-control"  placeholder="Enter a blogger name to search" id="searchtextbox" autocomplete="off">
											<span class="input-group-btn" style="padding-left:0px;"><button type="submit" class="btn btn-primary">Search</button></span>
											
										</div>
										</div>
										</form>
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
							<div class="col-md-4 hidden">
							
							<div id="address-book" class="scroll" style="height:400px;">
														<div class="slider-content">
															<ul>
																<c:set var="i" value="0" />
																<c:forEach items="${brNameList}" var="s2" begin="${i}">
																	<li><a
																		href="<%=request.getContextPath()%>
																		/AdditionalBlogger?authorName=${s2.blogger}">${s2.blogger}</a></li>
																</c:forEach>
																</ul>
																</div>
																</div>
							
							</div>
							<div class="col-md-12">
							
							<div class="panel panel-default">
							<div class="panel-heading">
								<h6 class="panel-title">Blogger Details <a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
			                	
			                	
							</div>

							<div class="panel-body">			
							<div class="col-md-6">
							<table class="table">
						<thead>
							<tr>
								<th>Blogger name</th>
								<th id="blogger-name">${bloggerDetails[0].author}</th>
								
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Blogsite name:</td>
								<td id="blogsite-name">${bloggerDetails[0].siteName}</td>
								
							</tr>
								<tr>
								<td>Visit Blog Site</td>
								<td id="blog-site"><a href="${bloggerDetails[0].siteURL}" target="_blank">${bloggerDetails[0].siteURL}</a></td>
								
							</tr>
							</tbody>
							</table>
							</div>
							<div class="col-md-6">
							<table class="table">
						<thead>
							<tr>
								<th>Most recent post data</th>
								<th id="recent-post">${bloggerDetails[0].lastCleaned}</th>
								
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Maximum influence</td>
								<td id="maximum-influence">${bloggerDetails[0].maxInfluence}</td>
								
							</tr>
							<tr>
								<td>Blogsite name:</td>
								<td id="blogsite-name">${bloggerDetails[0].lastCleaned}</td>
								
							</tr>
								
							</tbody>
							</table>
							</div>
							</div>
					</div>
								
								<div class="panel panel-default">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Content<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
			                	
									</div>
									<div class="panel-body">
										<span> ${bloggerDetails[0].description} </span>
										
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
														<div id="DailyAverageChart" style="height: 350px"></div>
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
														<div id="MonthlyAverageChart" style="height: 350px"></div>
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
						
  
								
								<div class="col-md-4">
															<canvas id="canvas1i" height="210" width="210"
																style="margin: 5px 10px 10px 0"></canvas>
															<h4 style="margin: 0">${bloggerSentiments[2].year}</h4>
														</div>
														<div class="col-md-4">
															<canvas id="canvas1i2" height="210" width="210"
																style="margin: 5px 10px 10px 0"></canvas>
															<h4 style="margin: 0">${bloggerSentiments[1].year}</h4>
														</div>
														<div class="col-md-4">
															<canvas id="canvas1i3" height="210" width="210"
																style="margin: 5px 10px 10px 0"></canvas>
															<h4 style="margin: 0">${bloggerSentiments[0].year}</h4>
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

							<div class="panel-body scroll2" style="height:500px;">
						<table class="table datatable-basic">
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
						<c:forEach items="${bloggerDomains}" var="s2" begin="${i}">
							<tr>
								<td><a href="${s2.link}" target="_blank">${s2.link}</a></td>
								<td>${s2.rank}</td>
								
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
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

							<div class="panel-body scroll2" style="height:500px;">
						<table class="table datatable-basic">
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
					<c:forEach items="${bloggerLinks}" var="s1"	begin="${i}">
							<tr>
								<td width="95%"><a href="${s1.link}" target="_blank">${s1.link}</a></td>
								<td >${s1.rank}</td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
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
  <jsp:include page="pagedependencies/additionalbloggerinfo.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
