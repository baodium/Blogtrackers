<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@page import="java.util.*"%>
<%
	Object username = (null == session.getAttribute("user")) ? "" : session.getAttribute("user");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	String tracker = (null == session.getAttribute("tracker")) ? "" : session.getAttribute("tracker").toString();
	if (username == null) {
		response.sendRedirect("index.jsp");
	}
%>
<% ArrayList mytrackers = new ArrayList();
mytrackers = (ArrayList)session.getAttribute("trackers");
int trackerSize = mytrackers.size();
    if(trackerSize == 0)
    {%>
    <c:redirect url="setup_tracker.jsp"/>	
  <% } %> 
 <jsp:include page="include_top.jsp"></jsp:include>
 
	<!-- Page header -->
	
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Data Export</span>
					<small class="display-block">Export your Data in JSON <font color=red>${erorrMessage}</font>
				</h4>
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
								<h6 class="panel-title">Export Data in JSON<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								
					<form name="dateform" id="dateform" method="post">
									<div data-intro="Select a Date Range" data-step="2" class="heading-elements" id="reportrange">
					<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  

					<b class="caret"></b>

									</button>
									<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" />
			                	</div>
								</form>
			                	
							</div>

							<div class="panel-body">
										<div class="panel bg-blue-400">
									<div class="panel-body">
										<div class="heading-elements">
											
					                	</div>
										<form action="ExportJSON" id="records" method="post">
										<h1 class="no-margin">Export Data from your Current Tracker to JSON</h1>
										Total Number Of Records Selected
										<input id="records" name="records" type="hidden" onchange="recordsChanged()" />
										<c:if test="${records==null}">
										<c:set var="records" scope="session" value="0" />
										</c:if>
										<div class="text-muted text-size-base" style="font-size:20px;">${records}</div>
										</form>
										<form name="exportJSON" id="exportJSON"	action="ExportJSON" method="post">
										<input id="exportJSON" name="exportJSON" type="hidden" onchange="exportJSON()" />
										<button class="btn btn-primary" type="submit">Download Now</button>
										
										</form>
									</div>
									
<!--									<div id="today-revenue"><svg width="275.328125" height="50"><g transform="translate(0,0)"><defs><clipPath id="clip-line-small"><rect class="clip" width="275.328125" height="50"></rect></clipPath></defs><path d="M20,8.46153846153846L59.22135416666667,25.76923076923077L98.44270833333334,5L137.6640625,15.384615384615383L176.88541666666666,5L216.10677083333334,36.15384615384615L255.328125,8.46153846153846" clip-path="url(#clip-line-small)" class="d3-line d3-line-medium" style="stroke: rgb(255, 255, 255);"></path><g><line class="d3-line-guides" x1="20" y1="50" x2="20" y2="8.46153846153846" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4, 2; shape-rendering: crispEdges;"></line><line class="d3-line-guides" x1="59.22135416666667" y1="50" x2="59.22135416666667" y2="25.76923076923077" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4, 2; shape-rendering: crispEdges;"></line><line class="d3-line-guides" x1="98.44270833333334" y1="50" x2="98.44270833333334" y2="5" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4, 2; shape-rendering: crispEdges;"></line><line class="d3-line-guides" x1="137.6640625" y1="50" x2="137.6640625" y2="15.384615384615383" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4, 2; shape-rendering: crispEdges;"></line><line class="d3-line-guides" x1="176.88541666666666" y1="50" x2="176.88541666666666" y2="5" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4, 2; shape-rendering: crispEdges;"></line><line class="d3-line-guides" x1="216.10677083333334" y1="50" x2="216.10677083333334" y2="36.15384615384615" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4, 2; shape-rendering: crispEdges;"></line><line class="d3-line-guides" x1="255.328125" y1="50" x2="255.328125" y2="8.46153846153846" style="stroke: rgba(255, 255, 255, 0.3); stroke-dasharray: 4, 2; shape-rendering: crispEdges;"></line></g><g><circle class="d3-line-circle d3-line-circle-medium" cx="20" cy="8.46153846153846" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(41, 182, 246); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="59.22135416666667" cy="25.76923076923077" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(41, 182, 246); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="98.44270833333334" cy="5" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(41, 182, 246); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="137.6640625" cy="15.384615384615383" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(41, 182, 246); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="176.88541666666666" cy="5" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(41, 182, 246); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="216.10677083333334" cy="36.15384615384615" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(41, 182, 246); opacity: 1;"></circle><circle class="d3-line-circle d3-line-circle-medium" cx="255.328125" cy="8.46153846153846" r="3" style="stroke: rgb(255, 255, 255); fill: rgb(41, 182, 246); opacity: 1;"></circle></g></g></svg></div>-->
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
  <jsp:include page="pagedependencies/datapresentation.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
