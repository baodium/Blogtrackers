<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
<%@page import="java.util.*"%>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
        ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
        String tracker_id = request.getParameter("tid");
%>

 <jsp:include page="include_top.jsp"></jsp:include>

	<!-- Page header -->
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Home</span> - Dashboard
					<small class="display-block"><span>Welcome, </span><%=username %>
				</h4>
			</div>

			<div class="heading-elements">
				<div class="heading-btn-group">
					<a href="#" class="btn btn-link btn-float has-text text-size-small"><i class="icon-bars-alt text-indigo-400"></i><span>Statistics</span></a>
					<a href="#" class="btn btn-link btn-float has-text text-size-small"><i class="icon-calendar5 text-indigo-400"></i> <span>Schedule</span></a>
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
								<h6 class="panel-title">Set Up Tracker <%=tracker_id%><a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
				                		<li><a data-action="close"></a></li>
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							<div class="form-group">
							<label class="col-lg-2 control-label">Search For Tracker:</label>
							<div class="col-lg-7">
							<input type="text" class="form-control" placeholder="Search for Tracker">
							</div>
							<div class="col-lg-3">
							<div class="text-right">
							<button type="submit" class="btn btn-primary legitRipple">Search Now <i class="icon-arrow-right14 position-right"></i></button>
							</div>
							</div>		
										
							</div>
							
							
							
							</div>
					</div>
					</div>
				<div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Dashboard Statistics<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
				                		<li><a data-action="close"></a></li>
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 ">
					
					<div class="dashboard-stat blue-madison animated bounce">
						<div class="visual">
							<i class="icon-book"></i>
						</div>
						<div class="details">
							<div class="number cus p10">83</div>
							<div class="desc">
								Blogs
							</div>
						</div>
						<a class="more" href="<?php echo base_url();?>index.php?admin/schools_reg">
						View Blogs <i class="m-icon-swapright m-icon-white"></i>
						</a>
					</div>
					
				</div>

    
    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 ">
					
					<div class="dashboard-stat red-intense animated swing">
						<div class="visual">
							<i class="icon-earth"></i>
						</div>
						<div class="details">
							<div class="number cus p10">56</div>
							<div class="desc">
								Bloggers
							</div>
						</div>
						<a class="more" href="<?php echo base_url();?>index.php?admin/manage_country">
						View Bloggers <i class="m-icon-swapright m-icon-white"></i>
						</a>
					</div>
					
				</div>
                           <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 ">
					
					<div class="dashboard-stat orange animated tada">
						<div class="visual">
							<i class="icon-location4"></i>
						</div>
						<div class="details">
							<div class="number cus p10">74</div>
							<div class="desc p10">
								Blog Posts
							</div>
						</div>
						<a class="more" href="<?php echo base_url();?>index.php?admin/manage_parent">
						View Blog Posts <i class="m-icon-swapright m-icon-white"></i>
						</a>
					</div>
					
				</div>
                               <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 ">
					
					<div class="dashboard-stat orange animated tada">
						<div class="visual">
							<i class="icon-user"></i>
						</div>
						<div class="details">
							<div class="number cus p10">98</div>
							<div class="desc p10">
								Users
							</div>
						</div>
						<a class="more" href="<?php echo base_url();?>index.php?admin/manage_teacher">
						View Users <i class="m-icon-swapright m-icon-white"></i>
						</a>
					</div>
					
				</div>
				
				       <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 ">
					
					<div class="dashboard-stat blue-madison animated bounce">
						<div class="visual">
							<i class="icon-tree6"></i>
						</div>
						<div class="details">
							<div class="number cus p10">27</div>
							<div class="desc p10">
								Positive Sentiments
							</div>
						</div>
						<a class="more" href="<?php echo base_url();?>index.php?admin/manage_state">
						View Positive Sentiments <i class="m-icon-swapright m-icon-white"></i>
						</a>
					</div>
					
				</div>
				
				<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 ">
					
					<div class="dashboard-stat blue-madison animated bounce">
						<div class="visual">
							<i class="icon-tree5"></i>
						</div>
						<div class="details">
							<div class="number cus p10">43</div>
							<div class="desc">
								Negative Sentiments
							</div>
						</div>
						<a class="more" href="<?php echo base_url();?>index.php?admin/manage_local_government">
						View Negative Sentiments <i class="m-icon-swapright m-icon-white"></i>
						</a>
					</div>
					
				</div>	
							</div>
						</div>
					</div>
				
				
				      
					
				</div>
				<!-- /main charts -->


				<!-- Dashboard content -->
				<div class="row">
				<div class="col-lg-12">
				<div class="panel panel-flat">
					<div class="panel-heading">
						<h5 class="panel-title">Blogsites Location Distribution</h5>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="reload"></a></li>
<!--		                		<li><a data-action="close"></a></li>-->
		                	</ul>
	                	</div>
					</div>

					<div class="panel-body">
<!--						<p class="content-group">Example of a <code>choropleth</code> world map. A choropleth map is a thematic map in which areas are shaded or patterned in proportion to the measurement of the statistical variable being displayed on the map. The choropleth map provides an easy way to visualize how a measurement varies across a geographic area or it shows the level of variability within a region. This example displays GDP by country, data stored in <code>json</code> file.</p>-->
						
						<div class="map-container map-choropleth"></div>
					</div>
				</div>
				
				</div>
				
				</div>
				<!-- /dashboard content -->
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->


	<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->

</body>
</html>
