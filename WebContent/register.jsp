<%@page import="java.util.*"%>
<%@page import="wrapper.*"%>
 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Blogtrackers  > Register</title>

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
	<script type="text/javascript" src="assets/js/plugins/forms/validation/validate.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>

	<script type="text/javascript" src="assets/js/core/app.js"></script>
    <script>
           var app_url ='${pageContext.request.contextPath}/'; 
    </script>
	<script type="text/javascript" src="assets/js/pages/login_validation.js"></script>

	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
        <!--<script type="text/javascript" src="assets/js/plugins/neon-login.js"></script>-->
	<!-- /theme JS files -->


</head>

<body class="login-container ">


	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">

			<!-- Main content -->
			<div class="content-wrapper">

				<!-- Advanced login -->
				<form action="${pageContext.request.contextPath}/register" id="form_register" method="post" class="form-validate">
					<div class="panel panel-body login-form">
						<div class="text-center">
							<!--<div class="icon-object border-success text-success"><i class="icon-plus3"></i></div>-->
                                                        <div ><img src="assets/images/newLogo.jpg" style="width:150px; height:60px"/></div>
                                                    
							<h5 class="content-group">Create account <small class="display-block">All fields are required</small></h5>
						</div>

						<div class="content-divider text-muted form-group"><span>Your credentials</span></div>

						<div class="form-group has-feedback has-feedback-left">
							<input type="text" name="username" id="username_validate" onmouseout="verify(this);" class="form-control" placeholder="Username" required="required">
							<div class="form-control-feedback">
								<i class="icon-user-check text-muted"></i>
							</div>
                                                        <!-- <span class="help-block" id="username_exist"><i class="icon-cancel-circle2 position-left"></i> This username is already taken</span>
						 -->
                                                        <div id="user_exist"></div>
						</div>
                                                <div class="form-group has-feedback has-feedback-left">
							<input type="email" name="email" id="email_validate" onmouseout="verify(this);" class="form-control" placeholder="Your email" required="required">
							<div class="form-control-feedback">
								<i class="icon-mention text-muted"></i>
							</div>
                                                        <div id="email_exist"></div>
						</div>

						<div class="form-group has-feedback has-feedback-left">
							<input type="password" name="password" id="password" class="form-control" placeholder="Password" required="required">
							<div class="form-control-feedback">
								<i class="icon-user-lock text-muted"></i>
							</div>
						</div>
                                                
                                                <div class="form-group has-feedback has-feedback-left">
							<input type="password" name="retype_password"id="password2" class="form-control" placeholder="Re-type password"required="required">
							<div class="form-control-feedback">
								<i class="icon-user-lock text-muted"></i>
							</div>
						</div>
                                                
                                                <div class="form-group has-feedback has-feedback-left">
							<select name="user_type" class="form-control" placeholder="user type" required="required">
                                                            <option value="">-User Type-</option>
                                                            <option value="basic">Basic</option>
                                                            <!--<option value="premium">Premium</option>-->
                                                        </select>
							<div class="form-control-feedback">
								<i class="icon-add text-muted"></i>
							</div>
						</div>

			
						<br/>

					

						<button type="submit" id="register" name="register" value="yes" class="btn bg-teal btn-block btn-lg">Register <i class="icon-circle-right2 position-right"></i></button>
					</div>
				</form>
				<!-- /advanced login -->

			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->


	  <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
