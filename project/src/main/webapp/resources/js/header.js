$(document).ready(function(){
	
	$("span.menubar").on("click",function(){
		
		let menubardisplay = $("div#mobdiv nav").css("right");
		console.log(menubardisplay);
		if(menubardisplay != "0" ){
			$("div#mobdiv nav").css("right","0");
			$("div#mobdiv nav").css("z-index","1001");
			$("body").css("overflow-y","hidden");
			
		} 
	})
	
	$("span.navclose").on("click",function(){
			let menubardisplay = $("div#mobdiv nav").css("right");
			console.log(menubardisplay);
			if(menubardisplay == "0px" ){
				$("div#mobdiv nav").css("right","-300px");
				$("div#mobdiv nav").css("z-index","1000");
				$("body").css("overflow-y","scroll");
				
			} 
	})
	
	$(window).resize(function(){
	
		if($(window).width() < 767){
			
			$("nav#menunav").css("display","none");
			
		} //end if
	
		if($(window).width() > 767){
			$("nav#menunav").css("display","block");
		}
	
	}) // end resize
	
	
	$("a.search_icon").on("click",function(){
		let show = $("div#search_text_area").css("display");
		console.log(show);
		if(show == 'flex'){
			$("div#search_text_area").fadeOut();
		} else{
			$("div#search_text_area").fadeIn();
			$("div#search_text_area").css("display","flex");			
		}
	}) // end search
	
	
	
	
	
	
})

