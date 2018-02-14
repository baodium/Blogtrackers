 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
   <script type="text/javascript" src="assets/js/intro.js"></script>
   
<script>
					
					 $('#trackerform').attr("action","Dashboard");
					</script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/moment/moment.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/pickers/daterangepicker.js"></script>

	<script type="text/javascript" src="assets/js/core/app.js"></script>
	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
	
	  <script
					src="${pageContext.request.contextPath}/vendors/echarts/dist/echarts.min.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/echarts/map/js/world.js"></script> 
	<script
					src="${pageContext.request.contextPath}/vendors/fastclick/lib/fastclick.js"></script>
				<!-- NProgress -->
				<script
					src="${pageContext.request.contextPath}/vendors/nprogress/nprogress.js"></script>
				<!-- Chart.js -->
				<!--  <script
					src="${pageContext.request.contextPath}/vendors/Chart.js/dist/Chart.min.js"></script>

				<!-- gauge.js -->
				<script
					src="${pageContext.request.contextPath}/vendors/gauge.js/dist/gauge.min.js"></script>
				<!-- bootstrap-progressbar -->
				<script
					src="${pageContext.request.contextPath}/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
				<!-- iCheck -->
				<script
					src="${pageContext.request.contextPath}/vendors/iCheck/icheck.min.js"></script>
				<!-- Skycons -->
				<script
					src="${pageContext.request.contextPath}/vendors/skycons/skycons.js"></script>
				<!-- Flot -->
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.pie.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.time.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.stack.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/Flot/jquery.flot.resize.js"></script>
				<!-- Flot plugins -->
				<script
					src="${pageContext.request.contextPath}/production/js/flot/jquery.flot.orderBars.js"></script>
				
				<script
					src="${pageContext.request.contextPath}/production/js/flot/jquery.flot.spline.js"></script>
				<script
					src="${pageContext.request.contextPath}/production/js/flot/curvedLines.js"></script>
				<!-- JQVMap -->
				<script
					src="${pageContext.request.contextPath}/vendors/jqvmap/dist/jquery.vmap.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/jqvmap/dist/maps/jquery.vmap.world.js"></script>
				<script
					src="${pageContext.request.contextPath}/vendors/jqvmap/examples/js/jquery.vmap.sampledata.js"></script>
				<!-- bootstrap-daterangepicker -->
				<script
					src="${pageContext.request.contextPath}/vendors/echarts/dist/echarts.min.js"></script>
					
					<script
					src="${pageContext.request.contextPath}/build/js/custom.min.js"></script>
 <!-- New Tree Map   -->
 <style>
.loader {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 9999;
	background: url('img/gif/Loading-data.gif') 50% 50% no-repeat
		rgb(249, 249, 249);
}
</style>
   <script src="http://d3js.org/d3.v3.min.js"></script>
   
 <script>


    var diameter = 500,
    format = d3.format(",d"),
    dataSource = 0;

    var pack = d3.layout.pack()
    .size([diameter - 4, diameter - 4])
    .sort( function(a, b) {
        return -(a.value - b.value);
    })
    .value(function(d) { return d.size; });

    var svg = d3.select(".bubble").append("svg")
    .attr("width", diameter)
    .attr("height", diameter);

    var buttonData = [];
    var buttonDiv = d3.select("body").append("svg")
    .attr("width", diameter)
    .attr("height", 50);
    var buttons = buttonDiv.selectAll(".updateButton")
    .data(buttonData)
    .enter()
    .append('g')
    .attr("class", "updateButton")
    .on("click", function(d, i) {
    	dataSource = i;
    	updateVis();
    });
    buttons.append("rect")
    .attr("x", function(d, i) { return (i * 100) + 100; })
    .attr("width", 98)
    .attr("height", 25)
    .attr("ry", 5)
    .style("stroke", "#787878")
    .style("fill", "tan");
    buttons.append("text")
    .attr("x", function(d, i) { return (i * 100) + (100 / 2) + 98; })
    .attr("y", 12)
    .attr("dy", "0.35em")
    .style("text-anchor", "middle")
    .style("font-size", "15px")
    .text(function(d) { return d; });

    var data = getData();

    var vis = svg.datum(data).selectAll(".node")
    .data(pack.nodes)
    .enter()
    .append("g");

    var titles = vis.append("title")
    .attr("x", function(d) { return d.x; })
    .attr("y", function(d) { return d.y; })
    
    .text(function(d) { return d.name +
        (d.children ? "" : ": " + format(d.value)); });

    var circles = vis.append("circle")
    .attr("stroke", "white")
    .style("fill", function(d) { return !d.children ? "#428bca" : "white"; })   
    .attr("cx", function(d) { return d.x; })
    .attr("cy", function(d) { return d.y; })
    .attr("r", function(d) { return d.r; });

    //updateVis();

    function updateVis() {

    if (dataSource == 0)
        pack.value(function(d) { return d.size; });
    if (dataSource == 1)
        pack.value(function(d) { return 100; });
    if (dataSource == 2)
        pack.value(function(d) { return 1 +
                 Math.floor(Math.random()*301); });
    //pack.sort(null)

    var data1 = pack.nodes(data);

    titles.attr("x", function(d) { return d.x; })
        .attr("y", function(d) { return d.y; })
        .text(function(d) { return d.name +
            (d.children ? "" : ": " + format(d.value)); });

    circles.transition()
        .duration(5000)
        .attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; })
        .attr("r", function(d) { return d.r; });
    };


    function getData() {
    return {
    "name": "",
    "children": [
    	<c:forEach var="v1" items="${nlg}">
    	{
    		"name":"${v1[1]}","size":${v1[0]}
    	},
    	</c:forEach>


    ]
    };
    }

  


    </script>
						<script>

		var sample_data = {${data}}
    $(document).ready(function(){
        $('#world-map-gdp').vectorMap({
            map: 'world_en',
            backgroundColor: null,
            color: '#ffffff',
            hoverOpacity: 0.7,
            selectedColor: '#666666',
            enableZoom: true,
            showTooltip: true,
            values: sample_data,
            scaleColors: ['#E6F2F0', '#149B7E'],
            normalizeFunction: 'polynomial'
        });
      });

      var theme = {
          color: [
              '#26B99A', '#34495E', '#BDC3C7', '#3498DB',
              '#9B59B6', '#8abb6f', '#759c6a', '#bfd3b7'
          ],
          title: {
              itemGap: 8,
              textStyle: {
                  fontWeight: 'normal',
                  color: '#408829'
              }
          },
          dataRange: {
              color: ['#1f610a', '#97b58d']
          },
          toolbox: {
              color: ['#408829', '#408829', '#408829', '#408829']
          },
          tooltip: {
              backgroundColor: 'rgba(0,0,0,0.5)',
              axisPointer: {
                  type: 'line',
                  lineStyle: {
                      color: '#408829',
                      type: 'dashed'
                  },
                  crossStyle: {
                      color: '#408829'
                  },
                  shadowStyle: {
                      color: 'rgba(200,200,200,0.3)'
                  }
              }
          },
          dataZoom: {
              dataBackgroundColor: '#eee',
              fillerColor: 'rgba(64,136,41,0.2)',
              handleColor: '#408829'
          },
          grid: {
              borderWidth: 0
          },
          categoryAxis: {
              axisLine: {
                  lineStyle: {
                      color: '#408829'
                  }
              },
              splitLine: {
                  lineStyle: {
                      color: ['#eee']
                  }
              }
          },
          valueAxis: {
              axisLine: {
                  lineStyle: {
                      color: '#408829'
                  }
              },
              splitArea: {
                  show: true,
                  areaStyle: {
                      color: ['rgba(250,250,250,0.1)', 'rgba(200,200,200,0.1)']
                  }
              },
              splitLine: {
                  lineStyle: {
                      color: ['#eee']
                  }
              }
          },
          timeline: {
              lineStyle: {
                  color: '#408829'
              },
              controlStyle: {
                  normal: {color: '#408829'},
                  emphasis: {color: '#408829'}
              }
          },
          k: {
              itemStyle: {
                  normal: {
                      color: '#68a54a',
                      color0: '#a9cba2',
                      lineStyle: {
                          width: 1,
                          color: '#408829',
                          color0: '#86b379'
                      }
                  }
              }
          },
          map: {
              itemStyle: {
                  normal: {
                      areaStyle: {
                          color: '#ddd'
                      },
                      label: {
                          textStyle: {
                              color: '#c12e34'
                          }
                      }
                  },
                  emphasis: {
                      areaStyle: {
                          color: '#99d2dd'
                      },
                      label: {
                          textStyle: {
                              color: '#c12e34'
                          }
                      }
                  }
              }
          },
          force: {
              itemStyle: {
                  normal: {
                      linkStyle: {
                          strokeColor: '#408829'
                      }
                  }
              }
          },
          chord: {
              padding: 4,
              itemStyle: {
                  normal: {
                      lineStyle: {
                          width: 1,
                          color: 'rgba(128, 128, 128, 0.5)'
                      },
                      chordStyle: {
                          lineStyle: {
                              width: 1,
                              color: 'rgba(128, 128, 128, 0.5)'
                          }
                      }
                  },
                  emphasis: {
                      lineStyle: {
                          width: 1,
                          color: 'rgba(128, 128, 128, 0.5)'
                      },
                      chordStyle: {
                          lineStyle: {
                              width: 1,
                              color: 'rgba(128, 128, 128, 0.5)'
                          }
                      }
                  }
              }
          },
          gauge: {
              startAngle: 225,
              endAngle: -45,
              axisLine: {
                  show: true,
                  lineStyle: {
                      color: [[0.2, '#86b379'], [0.8, '#68a54a'], [1, '#408829']],
                      width: 8
                  }
              },
              axisTick: {
                  splitNumber: 10,
                  length: 12,
                  lineStyle: {
                      color: 'auto'
                  }
              },
              axisLabel: {
                  textStyle: {
                      color: 'auto'
                  }
              },
              splitLine: {
                  length: 18,
                  lineStyle: {
                      color: 'auto'
                  }
              },
              pointer: {
                  length: '90%',
                  color: 'auto'
              },
              title: {
                  textStyle: {
                      color: '#333'
                  }
              },
              detail: {
                  textStyle: {
                      color: 'auto'
                  }
              }
          },
          textStyle: {
              fontFamily: 'Arial, Verdana, sans-serif'
          }
      };

      var dataStyle = {
        normal: {
          label: {
            show: false
          },
          labelLine: {
            show: false
          }
        }
      };
      var placeHolderStyle = {
        normal: {
          color: 'rgba(0,0,0,0)',
          label: {
            show: false
          },
          labelLine: {
            show: false
          }
        },
        emphasis: {
          color: 'rgba(0,0,0,0)'
        }
      };
      var echartMiniPie = echarts.init(document.getElementById('echart_mini_pie'), theme);
      echartMiniPie .setOption({
        title: {
          text: 'Language',
          subtext: '',
          sublink: 'http://e.weibo.com/1341556070/AhQXtjbqh',
          x: 'center',
          y: 'center',
          itemGap: 20,
          textStyle: {
            color: 'rgba(30,144,255,0.8)',
            fontFamily: '',
            fontSize: 35,
            fontWeight: 'bolder'
          }
        },
        tooltip: {
          show: true,
          formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
          orient: 'vertical',
          x: 170,
          y: 45,
          itemGap: 12,
          data: ${nlang}
        },
        toolbox: {
          show: true,
          feature: {
            mark: {
              show: true
            },
            dataView: {
              show: true,
              title: "Text View",
              lang: [
                "Text View",
                "Close",
                "Refresh"
              ],
              readOnly: false
            },
            restore: {
              show: true,
              title: "Restore"
            }

          }
        },
        series: ${series}
      });

    </script>
    
	<script type="text/javascript">

    function trackerchanged() {
		$(".loader").removeClass("hidden");
		document.getElementById("trackerform").submit();
		}
		function datechanged() {
			$(".loader").removeClass("hidden");
		document.getElementById("dateform").submit();
		}

    </script>
   
   



   <!-- New Tree Map   -->
   <script src="http://d3js.org/d3.v3.min.js"></script>

   <script>


window.addEventListener('message', function(e) {
    var opts = e.data.opts,
        data = e.data.data;

    return main(opts, data);
});

var defaults = {
    margin: {top: 24, right: 0, bottom: 0, left: 0},
    rootname: "TOP",
    format: ",d",
    title: "",
    width: 960,
    height: 500
};

function main(o, data) {
  var root,
      opts = $.extend(true, {}, defaults, o),
      formatNumber = d3.format(opts.format),
      rname = opts.rootname,
      margin = opts.margin,
      theight = 36 + 16;

  $('#chart').width(opts.width).height(opts.height);
  var width = opts.width - margin.left - margin.right,
      height = opts.height - margin.top - margin.bottom - theight,
      transitioning;

  var color = d3.scale.category20c();

  var x = d3.scale.linear()
      .domain([0, width])
      .range([0, width]);

  var y = d3.scale.linear()
      .domain([0, height])
      .range([0, height]);

  var treemap = d3.layout.treemap()
      .children(function(d, depth) { return depth ? null : d._children; })
      .sort(function(a, b) { return a.value - b.value; })
      .ratio(height / width * 0.5 * (1 + Math.sqrt(5)))
      .round(false);

  var svg = d3.select("#chart").append("svg")
      .attr("width","95%")
      .attr("height", height + margin.bottom + margin.top)
      .style("margin-left", -margin.left + "px")
      .style("margin.right", -margin.right + "px")
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
      .style("shape-rendering", "crispEdges");

  var grandparent = svg.append("g")
      .attr("class", "grandparent");

  grandparent.append("rect")
      .attr("y", -margin.top)
      .attr("width", width)
      .attr("height", margin.top);

  grandparent.append("text")
      .attr("x", 6)
      .attr("y", 6 - margin.top)
      .attr("dy", ".75em");

  if (opts.title) {
    $("#chart").prepend("<p class='title'>" + opts.title + "</p>");
  }
  if (data instanceof Array) {
    root = { key: rname, values: data };
  } else {
    root = data;
  }

  initialize(root);
  accumulate(root);
  layout(root);
  //console.log(root);
  display(root);

  if (window.parent !== window) {
    var myheight = document.documentElement.scrollHeight || document.body.scrollHeight;
    window.parent.postMessage({height: myheight}, '*');
  }

  function initialize(root) {
    root.x = root.y = 0;
    root.dx = width;
    root.dy = height;
    root.depth = 0;
  }

  // Aggregate the values for internal nodes. This is normally done by the
  // treemap layout, but not here because of our custom implementation.
  // We also take a snapshot of the original children (_children) to avoid
  // the children being overwritten when when layout is computed.
  function accumulate(d) {
    return (d._children = d.values)
        ? d.value = d.values.reduce(function(p, v) { return p + accumulate(v); }, 0)
        : d.value;
  }

  // Compute the treemap layout recursively such that each group of siblings
  // uses the same size (1×1) rather than the dimensions of the parent cell.
  // This optimizes the layout for the current zoom state. Note that a wrapper
  // object is created for the parent node for each group of siblings so that
  // the parent’s dimensions are not discarded as we recurse. Since each group
  // of sibling was laid out in 1×1, we must rescale to fit using absolute
  // coordinates. This lets us use a viewport to zoom.
  function layout(d) {
    if (d._children) {
      treemap.nodes({_children: d._children});
      d._children.forEach(function(c) {
        c.x = d.x + c.x * d.dx;
        c.y = d.y + c.y * d.dy;
        c.dx *= d.dx;
        c.dy *= d.dy;
        c.parent = d;
        layout(c);
      });
    }
  }

  function display(d) {
    grandparent
        .datum(d.parent)
        .on("click", transition)
      .select("text")
        .text(name(d));

    var g1 = svg.insert("g", ".grandparent")
        .datum(d)
        .attr("class", "depth");

    var g = g1.selectAll("g")
        .data(d._children)
      .enter().append("g");

    g.filter(function(d) { return d._children; })
        .classed("children", true)
        .on("click", transition);

    var children = g.selectAll(".child")
        .data(function(d) { return d._children || [d]; })
      .enter().append("g");

    children.append("rect")
        .attr("class", "child")
        .call(rect)
      .append("title")
        .text(function(d) { return d.key + " (" + formatNumber(d.value) + ")"; });
    children.append("text")
        .attr("class", "ctext")
        .text(function(d) { return d.key; })
        .call(text2);

    g.append("rect")
        .attr("class", "parent")
        .call(rect);

    var t = g.append("text")
        .attr("class", "ptext")
        .attr("dy", ".75em")

    t.append("tspan")
        .text(function(d) { return d.key; });
    t.append("tspan")
        .attr("dy", "1.0em")
        .text(function(d) { return formatNumber(d.value); });
    t.call(text);

    g.selectAll("rect")
        .style("fill", function(d) { return color(d.key); });

    function transition(d) {
      if (transitioning || !d) return;
      transitioning = true;

      var g2 = display(d),
          t1 = g1.transition().duration(750),
          t2 = g2.transition().duration(750);

      // Update the domain only after entering new elements.
      x.domain([d.x, d.x + d.dx]);
      y.domain([d.y, d.y + d.dy]);

      // Enable anti-aliasing during the transition.
      svg.style("shape-rendering", null);

      // Draw child nodes on top of parent nodes.
      svg.selectAll(".depth").sort(function(a, b) { return a.depth - b.depth; });

      // Fade-in entering text.
      g2.selectAll("text").style("fill-opacity", 0);

      // Transition to the new view.
      t1.selectAll(".ptext").call(text).style("fill-opacity", 0);
      t1.selectAll(".ctext").call(text2).style("fill-opacity", 0);
      t2.selectAll(".ptext").call(text).style("fill-opacity", 1);
      t2.selectAll(".ctext").call(text2).style("fill-opacity", 1);
      t1.selectAll("rect").call(rect);
      t2.selectAll("rect").call(rect);

      // Remove the old node when the transition is finished.
      t1.remove().each("end", function() {
        svg.style("shape-rendering", "crispEdges");
        transitioning = false;
      });
    }

    return g;
  }

  function text(text) {
    text.selectAll("tspan")
        .attr("x", function(d) { return x(d.x) + 6; })
    text.attr("x", function(d) { return x(d.x) + 6; })
        .attr("y", function(d) { return y(d.y) + 6; })
        .style("opacity", function(d) { return this.getComputedTextLength() < x(d.x + d.dx) - x(d.x) ? 1 : 0; });
  }

  function text2(text) {
    text.attr("x", function(d) { return x(d.x + d.dx) - this.getComputedTextLength() - 6; })
        .attr("y", function(d) { return y(d.y + d.dy) - 6; })
        .style("opacity", function(d) { return this.getComputedTextLength() < x(d.x + d.dx) - x(d.x) ? 1 : 0; });
  }

  function rect(rect) {
    rect.attr("x", function(d) { return x(d.x); })
        .attr("y", function(d) { return y(d.y); })
        .attr("width", function(d) { return x(d.x + d.dx) - x(d.x); })
        .attr("height", function(d) { return y(d.y + d.dy) - y(d.y); });
  }

  function name(d) {
    return d.parent
        ? name(d.parent) + " / " + d.key + " (" + formatNumber(d.value) + ")"
        : d.key + " (" + formatNumber(d.value) + ")";
  }
}

if (window.location.hash === "") {
    d3.json("countries.json", function(err, res) {
        if (!err) {
           // console.log(res);
            var data = d3.nest().key(function(d) { return d.region; }).key(function(d) { return d.subregion; }).entries(res);
            main({title: ""}, {key: "${tracker}", values: data});
        }
    });
}

</script>