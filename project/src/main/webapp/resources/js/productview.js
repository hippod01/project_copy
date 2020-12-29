let bno;
let auth;
let rno;
let replytext;
let html;

$(document).ready(function(){
	
	let loginpuserid = $("#loginuserid").val();
	let pno = $("#pno").val();
	html = $("div.replayarea").html();
	
	auth = $("#auth").val();
	console.log("ADMIN : "+auth);
	
	getAlllist();
	
	/*리뷰&문의 게시판 번호 메기기*/
	function getAlllist(){
		
		/*review 전체 리스트*/
		$.getJSON("/db/review/all/"+pno, function(reviewlist){
			
			/*게시물 번호*/
			let cnt = Object.keys(reviewlist).length;
			
			if(reviewlist != ""){
				$(reviewlist).each(function(){		
					$("td#tdbno"+this.bno).html(cnt);
					cnt -= 1;
				})
			} 
			
			
		}) //end 리뷰
		
		/*문의 게시판 리스트*/
		$.getJSON("/db/qaboard/all/"+pno, function(qalist){
			/*console.log(qalist);*/
			let cnt = Object.keys(qalist).length;
			
			if(qalist != ""){
				//console.log("내용 있음");
				$(qalist).each(function(){
					$("td#tdbno"+this.bno).html(cnt);
					cnt -= 1;
					
				})
			} 
			
		}) //end 문의
		
	} // end alllist
	
	

	/*게시판 내용 열고 닫기 - 댓글 내용 불러오기 */
	$("div.boardarea").on("click","span#title",function(){
		bno = $(this).parent().prev().data("bno");
		
		let obj = $(this);		
		let display = obj.parent().parent().next("tr.contenttr").css("display");
		
		/*창 열 때 */
		if(display == "none"){
			obj.parent().parent().next("tr.contenttr").css("display","table-row");
			
			/*댓글 내용 불러오기 함수*/
			getreplylist();
		
		/* 내용창 닫을 때 */	
		} else {
			obj.parent().parent().next("tr.contenttr").css("display","none");
		}
		
	}) // end 리뷰 게시판 열고 닫기
	
	
	/*댓글 작성하기*/
	$("input.writesubmitbtn").on("click",function(){
			
			bno = $(this).data("bno");
			let replytext = $("#replytext"+bno).val();
			let replyer = $("#replyer"+bno).val();
		
			$.ajax({
					url : "/db/reply/write",
					type : "post",
					data : { bno : bno, replytext : replytext, replyer : replyer },
					success : function(){
						alert("등록되었습니다.");
						getreplylist();
					},
					error : function(){
						
					} 
			})
	}) // end 댓글 작성
		

	
	/* 댓글 삭제*/
	$("td#contenttd").on("click","input.deletebtn",function(){
			bno = $(this).data("bno");
			let rno = $(this).data("rno");
			let result = confirm("댓글을 삭제하시겠습니까?");
			if(result){
				$.ajax({
					url : "/db/reply/delete",
					type : "post",
					data : { rno : rno },
					success : function(){
						alert("삭제되었습니다.");
						getreplylist();
					},
					error : function(){
						
					} 
				})
			}
			
	}) // end 댓글 삭제*/
	
	
	/*댓글 수정 버튼 눌렀을 때 */
	$("td#contenttd").on("click","input.modifybtn",function(){
		
		bno = $(this).data("bno");
		rno = $(this).data("rno");
		replytext = $(this).parent().prev().text();
				
		$("#replytext"+bno).val(replytext);
		$("#replybutton"+bno).attr("type","hidden");
		$("#updatebutton"+bno).attr("type","button");
		
		/*수정버튼 눌렀을 때 */
		$("#updatebutton"+bno).on("click",function(){
			replytext = $("#replytext"+bno).val();
			
			$.ajax({
					url : "/db/reply/update",
					type : "post",
					data : { rno : rno, replytext : replytext},
					success : function(){
						alert("수정되었습니다.");
						getreplylist();
						
						$("#replytext"+bno).val("");
						$("#replybutton"+bno).attr("type","button");
						$("#updatebutton"+bno).attr("type","hidden");

					},
					error : function(){
						
					} 
			})
		})
	})
	
	
	
	
	/*shipping info 열고 닫기*/
	$("p#shipinfo_p").on("click",function(){
			
		let obj = $(this);
		let result = obj.next("div#div_shipinfo").css("display");
		if( result == "none"){
			obj.next("div#div_shipinfo").css("display","block");
		} else{
			obj.next("div#div_shipinfo").css("display","none");
		}
				
	}) // end
	
	
	
	/* 장바구니 갯수 버튼 이벤트 */
	let cnt = parseInt($("span.cntnum").html());
		//왼쪽 버튼
	$("span.btnleft").on("click",function(){
		
		if (cnt == "1"){
			return;
		} else{
			cnt -= 1;
			$("span.cntnum").html(cnt);
		}
		
	})
	
	//오른쪽 버튼
	$("span.btnright").on("click",function(){
		
		if (cnt != "5"){
			cnt += 1;
			$("span.cntnum").html(cnt);
			
		} else{
			alert("최대 구매 가능 수량은 5개 입니다.");
			return;
		}
	}) // end 상품 갯수 선택 버튼 이벤트
	
	
	/*장바구니 담기 처리*/
	$("p#p_cart").on("click",function(){

		$.ajax({
			url : "/db/product/addcart",
			type : "post",
			data : { pno : pno, cartstock : cnt },
			success : function(result){
				if(result == 1){
					$(".modal").fadeIn().delay(3000).fadeOut();				
				} else if(result == 2){
					alert("이미 카트에 있는 제품입니다.");
				} 
			},
			error : function(){
				alert("카트 담기 실패");
			},
			
		})
		
	})
	
	
	/*submit 버튼*/
	
	/*수정 처리*/
	$("input#adminmodify").on("click",function(e){
		$("form").attr("action","/db/product/modify")
		$("form").attr("method","get")
		$("form").submit();
	
		
		
	}) // end 수정
	
	/*삭제 처리*/
	$("input#admindelete").on("click",function(e){
		let result = confirm("삭제하시겠습니까?");
		if(result){
			$("form").attr("action","/db/product/delete")
			$("form").attr("method","post")
			$("form").submit();
			alert("삭제되었습니다.");
		}
		
	}) // end 삭제
	
	
	
	
}) // end document ready





/*댓글 내용 불러오기*/
function getreplylist(){
		let str ="";
		$.getJSON("/db/reply/all/"+bno, function(replylist){
				$(replylist).each(function(){
					/*댓글 내용 있을 때*/
					if(replylist !=""){
						str += "<div id='reply"+this.bno+"' class='replylist' ><p class='replyer'>"+this.replyer+" | "+this.regdate+"</p>"+
								"<p class='replytext'><span>"+this.replytext+"</span>";
							if(auth){
								str += "<span><input type='button' data-bno='"+this.bno+"' data-rno='"+this.rno+"' id='modify"+bno+"' class='modifybtn' value='수정' />"+
										"<input type='button' data-bno='"+this.bno+"' data-rno='"+this.rno+"' id='delete"+bno+"' class='deletebtn' value='삭제' /></span></p></div>";		
							} else{
								str += "</p></div>";
							}
					/*댓글 내용 없을 때 */
					} else{
						str = "";
					}
				})
				$("div#replylist"+bno).html(str);
			})
		
} // end getreplylist


		
	