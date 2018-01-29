<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>


<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="authentication.DBConnector"%>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
     
	session.setAttribute("pre-selected-blogs", "");
	session.setAttribute("initiated_search_term", "");
	
        //try{
        ArrayList userinfo = new DBConnector().query("SELECT *  FROM usercredentials WHERE UserName='"+username+"'");          
        userinfo = (ArrayList)userinfo.get(0);
        //}catch(Exception e){
          //  response.sendRedirect("index.jsp");
        //}
%>
  <jsp:include page="include_top.jsp"></jsp:include>
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
					<span class="text-semibold">Profile</span>
					<%-- <small class="display-block"><span>Welcome, </span><%=username %></small> --%>
				</h4>
			</div>
			<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					
					<li class="active">Profile</li>
				</ul>

			<!-- 	<div class="heading-elements">
				<div class="heading-btn-group">
					<button type="button" onclick="location.href='setup_tracker.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-plus2"></i></b> Setup a new tracker</button>
					
					
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
				
				</div>
				<!-- /main charts -->


				<!-- Dashboard content -->
				<div class="row">
					<div class="col-lg-8">

						<!-- Marketing campaigns -->
						<div class="panel panel-flat">
							
                                        <div class="panel panel-flat">
					<div class="panel-heading">
						<h6 class="panel-title">Profile</h6>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="reload"></a></li>
		                		
		                	</ul>
	                	</div>
					</div>

	                <div class="panel-body">
   
	                	<form class="form-horizontal" action="<%=request.getContextPath()%>/profile" method="post" class="form-validate" >
							<div class="form-group">
								<label class="col-lg-2 control-label">Profile</label>
								<div class="col-lg-10">
									<div class="row">
										<div class="col-md-4">
							<div class="form-group">
				                                <input type="text" class="form-control"name="first_name" placeholder="First Name" required="required" maxlength="20" value = "<%=userinfo.get(4)%>" />
                                                                
                                                        </div>

			                                <div class="form-group">
				                                <input type="text" class="form-control" name="last_name" placeholder="Last Name" required="required" maxlength="20" value = "<%=userinfo.get(5)%>">
			                                </div>
										</div>

										<div class="col-md-8">
											<div class="form-group">
				                                <input type="email" name="email" class="form-control"  placeholder="Email" maxlength="40" required="required" value = "<%=userinfo.get(2)%>">
			                                </div>

			                                <div class="form-group">
				                                <input type="tel" name="phone_number" class="form-control" required="required" title="Invalid Phone Number" pattern="^[0-9\-\+\s\(\)]*$" placeholder="+15014196609" maxlength="14" value = "<%=userinfo.get(6)%>">
			                                </div>
										</div>
									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="col-lg-2 control-label">&nbsp;</label>
								<div class="col-lg-10">
									<div class="row">
										<div class="col-md-8">
											<div class="form-group">
				                                <input type="text" class="form-control" required="required" disabled name="username" placeholder="Username" value = "<%=userinfo.get(0)%>">
                                                                            <input type="hidden" class="form-control" required="required" name="username" placeholder="Username" value = "<%=userinfo.get(0)%>">
			                                
                                                                                        </div>

			                                <div class="form-group">
				                                <input type="text" name="address" class="form-control" placeholder="Address" maxlength="80" value = "<%=userinfo.get(7)%>">
			                                </div>
										</div>

										
									</div>
								</div>
							</div>

	                        <div class="text-right">
	                        	<button type="submit" name="update" value="yes" class="btn btn-primary">Update <i class="icon-arrow-right14 position-right"></i></button>
	                        </div>
                        </form>
				    </div>
				</div>
                                                    
                                                    
						</div>
						<!-- /marketing campaigns -->


						
						<!-- /support tickets -->


						<!-- Latest posts -->
						
						<!-- /latest posts -->

					</div>

					<div class="col-lg-4">

						

                                            
                       <form class="form-horizontal" name="upload_form" enctype="multipart/form-data" action="fileupload.jsp" method="POST">
						<!-- My messages -->
						<div class="panel panel-flat">
							
							<!-- Area chart -->
							<div id="messages-stats"></div>
							<!-- /area chart -->

							<!-- Tabs -->
		                	<ul class="nav nav-lg nav-tabs nav-justified no-margin no-border-radius bg-primary-400 border-top border-top-indigo-300">
							

								<li>
									<a href="#messages-fri" class="text-size-small text-uppercase" data-toggle="tab">
										Profile Image
									</a>
								</li>
							</ul>
							<!-- /tabs -->


							<!-- Tabs content -->
					<div class="tab-content" style="text-align:center"><br/>
						        <div class="fileinput fileinput-new" data-provides="fileinput">
                                                            <%
                                                            String path=application.getRealPath("/").replace('\\', '/')+"profile_images/";
                                                           
                                                            String filename = path+userinfo.get(0).toString()+".jpg";
                                                            String pimage = "assets/images/placeholder.jpg";
                                                            File f = new File(filename);
                                                            if(f.exists() && !f.isDirectory()) { 
                                                                pimage = "profile_images/"+userinfo.get(0).toString()+".jpg";
                                                            }
                                                            //pimage = pimage.replace("build/", "");
                                                            %>

                                                                  <div class="fileinput-new thumbnail"  data-trigger="fileinput" >
                                                                      <img class="img" src="<%=pimage%>" style="width:150px; height:150px" />
                                                
                                                                  </div>

                                                            
                                                                  <center>
                                                                     <div class="fileinput-preview fileinput-exists thumbnail" style="max-width:151px; max-height:151px; text-align:center"></div>
                 
                                                                       </center>
                                                                  <div >
                                                                
                                                                                              
                                                                      <span class="btn btn-white btn-file" >

                                                                          <span class="fileinput-new">Select</span>
                                                                          <span class="fileinput-exists">Change</span>
                                                                          <input type="file" name="userfile" accept="image/*">
                                                                      </span>
                                                                      <a href="#" class="btn btn-orange fileinput-exists" data-dismiss="fileinput">Remove</a>
                                                                  </div>

                                                                     </div>
                                                                    <input type="hidden" class="form-control" required="required" name="username"  value = "<%=userinfo.get(0)%>">
			                           
                                                                    <input type="submit" name="upload_image" value="upload" class="btn btn-primary"><br/> <br/>              
							<!-- /tabs content -->

					</div>
						<!-- /my messages -->
                                                </form>

						
					</div>
				</div>
				<!-- /dashboard content -->

			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->


	<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->

<!-- Dependencies -->
  <jsp:include page="pagedependencies/profile.jsp"></jsp:include>
  <!-- End of Dependencies -->
  
</body>
</html>
