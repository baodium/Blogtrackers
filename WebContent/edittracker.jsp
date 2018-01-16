<%@page import="java.util.*"%>
<%@page import="wrapper.*"%>



<%
	Object username = (null == session.getAttribute("username")) ? "" : session.getAttribute("username");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");
	Object edited_tracker = (null == session.getAttribute("edited_tracker")) ? "" : session.getAttribute("edited_tracker");
	String tracker_id = (null == request.getParameter("tracker_id")) ? edited_tracker.toString() : request.getParameter("tracker_id");
	ArrayList tracker = new ArrayList();
	ArrayList bloglist = new ArrayList();
	String s = "";
	if (username == null || username == "" || tracker_id == "") {
		response.sendRedirect("trackerlist.jsp");
	}
	

	try{
		Tracker tk = new Tracker();
		tracker = tk.getTracker(tracker_id);

		tracker = (ArrayList)tracker.get(0);
		String blog_list = tracker.get(5).toString();
		String[] blist  = blog_list.split("\\(");
		//s+= blist;
		blist = blist[1].split("\\)");
		s=blist[0];
		bloglist = tk.getBloglist(blist[0]);
	}catch(Exception e){
		
	}
%>
 <jsp:include page="include_top.jsp"></jsp:include>

 <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.css"> 
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"
            integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js"
            integrity="sha384-FzT3vTVGXqf7wRfy8k4BiyzvbNfeYjK+frTVqZeNDFl8woCbF0CYG6g2fMEFFo/i"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.2.13/semantic.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serialize-object/2.5.0/jquery.serialize-object.min.js"></script>


	<!-- Page header -->
	<div class="page-header mb-20">
		<div class="page-header-content">
			<div class="page-title">
				<h4>
					<a href="trackerlist.jsp"><i class="icon-arrow-left52 position-left"></i></a>
				<span class="text-semibold">Edit Tracker</span> 
				</h4>
				
				<ul class="breadcrumb breadcrumb-caret position-right">
					<li><a href="features.jsp">Home</a></li>
					<li><a href="trackerlist.jsp">Tracker List</a></li>
					<li class="active">Edit Tracker</li>
				</ul>
				
										
			</div>

	<!-- <div class="heading-elements">
				<div class="heading-btn-group">
					<button type="button" onclick="location.href='setup_tracker.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-reading"></i></b> Setup a new tracker</button>
					<button type="button" onclick="location.href='dashboard.jsp'" class="btn btn-default legitRipple btn-labeled btn-rounded legitRipple"><b><i class="icon-statistics position-left"></i></b> Back to dashboard</button>
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

				<div class="col-md-12">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Edit Tracker <a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
								<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
							
					<div class="col-lg-12 col-md-12 col-sm-12">
							<% if(tracker != null && tracker.size()>0){ %>			
							<div class="form-group">
							<form name="edit_tracker" method="post" action="setup_tracker">
							<label class="control-label">Tracker Name</label>
							<input class="form-control" type="text" required name="title" value="<%=(null == tracker.get(2)) ? "" : tracker.get(2)%>" />
							</div>
							<div class="form-group">
							<label class="control-label">Tracker Description</label>
							<textarea class="form-control" required name="descr"><%=(null == tracker.get(6)) ? "" : tracker.get(6)%></textarea>
							</div>
							<div>
							<input type="hidden" name="tracker_id" value="<%=(null == tracker.get(0)) ? "" : tracker.get(0)%>">
							<input type="hidden" name="edit_tracker" value="yes">
							<input type="hidden" name="action" value="edit_tracker">
							<button class="btn btn-primary" type="sumbit">Save Tracker</button>
							</form>
							</div>
							<% } %>
								</div>
							</div>
							</div>
					</div>
					</div>
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">List of Blogs<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
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
								<th>Site Name</th>
								<th>No of Blog Post</th>
								<th>No of Blogger</th>
								<th>Crawled Last</th>
								<th>Actions</th>
								<th class="hidden" width="0%"></th>
							</tr>
							
						</thead>
						<tbody>
						<% if(bloglist != null && bloglist.size()>0){ 
								for(int i=0; i<bloglist.size(); i++){
									ArrayList blog = (ArrayList)bloglist.get(i);
									String blogger = (blog.get(3)==null)?"":blog.get(3).toString();
									String[] bloggers = blogger.split(",");
							%>
							<tr id="blogrow-<%=blog.get(0)%>">
								<td><%=blog.get(1)%></td>
								<td><%=blog.get(15)%></td>
								<td><%=(blogger.equals(""))?0:bloggers.length%></td>
								<td><%=blog.get(10)%></td>
								<td><a href="#" onclick="remove_blog('<%=blog.get(0)%>');" class="btn bg-primary-400 btn-rounded btn-icon btn-xs legitRipple"><span class="letter-icon icon-trash"></span></a></td>
								<td class="hidden" width="0%"></td>
							</tr>
							<% }} %>
							
							</tbody>
							</table>
   
							</div>
						</div>
					<div class="panel panel-primary">
							<div class="panel-heading">
								<h6 class="panel-title">Crawl New Blogs<a class="heading-elements-toggle"><i class="icon-more"></i></a></h6>
								<div class="heading-elements">
									<ul class="icons-list">
				                		<li><a data-action="collapse"></a></li>
				                		<li><a data-action="reload"></a></li>
<!--				                		<li><a data-action="close"></a></li>-->
				                	</ul>
			                	</div>
							</div>

							<div class="panel-body">
						<div class="input textarea clearfix example1"></div>

    <!--content-->
    <div class="ui padded segment">

        <!--header-->
        <h3 class="ui block header">
            <i class="settings icon"></i> Automated Crawler
        </h3>

        <!--crawler block-->
        <div class="ui padded segment" id="crawler_block">

            <!--<form class="ui form">

                <div class="fields">
                    <div class="one wide field">
                        <label style="padding-left:20%">&nbsp;&nbsp;&nbsp;Sl.</label>
                    </div>

                    <div class="five wide field">
                        <label>Tracking Id</label>
                    </div>

                    <div class="nine wide field">
                        <label>&nbsp;URL to be crawled</label>
                    </div>

                    <div class="six wide field">
                        <label>&nbsp;Focus crawl by keyword(s)</label>
                    </div>

                    <div class="six wide field">
                        <label>&nbsp;Limit by pages</label>
                    </div>

                    <div class="three wide field">
                        <label>&nbsp;</label>
                    </div>
                    <div class="three wide field">
                        <label>&nbsp;</label>
                    </div>

                </div>
            </form>-->
            <div id="all-forms">
                <form class="ui form">
                    <div class="fields ">
                        <div class="one wide field">
                            <label style="padding-left:20%">Sl.</label>
                            <div class="ui label sl-number" style="font-size: 1.22rem">1</div>
                            <input class="hidden-serial-input" type="hidden" name="serial_no" value=""/>
                        </div>

                       <!-- <div class="two wide field">
                            <label>Tracking Id</label>
                            <div class="ui label tracking-id" style="font-size: 1.22rem"></div>
                            <input class="hidden-tracking-id-input" type="hidden" name="tracking_id" value=""/>
                        </div>-->


                        <div class="four wide field main-fields">
                            <label>&nbsp;URL to be crawled</label>
                            <input type="text" name="crawl_url" id="crawl_url"  placeholder="Enter URL here">
                        </div>

                        <div class="three wide field main-fields">
                            <label>&nbsp;Focus crawl by keyword(s)</label>
                            <input type="text" name="keyword" id="keyword" placeholder="Enter keyword">
                        </div>

                        <div class="three wide field main-fields">
                            <label>&nbsp;Limit by pages</label>
                            <div class="ui selection dropdown">
                                <input type="hidden" name="pages">
                                <i class="dropdown icon"></i>
                                <div class="default text">Select page limit</div>
                                <div class="menu">
                                    <div class="item" data-value="1">Current page only</div>
                                    <div class="item" data-value="10">Upto 10 pages</div>
                                    <div class="item" data-value="25">Upto 25 pages</div>
                                    <div class="item" data-value="50">Upto 50 pages</div>
                                    <div class="item" data-value="100">Upto 100 pages</div>
                                    <div class="item" data-value="no">No limit</div>
                                </div>
                            </div>
                        </div>

                        <div style="text-align: center"  class="two wide field main-fields">
                            <label>&nbsp;</label>
                            <button class="ui blue button" type="submit" style="margin-left:16%">Launch</button>

                        </div>
						
						<div style="display:none" class="fourteen wide field loading-bar">
                            <div class="ui active inverted dimmer">
                                <div class="ui text loader">The crawler is running...</div>
                            </div>
                        </div>
						
                        <div style="display:none" class="fourteen wide field progress-bar">
                            <!--<label>&nbsp;</label>-->
                            <h5 class="initiated-text ui positive message" style="text-align: center;margin-top:16px">The Crawler for URL has been Initiated.</h5>
                        </div>
                        <div style="text-align: center" class="two wide field">
                            <label>&nbsp;</label>
                            <button class="ui red button removeButton" type="button">Delete</button>
                        </div>


                        <!--<div style="display:none" class="twelve wide field progress-bar">
                            <div class="ui blue progress" data-value="20" data-total="100" style="padding:3px">
                                <div class="bar"></div>
                                <div class="label percentage">0%</div>
                            </div>
                            <div class="three wide field">
                                <button class="ui red button pauseButton" type="button">Remove</button>
                            </div>
                        </div>-->


                    </div>

                </form>
            </div>


        </div>


        <!--Add crawler-->
        <button class="ui compact labeled icon button" id='addNewButton'>
            <i class="add icon"></i>Add crawler
        </button>

    </div>
    <!--content end-->

</div>
<!--wrapper end-->


<script>

    function prepareView() {
        $('.ui.dropdown')
                .dropdown();
        $("#all-forms").find(".form").each(function () {
            var that = $(this);
            $(this).form({
                fields: {
                    crawl_url: {
                        identifier: 'crawl_url',
                        rules: [
                            {
                                type: 'url',
                                prompt: 'Please enter a valid URL'
                            }
                        ]
                    },
                    keyword: {
                        identifier: 'keyword',
                        rules: [
                            {
                                type: 'empty'
                            }
                        ]
                    },
                    pages: {
                        identifier: 'pages',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Please select a Current page only'
                            }
                        ]
                    }

                }, "onSuccess": function (event) {
                    event.preventDefault();
					$(that).find(".loading-bar").css({display:'block'});
                    $(that).find(".main-fields").each(function () {
                        $(this).css({display: "none"});
                    });
                    var data= $(this).serializeJSON();
					//console.log(data);
                    $.ajax({
                        type: "post",
                        url:   app_url+'/setup_tracker',
                        data:{data:data,action:"crawl"},
          		      
                       // dataType: "json",
                       // contentType: "application/json",
                       // accept: "application/json"
                    }).done(function (response) {
						console.log(response);
					$(that).find(".loading-bar").css({display:'none'});
                        $(that).find(".progress-bar").css({display: "block"});
                        $(that).find(".progress-bar .initiated-text").html("The crawling for "+
                           getLocation(JSON.parse(data).crawl_url).hostname+" is completed.");
                    }).fail(function (jqXHR, textStatus) {
						console.log(jqXHR);
                        console.log("Call failed: " + textStatus);
                    });


                }
            })
        });


    }

    function putSerialNumber() {
        var serial = 1;
        $("#all-forms").find(".form").each(function () {
            $(this).find(".sl-number").html(serial);
            $(this).find(".hidden-serial-input").val(serial);
            serial++;
        });
        if (serial > 10) {
            $("#addNewButton").css({display: "none"});
        } else {
            $("#addNewButton").css({display: "block"});
        }
    }

//    function allTrackingIds() {
//        var allTrackingIds = [];
//        $("#all-forms").find(".form").each(function () {
//            allTrackingIds.push($(this).find(".hidden-tracking-id-input").val());
//        });
//        return allTrackingIds;
//    }

    $(document).ready(function () {

        /*var newTrackingID = "TR" + parseInt(+new Date());
        $("#all-forms").find(".tracking-id").html(newTrackingID);
        $("#all-forms").find(".hidden-tracking-id-input").val(newTrackingID);*/

//        setInterval(function () {
//
//            $.ajax({
//                type: "post",
//                url: "data.php",
//                data: JSON.stringify({
//                    trackingIds: allTrackingIds(),
//                    apiKey: "123456789ygviykvboguy"
//                }),
//                dataType: "json",
//                contentType: "application/json",
//                accept:"application/json"
//            }).done(function (response) {
//                $("#all-forms").find(".form").each(function () {
//                    var that = $(this);
//                    if(response.length>0){
//                        response.map(function (item) {
//                            if(item.trackingId===$(that).find(".hidden-tracking-id-input").val()){
//                                $(that).find(".ui.progress").progress({percent:parseInt(item.progress)})
//                                $(that).find(".label.percentage").html(item.progress+"%")
//                            }
//                        })
//                    }
//                });
//            }).fail(function (jqXHR, textStatus) {
//                console.log("Call failed: " + textStatus);
//            });
//
//        }, 3000);


        prepareView();
        putSerialNumber();
        var allFormDiv = $("#all-forms");
        var formRow = allFormDiv.find(".form:first").clone();

        $("#all-forms").on("click", '.removeButton', function (e) {
            e.preventDefault();
            $(this).closest('.form').remove();
            putSerialNumber();
        });

        $("#all-forms").on("click", '.pauseButton', function (e) {
            e.preventDefault();
//            var trackingId = $(this).closest("#all-forms").find(".hidden-tracking-id-input").val();
            $(this).closest('.form').remove();
            putSerialNumber();
//            pauseCrawling(trackingId);
        });

        $("#addNewButton").on("click", function (e) {
            if ($("#all-forms").find(".form").length < 10) {
                e.preventDefault();
                var newFormRow = formRow.clone();
//                var newTrackingID = "TR" + parseInt(+new Date());
//                $(newFormRow).find(".tracking-id").html(newTrackingID);
//                $(newFormRow).find(".hidden-tracking-id-input").val(newTrackingID);
                allFormDiv.append((newFormRow));
                prepareView();
                putSerialNumber();
            }

        });


    });

//    function pauseCrawling(trackingId) {
//        $.ajax({
//            type: "post",
//            url: "data.php",
//            data: JSON.stringify({
//                trackingId: trackingId
//            }),
//            dataType: "json",
//            contentType: "application/json",
//            accept: "application/json"
//        }).done(function (response) {
//            console.log("Call passed: " + response);
//        }).fail(function (jqXHR, textStatus) {
//            console.log("Call failed: " + textStatus);
//        });
//    }


    function getLocation (href) {
        var l = document.createElement("a");
        l.href = href;
        return l;
    }

</script>

							
						
					</div>
				<!-- /main charts -->


			

			
			<!-- /main content -->

		</div>
		<!-- /page content -->

	</div>
	
	</div>
	<!-- /page container -->


	  <!-- Footer -->
  <jsp:include page="footer.jsp"></jsp:include>
  <% if(tracker != null && tracker.size()>0){ %>			
							
  <script>
	function remove_blog(id){
		var all_blogs ="<%=s%>";
		var blog_ids ="";
		var ids = all_blogs.split(",");
		for(var l=0; l<ids.length; l++){
			
			if(ids[l]!=id){
				blog_ids+= ids[l]+",";
			}
		}
		
		blog_ids = blog_ids.substring(0,(blog_ids.length-1));
		//alert(blog_ids);
		var tracker_id = "<%=tracker.get(0)%>";
		//var promt = confirm("Are you sure you want to delete this tracker?");
		
		if (confirm('Are you sure you want to remove this blog from tracker?')) {
			$("#blogrow-"+id).remove();
			
			$.ajax({
		        url: app_url+'/setup_tracker',
				method:'POST',
				data:{tracker_id:tracker_id,blog_id:blog_ids,action:"remove_blog"},
		        success: function(response)
		        {	
		        	//window.location.reload();
		        }
		    });	
			
		} else {
			return false;
		}
		
		
	}
  </script>
  <% } %>
	<!-- /footer -->
	<!-- Dependencies -->
  <jsp:include page="pagedependencies/edittracker.jsp"></jsp:include>
  <!-- End of Dependencies -->

</body>
</html>
