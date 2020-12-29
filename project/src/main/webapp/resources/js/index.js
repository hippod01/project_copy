$(document).ready(function(){
	
	// 공지사항
	let noticesize = $("div#div_notice li").height();
	let top = 0;
	let noticemax = noticesize*5;

	autoslide();

	function autoslide() {
		setInterval(function() {
			start();
		}, 3000);
	}

	function start() {
		top -= 100;

		if(top > -500){
			$("div#div_notice li").css("top", top);
		}else{
			top = 0;
			$("div#div_notice li").css("top", top);
		}
	}


	// 메인이미지 슬라이드
	let divsize = $("div#mainimg").width();
	let right = 0;
	let max = divsize*3;
	
	$(window).resize(function(){
		divsize = $("div#mainimg").width();
		max = divsize*3;
		right = 0;
		$("div#mainimg li").css("right",right);
	})
	console.log(max);
	
	$("div.rightbtn").on("click",function(){
		
		if(right >= max-divsize){
			right = 0;
			$("div#mainimg li").css("right",right);
		} else{
			right+=divsize;
			$("div#mainimg li").css("right",right);
		}
	})
	
	$("div.leftbtn").on("click",function(){
		
		if(right == '0'){
			right = max-divsize;
			console.log("right :"+right);
			$("div#mainimg li").css("right",right);
		} else{
			right -= divsize;
			$("div#mainimg li").css("right",right);
			console.log("right :"+right);
		}
	})
	
	
	
})