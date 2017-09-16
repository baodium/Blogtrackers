<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Blog Trackers&reg; | </title>

      <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="${pageContext.request.contextPath}/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="${pageContext.request.contextPath}/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- bootstrap-progressbar -->
    <link href="${pageContext.request.contextPath}/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="${pageContext.request.contextPath}/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
    <!-- jQuery custom content scroller -->
    <link href="${pageContext.request.contextPath}/vendors/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.min.css" rel="stylesheet"/>


    <!-- Custom Theme Style -->
    <link href="${pageContext.request.contextPath}/build/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
     <jsp:include page="new_sidebar.jsp"></jsp:include>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>
              <div class="nav toggle" style="position: absolute; right: 35%; width: 300px; " ></div> 
              <select id="heard" class="form-control" required>
                            <option value="">Name of Tracker</option>
                            <option value="">Name of Tracker 2</option>
                            <option value="">Name of Tracker 3</option>
                            <option value="">Name of Tracker 4</option>
             </select>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                   
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a href="javascript:;"> Profile</a></li>
                    <li>
                      <a href="javascript:;">
                        <span class="badge bg-red pull-right"></span>
                        <span>Settings</span>
                      </a>
                    </li>
                    <li><a href="javascript:;">Help</a></li>
                    <li><a href="${pageContext.request.contextPath}/test_logout.jsp"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                </li>
                <li role="presentation" class="dropdown">
                  <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope-o"></i>
                    <span class="badge bg-green">6</span>
                  </a>
                  <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>Sender 1</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Message....  
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>Sender 2</span>
                          <span class="time">20 mins ago</span>
                        </span>
                        <span class="message">
                           Message....
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>Sender 3</span>
                          <span class="time">45 mins ago</span>
                        </span>
                        <span class="message">
                          Message....
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span class="image"><img src="images/img.jpg" alt="Profile Image" /></span>
                        <span>
                          <span>Sender 4</span>
                          <span class="time">24 hours ago</span>
                        </span>
                        <span class="message">
                           Message....
                        </span>
                      </a>
                    </li>
                    <li>
                      <div class="text-center">
                        <a>
                          <strong>See All Alerts</strong>
                          <i class="fa fa-angle-right"></i>
                        </a>
                      </div>
                    </li>
                  </ul>
                </li>
              </ul>
            </nav>
          </div>
        </div>
        <div class="right_col" role="main">
         <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
              <div class="dashboard_graph">
               
                  
                     <div class="x_panel">
                    <div class="x_title">
                      <h3> Blogs to Twitter <small> visit Twitter Page </small></h3>
                     
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                     </div>
                    </div>
                  </div>
                </div>
        
            <div class="col-md-12 col-sm-12 col-xs-12">
              <div class="dashboard_graph">
                     <div class="x_panel">
                    <div class="x_title">
                      <h3> Twitter to Blogs <small> Inspect and Crawl</small></h3>
                     
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                     </div>
                    </div>
                  </div>
                </div>
                
                <div class="col-md-12 col-sm-12 col-xs-12">
              <div class="dashboard_graph">
                     <div class="x_panel">
                    <div class="x_title">
                      <h3> Extract Tracker IDs and Related Sites <small> Inspect and Crawl</small></h3>
                     
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                     </div>
                    </div>
                  </div>
                </div>
                
                 <div class="col-md-12 col-sm-12 col-xs-12">
              <div class="dashboard_graph">
                     <div class="x_panel">
                    <div class="x_title">
                      <h3> Blog Metadata <small> IP Address, Locations, domain name registration details</small></h3>
                     
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                     </div>
                    </div>
                  </div>
                </div>
        <!-- /top navigation -->
        <!-- footer content -->
        <div class="footer_fixed">
        <footer>
          <div class="pull-right" style="height:6px;">
            Blogtrackers 
          </div>
          <div class="clearfix"></div>
          
        </footer>
        </div>
        <!-- /footer content -->
        <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="${pageContext.request.contextPath}/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
    <!-- Chart.js -->
    <script src="${pageContext.request.contextPath}/vendors/Chart.js/dist/Chart.min.js"></script>
    <!-- gauge.js -->
    <script src="${pageContext.request.contextPath}/vendors/gauge.js/dist/gauge.min.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="${pageContext.request.contextPath}/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>
    <!-- Skycons -->
    <script src="${pageContext.request.contextPath}/vendors/skycons/skycons.js"></script>
    <!-- Flot -->
    <script src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.pie.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.time.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.stack.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.resize.js"></script>
    <!-- Flot plugins -->
    <script src="${pageContext.request.contextPath}/production/js/flot/jquery.flot.orderBars.js"></script>
    <script src="${pageContext.request.contextPath}/production/js/flot/date.js"></script>
    <script src="${pageContext.request.contextPath}/production/js/flot/jquery.flot.spline.js"></script>
    <script src="${pageContext.request.contextPath}/production/js/flot/curvedLines.js"></script>
    <!-- JQVMap -->
    <script src="${pageContext.request.contextPath}/vendors/jqvmap/dist/jquery.vmap.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
    <script src="${pageContext.request.contextPath}/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>

    
    

    <script src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>

    
    <!-- JQVMap -->
        
         </body>
</html>
