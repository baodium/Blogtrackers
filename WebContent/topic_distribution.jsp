<%-- 
    Document   : Topic Distribution
    Created on : 21-January-2018
    Author     : Adigun Adekunle
    
    import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.Month;

import java.io.IOException;

import org.supercsv.io.CsvListWriter;
import org.supercsv.io.ICsvListWriter;
import org.supercsv.prefs.CsvPreference;
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="blogtracker.util.*"%>
<%@page import="authentication.*"%>
<%@page import="java.text.*"%>
<%@page import="java.time.Month"%>
<%-- 
<%@page import="org.supercsv.io.CsvListWriter"%>
<%@page import="org.supercsv.io.ICsvListWriter"%>
<%@page import="org.supercsv.prefs.CsvPreference"%>
--%>
<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	ArrayList result = new ArrayList();
	
	
	 
	if (username == null || username == "") {
		response.sendRedirect("index.jsp");
	}
	else
	{    ArrayList userinfo = (ArrayList)session.getAttribute("userinfo");
        if(session.getAttribute("tracker") == null || session.getAttribute("tracker") =="")
        { 
       		response.sendRedirect("trackerlist.jsp");
        }
	}
	
	
	if(request.getParameter("tracker")!=null)
	{
	String tracker = request.getParameter("tracker");
	String userName = (String) session.getAttribute("user");
	//TopicDistributionUtil td = new TopicDistributionUtil();
	
	}
	if(request.getParameter("datepicked") != null)
	{
		try
		{
		String date = request.getParameter("datepicked");
		session.setAttribute("datepicked", date);
		

		//System.out.println("Filter Value"+filtervalue );
		//System.out.println("Date for Request "+date);
		// addition by adekunle blog network by date range
		date = session.getAttribute("datepicked").toString();
		String arr[] = date.split("-", 2);
		String sdate1 = arr[0];   
		String sdate2 = arr[1];
		sdate2=sdate2.trim();  // date 2 will have space trim it
		int mm1=Month.valueOf(sdate1.substring(0, sdate1.indexOf(' ')).toUpperCase()).getValue();
		int mm2=Month.valueOf(sdate2.substring(0, sdate2.indexOf(' ')).toUpperCase()).getValue();

		String tempdate[] = sdate1.split(" ", 3);
		String dd=tempdate[1];
		String year=tempdate[2];
		String d1 = year+"-"+mm1+"-"+dd;
		d1=d1.replace(" ", "");

		String tempdate2[] = sdate2.split(" ", 3);
		dd=tempdate2[1];
		year=tempdate2[2];
		String d2 = year+"-"+mm2+"-"+dd;
		d2=d2.replace(" ", "");

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 

		Date startdate = df.parse(d1);
		Date enddate = df.parse(d2);
		
		
// initalize tracker name and user session
	String tracker = (String) session.getAttribute("tracker");
	String userName = (String) session.getAttribute("user");
	//TopicDistributionUtil td = new TopicDistributionUtil();
	//td.GetTopicAllTopics(startdate, enddate, userName, tracker);
	//System.out.println(td);
		String queryStr  = "select title,date,influence_score from blogtrackers.blogposts where date >='"+startdate+"' and date<='"+enddate+"'  ";
		 result = new DBConnector().query(queryStr);
		//System.out.println(result);
		
		}
		
		catch(Exception e)
		{
			
		}

	}else{
		try{
		String queryStr  = "select title,date,influence_score from blogtrackers.blogposts LIMIT 20 ";
		 result = new DBConnector().query(queryStr);
		 //System.out.println(result);
		}catch(Exception e){}
	}
	
	if(result != null && result.size()>0){ 
		try{
		 String path=application.getRealPath("/").replace('\\', '/')+"assets/demo_data/dashboard/";
		 path = path.replace("build/", "");
		 String filePath = path;//"c:/apache-tomcat/";
		 
		   PrintWriter pw = new PrintWriter(new File(filePath+"test.csv"));
	       StringBuilder sb = new StringBuilder();
	       
	       	sb.append("key");
	       	sb.append(',');
		    sb.append("value");
		    sb.append(',');
		    sb.append("date");
		    sb.append('\n');
	       
		    /*
		    final String[][] csvMatrix = new String[3][3];
	        csvMatrix[0][0] = "key";
	        csvMatrix[0][1] = "value";
	        csvMatrix[0][2] = "date";
	       
			*/
	       // writeCsv(csvMatrix);
	        int k=1;
			for(int i=0; i<result.size(); i++){
				ArrayList blogs = (ArrayList)result.get(i);
				
				String title =  blogs.get(0).toString();
				String datee =  blogs.get(1).toString();
				String influence =  blogs.get(2).toString();
				//System.out.println(datee);
				String[] dt = datee.split(" ");
				String[] dat = dt[0].split("-");
				
				String  date = "";
				if(dat.length>2){
					date = dat[2]+"/"+dat[1]+"/"+dat[0]+" "+"00:00";
				}
				title = title.replace("\"", "\"\"");
				title = title.replace(",", " ");
			
				int inf = Integer.parseInt(influence);
			    sb.append(title);
			    sb.append(',');
			    sb.append(inf);
			    sb.append(',');
			    sb.append(date);
			    sb.append('\n');
			    
			    sb.append(title);
			    sb.append(',');
			    sb.append(inf);
			    sb.append(',');
			    sb.append((inf+inf));
			    sb.append('\n');
			    
			   
			    
				/*
				 csvMatrix[k][0] = title;
			     csvMatrix[k][1] = influence;
			     csvMatrix[k][2] = datee;
			     */
			       k++;
			        
			    
				
			}
			
			pw.write(sb.toString());
		    pw.close();
		}catch(Exception e){}
			
		/*
			    ICsvListWriter csvWriter = null;
		        try {
		            csvWriter = new CsvListWriter(new FileWriter(filePath+"test.csv"), 
		                null);
		
		            for (int i = 0; i < csvMatrix.length; i++) {
		                csvWriter.write(csvMatrix[i]);
		                System.out.println("Done");
		            }
		
		        } catch (Exception e) {
		           // e.printStackTrace(); // TODO handle exception properly
		        } finally {
		            try {
		                csvWriter.close();
		            } catch (Exception e) {
		            }
		        }
		
	
	    */
		
	}
	
	
%>



 <jsp:include page="include_top.jsp"></jsp:include>
<%

 %>

	<!-- Page header -->
	<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<a href="<%=request.getContextPath()%>/analytics.jsp"><i class="icon-arrow-left52 position-left"></i></a>
					<span class="text-semibold">Topic Distribution</span>

				</h4>
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li ><a href="trackerlist.jsp">Tracker List  </a></li>
					<li><a href="edittracker.jsp" title="Edit <%=session.getAttribute("tracker")%> Tracker"><%=session.getAttribute("tracker")%></a></li>
					<li><a href="analytics.jsp">Analytics</a></li>
						<li class="active">Topic Distribution</li>
				</ul>
			</div>


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
				
				<div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Topic Trends<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
								<form name="dateform" id="dateform" method="post">
									<div data-intro="Select a date range " data-step="2" id="reportrange">
									<button type="button" class="btn btn-primary daterange-ranges heading-btn text-semibold">
										<i class="icon-calendar3 position-left"></i> <span></span>  
					<b class="caret"></b>
									</button>
									<input type="hidden" name="is_request" value="yes">
									<input type="hidden" id="datepicked" name="datepicked"  onchange="datechanged()" />
			                	</div>
								</form>

			                	</div>
							</div>

							<div class="panel-body">

							

						<div class="chart-container">
							<div class="chart" id="d3-streamgraph"></div>
						</div>

						
							</div>








							</div>
					</div>
					
					
						<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Topic words<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<table class="table datatable-basic">
						<thead>
							<tr>
								<th>Topics</th>
								<th>Words</th>
								<th></th>
								<th></th>
								<th></th>
								
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Topic 1</td>
								<td>Word 1</td>
								<td>Word 2</td>
								<td>Word 3</td>
								<td>Word 4</td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
								<tr>
								<td>Topic 2</td>
								<td>Word 1</td>
								<td>Word 2</td>
								<td>Word 3</td>
								<td>Word 4</td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
								<tr>
								<td>Topic 3</td>
								<td>Word 1</td>
								<td>Word 2</td>
								<td>Word 3</td>
								<td>Word 4</td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
								<tr>
								<td>Topic 4</td>
								<td>Word 1</td>
								<td>Word 2</td>
								<td>Word 3</td>
								<td>Word 4</td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
							</tbody>
							</table>


							</div>
						</div>
					</div>



				<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Topic Document<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Post Title<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">


						<table class="table datatable-basic">
						<thead>
							<tr>
								<th>Post Title</th>
								<th class="hidden" width="0%" ></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden" width="0%"></th>
								<th class="hidden"  width="0%"></th>
								<th class="hidden" width="0%"></th>
							</tr>
						</thead>
						<tbody>
							
							<tr>
		<td>Title 1 <a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right">
														<span class="letter-icon icon-eye2 view"></span>
													</a></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
							<tr>
								<td>Title 2 <a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right"
													>
														<span class="letter-icon icon-eye2 view"></span>
													</a></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
								<tr>
								<td>Title 3 <a href="#" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple pull-right"
													>
														<span class="letter-icon icon-eye2 view"></span>
													</a></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%"></td>
								<td class="hidden" width="0%">

								</td>
							</tr>
							</tbody>
							</table>

							</div>
						</div>
					</div>

<div class="col-md-6 col-sm-12 col-xs-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h6 class="panel-title">Blog Content<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<textarea disabled class="form-control" id="contentfill" rows="12">Celebrated South Florida Chef Lindsay Autry is close to opening the doors of The Regional Kitchen & Public House at CityPlace in West Palm Beach. Over the past couple of months, construction has transformed the blank, open space into the vision Chef Autry & Thierry Beaud have of an open pantry kitchen, with a main dining room tastefully partitioned to create a warm and intimate ambiance. The restaurant will have outdoor seating on the refinished patio, significant private dining space and a distinct elaborate bar and lounge area. “As a chef that has built a home and career in the Palm Beach area over the past several years, the launch of this amazing project excites me both personally and professionally,” Autry said. Continuing to be inspired by consciously sourced ingredients, Autry has spent close to a decade working closely with South Florida’s most fundamental industry professionals - fisherman, farmers, and culinary artisans. Her intimate knowledge of regional product, as well as that of the exceptional product sourced beyond Florida’s borders, is matched only by the extraordinary culinary talents that have earned her industry celebrity and continued national acclaim. During her most recent visit to Kai-Kai Farm in Indiantown, Fla., Autry began to choose some of the selections of the best local ingredients for The Regional Kitchen & Public House’s new and evolving menu. “We toured the farm, ate warm strawberries right off the vine, and got our hands dirty. Knowing where our food comes from, seeing it through the whole process from ground to plate, those are the things I’ve dreamed of for this project,” Autry said. The Regional Kitchen & Public House, Autry said, intends to present a unique perspective on America’s time-honored cuisine through local ingredients, seasonally influenced dishes and the soulful inspiration of a chef-driven kitchen. “We are very excited to become a part of the Okeechobee corridor rebirth along with brands like Restoration Hardware and large new developments such as the beautiful convention center hotel.” said restaurateur Thierry Beaud. The Regional Kitchen & Public House will become the fifth restaurant concept for the TITOU Hospitality Group under Beaud’s leadership. Some of The Region’s fresh menu items will include: * Florida Sweet Corn & Heirloom Tomato Salad: butter lettuce, crispy okra, buttermilk ranch * House Chorizo & Key Clams: trofie pasta, spinach, braised fennel * Boneless Half Chicken: lemony orzo risotto, brussel leaves, feta & pepperoncini * Local Snapper in Banana Leaf: salsa verde, roasted tomatoes & radishes Autry’s culinary skills have earned her the opportunity to work alongside some of the best chefs in at prominent restaurants along the East Coast and in Mexico. A graduate of Johnson & Wales University, Autry honed her skill under James Beard Award winning Chef Michelle Bernstein, working as sous, then executive chef at a number of Bernstein’s top restaurants before headlining as a “Top Chef” finalist. Autry was Executive Chef of the historic Sundy House in Delray Beach, Fla., with whom she also traveled to New York City to cook at the prestigious James Beard House, and in Spring 2015, Autry won the Miami leg in the traveling culinary battle COCHON 555, which allowed her to compete against the country’s best in the final Grand COCHON competition during the 2015 Aspen Food & Wine.

						</textarea>

							</div>
						</div>
					</div>

							</div>
						</div>

					</div>




















				</div>
				<!-- /main charts -->





			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>

	
	<!-- /page container -->


	
	<!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
	<!-- /footer -->
	
<!-- Dependencies -->
  <jsp:include page="pagedependencies/topic_distribution.jsp"></jsp:include>
  <!-- End of Dependencies -->
</body>
</html>
