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
        //ArrayList userinfo = new DBConnector().query("SELECT *  FROM usercredentials WHERE UserName='"+username+"'");          
        //userinfo = (ArrayList)userinfo.get(0);
        //}catch(Exception e){
          //  response.sendRedirect("index.jsp");
        //}
        ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
%>

  <jsp:include page="include_top.jsp"></jsp:include>
 <% ArrayList mytrackers = new ArrayList();
mytrackers = (ArrayList) session.getAttribute("trackers");
int trackerSize = mytrackers.size();
%>
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
					<a href="<%=request.getContextPath()%>/trackerlist.jsp"><i class="icon-arrow-left52 position-left"></i></a>
					<span class="text-semibold">Analytics</span>
					
			
				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List  </a></li>
					<li><a href="edittracker.jsp" title="Edit <%=session.getAttribute("tracker")%> Tracker"><%=session.getAttribute("tracker")%></a></li>
					<li class="active">Analytics</li>
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
					<div class="col-md-4">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/Dashboard?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/dashboard.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel view overlay hm-red-strong">
							<div class="panel-body text-center">
								<div class="icon-object border-success text-success"><i class="icon-pie-chart8"></i></div>
								<h5 class="text-semibold">Dashboard</h5>
								<p class="mb-15">View Statistics such as Language Distribution </p>
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
								<p class="mb-15">Analyse the Posting Frequency of the Bloggers </p>
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
								<h5 class="text-semibold">Keyword Trend</h5>
								<p class="mb-15">Know the Trend of a Keyword</p>
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
								<p class="mb-15">Analyze the Sentiment of the Blogposts in the Tracker</p>
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
								<p class="mb-15">Analyse the Influence of Bloggers from Blogposts</p>
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
								<h5 class="text-semibold">Data Presentation</h5>
								<p class="mb-15">Export Your Tracker Information as a JSON</p>
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
<div class="col-md-4">
					<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/AdditionalInfoServlet?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/additional_blog_info.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-success text-success"><i class="icon-info22"></i></div>
								<h5 class="text-semibold">Additional Blog Information</h5>
								<p class="mb-15">Get Additional Blog Information</p>
								<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/AdditionalInfoServlet?tracker=${tracker}" class="btn bg-success-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Additional blog information"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/additional_blog_info.jsp" class="btn bg-success-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Additional blog information"> 
										</c:when>
										</c:choose>
								
								View Blog Information
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
											<a href="<%=request.getContextPath()%>/AdditionalBlogger?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/additional_blogger_info.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-warning text-warning"><i class="icon-user"></i></div>
								<h5 class="text-semibold">Additional Blogger information</h5>
								<p class="mb-15">Get Additional Blogger Information</p>
								<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/AdditionalBlogger?tracker=${tracker}" class="btn bg-warning-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Additional Blogger information"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/additional_blog_info.jsp" class="btn bg-warning-400 legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Additional Blogger information"> 
										</c:when>
										</c:choose>
								
								View Blogger Information
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
											<a href="<%=request.getContextPath()%>/BlogNetwork?tracker=${tracker}"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/blog_network.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-blue text-blue"><i class="icon-share3"></i></div>
								<h5 class="text-semibold">Blog Network</h5>
								<p class="mb-15">Get Information About the Network</p>
								<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/BlogNetwork?tracker=${tracker}" class="btn bg-blue legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Blog Network"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/blog_network.jsp" class="btn bg-blue legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Blog Network"> 
										</c:when>
										</c:choose>
								
								View Blog Network
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
											<a href="<%=request.getContextPath()%>/blog_clustering.jsp"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/blog_clustering.jsp.jsp"> 
										</c:when>
					</c:choose>
						<div class="panel">
							<div class="panel-body text-center">
								<div class="icon-object border-success text-success"><i class="icon-share3"></i></div>
								<h5 class="text-semibold">Blog Clustering</h5>
								<p class="mb-15">Analyze Group of Network</p>
								<c:choose>
										<c:when test="${tracker != null}">
											<a href="<%=request.getContextPath()%>/blog_clustering.jsp" class="btn bg-success legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Blog Clustering"> 
										</c:when>
										<c:when test="${tracker == null}">
											<a href="<%=request.getContextPath()%>/blog_clustering.jsp" class="btn bg-success legitRipple" data-popup="tooltip" title="" data-container="body" data-original-title="Blog Clustering"> 
										</c:when>
										</c:choose>
								
								View Blog Clusters
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
