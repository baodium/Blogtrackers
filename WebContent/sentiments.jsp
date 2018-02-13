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
<% ArrayList mytrackers = new ArrayList();
mytrackers = (ArrayList)session.getAttribute("trackers");
int trackerSize = mytrackers.size();
    if(trackerSize == 0)
    {%>
    
  <% } %>
  
  
<style>
	
				
.loader {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 9999;
	background: url('img/Loading.gif') 50% 50% no-repeat
		rgb(249, 249, 249);
}
</style>
   <script type="text/javascript">
$(window).load(function() {
	$(".loader").addClass("hidden");
	
})
</script>

				<script type="text/javascript">
									function showGif() {
									$(".loader").removeClass("hidden");
									}
</script>
	

	<!-- Page header -->
	<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Sentiments</span>
	<%-- <small class="display-block"><span>Welcome, </span><%=username %></small> --%>
				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List  </a></li>
					<li><a href="edittracker.jsp" title="Edit <%=session.getAttribute("tracker")%> Tracker"><%=session.getAttribute("tracker")%></a></li>
					<li><a href="analytics.jsp">Analytics</a></li>
						<li class="active">Sentiments</li>
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
	<div class="page-container mb-20">

		<!-- Page content -->
		<div class="page-content">

			<!-- Main content -->
			<div class="content-wrapper" id="body-result">

				<!-- Main charts -->
				<div class="row">
				<div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Timeline of Sentiments<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<form name="dateform" id="dateform" method="post" action="">
									<div class="heading-elements" data-intro="Select a daterange" data-step="2" id="reportrange" >
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					
									</button>
									<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" /><b class="caret"></b>
									
			                	</div>
								</form>
							</div>

							<div class="panel-body">
							
							<div class="col-lg-8 col-md-8 col-sm-12" data-intro="Select a datapoint on the graph" data-step="3">
							<!-- 	<div class="chart-container">
							  <div class="chart" id="c3-line-regions-chart"></div>
						</div>	-->		
						<div class="demo-container">

											<div id="chartContainer" style="height: 350px"></div>

											<div style="text-align: center; margin-bottom: 15px;">
												<br />


												<form name="pf_spanform" id="pf_spanform" action="Sentiments" method="post">
                                                  <jsp:include page="spanchecker.jsp"></jsp:include>
												</form>


												

												<form name="trendtype" id="trendtype" action="Sentiments"
													method="post">
													<c:choose>
														<c:when test="${radio eq 'aggregate'}">
															<input type="radio" name="aggr_norm" value="aggregate"
																checked="checked"> Aggregate 
															<input type="radio"  name="aggr_norm" value="normalized"
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
					
								<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12" data-intro="Select a Blogger Name" data-step="4">
		<div class="panel panel-default">
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

							<div class="panel-body scroll" style="height: 350px; overflow-x:hidden;">
						
<table class="table text-nowrap ">
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
						<div class="panel panel-default">
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
											<button  data-intro="Click the Go button to display the radar chart" data-step="6"  class="btn btn-primary" onclick="showGif()"
													type="submit" name="go">Go</button>
											</div>
	
						<table  data-intro="Click the check box" data-step="5"  id="sentitable" class="table datatable-basic bulk_action">
						<thead>
							<tr>
							<th></th>
								<th>Blog Post</th>
								
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
																							<!--  <label class="mylabel">
  <input class="mycheckbox individualcheckbox" name="table_records" type='checkbox'>
  <span class="myspan individualspan"></span></label> -->
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
						
<div  data-intro="Radar chart of personal content" data-step="7"  class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-default">
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
						<div data-intro="Radar chart of time orientation" data-step="8" class="panel panel-default">
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
						<div data-intro="Radar chart of core drive and need" data-step="9" class="panel panel-default">
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
						<div data-intro="Radar chart of cognitive process" data-step="10" class="panel panel-default">
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
						<div data-intro="Radar chart of summary variable" data-step="11" class="panel panel-default">
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
						<div data-intro="Radar chart of sentiment or emotion" data-step="12" class="panel panel-default">
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
