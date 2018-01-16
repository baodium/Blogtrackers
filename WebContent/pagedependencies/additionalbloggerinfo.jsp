   <script type="text/javascript" src="assets/js/intro.js"></script>
   

	<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/moment/moment.min.js"></script>
<script
					src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
<script type="text/javascript" src="assets/js/plugins/tables/datatables/datatables.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/selects/select2.min.js"></script>
	<script type="text/javascript" src="assets/js/core/app.js"></script>
 <script type="text/javascript" src="assets/js/pages/datatables_basic.js"></script>
 <script type="text/javascript" src="assets/js/jquery-ui.js"></script>

	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
	<!-- /theme JS files -->

<!-- <script type="text/javascript" src="js/slidernav/slidernav.js"></script> -->
<script
					src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Chart.js/dist/Chart.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>

					<script
					src="${pageContext.request.contextPath}/vendors/jQCloud-master/jqcloud/jqcloud-1.0.4.js"></script>
				<script
					src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/canvasjs/examples/bootbox.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/canvasjs/canvasjs.min.js"></script>
					
					
				<script type="text/javascript">
					$(function() {
						$("#domain_id").dataTable({
							"bPaginate" : false,
							"bLengthChange" : false,
							"bFilter" : false,
							"bSort" : true,
							"bInfo" : false,
							"bAutoWidth" : false,
							"asStripClasses" : null,
							"sDom" : '<"right"f>',
							"order" : [ [ 1, 'asc' ] ],

						});
					})
				</script>
				
				<script type="text/javascript">
					$(function() {
						$("#url_id").dataTable({
							"bPaginate" : false,
							"bLengthChange" : false,
							"bFilter" : false,
							"bSort" : true,
							"bInfo" : false,
							"bAutoWidth" : false,
							"asStripClasses" : null,
							"sDom" : '<"right"f>',
							"order" : [ [ 1, 'asc' ] ],

						});
					})
				</script>
				<script type="text/javascript">
					window.onload = function() {

						var gr1 = '${blist0}';
						var f1 = [];

						var gr2 = '${blist1}';
						var f2 = [];

						var gr3 = '${blist2}';
						var f3 = [];

						var gr4 = '${blist3}';
						var f4 = [];

						var gr5 = '${bavgList}';
						var f5 = [];
						if (gr1.length != 0 || gr2.length != 0
								|| gr3.length != 0 || gr4.length != 0
								|| gr5.length != 0) {

							graph1 = JSON.parse(gr1);
							graph2 = JSON.parse(gr2);
							graph3 = JSON.parse(gr3);
							graph4 = JSON.parse(gr4);
							graph5 = JSON.parse(gr5);

							for (var i = 0; i < graph1.length; i++) {
								f1.push({
									label : graph1[i].month,
									y : parseInt(graph1[i].postCount)
								});
							}

							for (var i = 0; i < graph2.length; i++) {
								f2.push({
									label : graph2[i].month,
									y : parseInt(graph2[i].postCount)
								});
							}

							for (var i = 0; i < graph3.length; i++) {
								f3.push({
									label : graph3[i].month,
									y : parseInt(graph3[i].postCount)
								});
							}

							for (var i = 0; i < graph4.length; i++) {
								f4.push({
									label : graph4[i].month,
									y : parseInt(graph4[i].postCount)
								});
							}

							for (var i = 0; i < graph5.length; i++) {
								f5.push({
									label : graph5[i].month,
									y : parseInt(graph5[i].postCount)
								});
							}
						}
						var chart = new CanvasJS.Chart(
								"MonthlyAverageChart",
								{
									title : {
										text : ""
									},
									legend : {
										verticalAlign : "center",
										horizontalAlign : "right"
									},
									animationEnabled : true,
									axisX : {
										interlacedColor : "#F0F8FF",
										labelFontSize : 12,
										interval : 1,
									},
									axisY : {
										labelFontSize : 12
									},
									exportEnabled : true,
									data : [ {

										type : "line",
										showInLegend : true,
										name : '${ballYears.year}',
										color : "#96CA59",
										dataPoints : f1
									}, {
										type : "line",
										color : "#20B2AA",
										showInLegend : true,
										name : '${ballYears.year1}',
										dataPoints : f2
									}, {
										type : "line",
										color : "#F08080",
										showInLegend : true,
										name : '${ballYears.year2}',
										dataPoints : f3
									}, {
										type : "line",
										color : "#9368AE",
										showInLegend : true,
										name : '${ballYears.year3}',
										dataPoints : f4
									}, {
										type : "line",
										color : "#0000ff",
										showInLegend : true,
										name : '${ballYears.average}',
										dataPoints : f5
									} ],
									legend : {
										cursor : "pointer",
										itemclick : function(e) {
											if (typeof (e.dataSeries.visible) === "undefined"
													|| e.dataSeries.visible) {
												e.dataSeries.visible = false;
											} else {
												e.dataSeries.visible = true;
											}
											e.chart.render();
										}
									}
								});
						chart.render();

						var freqDays = '${bloggerDays}';
						var finals = [];
						if (freqDays.length != 0) {
							tabData = JSON.parse(freqDays);
							for (var i = 0; i < tabData.length; i++) {
								finals.push({
									label : tabData[i].interval,
									y : parseInt(tabData[i].noofposts)
								});
							}
						}
						var chart = new CanvasJS.Chart("DailyAverageChart", {
							title : {
								text : "",
								fontSize : 20
							},

							animationEnabled : true,
							axisX : {
								labelFontSize : 12,
								interval : 1,
							},
							axisY : {
								labelFontSize : 12,
							},
							exportEnabled : true,

							data : [ {
								type : "column",
								fillOpacity : .9,
								color : "#1abc9c",
								dataPoints : finals
							}, ]

						});
						chart.render();
					}
				</script>
				<script>
					$(document)
							.ready(
									function() {
										var canvasDoughnut, options = {
											legend : false,
											responsive : false
										};

										new Chart(
												document
														.getElementById("canvas1i"),
												{
													type : 'doughnut',
													tooltipFillColor : "rgba(51, 51, 51, 0.55)",
													data : {
														labels : [ "Anxiety",
																"Positive",
																"Sad", "Anger" ],
														datasets : [ {
															data : [
																	'${bloggerSentiments[2].anxSentiments}',
																	'${bloggerSentiments[2].posSentiments}',
																	'${bloggerSentiments[2].sadSentiments}',
																	'${bloggerSentiments[2].angSentiments}' ],
															backgroundColor : [
																	"#ff7b00",
																	"#26B99A",
																	"#3b3bff",
																	"#E74C3C" ],
															hoverBackgroundColor : [
																	"#ffae62",
																	"#36CAAB",
																	"#9d9dff",
																	"#E95E4F" ]

														} ]
													},
													options : options
												});

										new Chart(
												document
														.getElementById("canvas1i2"),
												{
													type : 'doughnut',
													tooltipFillColor : "rgba(51, 51, 51, 0.55)",
													data : {
														labels : [ "Anxiety",
																"Positive",
																"Sad", "Anger" ],
														datasets : [ {
															data : [
																	'${bloggerSentiments[1].anxSentiments}',
																	'${bloggerSentiments[1].posSentiments}',
																	'${bloggerSentiments[1].sadSentiments}',
																	'${bloggerSentiments[1].angSentiments}' ],
															backgroundColor : [
																	"#ff7b00",
																	"#26B99A",
																	"#3b3bff",
																	"#E74C3C" ],
															hoverBackgroundColor : [
																	"#ffae62",
																	"#36CAAB",
																	"#9d9dff",
																	"#E95E4F" ]

														} ]
													},
													options : options
												});

										new Chart(
												document
														.getElementById("canvas1i3"),
												{
													type : 'doughnut',
													tooltipFillColor : "rgba(51, 51, 51, 0.55)",
													data : {
														labels : [ "Anxiety",
																"Positive",
																"Sad", "Anger" ],
														datasets : [ {
															data : [
																	'${bloggerSentiments[0].anxSentiments}',
																	'${bloggerSentiments[0].posSentiments}',
																	'${bloggerSentiments[0].sadSentiments}',
																	'${bloggerSentiments[0].angSentiments}' ],
															backgroundColor : [
																	"#ff7b00",
																	"#26B99A",
																	"#3b3bff",
																	"#E74C3C" ],
															hoverBackgroundColor : [
																	"#ffae62",
																	"#36CAAB",
																	"#9d9dff",
																	"#E95E4F" ]

														} ]
													},
													options : options
												});
									});
				</script>
				<script>
					jQuery(document).ready(function() {
						handleSliderNav();

					});
					var handleSliderNav = function() {
						//$('#address-book').sliderNav();

						$('#address-book .slider-content ul li ul li a')
								.click(
										function(e) {
											e.preventDefault();
											var contact_card = $('#contact-card');
											//Get the name clicked on
											var name = $(this).text();
											//Set the name
											$('#contact-card .panel-title')
													.html(name);
											$('#contact-card #card-name').html(
													name);
											//Randomize the image
											var img_id = Math.floor(Math
													.random()
													* (5 - 1 + 1)) + 1;
											//Set the image
											$('#contact-card .headshot img')
													.attr(
															'src',
															'img/addressbook/'
																	+ img_id
																	+ '.jpg');
											contact_card
													.removeClass(
															'animated fadeInUp')
													.addClass(
															'animated fadeInUp');
											var wait = window
													.setTimeout(
															function() {
																contact_card
																		.removeClass('animated fadeInUp')
															}, 1300);
										});
					}
					$('#trackerform').attr("action","AdditionalBlogger");
				</script>
				<script type="text/javascript">
					function trackerchanged() {
						$(".loader").removeClass("hidden");
						document.getElementById("trackerform").submit();

					}
				</script>
				<script>

				$(function() {
					 $("#searchtextbox").autocomplete({
					      
					        source: function( request, response ) {
					            $.ajax({
					              url: app_url+'/AdditionalBlogger',
					              method:'POST',
					              data: {
					            	  term:request.term,search_blogger:"true"
					              },
					              success: function( data ) {
					            	  names = data.split("|");
					                response( names );
					                
					              }
					            });
					          },
							 select: function( event, ui ) {
						        var blogger = ui.item.value;
						        console.log(blogger);
						        $.ajax({
						              url: app_url+'/AdditionalBlogger',
						              method:'POST',
						              data: {
						            	  blogger:blogger,get_detail:"true"
						              },
						              success: function( data ) {
						            	  console.log(data);
						            	  var result= JSON.parse(data);
						            	  console.log(result);
						            	  
						            	  if(result.length>0){
						            		  $("#blogger-name").html(result[0].author);
						            		  $("#blogsite-name").html(result[0].siteName);
						            		  $("#blog-site").html("<a href='"+result[0].siteUrl+"' target='_blank'>"+result[0].siteUrl+"</a>");
						            		  $("#maximum-influence").html(result[0].maxInfluence);
						            		  $("#recent-post").html(result[0].lastCleaned);
						            	  }
						            	 
						              }
						            });					        
						     }, 
							autoFocus:true,
					  });
					//var names=["PHP","HTML","CSS","JavaScript","jQuery","MySQL","Ajax","Java","ASP.Net"];
					
				
				 
				});

				</script>
				