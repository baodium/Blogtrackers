<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%
	Object username = (null == session.getAttribute("user")) ? "" : session.getAttribute("user");
	Object email = (null == session.getAttribute("email")) ? "" : session.getAttribute("email");

	if (username == null || username == "") {
		response.sendRedirect("index.jsp");

	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Meta, title, CSS, favicons, etc. -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Blogtrackers | Setup Tracker</title>

<!-- Bootstrap -->
<link
	href="${pageContext.request.contextPath}/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="${pageContext.request.contextPath}/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link
	href="${pageContext.request.contextPath}/vendors/nprogress/nprogress.css"
	rel="stylesheet">
<!-- iCheck -->
<link
	href="${pageContext.request.contextPath}/vendors/iCheck/skins/flat/green.css"
	rel="stylesheet">
<!-- Data tables -->
<link
	href="${pageContext.request.contextPath}/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript" src="js/function.js"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<!-- Custom Theme Style -->
<link href="build/css/custom.min.css" rel="stylesheet">
</head>
<body class="nav-md">
	<div class="loader"></div>
	<style>
.loader {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 9999;
	background: url('Resources/img/gif/Loading-data.gif') 50% 50% no-repeat
		rgb(249, 249, 249);
}
</style>

	<script type="text/javascript">
		$(window).load(function() {
			$(".loader").addClass("hidden");
			//$(".loader").fadeOut("slow");
		})
	</script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript" src="http://arrow.scrolltotop.com/arrow6.js"></script>
<noscript>Not seeing a <a href="http://www.scrolltotop.com/">Scroll to Top Button</a>? Go to our FAQ page for more info.</noscript>



	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
				

					<!-- menu profile quick info -->
					<div class="profile">
						<div class="profile_pic">
							<img src="production/images/profile.png" alt="..."
								class="img-circle profile_img">
						</div>
						<div class="profile_info" id="user_name" value="<%=username%>">
							<span>Welcome,</span>
							<h2><%=username%>
							</h2>
						</div>
					</div>
					<!-- /menu profile quick info -->

					<jsp:include page="new_sidebar.jsp"></jsp:include>
				</div>
			</div>


			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<nav>
						<div class="nav toggle">
							<a id="menu_toggle"><i class="fa fa-bars" onclick="toggleImage()"></i></a>
						</div>
						
						<div class="nav toggle"
							style="position: absolute; right: 35%; width: 30%;">
							<form name="trackerform" id="trackerform" action="Datasource"
								method="get">
								<select id="tracker" name="tracker" onchange="trackerchanged()"
									value="${item}" class="form-control" required>
									<c:choose>
										<c:when test="${tracker != null}">
											<option value="">${tracker}</option>
										</c:when>

										<c:when test="${tracker == null}">
											<option value="">Select Tracker</option>
										</c:when>
									</c:choose>

									<c:forEach items="${trackers}" var="item">
										<c:if test="${tracker ne item}">
											<option value="${item} "><c:out value="${item}" /></option>
										</c:if>c:if>
									</c:forEach>
								</select>
							</form>
						</div>

						<ul class="nav navbar-nav navbar-right">
							<li class=""><a href="javascript:;"
								class="user-profile dropdown-toggle" data-toggle="dropdown"
								aria-expanded="false"><span class="hideUsername"><%=username%></span> <span class=" fa fa-angle-down"></span>
							</a>
								<ul class="dropdown-menu dropdown-usermenu pull-right">
									<li><a href="javascript:;"> Profile</a></li>
									<li><a href="javascript:;"> <span
											class="badge bg-red pull-right"></span> <span>Settings</span>
									</a></li>
									<li><a href="javascript:;">Help</a></li>
									<li><a
										href="${pageContext.request.contextPath}/test_logout.jsp"><i
											class="fa fa-sign-out pull-right"></i> Log Out</a></li>
								</ul></li>
							<li role="presentation" class="dropdown"><a
								href="javascript:;" class="dropdown-toggle info-number"
								data-toggle="dropdown" aria-expanded="false"> </a>
								<ul id="menu1" class="dropdown-menu list-unstyled msg_list"
									role="menu">
									<li><a> <span class="image"> <!-- <img src="images/img.jpg"
												alt="Profile Image" /> -->
										</span> <span> <span>Sender 1</span> <span class="time">3
													mins ago</span>
										</span> <span class="message"> Message.... </span>
									</a></li>

									<li>
										<div class="text-center">
											<a> <strong>See All Alerts</strong> <i
												class="fa fa-angle-right"></i>
											</a>
										</div>
									</li>
								</ul></li>
						</ul>
					</nav>
				</div>
			</div>
			<!-- /top navigation -->

			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_right">
							<h3>
								Setup Tracker<small> </small>
							</h3>
						</div>
						<form action="Datasource" method="post">
							<div class="title">
								<div
									class="col-md-14 col-sm-14 col-xs-20 form-group pull-right top_search">
									<div class="input-group">
										<input type="text" class="form-control" name="searchText"
											id="searchBar" placeholder="Search for..."
											style="height: 45px; border: 1.2px solid gray"
											onkeyup="searchTextVerify(event)"> <span
											class="input-group-btn">
											<button class="btn btn-default"  onclick="showGif()"  type="submit"
												name="searchButton" id="searchButton"
												style="height: 45px; border: 1.2px solid gray" disabled>Go</button>
										</span>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div>
				<script type="text/javascript">
									function showGif() {
										$(".loader").removeClass("hidden");
									}
				</script>

					<%
						if (session.getAttribute("allSepSites") != null) {
					%>
					<jsp:include page="trackerTable.jsp" />
					<%
						}
					%>
					<form action="Datasource" method="post" name="track_form"
						id="track_form">
						<!-- <form method="post" action="" name="track_form" id="track_form"> -->
						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											Blogs from Blogtrackers database
										</h2>

										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<p class="text-muted font-13 m-b-30"></p>
										<div class="table-responsive">
											<table class="table table-striped jambo_table bulk_action">
												<thead>
													<tr class="headings">
														<th><input type="checkbox" id="check-all"
															class="flat"> Blogs ${searched} </span></th>
														<th class="column-title"></th>
														<th class="column-title"></th>

														<th class="bulk-actions" colspan="7"><a class="antoo"
															style="color: #fff; font-weight: 500;"> <span
																class="action-cnt"> </span></a></th>
												</thead>

												<tbody>
													<c:set var="i" value="0" />
													<c:set var="eo" value="1" />


													<c:forEach items="${sites}" var="s1" begin="${i}">

														<c:if test="${eo==1 || eo%2 ==1 }">
															<tr class="odd pointer">
																<c:forEach items="${sites}" var="s1" begin="${i}"
																	end="${i+2}">
																	<td class="a-center "><input type="checkbox"
																		class="flat" name="table_records"
																		value="${s1.blogsiteID}"> <c:out
																			value="${s1.blogsiteName} (${s1.blogSize} posts)" /></td>
																</c:forEach>
															</tr>
															<c:set var="i" value="${i+3}" />
														</c:if>


														<c:if test="${eo%2 ==0}">
															<tr class="even pointer">
																<c:forEach items="${sites}" var="s1" begin="${i}"
																	end="${i+2}">
																	<td class="a-center "><input type="checkbox"
																		class="flat" name="table_records"
																		value="${s1.blogsiteID}"> 
																		<c:out
																			value="${s1.blogsiteName} (${s1.blogSize} posts)" /></td>
																</c:forEach>
															</tr>
															<c:set var="i" value="${i+3}" />
														</c:if>


														<c:set var="eo" value="${eo+2}" />
													</c:forEach>

												</tbody>
											</table>

										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-12 col-sm-12 col-xs-12">
								<div class="x_panel">
									<div class="x_title">
										<h2>
											Blogs from the Internet <small style="color:red"> *We are currently working on this section*											</small>
										</h2>

										<div class="clearfix"></div>
									</div>
									<div class="x_content">
										<p class="text-muted font-13 m-b-30"></p>
										<table id="table-responsive"
											class="table table-striped table-bordered dt-responsive nowrap"
											class="table table-striped jambo_table bulk_action">
											<thead>
											<br/><br/><br/>
												<tr class="headings">
														</tr>
												<tr>
													
												</tr><br/><br/>
											</thead>
											<tbody>

											</tbody>
										</table>

									</div>
								</div>
							</div>
						</div>


						<!-- Tracker script -->
						<div class="clearfix"></div>
						<button type="button" class="btn btn-primary pull-right"
							data-toggle="modal" data-target=".bs-example-modal-lg">Proceed</button>

						<div class="modal fade bs-example-modal-lg"
							style="position: absolute; left: 10%; width: 1150px;"
							tabindex="-1" role="dialog" aria-hidden="true">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">

									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">
											<span aria-hidden="true">×</span>
										</button>
										<h4 class="modal-title" id="myModalLabel">Setup Your
											Tracker</h4>
									</div>
									<div class="modal-body">
										<div id="testmodal" style="padding: 5px 20px;">
											<div id="antoform" class="form-horizontal calender"
												role="form">
												<div id="tracker_error" style="color: red"></div>
												<div class="form-group">
													<label class="col-sm-3 control-label">Title</label>
													<div class="col-sm-9">
														<input type="text" class="form-control" id="title"
															name="title" onkeyup="stoppedTyping()"
															onfocusout="myFunction()">
													</div>
												</div>
												<div class="form-group">
													<label class="col-sm-3 control-label">Description</label>
													<div class="col-sm-9">
														<input type="text" class="form-control"
															style="height: 55px;" id="descr" name="descr"
															onkeyup="stoppedDescTyping()" disabled>

													</div>
												</div>
											</div>
										</div>
									</div>
<script type="text/javascript">
									function showGif() {
										$(".loader").removeClass("hidden");
									}
									</script>
									<div class="modal-footer">
										<button type="button" class="btn btn-default antoclose"
											data-dismiss="modal">Close</button>
										<input type="submit" name="Save" value="Save Changes"
											id="saveButton" onclick="showGif()" class="btn btn-primary antosubmit" disabled>
									</div>
									<!-- onclick="_checkTracker()" -->
								</div>
							</div>
						</div>
						<!-- Tracker script -->
						<div class="clearfix"></div>
						<div class="row"></div>
					</form>
				</div>

			</div>
		</div>
	</div>








	<!-- footer content -->

	<!-- /footer content -->
	<!-- jQuery -->


	<script
		src="${pageContext.request.contextPath}/vendors/jquery/dist/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/jszip/dist/jszip.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/pdfmake/build/pdfmake.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendors/pdfmake/build/vfs_fonts.js"></script>
	<script src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
	<script>
		$(document).ready(function() {
			var handleDataTableButtons = function() {
				if ($("#datatable-buttons").length) {
					$("#datatable-buttons").DataTable({
						dom : "Bfrtip",
						buttons : [ {
							extend : "copy",
							className : "btn-sm"
						}, {
							extend : "csv",
							className : "btn-sm"
						}, {
							extend : "excel",
							className : "btn-sm"
						}, {
							extend : "pdfHtml5",
							className : "btn-sm"
						}, {
							extend : "print",
							className : "btn-sm"
						}, ],
						responsive : true
					});
				}
			};
			TableManageButtons = function() {
				"use strict";
				return {
					init : function() {
						handleDataTableButtons();
					}
				};
			}();
			$('#datatable').dataTable();
			$('#datatable-keytable').DataTable({
				keys : true
			});
			$('#datatable-responsive').DataTable();
			$('#datatable-scroller').DataTable({
				ajax : "js/datatables/json/scroller-demo.json",
				deferRender : true,
				scrollY : 380,
				scrollCollapse : true,
				scroller : true
			});
			var table = $('#datatable-fixed-header').DataTable({
				fixedHeader : true
			});
			TableManageButtons.init();
		});

		function dropfunc() {
			$("#heard option:selected").text();
			alert($("#heard option:selected").text());
		}

		/* function logoutMethod() {
			
			
		} */
	</script>
	<script type="text/javascript">
		function trackerSubmit() {
			document.getElementById().submit();
		}
		function trackerchanged() {
			document.getElementById("trackerform").submit();

			$(".loader").removeClass("hidden");

		}
	</script>
	<script type="text/javascript">
		function stoppedTyping() {
			var value = $.trim($("#title").val());
			if (value.length > 0) {
				$("#descr").prop('disabled', false);
			} else {
				$("#descr").prop('disabled', true);
			}
		}
		function stoppedDescTyping() {
			var value = $.trim($("#descr").val());
			if (value.length > 0) {
				$("#saveButton").prop('disabled', false);
			} else {
				$("#saveButton").prop('disabled', true);
			}
		}
		function searchTextVerify(e) {

			var value = $.trim($("#searchBar").val());
			if (value.length > 0) {
				$("#searchButton").prop('disabled', false);
			} else {
				$("#searchButton").prop('disabled', true);
			}
			if (e.keyCode === 13) {
				e.preventDefault();
				$(".loader").removeClass("hidden");
				$(".searchBar").addClass("hidden");
				// alert("Enter was pressed was presses");
			}
		}

		function searchTracker() {
			$(".loader").removeClass("hidden");
		}

		function myFunction() {
			var app_url = "http://localhost:8080/BT/";
			var url = app_url + 'trackerChecker.jsp';
			var trackerName = document.forms['track_form'].title.value;
			var userName = document.getElementById('user_name').getAttribute(
					'value');
			$
					.ajax({
						type : "POST",
						url : url,
						async : true,
						data : {
							trackerName : trackerName,
							userName : userName,
							check_user : true
						},
						success : function(data) {
							console.log("Data " + data.trim());
							if (data.trim() == "true") {
								$("#tracker_error")
										.html(
												"Tracker Name Exists! Change to avoid duplicate name.");
								$("#descr").prop('disabled', true);
							} else {
								$("#tracker_error").html("");
							}
						}
					});

		}
	</script>

	<!-- /Datatables -->

</body>
</html>
