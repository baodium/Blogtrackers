<%@page import="java.util.*"%>
<%@page import="wrapper.*"%>



<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	Object edited_tracker = (null == session.getAttribute("edited_tracker")) ? "" : session.getAttribute("edited_tracker");
	String tracker_id = (null == request.getParameter("tracker_id")) ? edited_tracker.toString() : request.getParameter("tracker_id");
	ArrayList tracker = new ArrayList();
	ArrayList bloglist = new ArrayList();
	String s = "";
	if (username == null || username == "" || tracker_id == "") {
		response.sendRedirect("index.jsp");
	}
	
	try{
		Tracker tk = new Tracker();
		tracker = tk.getTracker(tracker_id);
		tracker = (ArrayList)tracker.get(0);
		String blog_list = tracker.get(5).toString();
		String[] blist  = blog_list.split("\\(");
		//s+= blist;
		blist = blist[1].split("\\)");
		s=blist[0];
		bloglist = tk.getBloglist(blist[0]);
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

	<div class="heading-elements">
				<div class="heading-btn-group">
					<button type="button" onclick="location.href='setup_tracker.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-reading"></i></b> Setup a new tracker</button>
					<button type="button" onclick="location.href='dashboard.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-statistics position-left"></i></b> Back to dashboard</button>
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
								<h6 class="panel-title">Edit Tracker <a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
							<input class="form-control" type="text" required name="title" value="<%=(null == tracker.get(2)) ? "" : tracker.get(2)%>" />
							</div>
							<div class="form-group">
							<label class="control-label">Tracker Description</label>
							<textarea class="form-control" required name="descr"><%=(null == tracker.get(6)) ? "" : tracker.get(6)%></textarea>
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
						<% if(bloglist != null && bloglist.size()>0){ 
								for(int i=0; i<bloglist.size(); i++){
									ArrayList blog = (ArrayList)bloglist.get(i);
									String blogger = (blog.get(3)==null)?"":blog.get(3).toString();
									String[] bloggers = blogger.split(",");
							%>
							<tr id="blogrow-<%=blog.get(0)%>">
								<td><%=blog.get(1)%></td>
								<td><%=blog.get(15)%></td>
								<td><%=(blogger.equals(""))?0:bloggers.length%></td>
								<td><%=blog.get(10)%></td>
								<td><a href="#" onclick="remove_blog('<%=blog.get(0)%>');" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple"><span class="letter-icon icon-trash"></span></a></td>
								<td class="hidden" width="0%"></td>
							</tr>
							<% }} %>
							
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
  
  <script>
	function remove_blog(id){
		var all_blogs ="<%=s%>";
		var blog_ids ="";
		var ids = all_blogs.split(",");
		for(var l=0; l<ids.length; l++){
			
			if(ids[l]!=id){
				blog_ids+= ids[l]+",";
			}
		}
		
		blog_ids = blog_ids.substring(0,(blog_ids.length-1));
		//alert(blog_ids);
		var tracker_id = "<%=tracker.get(0)%>";
		//var promt = confirm("Are you sure you want to delete this tracker?");
		
		if (confirm('Are you sure you want to remove this blog from tracker?')) {
			$("#blogrow-"+id).remove();
			
			$.ajax({
		        url: app_url+'/setup_tracker',
				method:'POST',
				data:{tracker_id:tracker_id,blog_id:blog_ids,action:"remove_blog"},
		        success: function(response)
		        {	
		        	//window.location.reload();
		        }
		    });	
			
		} else {
			return false;
		}
		
		
	}
  </script>
	<!-- /footer -->
	<!-- Dependencies -->
  <jsp:include page="pagedependencies/keywordtrend.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
