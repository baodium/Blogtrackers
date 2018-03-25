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
						<h6 class="panel-title">Change Password</h6>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="reload"></a></li>
		                		
		                	</ul>
	                	</div>
					</div>

	                <div data-intro="Change your password" data-step="2" class="panel-body">
   
	                	<form class="form-horizontal" action="<%=request.getContextPath()%>/profile" id="change_password2" method="post" class="form-validate" >
							<div id="invalid"></div>

							<div class="form-group">
								<div class="col-lg-10">
									<div class="row">
										<div class="col-md-10">
											<div class="form-group">
				                                <input type="text" class="form-control" required="required" onchange="verifypassword(this)" name="oldpassword" maxlength="60" id="old_password" required="required" placeholder="Old Password (Enter temporary password)" />
				                                              
			                                
                                              </div>

			                                <div class="form-group">
			                               
				                                <input type="text" name="password" required="required" id="password1" onchange="verifypassword(this)" class="form-control" placeholder="New Password" maxlength="60" />
			                                </div>
			                                
			                                	                                <div class="form-group">
				                                <input type="text" id="password2" required="required" name="confirmpassword" onchange="verifypassword(this)" class="form-control" placeholder="Confirm New Password" maxlength="60" />
			                                </div>
										</div>

										
									</div>
								</div>
							</div>
<br/><br/>
	                        <div class="text-left">
	                        	<button type="submit" name="update" value="change_password" id="submit" class="btn btn-primary">Change Password <i class="icon-arrow-right14 position-right"></i></button>
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

				</div>
				<!-- /dashboard content -->

			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->
<script>
$("#submit").prop("disabled",true);
</script>

	<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->

<!-- Dependencies -->
  <jsp:include page="pagedependencies/profile.jsp"></jsp:include>
  <!-- End of Dependencies -->
  
</body>
</html>
