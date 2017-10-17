<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
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
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Posting Frequency</span>
			<small class="display-block"><span>Welcome, </span><%=username %> <font color="red">${errorMessage}</font>
			
				</h4>
			</div>
				<div class="heading-elements">
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
								<h6 class="panel-title">Posting Frequency<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<form name="dateform" id="dateform" method="post">
									<div class="heading-elements" id="reportrange" action="PostingFrequency">
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					<b class="caret"></b>
									</button>
									<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" />
			                	</div>
								</form>
							</div>
							<form name="pf_spanForm" id="pf_spanForm"
									action="PostingFrequency" method="post">
							<div class="panel-body">
							
							<div class="col-lg-8 col-md-8 col-sm-12">
								<!--  <div class="chart-container">
							<div class="chart" id="c3-line-regions-chart"></div>
						</div>	-->
							<div class="demo-container">
												<div id="chartContainer" style="height: 350px"></div>
												<div style="text-align: center; margin-bottom: 15px;">
													<jsp:include page="spanchecker.jsp"></jsp:include>
												
												</div>

											</div>
							</div>
							
					
								<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
		<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Top Bloggers<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body scroll" style="height: 350px">
						
<table class="table text-nowrap">
									<thead>
										<tr>
											<th>Blogger Name</th>
											
											<th>Blog Count</th>
										</tr>
									</thead>
									<tbody>
									<c:set var="i" value="0" />
														<c:set var="eo" value="1" />


														<c:forEach items="${topBloggers}" var="s1" begin="${i}">
										<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">B</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="<%=request.getContextPath()%>
																		/AdditionalBlogger?authorName=${s1.bloggerName}" class="letter-icon-title">${s1.bloggerName}</a>
													</div>

												</div>
											</td>
											
											<td>
												<h6 class="text-semibold no-margin">${s1.blogCount}</h6>
											</td>
										</tr>
											</c:forEach>

																		</tbody>
								</table>
   
							</div>
						</div>
					
				</div>				
							
							</div>
								
							</form>
										
																
							
							
							
							
							</div>
					</div>
					</div>
				<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Browser<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
						
	
						<table class="table datatable-basic" style="height: 335px;">
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


				<c:forEach items="${blogTitlePost}" var="s12" begin="${i}">
							<tr>
<td>${s12.blogTitle} </td>
 <td style="display:none;">${s12.blogContent}</td>
<td><a class="use-address btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right">
														<span class="letter-icon icon-eye2"></span>
													</a>	</td>
								<!--  <td class="hidden" width="0%"></td> -->
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
						<textarea disabled class="form-control" rows="20" id="blogpost"></textarea>
                        
							</div>
						</div>
					</div>
   
							</div>
						</div>
					
					</div>
							<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Top Keywords<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<div id="my_words_cloud" class="col-md-12 col-sm-12 col-xs-12"
										style="min-height: 335px;"></div>

   
							</div>
						</div>
					</div>
					
					
					
					
						<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Top Entities<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<table class="table datatable-basic" style="min-height:200px;">
						<thead>
							<tr>
								<th>Name</th>
								<th> Type</th>
								<th > Frequency</th>
								<th >Positive</th>
								<th>Negative</th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
						<c:set var="i" value="0" />
												<c:set var="eo" value="1" />


												<c:forEach items="${topEntity}" var="s1" begin="${i}">
							<tr>
								<td>${s1.entityName}</td>
														<td>${s1.entityType}</td>
														<td>${s1.entityFrequency}</td>
														<td>${s1.posSentiment}</td>
														<td>${s1.negSentiment}</td>
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
  <jsp:include page="pagedependencies/postingfrequency.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
