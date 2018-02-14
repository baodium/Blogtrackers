<%-- 
    Document   : dashboard
    Created on : 28-Aug-2017, 22:23:45
    Author     : Omnibus_03
--%>
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
	<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%
if(session.getAttribute("tracker")==null && request.getParameter("tracker")==null)
{

	session.setAttribute("nblogs", 0);
	session.setAttribute("nblogposts", 0);
	session.setAttribute("nbloggers", 0);
	session.setAttribute("npsenti", 0);
	session.setAttribute("nnsenti", 0);
	session.setAttribute("nloc", "");
	session.setAttribute("data", "");
	session.setAttribute("nlang", "");
	session.setAttribute("series", "");

}
else
{
if(session.getAttribute("tree")!=""){
	ArrayList<ArrayList<String>> tree =(ArrayList<ArrayList<String>>) session.getAttribute("tree");
	String str = "[\n";

for(int i=0;i<tree.size();i++)
{
	//out.println(tree.get(i).get(3));
	if((tree.get(i).get(3)!=null) && (tree.get(i).get(3).contains("null")))
	{

		//out.println("n value");

	}
	else
	{
		//out.println(tree.get(i).get(3));
		str = str + "{\n"+"\"key\" : \" "+tree.get(i).get(1)+" \",\n\"region\" : \""+tree.get(i).get(2)+"\",\n\"value\" : "+tree.get(i).get(3)+"\n},\n";

	}
}
str =str.substring(0, str.length() - 1);
str = str.replaceAll(",$", "");
str=str+"\n]";
//out.println(getServletContext().getRealPath("/"));


//always give the path from root. This way it almost always works.
String nameOfTextFile = getServletContext().getRealPath("/")+"countries.json";
try {
    PrintWriter pw = new PrintWriter(new FileOutputStream(nameOfTextFile,false));
    pw.println(str);
    //clean up
    pw.close();
} catch(IOException e) {
   //out.println(e.getMessage());
}
}
else
{

	String str="";
	//always give the path from root. This way it almost always works.
	String nameOfTextFile = getServletContext().getRealPath("/")+"countries.json";
	try {
	    PrintWriter pw = new PrintWriter(new FileOutputStream(nameOfTextFile,false));
	    pw.println(str);
	    //clean up
	    pw.close();
	} catch(IOException e) {
	 //  out.println(e.getMessage());
	}
}
}
%>

<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
	else if(session.getAttribute("tracker") == null || session.getAttribute("tracker") =="")
    { 
   		response.sendRedirect("trackerlist.jsp");
    }
	
	session.setAttribute("pre-selected-blogs", "");
	session.setAttribute("initiated_search_term", "");
	
     ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
    String tracker_id = (null == session.getAttribute("tid")) ? "" : session.getAttribute("tid").toString();
	
    
    
%>
 <jsp:include page="include_top.jsp"></jsp:include>
 
 <style>

#chart {
  background: #fff;
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  width:100% !important;
}

#chart svg:last-child
{
display:none;
}

.title {
    font-weight: bold;
    font-size: 24px;
    text-align: center;
    margin-top: 6px;
    margin-bottom: 6px;
}
text {
  pointer-events: none;
}

.grandparent text {
  font-weight: bold;
}
#chart svg
{
width:100%;
}
.grandparent rect
{
  width:100% !important; 
/*  max-width:900px; */
}

rect {
  fill: none;
  
  width:100% !important; 
  /* max-width:900px;  */
  stroke: #fff;
}

rect.parent,
.grandparent rect {
  stroke-width: 2px;
}

rect.parent {
    pointer-events: none;
}

.grandparent rect {
  fill: orange;
}

.grandparent:hover rect {
  fill: #ee9700;
}

.children rect.parent,
.grandparent rect {
  cursor: pointer;
}

.children rect.parent {
  fill: #bbb;
  fill-opacity: .5;
}

.children:hover rect.child {
  fill: #bbb;
}

</style>
<script type="text/javascript" src="assets/js/jquery.flip.min.js"></script>
	<!-- Page header -->
	<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<a href="<%=request.getContextPath()%>/analytics.jsp"><i class="icon-arrow-left52 position-left"></i></a>
					<span class="text-semibold">Dashboard</span>
					
				</h4>
					<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List  </a></li>
					<li><a href="edittracker.jsp" title="Edit <%=session.getAttribute("tracker")%> Tracker"><%=session.getAttribute("tracker")%></a></li>
					<li><a href="analytics.jsp">Analytics</a></li>
						<li class="active">Dashboard</li>
				</ul>
	</div>
			<!--  <div class="heading-elements">
				<div class="heading-btn-group">
					<button type="button" onclick="location.href='setup_tracker.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-plus2"></i></b> Setup a new tracker</button>
					<button type="button" href="javascript:void(0);" onclick="javascript:introJs().start();" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-reading "></i></b> Tour Page</button>
				 
					<button id="google_translate_element" class="btn btn-default"><script type="text/javascript">
function googleTranslateElementInit() {
  new google.translate.TranslateElement({pageLanguage: 'ar', layout: google.translate.TranslateElement.InlineLayout.SIMPLE}, 'google_translate_element');
}
</script><script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
				
				</button>
			</div>
		</div> -->
		<!--<div class="form-group">
		<form action="<%=request.getContextPath()%>/search" method="post" class="main-search">
				
		 	<div class="col-md-12">
				<input type="hidden" name="search" value="yes">
				<div class="input-group">
				<input type="text" name="term" id="term" class="form-control" placeholder="Enter a keyword to search" id="searchtextbox" autocomplete="off">
					<span class="input-group-btn" style="padding-left:0px;"><button type="submit" class="btn btn-primary">Search</button></span>
											

				</div>
				</div>
				
		</form>
		</div>-->


			<!--  <div class="heading-elements">
				<div class="heading-btn-group">
					<a href="#" class="btn btn-link btn-float has-text text-size-small"><i class="icon-bars-alt text-indigo-400"></i><span>Statistics</span></a>
					<a href="#" class="btn btn-link btn-float has-text text-size-small"><i class="icon-calendar5 text-indigo-400"></i> <span>Schedule</span></a>
				</div>
			</div>-->
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


  <!--   <div id="card-2" class="card">
      <div class="front">
          Front: Cursus aliquet mus et sociis, placerat adipiscing a placerat magnis integer nisi lacus in, turpis porttitor? Lectus nunc dis in porta, montes lacus. Tortor. Pid sit nisi eu nec aenean.
      </div>
      <div class="back">
          <a href="http://google.com">link</a>
          Back: Dolor scelerisque ridiculus! Mus? Augue, montes, montes proin rhoncus vel a parturient dapibus eros? Penatibus nascetur. In turpis nisi elementum nascetur habitasse augue egestas, in ac rhoncus odio porttitor turpis.
          <button>button</button>
      </div> 
    </div>-->

    <script type="text/javascript">
    $(function(){
      $("#card-1").flip({
    	  axis: "x",
          reverse: true,
          trigger: 'manual',
        autoSize: true
      });
      $("#card-2").flip({
        axis: "x",
        reverse: true,
       	trigger: 'manual'
      });
      $("#toggle-btn").click(function(){
    	  $("#card-2").flip('toggle');  
      })
       $("#toggle-btn2").click(function(){
    	  $("#card-1").flip('toggle');  
      })
    });
    </script> 
				<div class="col-md-12">
						<div data-intro="View statistics about your tracker such as number of blogs, number of bloggers, positive and negative sentiments" data-step="2" class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Dashboard Statistics<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
				                		
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body" align="center">
							<div class="col-md-1">

</div>
							<div class="col-md-2 col-sm-6">

								<!-- Available hours -->
								<div class="panel text-center">
									<div class="panel-body">
									

					                	<!-- Progress counter -->
										<div class="content-group-sm svg-center position-relative" id="hours-available-progress"><svg width="76" height="76"><g transform="translate(38,38)"><path class="d3-progress-background" d="M0,38A38,38 0 1,1 0,-38A38,38 0 1,1 0,38M0,36A36,36 0 1,0 0,-36A36,36 0 1,0 0,36Z" style="fill: rgb(240, 98, 146);"></path><path class="d3-progress-foreground" filter="url(#blur)" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); stroke: rgb(240, 98, 146);"></path><path class="d3-progress-front" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); fill-opacity: 1;"></path></g></svg><h2 class="mt-15 mb-5">${nblogs}</h2><i class="icon-book text-pink-400 counter-icon" style="top: 22px"></i><div>Blogs</div></div>
										<!-- /progress counter -->


										

									</div>
								</div>
								<!-- /available hours -->

							</div>
							
						<div class="col-md-2 col-sm-6">

								<!-- Productivity goal -->
								<div class="panel text-center">
									<div class="panel-body">
										

										<!-- Progress counter -->
										<div class="content-group-sm svg-center position-relative" id="goal-progress"><svg width="76" height="76"><g transform="translate(38,38)"><path class="d3-progress-background" d="M0,38A38,38 0 1,1 0,-38A38,38 0 1,1 0,38M0,36A36,36 0 1,0 0,-36A36,36 0 1,0 0,36Z" style="fill: rgb(92, 107, 192);"></path><path class="d3-progress-foreground" filter="url(#blur)" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.3834279937087,-16.179613079472855L-32.573773888776664,-15.328054496342704A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(92, 107, 192); stroke: rgb(92, 107, 192);"></path><path class="d3-progress-front" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.3834279937087,-16.179613079472855L-32.573773888776664,-15.328054496342704A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(92, 107, 192); fill-opacity: 1;"></path></g></svg><h2 class="mt-15 mb-5">${nbloggers}</h2><i class="icon-earth text-indigo-400 counter-icon" style="top: 22px"></i><div>Bloggers</div></div>
										<!-- /progress counter -->

										

									</div>
								</div>
								<!-- /productivity goal -->

							</div>
							
								<div class="col-md-2">

								<!-- Available hours -->
								<div class="panel text-center">
									<div class="panel-body">
									

					                	<!-- Progress counter -->
										<div class="content-group-sm svg-center position-relative" id="hours-available-progress"><svg width="76" height="76"><g transform="translate(38,38)"><path class="d3-progress-background" d="M0,38A38,38 0 1,1 0,-38A38,38 0 1,1 0,38M0,36A36,36 0 1,0 0,-36A36,36 0 1,0 0,36Z" style="fill: rgb(240, 98, 146);"></path><path class="d3-progress-foreground" filter="url(#blur)" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); stroke: rgb(240, 98, 146);"></path><path class="d3-progress-front" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); fill-opacity: 1;"></path></g></svg><h2 class="mt-15 mb-5">${nblogposts}</h2><i class="icon-comment text-pink-400 counter-icon" style="top: 22px"></i><div>Blog post</div></div>
										<!-- /progress counter -->


										

									</div>
								</div>
								<!-- /available hours -->

							</div>

  
                        
                    	<div class="col-md-2 col-sm-6">

								<!-- Productivity goal -->
								<div class="panel text-center">
									<div class="panel-body">
										

										<!-- Progress counter -->
										<div class="content-group-sm svg-center position-relative" id="goal-progress"><svg width="76" height="76"><g transform="translate(38,38)"><path class="d3-progress-background" d="M0,38A38,38 0 1,1 0,-38A38,38 0 1,1 0,38M0,36A36,36 0 1,0 0,-36A36,36 0 1,0 0,36Z" style="fill: rgb(92, 107, 192);"></path><path class="d3-progress-foreground" filter="url(#blur)" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.3834279937087,-16.179613079472855L-32.573773888776664,-15.328054496342704A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(92, 107, 192); stroke: rgb(92, 107, 192);"></path><path class="d3-progress-front" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.3834279937087,-16.179613079472855L-32.573773888776664,-15.328054496342704A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(92, 107, 192); fill-opacity: 1;"></path></g></svg><h2 class="mt-15 mb-5">${npsenti}</h2><i class="icon-plus-circle2 text-indigo-400 counter-icon" style="top: 22px"></i><div>Positive Sentiments</div></div>
										<!-- /progress counter -->

										

									</div>
								</div>
								<!-- /productivity goal -->

							</div>
							
								<div class="col-md-2 col-sm-6">

								<!-- Available hours -->
								<div class="panel text-center">
									<div class="panel-body">
									

					                	<!-- Progress counter -->
										<div class="content-group-sm svg-center position-relative" id="hours-available-progress"><svg width="76" height="76"><g transform="translate(38,38)"><path class="d3-progress-background" d="M0,38A38,38 0 1,1 0,-38A38,38 0 1,1 0,38M0,36A36,36 0 1,0 0,-36A36,36 0 1,0 0,36Z" style="fill: rgb(240, 98, 146);"></path><path class="d3-progress-foreground" filter="url(#blur)" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); stroke: rgb(240, 98, 146);"></path><path class="d3-progress-front" d="M2.326828918379971e-15,-38A38,38 0 1,1 -34.38342799370878,16.179613079472677L-32.57377388877674,15.328054496342538A36,36 0 1,0 2.204364238465236e-15,-36Z" style="fill: rgb(240, 98, 146); fill-opacity: 1;"></path></g></svg><h2 class="mt-15 mb-5">${nnsenti}</h2><i class="icon-minus-circle2 text-pink-400 counter-icon" style="top: 22px"></i><div>Negative Sentiments</div></div>
										<!-- /progress counter -->


										

									</div>
								</div>
								<!-- /available hours -->

							</div>
							
							<div class="col-md-1">
</div>
							
				
				       
					
							</div>
						</div>
					</div>
				
				
				      
					
				</div>
				<!-- /main charts -->


				<!-- Dashboard content -->
				<div class="row">
				<div id="card-1" class="card">
				<div class="col-lg-6">
				<div data-intro="This portion will give information about location distribution of blogsites in your tracker " data-step="3" class="panel panel-primary">
					<div class="panel-heading">
						<h5 class="panel-title">Blogsites Location Distribution</h5>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="reload"></a></li>
<!--		                		<li><a data-action="close"></a></li>-->
		                	</ul>
	                	</div>
					</div>

					<div class="panel-body" style="min-height:600px;">
					<button class="btn btn-primary icon-flip-vertical2" style="position:absolute; z-index:99; top:5px ; right:5px;" id="toggle-btn2"></button>
					<div class="front">
						<div id="world-map-gdp" class="col-md-12 col-sm-12 col-xs-12"
											style="height: 420px;"></div>
											</div>
				<div class="back">
					<div class="col-md-12" style="overflow-y: scroll; margin-top:30px;">
											<table class="table table-striped">
												<tbody>
													<c:forEach items="${nloc}" var="v1" begin="0" end="5">
														<tr>
															<td  class="fs15 fw700 text-left">${v1[1]}</td>
															<td >${v1[0]}%</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
										</div>
<!--						<p class="content-group">Example of a <code>choropleth</code> world map. A choropleth map is a thematic map in which areas are shaded or patterned in proportion to the measurement of the statistical variable being displayed on the map. The choropleth map provides an easy way to visualize how a measurement varies across a geographic area or it shows the level of variability within a region. This example displays GDP by country, data stored in <code>json</code> file.</p>-->
						
						
						
					</div>
					
				</div>
				</div>
				</div>
				
				<div class="col-lg-6">
				<div id="card-2" class="card">
				<div data-intro="This portion will give information about language distribution of blogsites in your tracker " data-step="3" class="panel panel-primary">
					<div class="panel-heading">
						<h5 class="panel-title">Blogsites Language Distribution</h5>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="reload"></a></li>

		                	</ul>
	                	</div>
	                	
					</div>

					<div class="panel-body" style="min-height:600px;">
					<button class="btn btn-primary icon-flip-vertical2" style="position:absolute; z-index:99; top:5px; right:5px;" id="toggle-btn"></button>
					<div class="front">
						<div align="center" class="col-md-12 bubble"></div>


										</div>
				<div class="back">
			<div class="col-md-12">
											<table class="table table-striped">
    <thead>
    <br/>

        <th>Language</th>
        <th>Amount</th>

    </thead>
    <tbody>
													<c:forEach items="${nlg}" var="v1" begin="0" end="5">
														<tr>

				<td class="fs15 fw700 text-left">${fn:toUpperCase(fn:substring(v1[1], 0, 1))}${fn:toLowerCase(fn:substring(v1[1], 1,fn:length(v1[1])))}</td>
															<td><fmt:formatNumber type = "number"
         maxFractionDigits = "3" value = "${v1[0]}" /></td>
														</tr>
													</c:forEach>
												</tbody>
 									 </table>
  </div>						
  </div>
					
					
										</div>
					</div>
					</div>
					</div>
		<div class="col-lg-12">
					
					<div data-intro="This portion will give information about blog posts per blog site in your tracker " data-step="4" class="panel panel-primary">
					<div class="panel-heading">
						<h5 class="panel-title">Distribution of blog posts per blog site</h5>
						<div class="heading-elements">
							<ul class="icons-list">
		                		<li><a data-action="collapse"></a></li>
		                		<li><a data-action="reload"></a></li>

		                	</ul>
	                	</div>
					</div>

					<div class="panel-body">
					<div id="chart"></div>

							<script type="text/javascript"
								src="https://www.gstatic.com/charts/loader.js"></script>
							<script type="text/javascript">
      google.charts.load('current', {'packages':['treemap']});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
        	['Tracker','Parent','value'],
        	['${tracker}',null,0],
        <c:forEach var="v1" items="${tree}">
        		<c:choose>
        			<c:when test="${empty v1[1]}">
        				['${v1[2]}. ${v1[3]}','${v1[2]}',${v1[3]}],
        			</c:when>
        			<c:otherwise>
        				<c:choose>
        					<c:when test="${v1[1] eq v1[2]}">
								['${v1[1]}. ${v1[3]}','${v1[2]}',${v1[3]}],
 							</c:when>
							<c:otherwise>
								['${v1[1]} ${v1[3]}','${v1[2]}',${v1[3]}],
							</c:otherwise>
						</c:choose>
					</c:otherwise>
			 </c:choose>
        </c:forEach>
        ]);

       tree = new google.visualization.TreeMap(document.getElementById('chart_div'));

       tree.draw(data, {
          minColor: '#f00',
          midColor: '#ddd',
          maxColor: '#0d0',
          headerHeight: 15,
          fontColor: 'black',
          showScale: true
        });

     }
    </script>
											
					</div>
					</div>
				</div>
				</div>
				
				</div>
				<!-- /dashboard content -->
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	<!-- /page container -->


	<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
	
	
	<!-- Dependencies -->
  <jsp:include page="pagedependencies/dashboard.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
