<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="authentication.DBConnector"%>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	DBConnector dbhandle = new DBConnector();

	ArrayList total = new ArrayList();//dbhandle.getTotal();
	total.add(0,0);
	total.add(1,0);
	total.add(2,0);
	total.add(3,0);
	
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Welcome to Blogtracker</title>
        <meta name="description" content="">
        <meta name="keywords" content="">
        <meta charset="utf-8">
        <meta name="author" content="Harry Boo">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
        
        <!-- Favicons -->
        <link rel="shortcut icon" href="assets/img/logo/logo.png">
        <link rel="apple-touch-icon" href="assets/img/logo/logo.png">
        <link rel="apple-touch-icon" sizes="72x72" href="assets/img/logo/logo.png">
        <link rel="apple-touch-icon" sizes="114x114" href="assets/img/logo/logo.png">
        
        <!-- Load Core CSS 
        =====================================-->
        <link rel="stylesheet" href="assets/css/core/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/core/animate.min.css">
        
        <!-- Load Main CSS 
        =====================================-->
        <link rel="stylesheet" href="assets/css/main/main.css">
        <link rel="stylesheet" href="assets/css/main/setting.css">
        <link rel="stylesheet" href="assets/css/main/hover.css">        
        <link rel="stylesheet" href="assets/css/typed/typed.css">
        <link rel="stylesheet" href="assets/vegas/vegas.css" >
        <!-- Load Magnific Popup CSS 
        =====================================-->
        <link rel="stylesheet" href="assets/css/magnific/magic.min.css">        
        <link rel="stylesheet" href="assets/css/magnific/magnific-popup.css">              
        <link rel="stylesheet" href="assets/css/magnific/magnific-popup-zoom-gallery.css">
        
        <!-- Load OWL Carousel CSS 
        =====================================-->
        <link rel="stylesheet" href="assets/css/owl-carousel/owl.carousel.css">
        <link rel="stylesheet" href="assets/css/owl-carousel/owl.theme.css">
        <link rel="stylesheet" href="assets/css/owl-carousel/owl.transitions.css">
        
<!--
         Load Color CSS - Please uncomment to apply the color.
        =====================================      
-->
        <link rel="stylesheet" href="assets/css/color/blue.css">
   <!--      <link rel="stylesheet" href="assets/css/color/brown.css">
        <link rel="stylesheet" href="assets/css/color/cyan.css">
        <link rel="stylesheet" href="assets/css/color/dark.css">
        <link rel="stylesheet" href="assets/css/color/green.css">
        <link rel="stylesheet" href="assets/css/color/orange.css">
        <link rel="stylesheet" href="assets/css/color/purple.css">
        <link rel="stylesheet" href="assets/css/color/pink.css">
        <link rel="stylesheet" href="assets/css/color/red.css">
        <link rel="stylesheet" href="assets/css/color/yellow.css">
       <link rel="stylesheet" href="assets/css/color/pasific.css">-->
        
        <!-- Load Fontbase Icons - Please Uncomment to use linea icons
        =====================================       
        <link rel="stylesheet" href="assets/css/icon/linea-arrows-10.css">
        <link rel="stylesheet" href="assets/css/icon/linea-basic-10.css">
        <link rel="stylesheet" href="assets/css/icon/linea-basic-elaboration-10.css">
        <link rel="stylesheet" href="assets/css/icon/linea-ecommerce-10.css">
        <link rel="stylesheet" href="assets/css/icon/linea-music-10.css">
        <link rel="stylesheet" href="assets/css/icon/linea-software-10.css">
        <link rel="stylesheet" href="assets/css/icon/linea-weather-10.css">--> 
        <link rel="stylesheet" href="assets/css/icon/font-awesome.css">
        <link rel="stylesheet" href="assets/css/icon/et-line-font.css">
        
        <!-- Load JS
        HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries
        WARNING: Respond.js doesn't work if you view the page via file://
        =====================================-->

        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
       <link rel="stylesheet" href="assets/css/mystyle.css" />
       <style>
       #inputHelpBlock
       {
       background-color: #ffffff !important;
       color: #000000;
       }
       #helpBlock
       {
       color:#ffffff;
       }
       #inputHelpBlock::-webkit-input-placeholder {
color:  #000000 !important;
}
 
#inputHelpBlock:-moz-placeholder { /* Firefox 18- */
color: #000 !important;  
}
 
#inputHelpBlock::-moz-placeholder {  /* Firefox 19+ */
color: #000 !important;  
}
 
#inputHelpBlock:-ms-input-placeholder {  
color: #000 !important;  
}
body
{
overflow-x:hidden;
}
       </style>
    </head>
    <body  id="page-top" data-spy="scroll" data-target=".navbar" data-offset="100">
        
        <!-- Page Loader
        ===================================== -->
		<div id="pageloader">
			<div class="loader-item">
                <img src="assets/img/logo/Loading-data.gif" alt="page loader">
            </div>
		</div>
        
        <a href="#page-top" class="go-to-top">
            <i class="fa fa-long-arrow-up"></i>
        </a>
        
        <!-- Navigation Area
        ===================================== -->
        <nav class="navbar navbar-pasific navbar-op navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand font-montserrat font-size-normal" href="#page-top">
                       <!-- <img width="55%" style="padding-top: 12px" src="assets/img/logo/logo_light.png" alt="logo"> -->
                    <div>
					
<h3 class="animated infinite color-light" data-animation="pulse" style="margin-top: -5px" > BLOGTRACKERS </h3>
</div>
                    </a>
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="navbar-collapse collapse navbar-right">
                    <ul class="nav navbar-nav mr20">
                       <li class="hidden"><a href="#page-top"></a></li>
                        <li><a href="#welcome">Welcome</a></li>
                        <li><a href="#features">Features</a></li>
                        <li><a href="#blogs">Sponsors</a></li> 
                        <% if(username.equals("")){%>                            
                        <li onclick='location.href="<%=request.getContextPath()%>/login"'><a href="<%=request.getContextPath()%>/login" >Login</a></li>
                        <% }else{ %>
                         <li onclick='location.href="<%=request.getContextPath()%>/Analytics"'><a href="<%=request.getContextPath()%>/Analytics" >Dashboard</a></li>
                         <li onclick='location.href="<%=request.getContextPath()%>/logout"'><a href="<%=request.getContextPath()%>/logout" >Logout</a></li>
                        <% } %>
                                       
                                   </ul>
                </div>
            </div>
        </nav>

        
        
            </div>
        </div>
        
        
        <!-- Search Modal Dialog Box
        ===================================== -->
     
        <div id="searchModal" class="modal fade" role="dialog">
        <form class="inline-form" action="<%=request.getContextPath()%>/search" method="post" >
            <div class="modal-dialog">

                <!-- modal content start -->
                <div class="modal-content">
                    <div class="modal-header bg-gray">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h5 class="modal-title text-center"><i class="fa fa-search fa-fw"></i> Search here</h5>
                    </div>
                    
                    
                    <div class="modal-body">                        
                      
                            <input type="text" name="term" class="modal-search-input" autofocus>
                        	<input type="hidden" name="search" value="yes">
                       
                    </div>
                    <div class="modal-footer bg-gray">
                        <span class="text-center"><button type="submit" class="color-dark">Advanced Searching</button></span>
                    </div>
                     
                </div>
                <!-- modal content end -->

            </div>
            </form>
        </div>
        
        <!-- Intro Area
        ===================================== -->
        <header class="intro pt100 pb100 parallax-window" data-parallax="scroll" data-speed="0.5" data-image-src="assets/img/bg/img-bg-3.jpg">
            <div class="intro-body">
                <div class="container" style="">
                    <div class="row">
                        <div class="col-md-offset-3 col-md-6 col-md-offset-3 pt-50" align="center">
                            <h1 class="brand-heading text-capitalize color-light pt10 pb10">
                             <!--    <div class="brand-heading-typed-container">
                                    <div id="typed-strings">
                                        <p>Welcome to <span class="color-pasific">Blogtrackers</span></p>
                                        <p>Analyze anything about Blogs</p>
                                        <p>Analytics at your fingertips</p>
                                       
                                    </div>
                                    <span id="typed" style="white-space:pre;"></span>
                                </div> -->
			
                            </h1>
                        <form class="form-horizontal" method="post" action="<%=request.getContextPath()%>/search">
                                <label class="sr-only" for="inputHelpBlock">Enter a search keyword</label>
                       <input type="text" id="inputHelpBlock" required class="form-control input-circle input-lg text-center" name="term" placeholder="Enter a search keyword" aria-describedby="helpBlock">
                               <span id="helpBlock" class="help-block"></span>
                               <input type="hidden" name="search" value="yes">
							<% if(username.equals("")){%>  
							                          
	                       	<button class="button button-md button-gray hover-ripple-out mt30 " type="submit" data-animation="fadeInUp" data-animation-delay="6000" >Get Started</button>
                      
	                        <% }else{ %>
	                        <button type="submit" class="button button-md button-gray hover-ripple-out mt30 " data-animation="fadeInUp" data-animation-delay="6000" >Explore</button>
                      
	                        <% } %>
	                         </form>
                            
                              </div>
                    </div>
                </div>
                
                <div class="intro-direction">
                    <a href="#welcome">
                        <div class="mouse-icon"><div class="wheel"></div></div>
                    </a>
                </div>
                
            </div>
            
        </header>

      <!-- Welcome Area
        ===================================== -->
        <div id="welcome" class="pt75">
            <div class="container">
                <div class="row">
                    
                    <!-- title start -->
                    <div class="col-md-12 text-center">
                        <h1 class="font-size-normal">
                        <!--    <small>Welcome to Blogtrackers</small> -->
                            Welcome to Blogtrackers
                            <small class="heading heading-solid center-block"></small>
                        </h1>
                    </div>
                    <!-- title end -->
                    
                    <!-- title description start -->
                    <div class="col-md-8 col-md-offset-2 text-center">

                    BlogTrackers helps sociologists to track and analyze blogs of particular interests by designing and integrating unique features. It also help to monitor blogs and suggest valuable insights in a drilled-down fashion using
content analysis and social network analysis. 


                        </p>
                    </div>
                    <!-- title description end -->
                </div>
                
                <div class="row mt50">
                    
                    <!-- item one start -->
                    <div class="col-md-3 col-sm-6 col-xs-6 animated" data-animation="fadeInLeft" data-animation-delay="100">
                        <div class="content-box content-box-center">                        
                            <span class="icon-layers color-pasific"></span>
                                <h5>User friendly</h5>
                            <p>Easy-to-use interface for the user.</p>
                      
                        </div>
                    </div>
                    <!-- item one end -->
                    
                    <!-- item two start -->
                    <div class="col-md-3 col-sm-6 col-xs-6 animated" data-animation="fadeInLeft" data-animation-delay="200">
                        <div class="content-box content-box-center">                        
                            <span class="icon-mobile color-pasific"></span>
                                <h5>Mobile Optimzed</h5>
                            <p>Render efficiently on Desktop and Mobile devices.</p>
                      
                        </div>
                    </div>
                    <!-- item two end -->
                    
                    <!-- item three start -->
                    <div class="col-md-3 col-sm-6 col-xs-6 animated" data-animation="fadeInRight" data-animation-delay="300">
                        <div class="content-box content-box-center">                        
                            <span class="icon-flag color-pasific"></span>
                                <h5>Awesome tool</h5>
                            <p>Helps sociologists to track and analyze blogs of particular interests</p>
                      
                        </div>
                    </div>
                    <!-- item three end -->
                    
                    <!-- item four start -->
                    <div class="col-md-3 col-sm-6 col-xs-6 animated" data-animation="fadeInRight" data-animation-delay="400">
                        <div class="content-box content-box-center">                        
                            <span class="icon-briefcase color-pasific"></span>
                                <h5>Research-oriented</h5>
                            <p>Built to review user behavior in the blogosphere.</p>
                      
                        </div>
                    </div>
                    <!-- item four start -->                    
                    
                </div>                
            </div>
        </div>
        
        
      
       
        <!-- Fun Fact Area
        ===================================== -->
        <div id="fact" class="bg-grad-stellar pt100 pb100">
            <div class="container">
                
                <!-- title and short description start -->
                <div class="row">
                    <div class="col-md-12 text-center mb50">                        
                        <h1 class="font-size-normal color-light">
                            <small class="color-light">Tracking at Your Tips</small>
                            Better Solution for Actionable insights on Blogs
                        </h1>
                        
                    </div>
                </div>
                <!-- title and short description end -->
                
                <div class="row">
                    
                    <!-- fun fact left start -->
                    <div class="col-md-3">
                        <div class="row">
                            
                            <!-- fun fact one start -->
                            <!-- <div class="col-md-12 col-sm-6 col-xs-6">
                                <div class="fact">                                    
                                    <div class="fact-number timer" data-perc="">
                                        <span class="factor color-light"></span>
                                    </div>                                    
                                    <span class="fact-title color-light alpha7">Trackers</span>
                                </div>
                            </div> -->
                            <!-- fun fact one end -->
                            
                            <!-- fun fact two start -->
                            <!-- <div class="col-md-12 col-sm-6 col-xs-6">
                                <div class="fact">
                                    <div class="fact-number timer" data-perc="">
                                        <span class="factor color-light"></span>
                                    </div>
                                    <span class="fact-title color-light alpha7">Blog Posts</span>
                                </div>
                            </div> -->
                            <!-- fun fact two end -->
                            
                        </div>
                    </div>
                    <!-- fun fact left end -->
                    
                    <!-- fun fact right start -->
                    <div class="col-md-3 col-md-push-6">
                        <div class="row">
                            
                            <!-- fun fact three start -->
                            <!-- <div class="col-md-12 col-sm-6 col-xs-6">
                                <div class="fact">
                                    <div class="fact-number timer" data-perc="">
                                        <span class="factor color-light"></span>
                                    </div>
                                    <span class="fact-title color-light alpha7">Users</span>
                                </div>
                            </div> -->
                            <!-- fun fact three end -->
                            
                            <!-- fun fact four start -->
                            <!-- <div class="col-md-12 col-sm-6 col-xs-6">
                                <div class="fact">
                                    <div class="fact-number timer" data-perc="">
                                        <span class="factor color-light"></span>
                                    </div>
                                    <span class="fact-title color-light alpha7">Blog Sites</span>
                                </div>
                            </div> -->
                            <!-- fun fact four end -->
                            
                        </div>
                    </div>
                    <!-- fun fact right end -->
                    
                    <div class="col-md-6 col-md-pull-3">
                        <img src="assets/img/other/map.png" alt="macbook" class="img-responsive">
                    </div>
                    
                </div>
                
                <div class="row">
                    <div class="col-sm-8 col-sm-push-2 text-center">
<!--
                        <h4 class="pt25 color-light">Have an idea? We will do the rest!</h4>
                        <p class="pb10 color-light alpha8">Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.</p>
-->
                        <a href="index.jsp" class="button button-md button-gray hover-ripple-out"><span class="color-primary">Get Started Now</span></a>
                    </div>
                </div>
                
            </div><!-- container end -->
        </div><!-- section fun fact end -->
        
          
          <!-- Features Area
        ===================================== -->
        <div id="features" class="pt75 mb25">
                          
              
                    <div class="col-md-12 text-center">
                        <h1 class="font-size-normal">
                             Amazing Features
                            <small class="heading heading-solid center-block"></small>
                        </h1>
                    </div>

                
                <div class="row mt50">
                                       <!-- title description start -->
  <div class="col-md-12 text-center">
  <div class="cols">
			
			<div class="col" ontouchstart="this.classList.toggle('hover');">
			<div class="container-flip">
			<div class="col-md-12">
		    <div class="front" style="background-image:  url('assets/img/features/first.jpg')">
						<div class="inner">
							<p class="color-danger">Posting Frequency</p>
                          						</div>
					</div>
					<div class="back">
						<div class="inner">
							<p>Analyze Traffic Pattern</p>
						</div>
					</div>
				</div>
				</div>
				</div>
				
				
					<div class="col" ontouchstart="this.classList.toggle('hover');">
					<div class="container-flip">
			<div class="col-md-12">
		<div class="front" style="background-image:  url('assets/img/features/second.jpg')">
						<div class="inner">
					<p class="flip-title">Keyword Trends</p>
            
						</div>
					</div>
					<div class="back">
						<div class="inner">
							<p>Search Top Keyword</p>
						</div>
					</div>
				</div>
						</div>
				</div>
				
				
					<div class="col" ontouchstart="this.classList.toggle('hover');">
					<div class="container-flip">
			<div class="col-md-12">
		<div class="front" style="background-image:  url('assets/img/features/third.jpg')">
						<div class="inner">
							<p class="flip-title">Influence</p>
              
						</div>
					</div>
					<div class="back">
						<div class="inner">
							<p>Check influence of Blogs, Blog Posts and Bloggers</p>
						</div>
					</div>
				</div>
				</div>
	  </div>
			
				</div>
                       
                       <div class="cols">
			
			<div class="col" ontouchstart="this.classList.toggle('hover');">
			<div class="container-flip">
			<div class="col-md-12">
		    <div class="front" style="background-image:  url('assets/img/features/sixth.png')">
						<div class="inner">
			<p>Sentiments</p>
              		</div>
					</div>
					<div class="back">
						<div class="inner">
							<p>Analyze general perception</p>
						</div>
					</div>
				</div>
				</div>
				</div>
				
				
					<div class="col" ontouchstart="this.classList.toggle('hover');">
					<div class="container-flip">
			<div class="col-md-12">
		<div class="front" style="background-image:  url('assets/img/features/fourth.png')">
						<div class="inner">
							<p>Network Analysis</p>
              				
						</div>
					</div>
					<div class="back">
						<div class="inner">
							<p>Analyze trend on graphs</p>
						</div>
					</div>
				</div>
						</div>
				</div>
				
				
					<div class="col" ontouchstart="this.classList.toggle('hover');">
					<div class="container-flip">
			<div class="col-md-12">
		<div class="front" style="background-image:  url('assets/img/features/fifth.jpg')">
						<div class="inner">
							<p>Cross Media Analysis</p>
                      
						</div>
					</div>
					<div class="back">
						<div class="inner">
							<p>Analyze social media</p>
						</div>
					</div>
				</div>
				</div>
	  </div>
			
				</div>
                        <!--end of flip card -->

                        
                    </div>
                    
                </div><!-- row end -->                
            </div><!-- container end -->
        </div><!-- section feature end -->
        
   
       
        
        
        <!-- Info Area
        ===================================== -->
        <div id="Info-1" class="bg-gray pt30 bb-solid-1">
            <div class="container">
                <div class="row">                
                    <div class="col-md-8 col-md-offset-2 text-center pb35">
                        <h4>We are here to help you reach success</h4>
                        <a href="index.jsp" class="button button-md button-blue hover-ripple-out mr10">Start Project</a>
                        <a href="https://www.youtube.com/watch?v=YkJVs6QqF9A" class="button button-md button-pasific hover-ripple-out">Watch Video</a>
                    </div>                
                </div>
            </div>
        </div>
        
        
        <!-- General Content Area
        ===================================== -->
        <div id="general-content-1" class="pt100 pb100">
            <div class="container">
                <div class="row">
                    
                    <!-- left content start -->
                    <div class="col-md-6 animated" data-animation="fadeInLeft" data-animation-delay="200">
                        <div class="general-content">
                            <h3 class="mb25 font-size-normal">
                              About COSMOS
                            </h3>
                            <p>At COSMOS, we are studying various aspects of social media and online behavior - the good, bad and the ugly.
							At COSMOS, Dr. Agarwal is directing several projects with funding from the U.S.
							Research at COSMOS has made foundational contributions to computational social network analysis to study digital/cyber campaign coordination,
							identify powerful actors and groups, study propaganda dissemination, and monitor cyber threats through social media. 
							The applicational contributions of the research include, but not limited to, digital campaign coordination, propaganda dissemination analysis, 
							event analysis and monitoring cyberthreats through social media</p>
                            <a class="button button-md button-pasific hover-ripple-out" href="https://sites.google.com/a/ualr.edu/socialcomputing/home">Learn more</a>
                            
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <!-- left content end -->
                    
                    <!-- right content start -->
                    <div class="col-md-5 col-md-push-1 animated" data-animation="fadeInRight" data-animation-delay="200">
					
                        <img src="assets/img/vegasimg/cosmos.jpg" class="img-responsive pull-right" style="height: 55%; width: 55%">
                    </div>
                    <!-- right content end -->
                    
                </div>
            </div>
        </div>
        
    
           
        
         <div id="blogs" class="bg-gray pt70 pb50">
            <div class="container">
                
                <!-- title start -->
                <div class="row text-center mb25">
                    <h1 class="font-size-normal">
                           Our Sponsors
                        <small class="heading heading-solid center-block"></small>
                    </h1>
                </div>
                <!-- title end -->
                
                <div class="row text-center">
                    <div class="col-md-12">                    
                        <div id="owlShop">
                            
                            <!-- shop item start -->
                            <div class="shop-item-container-out">
                                <div class="shop-item-container-in">
                                    <div class="shop-label">-50%</div>
                                    <img src="assets/sponsor/nsf.jpg" alt="shop item" class="img-responsive center-block">
                                    <span class="shop-item-price">U.S. National Science
Foundation</span>
                                    
                                </div>
                                
                            </div>
                            <!-- shop item end -->
                            
                            <!-- shop item start -->
                            <div class="shop-item-container-out">
                                <div class="shop-item-container-in">
                                    <img src="assets/sponsor/oonr.jpg" alt="U.S. Office of Naval Research" class="img-responsive center-block">
                                    <span class="shop-item-price">U.S. Office of Naval &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Research <br/></span> 
                                  
                                </div>

                            </div>
                            <!-- shop item end -->
                            
                            <!-- shop item start -->
                            <div class="shop-item-container-out">
                                <div class="shop-item-container-in">
                                    <img src="assets/sponsor/aflr.jpg" alt="U.S. Air Force Research" class="img-responsive center-block">
                                    <span class="shop-item-price">U.S. Air Force Research
Lab, U.S. Army Research Office</span>
                                    
                                </div>

                                
                            </div>
                            <!-- shop item end -->
                            
                           
                            
                            <!-- shop item start -->
                            <div class="shop-item-container-out">
                                <div class="shop-item-container-in">
                                    <img src="assets/sponsor/darpa.jpg" alt="U.S. Defense Advanced Research Projects Agency" class="img-responsive center-block">
                                    <span class="shop-item-price">U.S. Defense Advanced Research Projects Agency</span>
                                    
                                </div>

                               
                            </div>
                            <!-- shop item end -->
                            
                          
                            
                            <!-- shop item start -->
                            
                            <!-- shop item end -->
                            
                            <!-- shop item start -->
                           
                            <!-- shop item end -->

                        </div><!-- #owlShop end -->
                    </div><!-- col-md end -->
                </div><!-- row end -->
                
                <div class="row mt25 mb50">
                    <div class="col-md-2 col-md-offset-5 text-center">                    
                        <i class="fa fa-angle-left shop-control-prev"></i>
                        <i class="fa fa-angle-right shop-control-next"></i>                    
                    </div>
                </div>
                
            </div><!-- container end -->
        </div><!-- section shop end -->
        
      
        
        
        
        <!-- Testimonial Area
        ===================================== -->
        <div id="testimonial" class="pt75 pb75">
            <div class="container">
                
                <!-- title start -->
                <div class="row text-center mb25">
                    <h1 class="font-size-normal">
                        <small>Testimonials</small>
                        What Our Clients Say About Us
                        <small class="heading heading-solid center-block"></small>
                    </h1>
                </div>
                <!-- title end -->
                
                <div class="row">
                    
                    <div class="col-sm-12">                        
                        <div class="row">
                            
                            <div id="owlSectionThreeItem" class="owl-carousel">
                                    
                                <!-- Testimonial Item start -->
                                <div class="testimonial testimonial-triangle-isosceles bottom-left">
                                    <div class="testimonial-body">
                                        <p>
                                            Blogtrackers is the best tool so far. So easy to use. Highly recommended!
                                        </p>
                                    </div>
                                    <div class="testimonial-footer">
                                        <img src="assets/img/other/photo-1.jpg" alt="testimonial author" class="img-responsive img-circle">
                                        <i class="fa fa-quote-left"></i>
                                        Mukti Barole <a href="#"> </a>
                                    </div>
                                </div>
                                <!-- Testimonial Item end -->

                                <!-- Testimonial Item start -->
                                <div class="testimonial testimonial-triangle-isosceles bottom-left">
                                    <div class="testimonial-body">
                                        <p>
                                            Good tool for sentiments analysis
                                        </p>
                                    </div>
                                    <div class="testimonial-footer">
                                        <img src="assets/img/other/photo-2.jpg" alt="testimonial author" class="img-responsive img-circle">
                                        <i class="fa fa-quote-left"></i>
                                        Samer Al-khateeb <a href="#"></a>
                                    </div>
                                </div>
                                <!-- Testimonial Item end -->

                                <!-- Testimonial Item start -->
                                <div class="testimonial testimonial-triangle-isosceles bottom-left">
                                    <div class="testimonial-body">
                                        <p>
                                            You can see the trend of a keyword over a period of time with a click on a button. 
                                        </p>
                                    </div>
                                    <div class="testimonial-footer">
                                        <img src="assets/img/other/photo-4.jpg" alt="testimonial author" class="img-responsive img-circle">
                                        <i class="fa fa-quote-left"></i>
                                       Nihal Hussain <a href="#"> </a>
                                    </div>
                                </div>
                                <!-- Testimonial Item end -->

                                <!-- Testimonial Item start -->
                                <div class="testimonial testimonial-triangle-isosceles bottom-left">
                                    <div class="testimonial-body">
                                        <p>
                                            Great interface, smooth and efficient
                                        </p>
                                    </div>
                                    <div class="testimonial-footer">
                                        <img src="assets/img/other/photo-1.jpg" alt="testimonial author" class="img-responsive img-circle">
                                        <i class="fa fa-quote-left"></i>
                                        Kiran Bandeli <a href="#"> </a>
                                    </div>
                                </div>
                                <!-- Testimonial Item end -->

                                <!-- Testimonial Item start -->
                               
                                <!-- Testimonial Item end -->

                                <!-- Testimonial Item start -->
                               
                                <!-- Testimonial Item end -->

                            </div><!-- owlSectionThreeItem end -->
                        </div><!-- row end -->
                    </div><!-- col end -->
                    
                </div><!-- row end -->
            </div><!-- container end -->
        </div><!-- section testimonial end -->
        
          
        
        
        
           
        <!-- footer Area
        ===================================== -->
        <div id="footer" class="footer-two pt0 bg-grad-stellar">
          
            <div class="container-fluid pt20">
                <div class="container">
                    <div class="row">

                        <!-- copyright start -->
                        <div class="col-md-12 col-sm-12 col-xs-12 text-center">
                            <p class="color-light">Copyright &copy;2017 Blogtrackers All rights reserved.</p>
                        </div>
                        <!-- copyright end -->

                      

                    </div><!-- row end -->
                </div><!-- container end -->
            </div><!-- container-fluid end -->
        </div><!-- footer end -->
        
        
        <!-- JQuery Core
        =====================================-->
        <script src="assets/js/core/jquery.min.js"></script>
        <script src="assets/js/core/bootstrap.min.js"></script>
        
        <!-- Magnific Popup
        =====================================-->
        <script src="assets/js/magnific-popup/jquery.magnific-popup.min.js"></script>
        <script src="assets/js/magnific-popup/magnific-popup-zoom-gallery.js"></script>
        
        <!-- Progress Bars
        =====================================-->
        <script src="assets/js/progress-bar/bootstrap-progressbar.js"></script>
        <script src="assets/js/progress-bar/bootstrap-progressbar-main.js"></script>
        
        <!-- Typed
        =====================================-->
        <script src="assets/js/typed/typed.min.js"></script>
        
        <!-- JQuery Main
        =====================================-->
        <script src="assets/js/main/jquery.appear.js"></script>
        <script src="assets/js/main/isotope.pkgd.min.js"></script>
        <script src="assets/js/main/parallax.min.js"></script>
        <script src="assets/js/main/jquery.countTo.js"></script>
        <script src="assets/js/main/owl.carousel.min.js"></script>
        <script src="assets/js/main/jquery.sticky.js"></script>
        <script src="assets/js/main/imagesloaded.pkgd.min.js"></script>
        <script src="assets/js/main/main.js"></script>  
        <script src="assets/vegas/vegas.js"></script> 
        
		 <script>
			$("header").vegas({
    slides: [
        { src: "assets/img/vegasimg/1.jpg" },
         { src: "assets/img/vegasimg/22.jpg" },
		   { src: "assets/img/vegasimg/33.jpg" }
		
        
     
     ],
	
				
	animation: [ 'kenburnsLeft', 'kenburnsDown', 'kenburnsUp', 'kenburnsRight' ],
overlay:true,
				 shuffle: true,
				loop:true,
		timer:false
});
	
	
		</script>
    </body>
</html>