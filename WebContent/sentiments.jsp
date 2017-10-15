<%-- 
    Document   : Sentiment Analysis
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					<span class="text-semibold">Sentiments</span>
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
								<h6 class="panel-title">Timeline of Sentiments<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<form name="dateform" id="dateform" method="post">
									<div class="heading-elements" id="reportrange" >
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					
									</button>
									<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" /><b class="caret"></b>
									
			                	</div>
								</form>
							</div>

							<div class="panel-body">
							
							<div class="col-lg-8 col-md-8 col-sm-12">
							<!-- 	<div class="chart-container">
							  <div class="chart" id="c3-line-regions-chart"></div>
						</div>	-->		
																<div class="demo-container">

											<div id="chartContainer" style="height: 350px"></div>

											<div style="text-align: center; margin-bottom: 15px;">
												<br />


												<form name="st_spanform" id="st_spanform"
													action="Sentiments" method="post">

													<%
														Object span = (null == session.getAttribute("st_span")) ? "" : session.getAttribute("st_span");
														if (span != null && (span.toString()).equalsIgnoreCase("month")) {
													%>

													<div class="btn-group colors" data-toggle="buttons">
														<label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="day"
															autocomplete="off" onchange="spanChanged()"> Day
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="week"
															autocomplete="off" onchange="spanChanged()"> Week
														</label> <label class="btn btn-default btn-sm active"> <input
															type="radio" name="options" value="month"
															autocomplete="off" checked onchange="spanChanged()">
															Month
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="year"
															autocomplete="off" onchange="spanChanged()"> Year
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
															autocomplete="off" onchange="spanChanged()"> Week
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="month"
															autocomplete="off" onchange="spanChanged()">
															Month
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="year"
															autocomplete="off" onchange="spanChanged()"> Year
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
															autocomplete="off" onchange="spanChanged()"> Week
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
															autocomplete="off" onchange="spanChanged()"> Year
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
															autocomplete="off" onchange="spanChanged()"> Week
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="month"
															autocomplete="off" onchange="spanChanged()">
															Month
														</label> <label class="btn btn-default btn-sm"> <input
															type="radio" name="options" value="year"
															autocomplete="off" onchange="spanChanged()"> Year
														</label>
													</div>

													<%
														}
													%>

												</form>


												<!-- <div class="btn-group" role="group" aria-label="First group">
													<form name="spanform" id="spanform" action="Sentiments" method="post">
														<button type="submit" name="spandaily" value="daily" id="addDataPoint"
															class="btn btn-default btn-sm">Day</button>
														<button type="submit" name="spanweekly" value="weekly"
															class="btn btn-default btn-sm">Week</button>
														<button type="submit" name="spanmonthly" value="monthly"
															class="btn btn-default btn-sm">Month</button>
														<button type="submit" name="spanyearly" value="yearly"
															class="btn btn-default btn-sm">Year</button>
													</form>
													<br/>
												</div> -->

												<form name="trendtype" id="trendtype" action="Sentiments"
													method="post">
													<c:choose>
														<c:when test="${radio eq 'aggregate'}">
															<input type="radio" name="aggr_norm" value="aggregate"
																checked="checked"> Aggregate 
															<input type="radio" name="aggr_norm" value="normalized"
																onchange="aggr_norm_changed()"> Normalized
													    </c:when>
														<c:otherwise>

															<input type="radio" name="aggr_norm" value="aggregate"
																onchange="aggr_norm_changed()"> Aggregate 
															<input type="radio" name="aggr_norm" value="normalized"
																checked="checked"> Normalized
													    
    												</c:otherwise>
													</c:choose>
												</form>


												<div id="chartpoint">
													<form name="xyform" id="xyform" action="Sentiments"
														method="post">
														<input id="xychange" name="xychange" type="hidden"
															onchange="xychanged()">
													</form>
												</div>

											</div>

										</div>			
							</div>
					
								<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
		<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Blogger Name<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
											
										</tr>
									</thead>
									<tbody>
										<c:set var="i" value="0" />
													<c:set var="eo" value="1" />
										<c:forEach items="${bloggers}" var="s1" begin="${i}">			
										<tr>
											<td>
												<div class="media-left media-middle">
													<a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple">
														<span class="letter-icon">B</span>
													</a>
												</div>

												<div class="media-body">
													<div class="media-heading">
														<a href="<%=request.getContextPath()%>/AdditionalBlogger?authorName=${s1}" class="letter-icon-title">${s1}</a>
													</div>

													
												</div>
											</td>
											
											
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
				<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Sentiments<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							<div class="col-md-12 col-sm-12 col-xs-12">
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
<form action="Sentiments" method="post">
							<div class="panel-body">
						<div style="margin-top: auto;">
											<button class="btn btn-primary" onclick="showGif()"
													type="submit" name="go">Go</button>
											</div>
	
						<table id="sentitable" class="table datatable-basic bulk_action">
						<thead>
							<tr>
							<th>
							<label class="mylabel">
  <input class="mycheckbox individualcheckbox" type='checkbox'>
  <span class="myspan individualspan"></span></label>
							<input type="checkbox" id="check-all" class="flat"></th>
								<th>Select All</th>
								
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
						<c:set var="i" value="0" />
																			<c:set var="eo" value="1" />
																			<c:forEach items="${names}" var="s1" begin="${i}">
																				<c:if test="${eo==1 || eo%2 ==1 }">
																					<tr class="odd pointer">
																						<c:forEach items="${names}" var="s1" begin="${i}"
																							end="${i}">
																							<td class="a-center ">
																							<label class="mylabel">
  <input class="mycheckbox individualcheckbox" name="table_records" type='checkbox'>
  <span class="myspan individualspan"></span></label>
																							<input type="checkbox"
																								class="flat" name="table_records"
																								value="${s1[1]}"></td>
																							<td class=" " value="${s1[0]}"><c:out
																									value="${s1[0]}" /></td>
																									<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>

																						</c:forEach>
																					</tr>
																					<c:set var="i" value="${i+1}" />
																				</c:if>
																				<c:if test="${eo%2 ==0}">
																					<tr class="even pointer">
																						<c:forEach items="${names}" var="s1" begin="${i}"
																							end="${i}">
																							<td class="a-center "><input type="checkbox"
																								class="flat" name="table_records"></td>
																							<td class=" " value="${s1[0]}"><c:out
																									value="${s1[0]}" /></td>
																									<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
																						</c:forEach>
																					</tr>
																					<c:set var="i" value="${i+1}" />
																				</c:if>
																				<c:set var="eo" value="${eo+2}" />
																			</c:forEach>
							
							</tbody>
							</table>
   
							</div>
							</form>
						</div>
					</div>
						
<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Personal Content<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<small><span
																				class="glyphicon glyphicon-info-sign"
																				data-toggle="tooltip"
																				data-original-title="Work -job, majors, xerox  &nbsp&nbsp&nbsp
																									Leisure - cook, chat, movie &nbsp&nbsp&nbsp
																									Home - kitchen, landlord &nbsp&nbsp&nbsp &nbsp&nbsp
																									Money - audit, cash, owe &nbsp&nbsp&nbsp
																									Religion - altar, church &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
																									Death - bury, coffin, kill"></span>
																									</small>
																									<div class="x_content">
																			<canvas id="canvasRadar"></canvas>
																		</div>
                        
							</div>
						</div>
					</div>
					
					<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Time Orientation<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						
                        <small><span
																				class="glyphicon glyphicon-info-sign"
																				data-toggle="tooltip"
																				data-original-title="Past Focus - ago, did, talked 
																								Present focus - today, is, now 
																								Future focus - may, will, soon"></span>
																			</small>
																			<div class="x_content">
																			<canvas id="canvasRadar1"></canvas>
																		</div>
							</div>
						</div>
					</div>
					
					<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Core Drive and Need<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<small><span
																				class="glyphicon glyphicon-info-sign"
																				data-toggle="tooltip"
																				data-original-title="Core Drives and Needs &nbsp&nbsp&nbsp
																										Affiliation - ally, friend, social 
																										Achievement - win, success, better 
																										Power - superior, bully &nbsp&nbsp&nbsp
																										Reward - take, prize, benefit &nbsp&nbsp&nbsp
																										Risk - danger, doubt"></span>
																			</small>
																			<div class="x_content">
																			<canvas id="canvasRadar2"></canvas>
																		</div>
                        
							</div>
						</div>
					</div>
					
					
					<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Cognitive Process<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<small><span
																				class="glyphicon glyphicon-info-sign"
																				data-toggle="tooltip"
																				data-original-title="Insight - think, know &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
																							Causation - because, effect &nbsp&nbsp&nbsp
																							Discrepancy - should, would &nbsp&nbsp&nbsp
																							Tentative - maybe, perhaps &nbsp&nbsp&nbsp
																							Certainty - always, never &nbsp&nbsp&nbsp
																							Differentiation - hasn’t, but, else"></span>
																			</small>
																			<div class="x_content">
																			<canvas id="canvasRadar3"></canvas>
																		</div>
                        
							</div>
						</div>
					</div>
					
					<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Summary Variable<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<small><span
																				class="glyphicon glyphicon-info-sign"
																				data-toggle="tooltip"
																				data-original-title="no examples available"></span>
																			</small>
																			<div class="x_content">
																			<canvas id="canvasRadar4"></canvas>
																		</div>
                        
							</div>
						</div>
					</div>
					
					
					<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Sentiment/Emotion<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<small><span
																				class="glyphicon glyphicon-info-sign"
																				data-toggle="tooltip"
																				data-original-title="Positive emotion- love,nice,sweet &nbsp&nbsp&nbsp&nbsp
																									Negative emotion - hurt, ugly, nasty 
																									Anxiety - worried, fearful &nbsp&nbsp&nbsp
																									Anger - hate, kill, annoyed &nbsp&nbsp&nbsp
																									Sadness - crying, grief, sad"></span>
																			</small>
																			<div class="x_content">
																			<canvas id="canvasRadar5"></canvas>
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
	
	
	<!-- /page container -->


	   <!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
	<!-- Dependencies -->
  <jsp:include page="pagedependencies/sentiments.jsp"></jsp:include>
  <!-- End of Dependencies -->
  
</body>
</html>
