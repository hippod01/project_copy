
$(document).ready(function(){
	/*modify/read, modify : btn click 관련 */
	let form = $("form");
		
	$("input#modifyget").on("click",function(){
		form.attr("action","modify");
		form.attr("method","get");
		form.submit();
	})

	$("input#modify").on("click",function(){
		
		form.attr("action","modify");
		form.attr("method","post");
		form.submit();
	})
	
	$("input#delete").on("click",function(){
		let result =  confirm("정말 삭제하시겠습니까?");
			if(result){
			form.attr("action","delete");
			form.attr("method","post");
			form.submit();
		}
	})
	
	$("input#list").on("click",function(){
		form.attr("action","/db/board");
		form.attr("method","get");
		form.submit();
	})

	/* 제목 input 크기 자동 조절*/
	let inputlength = $("input#noticetitle").val().length;
	$("input#noticetitle").css("width",(inputlength+1)*20+"px");
	
	
	$("input#noticetitle").on("keyup",function(){
		inputlength = $("input#noticetitle").val().length;
		$("input#noticetitle").css("width",(inputlength+1)*20+"px");
		
	})


}) // end document.ready