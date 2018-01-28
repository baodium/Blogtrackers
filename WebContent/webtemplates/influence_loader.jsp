

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.IOException"%>
<%@page import="java.text.*"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="blogtracker.gui.blogtrackers.*"%>
<%@page import="blogtracker.util.*"%>
<%@page import="javax.json.*"%>
<%@page import="java.sql.*"%>
<%@page import="javax.json.*"%>
<%@page import="java.time.*"%>
<%@page import="wrapper.InfluenceServlet"%>
<%@page import="blogtracker.util.Common"%>


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
	InfluenceServlet inf = new InfluenceServlet();
	InfluenceDialog iflDialog= new InfluenceDialog();
	Common ccommon= new Common();
	
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
	}
	else if(request.getParameter("datepicked")!= null){	
		String date =request.getParameter("datepicked");
		session.setAttribute("datepicked", date);
		List<String> aa=common.returnDates(date);
		String scale=common.returnScale(aa);
		if(session.getAttribute("tracker")!=null){
			session.setAttribute("errorMessage", "");
			String userName = (String) session.getAttribute("user");
			String trackerName = (String) session.getAttribute("tracker");
			String datePicked = (String) session.getAttribute("datepicked");
			TrackerDialog dialog= new TrackerDialog();
			String selectedSites=dialog.getSelectedSites(userName,trackerName);
			try{
			inf.getRequestedData(scale,selectedSites,datePicked,session);
			}catch(Exception ex){}
		}else{
			session.setAttribute("errorMessage", "Please Select Tracker then Date");
		}
	}

	else if(request.getParameter("infl_option")!=null){
		String scale=request.getParameter("infl_option");
		System.out.println(request.getParameter("infl_option"));

		session.setAttribute("inflCalScale", scale);
		if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null){
			session.setAttribute("errorMessage", "");
			//				session.removeAttribute("errorMessage");


			String userName = (String) session.getAttribute("user");
			String trackerName = (String) session.getAttribute("tracker");
			String datePicked = (String) session.getAttribute("datepicked");
			String selectedSites=trackerDialog.getSelectedSites(userName,trackerName);
			inf.getRequestedData(scale,selectedSites,datePicked,session);

		}
		else{
			session.setAttribute("errorMessage", "Please Select Tracker or Date");
		}

	}

	//		else if(request.getParameter("monthFreq")!=null || request.getParameter("dayFreq")!=null 
	//				|| request.getParameter("weekFreq")!=null || request.getParameter("yearFreq")!=null){
	//
	//			if(session.getAttribute("datepicked")!=null && session.getAttribute("tracker")!=null){
	//				session.setAttribute("errorMessage", "");
	//				String scale=null;
	//				if(request.getParameter("dayFreq")!=null){ scale="day"; }
	//				else if(request.getParameter("weekFreq")!=null){ scale="week"; }
	//				else if(request.getParameter("monthFreq")!=null){ scale="month"; }
	//				else if(request.getParameter("yearFreq")!=null){ scale="year"; }
	//
	//				String userName = (String) session.getAttribute("user");
	//				String trackerName = (String) session.getAttribute("tracker");
	//				String datePicked = (String) session.getAttribute("datepicked");
	//				String selectedSites=trackerDialog.getSelectedSites(userName,trackerName);
	//				getRequestedData(scale,selectedSites,datePicked,session);
	//
	//			}else{
	//				session.setAttribute("errorMessage", "Please Select Tracker or Date");
	//			}
	//
	//		}

	else if (request.getParameter("inflPost")!=null){
		String incomingName = request.getParameter("inflPost");
		System.out.println("onClick -"+incomingName);
		String type=(String) session.getAttribute("inflCalScale");
		String extractedDate=incomingName.substring(0, 15);
		String bloggerName=incomingName.substring(incomingName.lastIndexOf(')') + 2, incomingName.length());
		DateFormat df = new SimpleDateFormat("EEE MMM dd yyyy"); 
		DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd"); 
		Calendar c = Calendar.getInstance();
		Date date;
		String newStartDate = null;
		String newEndDate;
		try {
			date = df.parse(extractedDate);
			newStartDate = df1.format(date);
			c.setTime(df1.parse(newStartDate));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if(type.equalsIgnoreCase("day")){
			c.add(Calendar.DATE, 1);	
		}else if (type.equalsIgnoreCase("week")) {
			c.add(Calendar.DATE, 7);
		}else if (type.equalsIgnoreCase("month")) {
			c.add(Calendar.MONTH, 1);
		}else if (type.equalsIgnoreCase("year")) {
			c.add(Calendar.YEAR, 1);
		}
		newEndDate = df1.format(c.getTime()); 
		String userName = (String) session.getAttribute("user");
		String trackerName = (String) session.getAttribute("tracker");
		String selectedSites=trackerDialog.getSelectedSites(userName,trackerName);

		String inflBlogPost = iflDialog.getInfluentialPost(newStartDate, newEndDate, selectedSites, bloggerName);
		session.setAttribute("inflBlogPost", inflBlogPost);

	}else{
		String scatClickData = request.getParameter("scatterClick");
		String bloggerName=scatClickData.substring(1, scatClickData.indexOf("<"));

		String userName = (String) session.getAttribute("user");
		String trackerName = (String) session.getAttribute("tracker");
		String datePicked = (String) session.getAttribute("datepicked");
		String selectedSites=trackerDialog.getSelectedSites(userName,trackerName);

		//Common ccommon= new Common();
		List<String> aa=common.returnDates(datePicked);
		String d1 = aa.get(0);
		String d2 = aa.get(1);

		ArrayList<BeanTopKeywords> scatWordList=iflDialog.getTopKeywords(bloggerName,selectedSites,d1,d2); 
		System.out.println(scatWordList);
		session.setAttribute("scatWordList", scatWordList);
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
								
								<table data-intro="Select a blogger name to view additional blogger information" data-step="3" class="table ">
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
					<!-- 	<tr>
																			<td scope="row">Average</td>
																			<td></td>
																			<td>${topBScore}</td>
																			<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">
																		</tr> --!>
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
<jsp:include page="../pagedependencies/influence.jsp"></jsp:include>