<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="authentication.DBConnector"%>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
        
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
	<div class="page-header">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<i class="icon-arrow-left52 position-left"></i>
					<span class="text-semibold">Help</span>
					<small class="display-block"><span>How can we help? </span><%=username %>
				</h4>
			</div>

				<div class="heading-elements">
				<div class="heading-btn-group">
					<button type="button" onclick="location.href='setup_tracker.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-reading"></i></b> Proceed to setup Tracker</button>
					<button type="button" onclick="location.href='dashboard.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-statistics position-left"></i></b> Proceed to Dashboard</button>
					<button id="google_translate_element" class="btn btn-default"><script type="text/javascript">
function googleTranslateElementInit() {
  new google.translate.TranslateElement({pageLanguage: 'ar', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
}
</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
				
				</button>
			</div>
		</div>
	</div>
	<!-- /page header -->

	<!-- Page container -->
	<div class="page-container">

		<!-- Page content -->
		<div class="page-content">




				<!-- Support tickets -->
				<div class="panel panel-flat">
					<div class="panel-body" style="font-size: 14px">
								<h6 class="text-semibold">About Blogtrackers</h6>
								<p class="content-group">Blogtrackers, a tool for tracking and analyzing blog activity. Built to review user behavior in the blogosphere, after a careful study of social scientists' requirement. These are some of the most frequently asked questions about blogging and publishing content online. For people starting out, there are so many new things to do and be aware of, that it’s difficult to get it right first time around. This is why asking questions, looking for examples and learning from people who have been there and done that makes sense at this stage.</p>

								<h6 class="text-semibold">Frequently Asked Questions</h6>
								<p class="content-group-lg"></p>

								<div class="row container-fluid">
									<div class="col-sm-6">
										<div class="content-group">
											<dl>
				                                <dt class="text-size-small text-primary text-uppercase">1. Which Blog should I crawl?</dt>
				                                <dd>You can crawl any blog.</dd>

				                                <dt class="text-size-small text-primary text-uppercase">2. How do I crawl</dt>
				                                <dd>You need to first setup your tracker to track, then you can track the blog.</dd>

				                                <dt class="text-size-small text-primary text-uppercase">3. What can I track?</dt>
				                                <dd>You can track the keywork trends, sentiments, etc.</dd>
				                            </dl>
			                            </div>
									</div>

									<div class="col-sm-6">
										<div class="content-group">
											<dl>
				                                <dt class="text-size-small text-primary text-uppercase">4. What is sentiment analysis</dt>
				                                <dd>Sentiment analysis (also known as opinion mining) refers to the use of natural language processing, text analysis and computational linguistics to identify and extract subjective information in source materials.</dd>

				                                <dt class="text-size-small text-primary text-uppercase">5. How can I measure influence</dt>
				                                <dd>Social media influence matters on multiple levels. For businesses, online influence signals better engagement with customers and a smarter social media strategy..</dd>

				                                <dt class="text-size-small text-primary text-uppercase">6. What is trend analysis</dt>
				                                <dd>Trend analysis is the process of comparing business data over time to identify any consistent results or trends. You can then develop a strategy to respond to these trends in line with your business goals.</dd>
				                            	
				                            	<dt class="text-size-small text-primary text-uppercase">6. Can I perform Network Analysis</dt>
				                                <dd>The process of investigating social structures through the use of network and graph theories. It characterizes networked structures in terms of nodes (individual actors, people within the network) and the ties or edges (relationships or interactions) that connect them.</dd>
				                            </dl>
			                            </div>
									</div>
			                    </div>

			                    
								</div>
								
	</div>
	<!-- /page container -->


	<!-- Footer -->
	<jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->

</body>
</html>
