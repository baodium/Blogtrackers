var back_url=app_url;
 
var request = false;
var requests = new Array();
var z=0;
 
 

isRunning = false;

function loadMoreResult(){
	//abort_requests();
	if (!isRunning) {
      isRunning = true;	
	//var url=back_url;
	var url = app_url+'webtemplates/loader.jsp'
	var $form = $("#page_form"),
		page_no = $form.find( "input[name='page_id']" ).val();
	var	hasmore= document.forms["page_form"].hasmore.value;
	var	term= $("#term").val();
	
	if(hasmore=="0" || hasmore==""){
		$("#loading-img").addClass("hidden");
		return false;
	}
		
	page_no=parseInt(page_no);
	page_no++;

	$form.find("input[name='page_id']").val(page_no);
	z++;
			requests[z] = $.ajax({ type: "POST",
				url:url,
				async: true,
				data:{page:page_no,term:term,search:"yes"},
				async: true,
				success : function(data){	
				isRunning = false;
				//$.get(url+"/"+page_no,function(data){
				var pos=$(window).height()-200;
				if(data.trim()=="empty"){
					document.forms["page_form"].hasmore.value="0";
					$("#loading-img").html("");
					return false;
				}else{
					try{
						$(".loader-box").addClass("hidden");
					}catch(err){}
					//console.log(data);
					$("#appendee").append(data);
					try{
						
					}catch(err){}
					
					/* Reload masonry*/
					$.getScript("https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js", function( data, textStatus, jqxhr ) {				
						var container = document.querySelector('.grid');
						var msnry = new Masonry( container, {
						itemSelector: '.grid-item'
						});
					//msnry.appended(data);
						msnry.layout();
						//alert("yes");
					});
					
				}
			}
	});
	return false;
	}
}



function trackerchanger(){
	var tracker = $("#tracker").val();
	console.log(tracker);
	if(tracker==""){
		return false;
	}else{
		$.ajax({
	        url: app_url+'setup_tracker',
			method:'POST',
			async: true,
			data:{tracker_id:tracker,select:"yes"},
	        success: function(response)
	        {	
	        	console.log(response);
	        	if(response=="success"){
	        		 window.location.reload;//href = app_url+"dashboard.jsp";
	        	}else{
	        		
	        	}
	        }
	    });	
	}
}


function loadMoreBlogs(){
	//abort_requests();
	if (!isRunning) {
      isRunning = true;	
	//var url=back_url;
	var url = app_url+'webtemplates/trackerloader.jsp'
	var $form = $("#page_form"),
		page_no = $form.find( "input[name='page_id']" ).val();
	var	hasmore= document.forms["page_form"].hasmore.value;
	var	term= $("#search-keyword").val();
	var selected_blogs =  $("#select_ed").val();
	
	if(hasmore=="0" || hasmore==""){
		$("#loading-img").addClass("hidden");
		return false;
	}
	
	page_no=parseInt(page_no);
	page_no++;

	$form.find("input[name='page_id']").val(page_no);
	z++;
			requests[z] = $.ajax({ type: "POST",
				url:url,
				async: true,
				data:{page:page_no,term:term,search:"yes",selected_blogs:selected_blogs},
				//async: true,
				success : function(data){	
				isRunning = false;
				//$.get(url+"/"+page_no,function(data){
				var pos=$(window).height()-200;
				if(data.trim()=="empty"){
					document.forms["page_form"].hasmore.value="0";
					$("#loading-img").html("");
					return false;
				}else{
					try{
						$(".loader-box").addClass("hidden");
					}catch(err){}
					//console.log(data);
					$("#tracking-blog").append(data);				
				}
			}
	});
	return false;
	}
}


function reset_tracker(){
	console.log("yes");
	try{
		$("#search-blog").val("no");
	}catch(e){}
	
}


function abort_requests(){
	for(var m=0; m < requests.length; m++){
		try{
			requests[m].abort();
		}catch(err){}
	}
}
