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
					<span class="text-semibold">Edit Tracker</span>
<!--					<small class="display-block">Good morning, Victoria Baker!</small>-->
				</h4>
				
				
										
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
								<h6 class="panel-title">Edit Tracker<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
								<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							
					<div class="col-lg-12 col-md-12 col-sm-12">
										
							<div class="form-group">
							<label class="control-label">Tracker Name</label>
							<input class="form-control" type="text" />
							</div>
							<div class="form-group">
							<label class="control-label">Tracker Description</label>
							<textarea class="form-control"></textarea>
							</div>
							<div>
							<button class="btn btn-primary">Edit Tracker</button>
							</div>
						
								</div>
							</div>
								
							
										
																
							
							
							
							
							</div>
					</div>
					</div>
				
						
				
						

							
							
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">List of Blogs<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						
	
						<table class="table datatable-basic">
						<thead>
							<tr>
								<th>Blog Post Title</th>
								<th class="hidden" width="0%" >Frequency</th>
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Choosing sandals that meet the corporate casual dress code <a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right"
													>
														<span class="letter-icon icon-eye2"></span>
													</a></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
							</tbody>
							</table>
   
							</div>
						</div>
					
						

   
							
					
					
					<div class="panel panel-primary">
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
