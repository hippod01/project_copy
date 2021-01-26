
$(document).ready(function(){
	
	
	
    //쪽지 보기 버튼 눌렀을 때
	$("p#msgViewLink").on("click",function(){
        $("div.modal").fadeIn();
        $("div#viewMsg").css("display","flex");
        $("body").css("overflow-y","hidden");
        $("div#viewMsg").css("z-index","1001");
		
		/*안읽은 메세지 읽음 처리*/
		 $("div#msglist").each(function(index, item){
			let msgchk = $(this).data("msgchk");
			
			if(msgchk == 'NO'){
				let message_no = $(this).data("msgno");
				$.ajax({
		            url : "/db/member/updatemsg",
		            type : "post",
		            data : { message_no : message_no },
		            success : function(result){
						sendMessage();
		            },
		            error : function(){
		                console.log("error");
		            } 
		    	}) // end ajax
			} // end if	
			
		}); // end div#msglist

    }) //end msgviewlink

    
    // 모달창 이외의 영역 누르면 모달 창 꺼지게
    $("div.modal").on("click",function(e){
        let result = $("div.modal").is(e.target);
        if(result){
            $("div.modal").fadeOut();
            $("div#viewMsg").css("display","none");
            $("body").css("overflow-y","scroll");
        }
        
    })


	//adminpage js
	
	//쪽지 보내기 모달창
	$("span.fa-envelope").on("click",function(){
        $("div.modal").fadeIn();
        $("div#viewMsg").css("display","flex");
        $("body").css("overflow-y","hidden");
        $("div#viewMsg").css("z-index","1001");

		let receive_id = $(this).parent("td").text();
		$("input#receive_id").val(receive_id);
		
	})
	
	/* 쪽지 보내기 */
	$("input#msgSend").on("click",function(){
		msgsend();
	})
	
	function msgsend(){
		let receive_id = $("input#receive_id").val();
		let content = $("#msgCnt").val();
		 $.ajax({
            url : "/db/member/msgsend",
            type : "post",
            data : { content : content, receive_id : receive_id, },
            success : function(){
                alert("보내기 완료");
				$("div.modal").fadeOut();
                $("body").css("overflow-y","scroll");
				sendMessage();

            },
            error : function(){
                console.log("error");
            } 
    	})
	}


})

	


