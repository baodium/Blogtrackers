(function(window,undefined){
	window.$.fn.boshWordcloud=function(data, option){
		
		var option = option || {};
	    var w = option['width'] || 1440;
	    var h = option['height'] || 1080;
	    var font = option['fontlist'] || ["Impact","calibri","Ariel","Forte","monospace","Courier New","Verdana","Times","fantasy","Georgia"];
		var max_r = (typeof option['max_rotate'] === "undefined") ? 60 : option['max_rotate'];
		var r = d3.scale.linear()
			.range([-max_r, max_r])
			.domain([0, 1]);
		var c = d3.scale.linear()
			.range([0, 240])
			.domain([0, 1]);
		
		var recovertime = option['focusperiod'] || 3000;
		var map_f = option['mapping'] || 'linear';
		var len_adj = (typeof option['len_adjust'] === "undefined") ? true : option['len_adjust'];
		var max = option['max_font_size'] || 150;
		var min = option['min_font_size'] || 15;
		
		var d_len = data.length;
		var style = option['style'] || 'random';
		var timer;
		var target = d3.select(this[0]);
		var freq_box;
		
		console.log(font instanceof Array);
		
		d3.layout.cloud()
			.size([w, h])
            .words(map(data, map_f, len_adj, max, min))
            .rotate(function(){return r(Math.random());})
            .fontSize(function(d) {return d.size;})
            .on("end", draw)
            .start();
		
		function draw(data){
		
			freq_box = target
				.append("div")
				.attr("class", "tooltip")
				.style("opacity", 1);
			
			target.append('svg')
				.attr('width', w)
				.attr('height', h)
				.append('g')
				.attr('transform', function(d) { return 'translate(' + w/2 + ',' + h/2 + ')'; })
				.selectAll('text')
				.data(data)
				.enter()
				.append('text')
				.transition().duration(1000)
				.style('font-size', function(d) { return d.size+'px'; })
				.style('font-family', function(d) { return getfont(); })
				.style('opacity', 1)
				.style('fill', function(d, i) { return color(i); })
				.attr('text-anchor', 'middle')
				.attr('transform', function(d) { return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")"; })
				.attr('freq', function(d){ return d.freq; })
				.text(function(d) { return d.text; });
			
			d3.selectAll("text")
				.on("mouseover", highlight);
		}
		
		function highlight(){
			d3.selectAll("text").style('opacity', .1);
			d3.select(this).style('opacity',1);
			freq_box
				.html('<text>'+d3.select(this).text()+'</text><br><text>'+d3.select(this).attr('freq')+'</text>')
				.style("opacity", 1)
				.style("left", d3.event.pageX+"px")
				.style("top", d3.event.pageY+"px");
			
			clearTimeout(timer);
			timer = setTimeout(wakeup, recovertime);
		}
		
		function wakeup(){
			d3.selectAll("text")
				.transition()
				.duration(1000)
				.style('opacity', 1);
			freq_box
				.transition()
				.duration(1000)
				.style("opacity", 0);
		}
		
		function adj_size(d){ return d[1]/d[0].length; }
		function nml_size(d){ return d[1]; }
		function map(data, map_f, len_adj, max, min){
			
			// sorting
                        eff_size = (len_adj) ? adj_size : nml_size;
		        data.sort(function(a,b){
				if (eff_size(a) < eff_size(b)) return 1;
  				return -1;
			});
		
			var s;
			if(map_f == 'log') 
				s = d3.scale.log();
			else if(map_f.substr(0, 3) == 'pow')
				s = d3.scale.pow(parseFloat(map_f.substr(4, map_f.length-1)));
			else // include 'linear' and default
				s = d3.scale.linear();
			
		
			s.range([max, min])
				.domain([eff_size(data[0]), eff_size(data[data.length-1])]);
			
			re = [];
			for(i in data)
				re.push({"text":data[i][0],"size":s(eff_size(data[i])),"freq":data[i][1]});
			
			return re;
		}
		
		function darkness(d){
			if((typeof d) != "undefined") return Math.floor(c(d));
			return Math.floor(c(Math.random()));
		}
		
		function color(i){
			console.log(style);
			switch(style){
				case 'r':
					return 'rgb('+darkness(1)+','+darkness()+','+darkness()+')';
				case 'g':
					return 'rgb('+darkness()+','+darkness(1)+','+darkness()+')';
				case 'b':
					return 'rgb('+darkness()+','+darkness()+','+darkness(1)+')';
				case '-r':
					return 'rgb('+darkness(0)+','+darkness()+','+darkness()+')';
				case '-g':
					return 'rgb('+darkness()+','+darkness(0)+','+darkness()+')';
				case '-b':
					return 'rgb('+darkness()+','+darkness()+','+darkness(0)+')';
				case 'mono':
					d = Math.random();
					return 'rgb('+darkness(d)+','+darkness(d)+','+darkness(d)+')';
				case 'random':
				default:
					return 'rgb('+darkness()+','+darkness()+','+darkness()+')';
			}
		}
		
		function getfont(){
			return font[Math.floor(Math.random()*font.length)];
		}     
	         
	         
		return this;
	};

})(window);
