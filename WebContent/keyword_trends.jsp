<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>

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
	else
	{
        ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
	}
%>

 <jsp:include page="include_top.jsp"></jsp:include>


	<!-- Page header -->
	<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<a href="<%=request.getContextPath()%>/analytics.jsp"><i class="icon-arrow-left52 position-left"></i></a>
					<span class="text-semibold">Keyword Trends</span>

				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right mb-20">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List </a><a href="edittracker.jsp" title="Edit <%=session.getAttribute("tracker")%> Tracker">(<%=session.getAttribute("tracker")%>)</a></li>
					<li> <a href="analytics.jsp">Analytics</a></li>
					<li class="active">Keyword Trends </li>
				</ul>
		
				<form name="tagform" id="tagform" action="KeywordTrendsServlet" method="post">
				<div  class="form-group ">
				<!-- <div class="col-md-12 mb-20"> -->
				
				<div data-intro="Enter a keyword to search and press enter key or click the search button" data-step="2" class="input-group">
				<c:choose>
				<c:when test="${tags != null}">
				<input type="text" class="form-control" name="searchText" id="searchBar" placeholder="${tags}"
															onkeyup="searchTextVerify()" autocomplete="off">
				</c:when>
				<c:when test="${tags == null}">
				<input type="text" class="form-control" name="searchText" id="searchBar" placeholder="Enter a keyword to Search"
															onkeyup="searchTextVerify()" autocomplete="off">
					</c:when>
												</c:choose>											
											<span class="input-group-btn" style="padding-left:0px;"><button type="submit" class="btn btn-primary" name="searchButton" id="searchButton">Search</button></span>
											
										</div>
										<!-- </div> -->
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
			<div class="content-wrapper" id="body-result" >

				<!-- Main charts -->
				<div class="row">
				<div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Keyword Trendline<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<form name="dateform" id="dateform" method="post" 	>
									<div data-intro="Select a date range" data-step="3" class="heading-elements" id="reportrange" >
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					<b class="caret"></b>
									</button>
									<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" />
			                	</div>
								</form>
							</div>

							<div class="panel-body">
							
					<div class="col-lg-12 col-md-12 col-sm-12">
										
							<!-- <div class="chart-container">
							<div class="chart" id="c3-line-regions-chart"></div>
						</div>	-->
																		<div data-intro="Click on a datapoint on the graph" data-step="4" class="demo-container">
													<div id="chartContainer" style="height: 350px;"></div>
													<div data-intro="Switch between day, week, month and year" data-step="5" style="text-align: center; margin-bottom: 15px;">
														<form name="kt_spanform" id="kt_spanform" action="KeywordTrendsServlet"
																method="post">
														<%
															Object span = (null == session.getAttribute("kt_span")) ? "" : session.getAttribute("kt_span");
															if (span != null && (span.toString()).equalsIgnoreCase("month")) {
														%>

														<div class="btn-group colors" role="group"
															aria-label="First group" data-toggle="buttons">
															<label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="day"
																autocomplete="off" onchange="spanChanged()"> Day
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="week"
																autocomplete="off" onchange="spanChanged()">
																Week
															</label> <label class="btn btn-default btn-sm active"> <input
																type="radio" name="options" value="month"
																autocomplete="off" checked onchange="spanChanged()">
																Month
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="year"
																autocomplete="off" onchange="spanChanged()">
																Year
															</label>
														</div>
														<%
															} else if (span != null && (span.toString()).equalsIgnoreCase("day")) {
														%>
														<div class="btn-group colors" data-toggle="buttons">
															<label class="btn btn-default btn-sm active"> <input
																type="radio" name="options" value="day"
																autocomplete="off" checked onchange="spanChanged()">
																Day
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="week"
																autocomplete="off" onchange="spanChanged()">
																Week
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="month"
																autocomplete="off" onchange="spanChanged()">
																Month
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="year"
																autocomplete="off" onchange="spanChanged()">
																Year
															</label>
														</div>
														<%
															} else if (span != null && (span.toString()).equalsIgnoreCase("year")) {
														%>
														<div class="btn-group colors" data-toggle="buttons">
															<label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="day"
																autocomplete="off" onchange="spanChanged()"> Day
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="week"
																autocomplete="off" onchange="spanChanged()">
																Week
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="month"
																autocomplete="off" onchange="spanChanged()">
																Month
															</label> <label class="btn btn-default btn-sm active"> <input
																type="radio" name="options" value="year"
																autocomplete="off" checked onchange="spanChanged()">
																Year
															</label>
														</div>
														<%
															} else if (span != null && (span.toString()).equalsIgnoreCase("week")) {
														%>

														<div class="btn-group colors" data-toggle="buttons">
															<label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="day"
																autocomplete="off" onchange="spanChanged()"> Day
															</label> <label class="btn btn-default btn-sm active"> <input
																type="radio" name="options" value="week"
																autocomplete="off" checked onchange="spanChanged()">
																Week
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="month"
																autocomplete="off" onchange="spanChanged()">
																Month
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="year"
																autocomplete="off" onchange="spanChanged()">
																Year
															</label>
														</div>
														<%
															} else {
														%>
														<div class="btn-group colors" data-toggle="buttons">
															<label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="day"
																autocomplete="off" onchange="spanChanged()"> Day
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="week"
																autocomplete="off" onchange="spanChanged()">
																Week
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="month"
																autocomplete="off" onchange="spanChanged()">
																Month
															</label> <label class="btn btn-default btn-sm"> <input
																type="radio" name="options" value="year"
																autocomplete="off" onchange="spanChanged()">
																Year
															</label>
														</div>

														<%
															}
														%>
													</form>

														<!-- <div class="btn-group" role="group" aria-label="First group">
															<form name="spanform" id="spanform" action="KeywordTrendsServlet"
																method="post">
																<button type="submit" name="spandaily" value="daily"
																	id="addDataPoint" class="btn btn-default btn-sm">Day</button>
																<button type="submit" name="spanweekly" value="weekly"
																	class="btn btn-default btn-sm">Week</button>
																<button type="submit" name="spanmonthly" value="monthly"
																	class="btn btn-default btn-sm">Month</button>
																<button type="submit" name="spanyearly" value="yearly"
																	class="btn btn-default btn-sm">Year</button>
															</form>
														 </div> -->
														<div id="chartpoint">
															<form name="xyform" id="xyform"
																action="KeywordTrendsServlet" method="post">
																<input id="xychange" name="xychange" type="hidden"
																	onchange="xychanged()">
															</form>
														</div>

													</div>


												</div>
						
								</div>
							</div>
								
							
										
																
							
							
							
							
							</div>
					</div>
					</div>
				
						
				
						<div data-intro="Click on the icon in front of the blog title to view blog content" data-step="6" class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blog <Browser></Browser><a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
						<div class="panel panel-default">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Post<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								
							</div>

							<div class="panel-body scroll2">
						
	                  
						<table class="table datatable-basic">
						<thead>
							<tr>
								<th>Blog Post Title</th>
								<th class="hidden" width="0%"></th>
								<th ></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
						
						<c:set var="i" value="0" />
															<c:set var="eo" value="1" />
															<c:forEach items="${key_names}" var="s" begin="${i}">
																<tr>
																	<td ><c:out value="${s[1]}" /></td>
																	<td style="display:none;"><c:out value="${s[2]}" /></td>
																	<td>
																		<a class="use-address btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right">
														<span class="letter-icon icon-eye2"></span>
													</a>
																	</td>
																	<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
																	
																																	</tr>
																<c:set var="i" value="${i+1}" />
															</c:forEach>
															
							
							</tbody>
							</table>
							
   
							</div>
						</div>
						</div>
					</div>
						
						
                      <div class="col-md-6 col-sm-12 col-xs-12">
                      <div class="col-md-12 col-sm-12 col-xs-12">
						<div data-intro="This section displays the blog content" data-step="7" class="panel panel-default">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Content<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								
							</div>

							<div class="panel-body scroll2">
						<div id="blogpost" ></div>
                        
							</div>
						</div>
						</div>
					</div>
					
					</div>
					
					
   
							</div>
						</div>
					
					
					<div data-intro="This section displays the entity network" data-step="8" class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Entity Network<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
												<div id="mynetwork" style="height: 400px"></div>
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
  <jsp:include page="pagedependencies/keywordtrend.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
