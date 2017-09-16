<%-- 
    Document   : index
    Created on : 28-Aug-2017, 21:51:03
    Author     : Omnibus_03
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>

<%
	Object error_message = (null == session.getAttribute("error_message")) ? "" : session.getAttribute("error_message");
	Object success_message = (null == session.getAttribute("success_message")) ? "" : session.getAttribute("success_message");
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><%="System Name" %></title>

	<!-- Global stylesheets -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" rel="stylesheet" type="text/css">
	<link href="assets/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
	<link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="assets/css/core.css" rel="stylesheet" type="text/css">
	<link href="assets/css/components.css" rel="stylesheet" type="text/css">
	<link href="assets/css/colors.css" rel="stylesheet" type="text/css">
	<!-- /global stylesheets -->

	<!-- Core JS files -->
	<script type="text/javascript" src="assets/js/plugins/loaders/pace.min.js"></script>
	<script type="text/javascript" src="assets/js/core/libraries/jquery.min.js"></script>
	<script type="text/javascript" src="assets/js/core/libraries/bootstrap.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/loaders/blockui.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/nicescroll.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/drilldown.js"></script>
	<!-- /core JS files -->


	<!-- Theme JS files -->
	<script type="text/javascript" src="assets/js/core/app.js"></script>

	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
         <script type="text/javascript" src="assets/js/plugins/forms/validation/validate.min.js"></script>
        <script type="text/javascript" src="assets/js/plugins/fileinput.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>

	<script type="text/javascript" src="assets/js/core/app.js"></script>
<<<<<<< HEAD
=======
	 <script>
           var app_url ='${pageContext.request.contextPath}/'; 
        </script>
>>>>>>> origin/master
	<script type="text/javascript" src="assets/js/pages/login_validation.js"></script>
	<!-- /theme JS files -->

</head>

<body class="login-container">

	<!-- /main navbar -->

	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">

			<!-- Main content -->
			<div class="content-wrapper">
                                <% if(success_message.equals("")){ %>
				<!-- Password recovery -->
				<form action="${pageContext.request.contextPath}/resetpassword" method="post" name="recover" class="form-validate">
					<div class="panel panel-body login-form">
						<div class="text-center">
							<div class="icon-object border-warning text-warning"><i class="icon-spinner11"></i></div>
                                                        <div class="text-warning"><%=(error_message!="")?error_message:""%></div>
							<h5 class="content-group">Password recovery <small class="display-block">We'll send you instructions in email</small></h5>
						</div>

						<div class="form-group has-feedback">
							<input type="email" class="form-control" name="email" required="required" placeholder="Your email">
							<div class="form-control-feedback">
								<i class="icon-mail5 text-muted"></i>
							</div>
						</div>

						<button type="submit" name="recover" value="yes" class="btn bg-pink-400 btn-block">Reset password <i class="icon-arrow-right14 position-right"></i></button>
					</div>
				</form>
                                <% }else{ %>
                                <div class="panel panel-body login-form">
						<div class="text-center">
							<div class="icon-object border-warning text-warning"><i class="icon-spinner11"></i></div>
							<h5 class="content-group"><%=success_message%></h5>
						</div>

						
						<a href="${pageContext.request.contextPath}/" class="btn bg-blue-400 btn-block">Back <i class="icon-arrow-left52 position-right"></i></a>
                                </div>
                                
                                <% } %>
				<!-- /password recovery -->

			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->

  <jsp:include page="footer.jsp"></jsp:include>

</body>
</html>

