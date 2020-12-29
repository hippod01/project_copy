
$(document).ready(function(){
	
	let btype= $("input#btype").val();
	console.log(btype);
	
	$("table.boardlist").each(function(){
		let bno = $(this).data("bno");
		
		$.getJSON("/db/reply/count",{bno : bno}, function(result){
			
			if(result > 0){
				
				$("td#title"+bno).append("<span style='color : rgb(78,78,78)'> ["+result+"] </span> ");
				
				if(btype == 'qanda'){
					$("td#title"+bno).prepend("<p style='color : green; display : block; text-align :left;' class='far fa-check-circle'> 답변완료 </p> ");
				}
			} else if(result == 0){
				if(btype == 'qanda'){
					$("td#title"+bno).prepend("<p style='color : gray; display : block; text-align :left;' class='far fa-circle'> 답변대기 </p>");
					
				}
			}
		
		}) // end json
		//
		
	}) // end 댓글 수


	
}) // end document ready