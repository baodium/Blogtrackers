   <script type="text/javascript" src="assets/js/intro.js"></script>
   
	<!--  before Theme JS files -->
	<script type="text/javascript" src="assets/js/plugins/forms/styling/switchery.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/styling/uniform.min.js"></script>
	<script type="text/javascript" src="assets/js/plugins/forms/selects/bootstrap_multiselect.js"></script>
<script
					src="${pageContext.request.contextPath}/production/js/moment/moment.min.js"></script>
	<script
						src="${pageContext.request.contextPath}/production/js/datepicker/daterangepicker.js"></script>
<script type="text/javascript" src="assets/js/plugins/tables/datatables/datatables.min.js"></script>
<script type="text/javascript" src="assets/js/plugins/forms/selects/select2.min.js"></script>



	


 <script type="text/javascript" src="assets/js/core/app.js"></script>

	<script type="text/javascript" src="assets/js/plugins/ui/ripple.min.js"></script>
	<script src="js/hcluster.js"></script>
	 <script>
	// hierachical clustering
	var colors = [{"name":"�Red","position":[238,32,77]},{"name":"�Maroon","position":[195,33,72]},{"name":"�Scarlet","position":[253,14,53]},{"name":"�Brick Red","position":[198,45,66]},{"name":"�English Vermilion","position":[204,71,75]},{"name":"�Madder Lake","position":[204,51,54]},{"name":"�Permanent Geranium Lake","position":[225,44,44]},{"name":"�Maximum Red","position":[217,33,33]},{"name":"�Indian Red","position":[185,78,72]},{"name":"�Orange-Red","position":[255,63,52]},{"name":"�Sunset Orange","position":[254,76,64]},{"name":"�Bittersweet","position":[254,111,94]},{"name":"�Dark Venetian Red","position":[179,59,36]},{"name":"�Venetian Red","position":[204,85,61]},{"name":"�Light Venetian Red","position":[230,115,92]},{"name":"�Vivid Tangerine","position":[255,153,128]},{"name":"�Middle Red","position":[229,144,115]},{"name":"�Burnt Orange","position":[255,112,52]},{"name":"�Red-Orange","position":[255,104,31]},{"name":"�Orange","position":[255,136,100]},{"name":"�Macaroni and Cheese","position":[255,185,123]},{"name":"�Middle Yellow Red","position":[236,177,118]},{"name":"�Mango Tango","position":[231,114,0]},{"name":"�Yellow-Orange","position":[255,174,66]},{"name":"�Maximum Yellow Red","position":[242,186,73]},{"name":"�Banana Mania","position":[251,231,178]},{"name":"�Maize","position":[242,198,73]},{"name":"�Orange-Yellow","position":[248,213,104]},{"name":"�Goldenrod","position":[252,214,103]},{"name":"�Dandelion","position":[254,216,93]},{"name":"�Yellow","position":[252,232,131]},{"name":"�Green-Yellow","position":[241,231,136]},{"name":"�Middle Yellow","position":[255,235,0]},{"name":"�Olive Green","position":[181,179,92]},{"name":"�Spring Green","position":[236,235,189]},{"name":"�Maximum Yellow","position":[250,250,55]},{"name":"�Canary","position":[255,255,153]},{"name":"�Lemon Yellow","position":[255,255,159]},{"name":"�Maximum Green Yellow","position":[217,230,80]},{"name":"�Middle Green Yellow","position":[172,191,96]},{"name":"�Inchworm","position":[175,227,19]},{"name":"�Light Chrome Green","position":[190,230,75]},{"name":"�Yellow-Green","position":[197,225,122]},{"name":"�Maximum Green","position":[94,140,49]},{"name":"�Asparagus","position":[123,160,91]},{"name":"�Granny Smith Apple","position":[157,224,147]},{"name":"�Fern","position":[99,183,108]},{"name":"�Middle Green","position":[77,140,87]},{"name":"�Green","position":[58,166,85]},{"name":"�Medium Chrome Green","position":[108,166,124]},{"name":"�Forest Green","position":[95,167,119]},{"name":"�Sea Green","position":[147,223,184]},{"name":"�Shamrock","position":[51,204,153]},{"name":"�Mountain Meadow","position":[26,179,133]},{"name":"�Jungle Green","position":[41,171,135]},{"name":"�Caribbean Green","position":[0,204,153]},{"name":"�Tropical Rain Forest","position":[0,117,94]},{"name":"�Middle Blue Green","position":[141,217,204]},{"name":"�Pine Green","position":[1,120,111]},{"name":"�Maximum Blue Green","position":[48,191,191]},{"name":"�Robin's Egg Blue","position":[0,204,204]},{"name":"�Teal Blue","position":[0,128,128]},{"name":"�Light Blue","position":[143,216,216]},{"name":"�Aquamarine","position":[149,224,232]},{"name":"�Turquoise Blue","position":[108,218,231]},{"name":"�Outer Space","position":[45,56,58]},{"name":"�Sky Blue","position":[118,215,234]},{"name":"�Middle Blue","position":[126,212,230]},{"name":"�Blue-Green","position":[0,149,183]},{"name":"�Pacific Blue","position":[0,157,196]},{"name":"�Cerulean","position":[2,164,211]},{"name":"�Maximum Blue","position":[71,171,204]},{"name":"�Blue (I)","position":[46,180,230]},{"name":"�Cerulean Blue","position":[51,154,204]},{"name":"�Cornflower","position":[147,204,234]},{"name":"�Green-Blue","position":[40,135,200]},{"name":"�Midnight Blue","position":[0,70,140]},{"name":"�Navy Blue","position":[0,102,204]},{"name":"�Denim","position":[21,96,189]},{"name":"�Blue (III)","position":[0,102,255]},{"name":"�Cadet Blue","position":[169,178,195]},{"name":"�Periwinkle","position":[195,205,230]},{"name":"�Blue (II)","position":[69,112,230]},{"name":"�Wild Blue Yonder","position":[122,137,184]},{"name":"�Indigo","position":[79,105,198]},{"name":"�Manatee","position":[141,144,161]},{"name":"�Cobalt Blue","position":[140,144,200]},{"name":"�Celestial Blue","position":[112,112,204]},{"name":"�Blue Bell","position":[153,153,204]},{"name":"�Maximum Blue Purple","position":[172,172,230]},{"name":"�Violet-Blue","position":[118,110,200]},{"name":"�Blue-Violet","position":[100,86,183]},{"name":"�Ultramarine Blue","position":[63,38,191]},{"name":"�Middle Blue Purple","position":[139,114,190]},{"name":"�Purple Heart","position":[101,45,193]},{"name":"�Royal Purple","position":[107,63,160]},{"name":"�Violet (II)","position":[131,89,163]},{"name":"�Medium Violet","position":[143,71,179]},{"name":"�Wisteria","position":[201,160,220]},{"name":"�Lavender (I)","position":[191,143,204]},{"name":"�Vivid Violet","position":[128,55,144]},{"name":"�Maximum Purple","position":[115,51,128]},{"name":"�Purple Mountains' Majesty","position":[214,174,221]},{"name":"�Fuchsia","position":[193,84,193]},{"name":"�Pink Flamingo","position":[252,116,253]},{"name":"�Violet (I)","position":[115,46,108]},{"name":"�Brilliant Rose","position":[230,103,206]},{"name":"�Orchid","position":[226,156,210]},{"name":"�Plum","position":[142,49,121]},{"name":"�Medium Rose","position":[217,108,190]},{"name":"�Thistle","position":[235,176,215]},{"name":"�Mulberry","position":[200,80,155]},{"name":"�Red-Violet","position":[187,51,133]},{"name":"�Middle Purple","position":[217,130,181]},{"name":"�Maximum Red Purple","position":[166,58,121]},{"name":"�Jazzberry Jam","position":[165,11,94]},{"name":"�Eggplant","position":[97,64,81]},{"name":"�Magenta","position":[246,83,166]},{"name":"�Cerise","position":[218,50,135]},{"name":"�Wild Strawberry","position":[255,51,153]},{"name":"�Lavender (II)","position":[251,174,210]},{"name":"�Cotton Candy","position":[255,183,213]},{"name":"�Carnation Pink","position":[255,166,201]},{"name":"�Violet-Red","position":[247,70,138]},{"name":"�Razzmatazz","position":[227,11,92]},{"name":"�Pig Pink","position":[253,215,228]},{"name":"�Carmine","position":[230,46,107]},{"name":"�Blush","position":[219,80,121]},{"name":"�Tickle Me Pink","position":[252,128,165]},{"name":"�Mauvelous","position":[240,145,169]},{"name":"�Salmon","position":[255,145,164]},{"name":"�Middle Red Purple","position":[165,83,83]},{"name":"�Mahogany","position":[202,52,53]},{"name":"�Melon","position":[254,186,173]},{"name":"�Pink Sherbert","position":[247,163,142]},{"name":"�Burnt Sienna","position":[233,116,81]},{"name":"�Brown","position":[175,89,62]},{"name":"�Sepia","position":[158,91,64]},{"name":"�Fuzzy Wuzzy","position":[135,66,31]},{"name":"�Beaver","position":[146,111,91]},{"name":"�Tumbleweed","position":[222,166,129]},{"name":"�Raw Sienna","position":[210,125,70]},{"name":"�Van Dyke Brown","position":[102,66,40]},{"name":"�Tan","position":[217,154,108]},{"name":"�Desert Sand","position":[237,201,175]},{"name":"�Peach","position":[255,203,164]},{"name":"�Burnt Umber","position":[128,85,51]},{"name":"�Apricot","position":[253,213,177]},{"name":"�Almond","position":[238,217,196]},{"name":"�Raw Umber","position":[102,82,51]},{"name":"�Shadow","position":[131,112,80]},{"name":"�Raw Sienna (I)","position":[230,188,92]},{"name":"�Timberwolf","position":[217,214,207]},{"name":"�Gold (I)","position":[146,146,110]},{"name":"�Gold (II)","position":[230,190,138]},{"name":"�Silver","position":[201,192,187]},{"name":"�Copper","position":[218,138,103]},{"name":"�Antique Brass","position":[200,138,101]},{"name":"�Black","position":[0,0,0]},{"name":"�Charcoal Gray","position":[115,106,98]},{"name":"�Gray","position":[139,134,128]},{"name":"�Blue-Gray","position":[200,200,205]},{"name":"�White","position":[255,255,255]}];

	// http://bl.ocks.org/shamangeorge/8029743
	// var colors = window.colors = [{"name":"Almond","position":[239,222,205]},{"name":"Antique Brass","position":[205,149,117]},{"name":"Apricot","position":[253,217,181]},{"name":"Aquamarine","position":[120,219,226]},{"name":"Asparagus","position":[135,169,107]},{"name":"Atomic Tangerine","position":[255,164,116]},{"name":"Banana Mania","position":[250,231,181]},{"name":"Beaver","position":[159,129,112]},{"name":"Bittersweet","position":[253,124,110]},{"name":"Black","position":[1,1,1]},{"name":"Blizzard Blue","position":[172,229,238]},{"name":"Blue","position":[31,117,254]},{"name":"Blue Bell","position":[162,162,208]},{"name":"Blue Gray","position":[102,153,204]},{"name":"Blue Green","position":[13,152,186]},{"name":"Blue Violet","position":[115,102,189]},{"name":"Blush","position":[222,93,131]},{"name":"Brick Red","position":[203,65,84]},{"name":"Brown","position":[180,103,77]},{"name":"Burnt Orange","position":[255,127,73]},{"name":"Burnt Sienna","position":[234,126,93]},{"name":"Cadet Blue","position":[176,183,198]},{"name":"Canary","position":[255,255,153]},{"name":"Caribbean Green","position":[28,211,162]},{"name":"Carnation Pink","position":[255,170,204]},{"name":"Cerise","position":[221,68,146]},{"name":"Cerulean","position":[29,172,214]},{"name":"Chestnut","position":[188,93,88]},{"name":"Copper","position":[221,148,117]},{"name":"Cornflower","position":[154,206,235]},{"name":"Cotton Candy","position":[255,188,217]},{"name":"Dandelion","position":[253,219,109]},{"name":"Denim","position":[43,108,196]},{"name":"Desert Sand","position":[239,205,184]},{"name":"Eggplant","position":[110,81,96]},{"name":"Electric Lime","position":[206,255,29]},{"name":"Fern","position":[113,188,120]},{"name":"Forest Green","position":[109,174,129]},{"name":"Fuchsia","position":[195,100,197]},{"name":"Fuzzy Wuzzy","position":[204,102,102]},{"name":"Gold","position":[231,198,151]},{"name":"Goldenrod","position":[252,217,117]},{"name":"Granny Smith Apple","position":[168,228,160]},{"name":"Gray","position":[149,145,140]},{"name":"Green","position":[28,172,120]},{"name":"Green Blue","position":[17,100,180]},{"name":"Green Yellow","position":[240,232,145]},{"name":"Hot Magenta","position":[255,29,206]},{"name":"Inchworm","position":[178,236,93]},{"name":"Indigo","position":[93,118,203]},{"name":"Jazzberry Jam","position":[202,55,103]},{"name":"Jungle Green","position":[59,176,143]},{"name":"Laser Lemon","position":[254,254,34]},{"name":"Lavender","position":[252,180,213]},{"name":"Lemon Yellow","position":[255,244,79]},{"name":"Macaroni and Cheese","position":[255,189,136]},{"name":"Magenta","position":[246,100,175]},{"name":"Magic Mint","position":[170,240,209]},{"name":"Mahogany","position":[205,74,76]},{"name":"Maize","position":[237,209,156]},{"name":"Manatee","position":[151,154,170]},{"name":"Mango Tango","position":[255,130,67]},{"name":"Maroon","position":[200,56,90]},{"name":"Mauvelous","position":[239,152,170]},{"name":"Melon","position":[253,188,180]},{"name":"Midnight Blue","position":[26,72,118]},{"name":"Mountain Meadow","position":[48,186,143]},{"name":"Mulberry","position":[197,75,140]},{"name":"Navy Blue","position":[25,116,210]},{"name":"Neon Carrot","position":[255,163,67]},{"name":"Olive Green","position":[186,184,108]},{"name":"Orange","position":[255,117,56]},{"name":"Orange Red","position":[255,43,43]},{"name":"Orange Yellow","position":[248,213,104]},{"name":"Orchid","position":[230,168,215]},{"name":"Outer Space","position":[65,74,76]},{"name":"Outrageous Orange","position":[255,110,74]},{"name":"Pacific Blue","position":[28,169,201]},{"name":"Peach","position":[255,207,171]},{"name":"Periwinkle","position":[197,208,230]},{"name":"Piggy Pink","position":[253,221,230]},{"name":"Pine Green","position":[21,128,120]},{"name":"Pink Flamingo","position":[252,116,253]},{"name":"Pink Sherbet","position":[247,143,167]},{"name":"Plum","position":[142,69,133]},{"name":"Purple Heart","position":[116,66,200]},{"name":"Purple Mountain's Majesty","position":[157,129,186]},{"name":"Purple Pizzazz","position":[254,78,218]},{"name":"Radical Red","position":[255,73,108]},{"name":"Raw Sienna","position":[214,138,89]},{"name":"Raw Umber","position":[113,75,35]},{"name":"Razzle Dazzle Rose","position":[255,72,208]},{"name":"Razzmatazz","position":[227,37,107]},{"name":"Red","position":[238,32,77]},{"name":"Red Orange","position":[255,83,73]},{"name":"Red Violet","position":[192,68,143]},{"name":"Robin's Egg Blue","position":[31,206,203]},{"name":"Royal Purple","position":[120,81,169]},{"name":"Salmon","position":[255,155,170]},{"name":"Scarlet","position":[252,40,71]},{"name":"Screamin' Green","position":[118,255,122]},{"name":"Sea Green","position":[159,226,191]},{"name":"Sepia","position":[165,105,79]},{"name":"Shadow","position":[138,121,93]},{"name":"Shamrock","position":[69,206,162]},{"name":"Shocking Pink","position":[251,126,253]},{"name":"Silver","position":[205,197,194]},{"name":"Sky Blue","position":[128,218,235]},{"name":"Spring Green","position":[236,234,190]},{"name":"Sunglow","position":[255,207,72]},{"name":"Sunset Orange","position":[253,94,83]},{"name":"Tan","position":[250,167,108]},{"name":"Teal Blue","position":[24,167,181]},{"name":"Thistle","position":[235,199,223]},{"name":"Tickle Me Pink","position":[252,137,172]},{"name":"Timberwolf","position":[219,215,210]},{"name":"Tropical Rain Forest","position":[23,128,109]},{"name":"Tumbleweed","position":[222,170,136]},{"name":"Turquoise Blue","position":[119,221,231]},{"name":"Unmellow Yellow","position":[255,255,102]},{"name":"Violet (Purple)","position":[146,110,174]},{"name":"Violet Blue","position":[50,74,178]},{"name":"Violet Red","position":[247,83,148]},{"name":"Vivid Tangerine","position":[255,160,137]},{"name":"Vivid Violet","position":[143,80,157]},{"name":"White","position":[255,255,255]},{"name":"Wild Blue Yonder","position":[162,173,208]},{"name":"Wild Strawberry","position":[255,67,164]},{"name":"Wild Watermelon","position":[252,108,133]},{"name":"Wisteria","position":[205,164,222]},{"name":"Yellow","position":[252,232,131]},{"name":"Yellow Green","position":[197,227,132]},{"name":"Yellow Orange","position":[255,174,66]}];

	//
	var colorCluster = window.colorCluster = hcluster()
	  .distance('euclidean')
	  .linkage('avg')
	  // .verbose(true)
	  .data(
	    colors.sort(function(a,b) { return Math.random() - 0.5 })
	  );

	//
	var height = 2000,
	    width = 500;

	//
	var svg = d3.select('#container').append('svg')
	  .attr('width', width + 300)
	  .attr('height', height + 60)
	  .append('g')
	    .attr('transform', 'translate(30,30)');

	//
	var cluster = d3.layout.cluster()
	  .size([height, width]);
	var diagonal = d3.svg.diagonal()
	  .projection(function(d) { return [d.y, d.x]; });

	//
	var nodes = cluster.nodes(colorCluster.tree()),
	    links = cluster.links(nodes);

	// http://bl.ocks.org/mbostock/2429963
	var elbow = function (d, i) {
	  return "M" + d.source.y + "," + d.source.x
	    + "V" + d.target.x + "H" + d.target.y;
	};

	var x = d3.scale.linear()
	  .domain(d3.extent(nodes, function(d) { return d.height; }))
	  .range([width, 0]);
	nodes.forEach(function(d,ndx) { d.y = x(d.height); });

	//
	var link = svg.selectAll('.link')
	  .data(links)
	  .enter().append('path')
	    .attr('class', 'link')
	    .attr('stroke', '#AAA')
	    .attr('stroke-width', '1.5px')
	    .attr('d', elbow);
	var node = svg.selectAll('.node')
	  .data(nodes)
	  .enter().append('g')
	    .attr('class', 'node')
	    .attr('transform', function(d) { return 'translate('+d.y+','+d.x+')'; });
	node.append('circle')
	  .style('stroke', 'none')
	  .style('fill', function(d) { return d.position ? 'rgb('+d.position.join(',')+')' : '#777'; })
	  .attr('r', function(d) { return d.children ? 1.5 : 5.5 });
	node.append('text')
	  .attr('dx', 6)
	  .attr('dy', 2)
	  .text(function(d) { return d.children ? '' : d.name; });
	</script>
	
	<script src="scripts/vendor.js"></script>
	
	
	<script src="js/alchemy.js"></script>
	
<script type="text/javascript">

									 alchemy.begin({
												dataSource: "clusters.json",
												nodeCaption: 'name',
												nodeMouseOver: 'name',
													 cluster: true,
													 clusterColours: ["#1B9E77","#D95F02","#7570B3","#E7298A","#66A61E","#E6AB02"]})

								 </script>
				