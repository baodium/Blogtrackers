<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
      <div id="header"> ... </div>
            <div id="contentHolder"> 
                <div class="leftsidebar">...</div>
                <div class="content">...</div>
            </div>
      <div id="footer">...</div>
</div>
<style>

#wrapper {
    margin: 0 auto;
    width: 1000px;
}
#contentHolder{
position:relative;
}
#header,#footer {
    background: none repeat scroll 0 0 #CCFFFF;
    color: #000000;
    height: 80px;
    width: 1000px;
    clear:both;
    font-size:3em;
    text-align:center;
    padding-top:20px;
}
.leftsidebar {
    background: none repeat scroll 0 0 #FFFFFF;
    border-color: #CCCCCC #BBBBBB #888888;
    border-style: solid;
    border-width: 1px 2px 2px 1px;
    margin-bottom: 3px;
    position: absolute;
    top: 0;
    width: 160px;
}
.leftsidebarfixed {
    position: fixed;
    top: 0;
}
.content {
    float: left;
    margin-left: 165px;
    position: relative;
    width: 570px;
}
</style>
<script>
$(function () {
	   
	  var msie6 = $.browser == 'msie' && $.browser.version < 7;
	   
	  if (!msie6 && $('.leftsidebar').offset()!=null) {
	    var top = $('.leftsidebar').offset().top - parseFloat($('.leftsidebar').css('margin-top').replace(/auto/, 0));
	    var height = $('.leftsidebar').height();
	    var winHeight = $(window).height(); 
	    var footerTop = $('#footer').offset().top - parseFloat($('#footer').css('margin-top').replace(/auto/, 0));
	    var gap = 7;
	    $(window).scroll(function (event) {
	      // what the y position of the scroll is
	      var y = $(this).scrollTop();
	       
	      // whether that's below the form
	      if (y+winHeight >= top+ height+gap && y+winHeight<=footerTop) {
	        // if so, ad the fixed class
	        $('.leftsidebar').addClass('leftsidebarfixed').css('top',winHeight-height-gap +'px');
	      } 
	      else if (y+winHeight>footerTop) {
	        // if so, ad the fixed class
	       $('.leftsidebar').addClass('leftsidebarfixed').css('top',footerTop-height-y-gap+'px');
	      } 
	      else    
	      {
	        // otherwise remove it
	        $('.leftsidebar').removeClass('leftsidebarfixed').css('top','0px');
	      }
	    });
	  }  
	});
</script>
</body>
</html>