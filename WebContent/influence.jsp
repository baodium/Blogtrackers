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

	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Influence</span>
<small class="display-block"><span>Welcome, </span><%=username %>	
				</h4>
				<div class="form-group">
				<div class="col-md-12">
				
				<div class="input-group">
				<input type="text" class="form-control" placeholder="Enter a keyword to search" id="searchtextbox" autocomplete="off">
											<span class="input-group-btn" style="padding-left:0px;"><button type="button" class="btn btn-primary">Search</button></span>
											
										</div>
										</div>
										</div>
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
								<h6 class="panel-title">Influential Bloggers<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<form name="dateform" id="dateform" method="post">
									<div class="heading-elements" id="reportrange" action="PostingFrequency">
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" /><b class="caret"></b>
									</button>
			                	</div>
								</form>
							</div>

							<div class="panel-body">
							
							<div class="col-lg-12 col-md-12 col-sm-12">
								
								<table class="table datatable-basic">
						<thead>
							<tr>
								<th>Blogger</th>
								<th>Blog</th>
								<th>(Score Blogger)</th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
						<tr>
																			<td scope="row">Average</td>
																			<td></td>
																			<td>${topBScore}</td>
																			<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">
																		</tr>
							<c:set var="i" value="0" />
																		<c:set var="eo" value="1" />


																		<c:forEach items="${INFBlScz}" var="s12" begin="${i}">
																			<tr>
																				<td scope="row"><a class="title"
																					href="<%=request.getContextPath()%>
																		/AdditionalBlogger?authorName=${s12.bloggerName}">${s12.bloggerName}</a></td>
																				<td>${s12.blogName}</td>
																				<td>${s12.influenceScore}</td>
<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">
																			</tr>
																		</c:forEach>
							</tbody>
							</table>
   
																												
							</div>
					<div class="col-lg-12 col-md-12 col-sm-12">
										
							<!--  <div class="chart-container">
							<div class="chart" id="c3-line-regions-chart"></div>
						</div>	-->
						<div class="demo-container">
												<div id="chartContainer" style="height: 350px; width: 100%;"></div>
												<form action="InfluenceServlet" method="post">
													<div style="text-align: center; margin-bottom: 15px;">
														<div class="btn-group" role="group"
															aria-label="First group">
															<span id="spanform">
																<button type="submit" name="dayFreq"
																	class="btn btn-default btn-sm">Day</button>
																<button type="submit" name="weekFreq"
																	class="btn btn-default btn-sm">Week</button>
																<button type="submit" name="monthFreq"
																	class="btn btn-default btn-sm">Month</button>
																<button type="submit" name="yearFreq"
																	class="btn btn-default btn-sm">Year</button>
															</span>
														</div>
													</div>
												</form>
											</div>
								</div>
							</div>
								
							
										
																
							
							
							
							
							</div>
					</div>
					</div>
					<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Post<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<textarea disabled class="form-control" id="alert" rows="12"><c:out value="${inflBlogPost}" /></textarea>
                        
							</div>
						</div>
						
				<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Influencial Blog Post<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Post<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						
	
						<table class="table datatable-basic">
						<thead>
							<tr>
								<th>Blog Post Title</th>
								<th></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
						<tbody>
																	<c:set var="i" value="0" />
																	<c:set var="eo" value="1" />


																	<c:forEach items="${INFBlSc}" var="s12" begin="${i}">
																		<tr>
																			<th scope="row">${s12.title}</th>
																			<td style="display: none;">${s12.postContent}</td>
																			<td>
																				<button type="button" class="use-address btn btn-primary btn-rounded legitRipple">
																			<i class="icon-target"></i>
																		</button>
																			</td>
																			<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
																			
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
						<textarea disabled class="form-control" id="blogpostContent" rows="12"></textarea>
                        
							</div>
						</div>
					</div>
   
							</div>
						</div>
					
					</div>
					
					
					
					
					
									<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Bloggers Activity Vs Influence<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Bloggers Activity<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						
		<div id="my_words" 	style="height: 460px;"></div>
										</div>
					
   
							</div>
						</div>
						
						
						
						<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Influence<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						
                        <div class="demo-container">
												<div id="chartscatter" style="height: 460px;"></div>
											</div>
											
							</div>
						</div>
					</div>
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
	
	</div>
	<!-- /page container -->


	   <!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
	<!-- Dependencies -->
  <jsp:include page="pagedependencies/influence.jsp"></jsp:include>
  <!-- End of Dependencies -->
	
	
</body>
</html>
