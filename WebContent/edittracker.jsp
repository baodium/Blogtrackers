<%@page import="java.util.*"%>
<%@page import="wrapper.*"%>



<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	Object edited_tracker = (null == session.getAttribute("edited_tracker")) ? "" : session.getAttribute("edited_tracker");
	String tracker_id = (null == request.getParameter("tracker_id")) ? edited_tracker.toString() : request.getParameter("tracker_id");
	ArrayList tracker = new ArrayList();
	if (username == null || username == "" || tracker_id == "") {
		response.sendRedirect("index.jsp");
	}
	
	try{
		tracker = new Tracker().getTracker(tracker_id);
		tracker = (ArrayList)tracker.get(0);
	}catch(Exception e){}
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
								<h6 class="panel-title">Edit Tracker <%=tracker_id %><a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
							<form name="edit_tracker" method="post" action="setup_tracker">
							<label class="control-label">Tracker Name</label>
							<input class="form-control" type="text" name="title" value="<%=(null == tracker.get(2)) ? "" : tracker.get(2)%>" />
							</div>
							<div class="form-group">
							<label class="control-label">Tracker Description</label>
							<textarea class="form-control" name="descr"><%=(null == tracker.get(6)) ? "" : tracker.get(6)%></textarea>
							</div>
							<div>
							<input type="hidden" name="tracker_id" value="<%=(null == tracker.get(0)) ? "" : tracker.get(0)%>">
							<input type="hidden" name="edit_tracker" value="yes">
							<input type="hidden" name="action" value="edit_tracker">
							<button class="btn btn-primary" type="sumbit">Save Tracker</button>
							</form>
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
								<th>Site Name</th>
								<th>No of Blog Post</th>
								<th>No of Blogger</th>
								<th>Crawled Last</th>
								<th>Actions</th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Choosing sandals that meet the corporate casual dress code </td>
								<td></td>
								<td></td>
								<td></td>
								<td><a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple"><span class="letter-icon icon-trash"></span>
													</a></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
							</tbody>
							</table>
   
							</div>
						</div>
					
						

   
							
					
					
					<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Add New Blogs to Crawl<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>

				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<div class="form-group">
							
							<textarea class="form-control" placeholder="Enter List of Blog One Per Line" rows="12"></textarea>
							</div>
							<div>
							<button class="btn btn-primary">Crawl Now</button>
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
