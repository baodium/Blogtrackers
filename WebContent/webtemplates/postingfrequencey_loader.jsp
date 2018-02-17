<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*"%>
<%@page import="java.io.IOException"%>
<%@page import="java.text.*"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="blogtracker.gui.blogtrackers.*"%>
<%@page import="blogtracker.util.*"%>
<%@page import="wrapper.PostingFrequency"%>



<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>

<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
	
    ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
    
    
    //private static final long serialVersionUID = 1L;
	PostingFrequencyDialog pfDialog= new PostingFrequencyDialog();
	Common common= new Common();
	TrackerDialog trackerDialog = new TrackerDialog();
	BloggerInfoDialog biDialog= new BloggerInfoDialog();
	
	PostingFrequency freq = new PostingFrequency();

	//HttpSession session= request.getSession();

	if(request.getParameter("tracker")!=null){
		String tracker = request.getParameter("tracker");
		session.setAttribute("tracker", tracker);
		String userName = (String) session.getAttribute("user");
		String selectedSites=trackerDialog.getSelectedSites(userName,tracker);

		ArrayList<JSONObject> brNameList = biDialog.getBloggerNames(selectedSites);
		session.setAttribute("brNameList", brNameList);

		ArrayList<BeanAllSites> allSites=trackerDialog.getSiteNames(selectedSites);
		if(session.getAttribute("bsName")!=null)
			session.removeAttribute("bsName");
		session.setAttribute("allSepSites", allSites);
		//session.setAttribute("errorMessage",session.getAttribute("tracker") );
	}
	
	else if(request.getParameter("datepicked")!= null){	
		String date =request.getParameter("datepicked");
		session.setAttribute("datepicked", date);
		List<String> aa=common.returnDates(date);
		String scale=common.returnScale(aa);
		//session.setAttribute("errorMessage",aa );
		if(session.getAttribute("tracker")!=null){
			session.setAttribute("errorMessage", "");
			String userName = (String) session.getAttribute("user");
			String trackerName = (String) session.getAttribute("tracker");
			String datePicked = (String) session.getAttribute("datepicked");
			//session.setAttribute("errorMessage", userName);
			TrackerDialog dialog = new TrackerDialog();
			String selectedSites = dialog.getSelectedSites(userName,trackerName);
			
			//session.setAttribute("errorMessage",userName+ " "+trackerName );
			//freq.
			freq.getRequestedData(scale,selectedSites,datePicked,session);
			
		}
		else{
			session.setAttribute("errorMessage", "Please Select Tracker then Date");
		}
		
		
	}

	else if(request.getParameter("options")!=null){
		String scale=request.getParameter("options");
		System.out.println(request.getParameter("options"));

		session.setAttribute("calScale", scale);
		if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null){
			session.setAttribute("errorMessage", "");
			//				session.removeAttribute("errorMessage");


			String userName = (String) session.getAttribute("user");
			String trackerName = (String) session.getAttribute("tracker");
			String datePicked = (String) session.getAttribute("datepicked");
			TrackerDialog dialog= new TrackerDialog();
			String selectedSites=dialog.getSelectedSites(userName,trackerName);
			freq.getRequestedData(scale,selectedSites,datePicked,session);

		}
		else{
			session.setAttribute("errorMessage", "Please Select Tracker or Date");
		}

	}

%>

<% ArrayList mytrackers = new ArrayList();
mytrackers = (ArrayList)session.getAttribute("trackers");
int trackerSize = mytrackers.size();
    if(trackerSize == 0)
    {%>
    <c:redirect url="setup_tracker.jsp"/>	
  <% } %> 
<!-- Main charts -->
				<div class="row">
				<div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Posting Frequency Loaded<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
								<form name="dateform" id="dateform" method="post">
									<div data-intro="Select a date range " data-step="2" id="reportrange" action="PostingFrequency">
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					<b class="caret"></b>
									</button>
									<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" />
			                	</div>
								</form>
								</div>
							</div>
							<form name="pf_spanForm" id="pf_spanForm" action="PostingFrequency" method="post">
							<div class="panel-body" >
							
							<div class="col-lg-8 col-md-8 col-sm-12">
								<!--  <div class="chart-container">
							<div class="chart" id="c3-line-regions-chart"></div>
						     </div>	-->
							<div data-intro="Select a data point on the graph" data-step="3" class="demo-container">
												<div id="chartContainer" style="height: 350px"></div>
												<div data-intro="You can switch between day, weeek, month and year" data-step="4" style="text-align: center; margin-bottom: 15px;">
													<jsp:include page="../spanchecker.jsp"></jsp:include>
												
												</div>

											</div>
							</div>
							
					
								<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
		<div data-intro="Click on a blogger name to get additional blogger information" data-step="5" class="panel panel-default">
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
							<div class="row flex">
							<div class="col-md-6 col-sm-12 col-xs-12">
							<div class="col-md-12 col-sm-12 col-xs-12">
						<div data-intro="Click on the icon in front of the blog title to view blog content" data-step="6" class="panel panel-default">
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
					</div>
						
<div class="col-md-6 col-sm-12 col-xs-12">
<div class="col-md-12 col-sm-12 col-xs-12">
						<div data-intro="This section displays the blog content" data-step="7" class="panel panel-default">
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
						<div id="blogpost"></div>
                        
							</div>
						</div>
					</div>
					</div>
   </div>
							</div>
						</div>
					

						<div class="panel panel-primary">
							<div class="panel-heading">Keywords Vs Entities<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
						<div data-intro="This section displays the top keywords" data-step="8" class="panel panel-primary">
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

							<div class="panel-body scroll2">
						<div id="my_words_cloud" class="col-md-12 col-sm-12 col-xs-12"
										style="min-height: 335px;"></div>

   
							</div>
						</div>
					</div>
					
					
					
					
						<div class="col-md-6 col-sm-12 col-xs-12">
						<div data-intro="This section displays the top entities" data-step="9" class="panel panel-primary">
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

							<div class="panel-body scroll2" style="overflow-x:hidden;">
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
					</div>
					
					
					
				</div>
 <jsp:include page="../pagedependencies/postingfrequency.jsp"></jsp:include>