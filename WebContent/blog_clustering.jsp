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


	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title mb-15">
				<h4>
					<a href="<%=request.getContextPath()%>/analytics.jsp"><i class="icon-arrow-left52 position-left"></i></a>
					<span class="text-semibold">Blog Clustering</span>
			<%-- <small class="display-block"><span>Welcome, </span><%=username %> <font color="red">${errorMessage}</font></small> --%>
			
				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List  </a></li>
					<li><a href="edittracker.jsp" title="Edit <%=session.getAttribute("tracker")%> Tracker"><%=session.getAttribute("tracker")%></a></li>
					<li><a href="analytics.jsp">Analytics</a></li>
						<li class="active">Blog Clustering</li>
				</ul>
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




						<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Hierachical Clusters<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>

				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
                          <div class="col-lg-12 col-md-12 col-sm-12 scroll2" style="min-height:800px;">
                          <div id="container"></div>
</div>
							</div>
						</div>
					</div>

					<div class="col-md-12">
							<div class="panel panel-primary">
								<div class="panel-heading">
									<h6 class="panel-title">Blog Clusters<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
									<div class="heading-elements">
									<!--<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
											<i class="icon-calendar3 position-left"></i> <span></span> <b class="caret"></b>
										</button>-->
													</div>
								</div>

								<div class="panel-body">

								<div class="col-lg-12 col-md-12 col-sm-12" style="min-height:400px;">
									<div class="alchemy" id="alchemy"></div>
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
  <jsp:include page="pagedependencies/blog_clustering.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
