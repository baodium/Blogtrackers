<%@page import="java.util.*"%>
<%@page import="wrapper.*"%>
<%@page import="authentication.*"%>
 
<%
	DBConnector test = new DBConnector();//.query("SELECT * FROM usercredentials");
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	if (username != null && username != "") {
		response.sendRedirect("dashboard.jsp");
	}
        //
%> 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="assets/css/icon/font-awesome.css">
<link rel="stylesheet" href="assets/css/icon/et-line-font.css">
 <link rel="shortcut icon" href="assets/img/logo/logo.png">
        <link rel="apple-touch-icon" href="assets/img/logo/logo.png">
        <link rel="apple-touch-icon" sizes="72x72" href="assets/img/logo/logo.png">
        <link rel="apple-touch-icon" sizes="114x114" href="assets/img/logo/logo.png">

	<!-- Global stylesheets -->
	<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" rel="stylesheet" type="text/css">
	<link href="assets/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
	<link href="assets/css/bootstrap.css" rel="stylesheet" type="text/css">
	<link href="assets/css/core.css" rel="stylesheet" type="text/css">
	<link href="assets/css/components.css" rel="stylesheet" type="text/css">
	<link href="assets/css/colors.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="vegas/vegas.css">
	<link href="assets/css/mystyle.css" rel="stylesheet" type="text/css">
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
	<script type="text/javascript" src="assets/js/pages/login_validation.js?v=7888"></script>

	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
        <!--<script type="text/javascript" src="assets/js/plugins/neon-login.js"></script>-->
	<!-- /theme JS files -->
</head>
<!-- login-cover-->
<body class="login-container ">

	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">

			<!-- Main content -->
			<div class="content-wrapper">

				<!-- Form with validation -->
				<form action="#" id="form_login" method="post">
					<div class="panel panel-body login-form">
						<div class="text-center">
                                                    <div ><img src="assets/images/a.png" style="width:155px; height:50px"/></div>
                                                        
							<h5 class="content-group">Login to your account <small class="display-block">Your credentials</small></h5>
                                                         <div class="form-login-error">
                                                                <p id="error_message-box" style="color:red"></p>
                                                    </div>
						</div>

						<div class="form-group has-feedback has-feedback-left">
							<input type="email" class="form-control" placeholder="Email" id="username" name="username" required="required">
							<div class="form-control-feedback">
								<i class="icon-user text-muted"></i>
							</div>
						</div>

						<div class="form-group has-feedback has-feedback-left">
							<input type="password" class="form-control" placeholder="Password" id="password" name="password" required="required">
							<div class="form-control-feedback">
								<i class="icon-lock2 text-muted"></i>
							</div>
						</div>

						<div class="form-group login-options">
							<div class="row">
								<div class="col-sm-6">
									&nbsp;
								</div>

								<div class="col-sm-6 text-right">
									<a href="${pageContext.request.contextPath}/resetpassword">Forgot password?</a>
								</div>
							</div>
						</div>
                                                   
						<div class="form-group">
							<button type="submit" id="submit" value="submit" value="login" class="btn bg-pink-400 btn-block">Login <i class="icon-arrow-right14 position-right"></i></button>
						</div>
                                                             <div class="content-divider text-muted form-group"><span>No account?</span></div>
                                                <div class="form-group">
							<a href="${pageContext.request.contextPath}/register" class="btn bg-blue-400 btn-block">Register <i class="icon-arrow-right14 position-right"></i></a>
						</div>

						</div>
				</form>
				<!-- /form with validation -->

			</div>
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->

 <script src="vegas/vegas.min.js"></script>
<script>
	$("body").vegas({
    slides: [
        { src: "img/signin.jpg" },
        { src: "img/signin2.jpg" }
     ],
overlay:true,
		timer:false
});
	</script>
<script>


</script>
	  <jsp:include page="footer.jsp"></jsp:include>

</body>
</html>