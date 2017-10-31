<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="authentication.DBConnector"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
        
        //try{
        ArrayList userinfo = new DBConnector().query("SELECT *  FROM usercredentials WHERE UserName='"+username+"'");          
        userinfo = (ArrayList)userinfo.get(0);
        //}catch(Exception e){
          //  response.sendRedirect("index.jsp");
        //}
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
        <style>
            input[type="file"] {
    display: block;
}

.btn-file > input {
    position: absolute;
    top: 0;
    right: 0;
    margin: 0;
    opacity: 0;
    filter: alpha(opacity=0);
    font-size: 23px;
    direction: ltr;
    border:1px solid #ccc !important;
    cursor: pointer;
}
 .fileinput-exists .fileinput-new, .fileinput-new .fileinput-exists {
    display: none;
}

.btn{
    margin:5px;
}
.fileinput .btn {
    vertical-align: middle;
}

.btn-orange {
    color: #ffffff;
    background-color: #ff9600;
    border-color: #ff9600;
}

.btn-white {
    color: #303641;
    background-color: #ffffff;
    border-color: #ffffff;
    border-color: #ebebeb;
}

.fileinput .btn {
    vertical-align: middle;
}

.btn-white {
    color: #303641;
    background-color: #ffffff;
    border-color: #ccc;
    border-color: #ebebeb;
} 
        </style>
	<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Analytics</span>
					
			
				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List </a></li>
					<li class="active">Analytics (Current Tracker: <%=session.getAttribute("tracker")%>)</li>
				</ul>
			</div>

				<!--  <div class="heading-elements">
				<div class="heading-btn-group">
					<button type="button" onclick="location.href='setup_tracker.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-cross"></i></b>Tracker Name: <%=session.getAttribute("username")%></button>
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
				
				
					<div class="col-lg-2 col-md-6">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/Dashboard?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/dashboard.jsp"> 
										</c:when>
					</c:choose>
					
						<div class="thumbnail">
							<div class="thumb thumb-slide">
								<img src="img/dashboard.jpg" alt="">
								<div class="caption">
									<span style="font-size: 18px;">
									Check the dashboard statistics of your tracker
								   </span>
								</div>
							</div>
						
					    	<div class="caption text-center">
					    		<h6 class="text-semibold no-margin">Dashboard
<!--					    		<small class="display-block">Network engineer</small>-->
					    		
					    		</h6>
				    			<ul class="icons-list mt-15">
			                    	<li>
			                    	<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/Dashboard?tracker=${tracker}" data-popup="tooltip" title="" data-container="body" data-original-title="Dashboard"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/dashboard.jsp" data-popup="tooltip" title="" data-container="body" data-original-title="Dashboard"> 
										</c:when>
										</c:choose>
			                    	
			                    	<button type="button" class="btn btn-primary btn-icon btn-float btn-float-lg btn-rounded legitRipple"><i class="icon-pie-chart8"></i></button>
			                    	<c:choose>
										<c:when test="${tracker != null}">
			                    	</a>
			                    	</c:when>
			                    		<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
										</c:choose>
			                    	</li>
			                    	
		                    	</ul>
					    	</div>
				    	</div>
				    	<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>
				
						<div class="col-lg-2 col-md-6">
						<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/PostingFrequency?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/posting_frequencey.jsp"> 
										</c:when>
					</c:choose>
						<div class="thumbnail">
							<div class="thumb thumb-slide">
								<img src="img/postingfrequency.jpg" alt="">
								<div class="caption">
									<span style="font-size: 18px;">
									Check the frequency of a particular blog post and analyze some basic Information
								   </span>
								</div>
							</div>
						
					    	<div class="caption text-center">
					    		<h6 class="text-semibold no-margin">Posting Frequency 
<!--					    		<small class="display-block">Network engineer</small>-->
					    		
					    		</h6>
				    			<ul class="icons-list mt-15">
			                    	<li>
			                    	<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/PostingFrequency?tracker=${tracker}" data-popup="tooltip" title="" data-container="body" data-original-title="Posting Frequency"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/posting_frequencey.jsp" data-popup="tooltip" title="" data-container="body" data-original-title="Posting Frequency"> 
										</c:when>
										</c:choose>
			                    	<button type="button" class="btn btn-primary btn-icon btn-float btn-float-lg btn-rounded legitRipple"><i class="icon-comment"></i></button>
			                    	<c:choose>
										<c:when test="${tracker != null}">
			                    	</a>
			                    	</c:when>
			                    		<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
										</c:choose>
			                    	
			                    	</li>
			                    	
		                    	</ul>
					    	</div>
				    	</div>
				    	<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>
							
							<div class="col-lg-2 col-md-6">
							<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/KeywordTrendsServlet?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/keyword_trends.jsp"> 
										</c:when>
					</c:choose>
						<div class="thumbnail">
							<div class="thumb thumb-slide">
								<img src="img/keywords.jpg" alt="">
								<div class="caption">
									<span style="font-size: 18px;">
									Analyze the keyword trends in blogs on your trackers
								   </span>
								</div>
							</div>
						
					    	<div class="caption text-center">
					    		<h6 class="text-semibold no-margin">Keyword Trends
<!--					    		<small class="display-block">Network engineer</small>-->
					    		
					    		</h6>
				    			<ul class="icons-list mt-15">
			                    	<li>
			                    	<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/KeywordTrendsServlet?tracker=${tracker}" data-popup="tooltip" title="" data-container="body" data-original-title="Keyword Trends"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/keyword_trends.jsp" data-popup="tooltip" title="" data-container="body" data-original-title="Posting Frequency"> 
										</c:when>
										</c:choose>
			                    	<button type="button" class="btn btn-primary btn-icon btn-float btn-float-lg btn-rounded legitRipple"><i class="icon-search4"></i></button>
			                    	<c:choose>
										<c:when test="${tracker != null}">
			                    	</a>
			                    	</c:when>
			                    		<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
										</c:choose>
			                    	
			                    	</li>
			                    	
		                    	</ul>
					    	</div>
				    	</div>
				    	<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>
					
					
					
					
					<div class="col-lg-2 col-md-6">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/Sentiments?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/sentiments.jsp"> 
										</c:when>
					</c:choose>
						<div class="thumbnail">
							<div class="thumb thumb-slide">
								<img src="img/sentiments.jpg" alt="">
								<div class="caption">
									<span style="font-size: 18px;">
									Analyze the positive and the negative sentiments in blogsites
								   </span>
								</div>
							</div>
						
					    	<div class="caption text-center">
					    		<h6 class="text-semibold no-margin">Sentiments
<!--					    		<small class="display-block">Network engineer</small>-->
					    		
					    		</h6>
				    			<ul class="icons-list mt-15">
			                    	<li>
			                    	<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/Sentiments?tracker=${tracker}" data-popup="tooltip" title="" data-container="body" data-original-title="Sentiments"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/sentiments.jsp" data-popup="tooltip" title="" data-container="body" data-original-title="Sentiments"> 
										</c:when>
										</c:choose>
			                    	
			                    	<button type="button" class="btn btn-primary btn-icon btn-float btn-float-lg btn-rounded legitRipple"><i class="icon-puzzle3"></i></button>
			                    	<c:choose>
										<c:when test="${tracker != null}">
			                    	</a>
			                    	</c:when>
			                    		<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
										</c:choose>
			                    	
			                    	</li>
			                    	
		                    	</ul>
					    	</div>
				    	</div>
				    		<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>
					
					
					<div class="col-lg-2 col-md-6">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/InfluenceServlet?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/influence.jsp"> 
										</c:when>
					</c:choose>
						<div class="thumbnail">
							<div class="thumb thumb-slide">
								<img src="img/influencers.jpg" alt="">
								<div class="caption">
									<span style="font-size: 18px;">
									Analyze the influence on different blog sites on your tracker	
								   </span>
								</div>
							</div>
						
					    	<div class="caption text-center">
					    		<h6 class="text-semibold no-margin">Influence
<!--					    		<small class="display-block">Network engineer</small>-->
					    		
					    		</h6>
				    			<ul class="icons-list mt-15">
			                    	<li>
			                    	
			                    	<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/InfluenceServlet?tracker=${tracker}" data-popup="tooltip" title="" data-container="body" data-original-title="Influence"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/influence.jsp" data-popup="tooltip" title="" data-container="body" data-original-title="Influence"> 
										</c:when>
										</c:choose>
										
			                    	<button type="button" class="btn btn-primary btn-icon btn-float btn-float-lg btn-rounded legitRipple"><i class="icon-split"></i></button>
			                    	<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
			                    	</li>
			                    	
		                    	</ul>
					    	</div>
				    	</div>
				    	<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>
					
					
					<div class="col-lg-2 col-md-6">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/ExportJSON?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/data_presentation.jsp"> 
										</c:when>
					</c:choose>
						<div class="thumbnail">
							<div class="thumb thumb-slide">
								<img src="img/datapresentation.jpg" alt="">
								<div class="caption">
									<span class="text-size-large" style="font-size: 18px;">
									Export data in a JSON format for analysis purpose
								   </span>
								</div>
							</div>
						
					    	<div class="caption text-center">
					    		<h6 class="text-semibold no-margin">Data Presentation
<!--					    		<small class="display-block">Network engineer</small>-->
					    		
					    		</h6>
				    			<ul class="icons-list mt-15">
			                    	<li>
			                    	<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/ExportJSON?tracker=${tracker}" data-popup="tooltip" title="" data-container="body" data-original-title="Data Presentation"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/data_presentation.jsp" data-popup="tooltip" title="" data-container="body" data-original-title="Data Presentation"> 
										</c:when>
										</c:choose>
			                    	<button type="button" class="btn btn-primary btn-icon btn-float btn-float-lg btn-rounded legitRipple"><i class="icon-database-export"></i></button>
			                    		<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
			                    	</li>
			                    	
		                    	</ul>
					    	</div>
				    	</div>
				    		<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>


				
					
					</div>
			
				      
					
				</div>
				
				
				<div class="row">
					<div class="col-md-4">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/Dashboard?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/dashboard.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-success text-success"><i class="icon-pie-chart8"></i></div>
								<h5 class="text-semibold">Dashboard</h5>
								<p class="mb-15">Analyze the Dashboard Statistics</p>
								<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/Dashboard?tracker=${tracker}" class="btn bg-success-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Dashboard">
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/dashboard.jsp" class="btn bg-success-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Dashboard">
										</c:when>
										</c:choose>
										View Dashboard 
								<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
							</div>
						</div>
						<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>
					
					<div class="col-md-4">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/PostingFrequency?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/posting_frequencey.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-warning text-warning"><i class="icon-comment"></i></div>
								<h5 class="text-semibold">Posting Frequency</h5>
								<p class="mb-15">Analyse the posting frequency</p>
								<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/PostingFrequency?tracker=${tracker}" class="btn bg-warning-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Posting Frequency">
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/posting_frequencey.jsp" class="btn bg-warning-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Posting Frequency"> 
										</c:when>
										</c:choose>
										View Posting Frequency 
								<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
							</div>
						</div>
						<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>
              <div class="col-md-4">
              	<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/KeywordTrendsServlet?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/keyword_trends.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-blue text-blue"><i class="icon-search4"></i></div>
								<h5 class="text-semibold">Keyword trend</h5>
								<p class="mb-15">Know the trend of a keyword</p>
								<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/KeywordTrendsServlet?tracker=${tracker}" class="btn bg-blue legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Keyword Trends">
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/keyword_trends.jsp" data-popup="tooltip"  class="btn bg-blue legitRipple"title="" data-container="body" data-original-title="Keyword Trends"> 
										</c:when>
										</c:choose>
								View Keywords Trend 
								<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
							</div>
						</div>
						<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>
					<div class="col-md-4">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/Sentiments?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/sentiments.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-success text-success"><i class="icon-puzzle3"></i></div>
								<h5 class="text-semibold">Sentiments Analysis</h5>
								<p class="mb-15">Analyze the sentiment in a text</p>
								<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/Sentiments?tracker=${tracker}" class="btn bg-success-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Sentiments"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/sentiments.jsp" class="btn bg-success-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Sentiments"> 
										</c:when>
										</c:choose>
								
								View Sentiment
								<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
							</div>
						</div>
						<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>
					<div class="col-md-4">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/InfluenceServlet?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/influence.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-warning text-warning"><i class="icon-split"></i></div>
								<h5 class="text-semibold">Influence</h5>
								<p class="mb-15">Analyse the influence of text</p>
								<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/InfluenceServlet?tracker=${tracker}" class="btn bg-warning-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Influence"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/influence.jsp" class="btn bg-warning-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Influence"> 
										</c:when>
										</c:choose>
								View Influence
								<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
							</div>
						</div>
						<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
					</div>
					
					<div class="col-md-4">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/ExportJSON?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/data_presentation.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-blue text-blue"><i class="icon-database-export"></i></div>
								<h5 class="text-semibold">Data presentation</h5>
								<p class="mb-15">Export your work</p>
								<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/ExportJSON?tracker=${tracker}"  class="btn bg-blue legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Data Presentation"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/data_presentation.jsp"  class="btn bg-blue legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Data Presentation"> 
										</c:when>
										</c:choose>
								Export JSON
								<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
							</div>
						</div>
						<c:choose>
										<c:when test="${tracker != null}">
				    	</a>
				    	</c:when>
				    		<c:when test="${tracker == null}">
				    	</a>
				    	</c:when>
										</c:choose>
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
  <jsp:include page="pagedependencies/analytics.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
