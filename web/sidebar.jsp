<%
	Object username = (null == session.getAttribute("user")) ? "" : session.getAttribute("user");
%>


<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
					<span class="tog">
						<img src="Resources/img/a.png" class="toggleImage" alt="Blogtrackers Logo" style="height: 100%; width:100%">
						<img src="Resources/img/b.png" class="toggleImage" alt="Blogtrackers Logo" style="height: 100%;  display:none; width:100%">
					</span>
					</div>

					<div class="clearfix"></div>

					<!-- menu profile quick info -->
					<div class="profile">
						<div class="profile_pic">
							<img src="production/images/profile.png" alt="..."
								class="img-circle profile_img">
						</div>
						<div class="profile_info">
							<span>Welcome,</span>
							<h2><%=username %>
							</h2>
						</div>
					</div>
					<!-- /menu profile quick info -->

					<br />
					<div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <p id="demo"></p>
<br/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
function toggleImage(){
	$('img.toggleImage').toggle();
	//$(".fullImage").addClass("hidden");	
//	$(".halfImage").removeClass("hidden");
}
</script>
<script>
$(function() {

    var $sidebar   = $(".col-md-3.left_col"), 
        $window    = $(window),
        $bodyslide = $(".container");
        offset     = $sidebar.offset(),
        topPadding = 100;

   
            $sidebar.stop().animate({
                marginTop: 0
            });
        }
    );
</script>



<div class="loader"></div>
<style>
.loader {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 9999;
	background: url('Resources/img/gif/Loading-data.gif') 50% 50% no-repeat rgb(249,249,249);
}
</style>

<script type="text/javascript">
$(window).load(function() {
	$(".loader").addClass("hidden");	
	//$(".loader").fadeOut("slow");
})
</script>

	<script type="text/javascript">
									function showGif() {
										$(".loader").removeClass("hidden");
									}
									</script>
<br/><br/>
 				
                <ul class="nav side-menu">
                  <li>
                   <li><a><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu current-page">
                     <li> <a href="<%=request.getContextPath()%>/Datasource" onclick="showGif()"> Setup Tracker </a></li>
                     <li> <a href="<%=request.getContextPath()%>/Dashboard" onclick="showGif()"> Dashboard </a></li>
                    </ul>
                 </li>
                 </ul>
                  <ul class="nav side-menu">
                   <li><a href="${pageContext.request.contextPath}/posting_frequencey.jsp" onclick="showGif()"><i class="fa fa-line-chart"></i>Posting Frequency<span class="fa fa-chevron-right"></span></a>
                  </li>
                  </ul>
                  <ul class="nav side-menu">
                   <li><a href="${pageContext.request.contextPath}/keyword_trends.jsp" onclick="showGif()"><i class="fa fa-key"></i>Keyword Trends<span class="fa fa-chevron-right"></span></a>
                  </li>
                  </ul>
                  <ul class="nav side-menu">
                   <li><a href="${pageContext.request.contextPath}/sentiments.jsp" onclick="showGif()"><i class="fa fa-puzzle-piece"></i>Sentiments<span class="fa fa-chevron-right"></span></a>
                  </li>
                  </ul>
                  <ul class="nav side-menu">
                  <li><a href="${pageContext.request.contextPath}/influence.jsp" onclick="showGif()"><i class="fa fa-newspaper-o"></i>Influence<span class="fa fa-chevron-right"></span></a>
                  </li>
                  </ul>
                  
                
                 <ul class="nav side-menu">
					<li><a><i class="fa fa-edit"></i>Additional Information <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu current-page">
                    <li> <a href="/BT/additional_blog_info.jsp" onclick="showGif()">Additional Blog Info</a></li>
                   <li> <a href="/BT/additional_blogger_info.jsp" onclick="showGif()">Additional Blogger Info</a></li>
                     
                    </ul>
                  </li>
                </ul>
               
                <ul class="nav side-menu">
					<li><a><i class="fa fa-bar-chart-o"></i> Data Presentation <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                    <li class="current-page"> <a href="/BT/data_presentation.jsp" onclick="showGif()">Data Export in JSON</a></li>
                     
                    </ul>
                  </li>
                </ul>
                
                <ul class="nav side-menu">
                   <li><a href="${pageContext.request.contextPath}/blog_network.jsp" onclick="showGif()"><i class="fa fa-line-chart"></i>Blog network<span class="fa fa-chevron-right"></span></a>
                  </li>
                  </ul>
                
                
              </div>
              <div class="menu_section">
                <h3>Services</h3>
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-windows"></i> Upgrade Options <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="/" onclick="alert('This section is under construction'); return false">Plans</a></li>
                      <li><a href="/" onclick="alert('This section is under construction'); return false">testimonials</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-video-camera"></i> Training <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="/" onclick="alert('This section is under construction'); return false">Video Tutorials</a></li>
                      <li><a href="/" onclick="alert('This section is under construction'); return false">Download PDF</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-sitemap"></i> Customer Support <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        <li><a href="/" onclick="alert('This section is under construction'); return false"></a>
                          
                  <!-- <a href="${pageContext.request.contextPath}/topic_models.jsp"> --%> <i
					class="fa fa-language"></i>Topic Models<span class="fa fa-chevron-right"></span></a>
					</li>
				</ul>
                  
                  <ul class="nav side-menu">
                  <li><%--<a><i class="fa fa-desktop">--%></i> Network Analysis <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="${pageContext.request.contextPath}/blog_network.jsp">Blog Network</a></li>
                      <li><a href="${pageContext.request.contextPath}/x.jsp">Network Structural Measures</a></li>
                      <li><a href="${pageContext.request.contextPath}/x.jsp">Blogger-blog Network</a></li>
                      <li><a href="${pageContext.request.contextPath}/x.jsp">Blog-cited domains</a></li>
                    </ul>
                  </li>
                  <ul class="nav side-menu">
                  <li><a href="${pageContext.request.contextPath}/cyber_forensics.jsp"><i class="fa fa-code-fork"></i>Cyber Forensics<span class="fa fa-chevron-right"></span></a>
                  </li>
                  </ul>
                 -->
                </ul>
              </div>

            </div>
				</div>
			</div>