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
			<div class="page-title">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Influence</span>

				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List </a></li>
					<li> <a href="analytics.jsp">Analytics</a></li>
					<li class="active">Influence (Current Tracker: <%=session.getAttribute("tracker")%>)</li>
				</ul>
			<!-- 	<div class="heading-elements">
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
	</div>
	<!-- /page header -->


	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">

			<!-- Main content -->
			<div class="content-wrapper" id="body-result">

				<!-- Main charts -->
				<div class="row">
				<div class="col-md-12">
						<div class="panel panel-primary">
							<div  class="panel-heading">
								<h6 class="panel-title">Influential Bloggers<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
								<form name="dateform" id="dateform" method="post">
									<div data-intro="Select a daterange" data-step="2" id="reportrange">
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					<b class="caret"></b> 
									</button>
									<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" />
			                	</div>
								</form>
								</div>
							</div>

							<div class="panel-body">
							<div class="col-lg-8 col-md-12 col-sm-12">
										
							<!--  <div class="chart-container">
							<div class="chart" id="c3-line-regions-chart"></div>
						</div>	-->
						<div data-intro="Select a data point on the graph" data-step="4" class="demo-container">
												<div id="chartContainer" style="height: 350px; width: 100%;"></div>
												<form action="InfluenceServlet" method="post">
													<div data-intro="Switch between day, week, month and year" data-step="5" style="text-align: center; margin-bottom: 15px;">
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
							<div class="col-lg-4 col-md-12 col-sm-12">
							
							<div data-intro="Click on a blogger name to get additional blogger information" data-step="5" class="panel panel-default">
							<div class="panel-heading">
								<h6 class="panel-title">Top Bloggers<a class="heading-elements-toggle"><i class="icon-more"></i></a><a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body scroll" style="height: 350px">					
								
								<table data-intro="Select a blogger name to view additional blogger information" data-step="3" class="table datatable-basic">
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
						</div>
   
																												
							</div>
					
							</div>
								
							
										
																
							
							
							
							
							</div>
					</div>
					</div>
					<div data-intro="This section shows blog post corresponding to the point of click" data-step="6" class="panel panel-primary">
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
						
				
						<div data-intro="This section displays the top entities" data-step="9" class="panel panel-primary">
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
							<div class="row flex">
							<div class="col-md-6 col-sm-12 col-xs-12">
							 <div class="col-md-12 col-sm-12 col-xs-12">
						<div  data-intro="Click on the icon in front of the blog title to view content" data-step="8" class="panel panel-default">
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

							<div class="panel-body scroll2">
						
	
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
						
																	<c:set var="i" value="0" />
																	<c:set var="eo" value="1" />


																	<c:forEach items="${INFBlSc}" var="s12" begin="${i}">
																		<tr>
																			<th scope="row">${s12.title}</th>
																			<td style="display: none;">${s12.postContent}</td>
																			<td>
																						<a class="use-address btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right">
														<span class="letter-icon icon-eye2"></span>
													</a>
																				
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
					</div>
						
<div class="col-md-6 col-sm-12 col-xs-12">
 <div class="col-md-12 col-sm-12 col-xs-12">
						<div  data-intro="This section displays the blog content" data-step="9" class="panel panel-default">
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

							<div class="panel-body scroll2">
						<div id="blogpostContent" rows="20"></div>
                        
							</div>
						</div>
						</div>
					</div>
					</div>
   
							</div>
						</div>
					
					
					
					
					
					
					
									
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
						<div  data-intro="Click on the point to view bloggers activity" data-step="10" class="panel panel-default">
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
					
					<div class="col-md-6 col-sm-12 col-xs-12">
						<div  data-intro="This section displays the bloggers activities" data-step="11" class="panel panel-default">
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
