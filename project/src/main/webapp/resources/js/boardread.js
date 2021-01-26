$(document).ready(function(){

	/*modify/read, modify : btn click 관련 */
	let form = $("form");
		
	$("input#modifyget").on("click",function(){
		form.attr("action","modify");
		form.attr("method","get");
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

	/*댓글 내용 불러오기*/
	let str ="";
	let bno = $("input#bno").val();
	let auth = $("input#auth").val();
	
	
	/*댓글 리스트 불러오기 */
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
			$("div#replylistarea").prepend(str);
	})
	
	
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
						location.reload();
					},
					error : function(){
						
					} 
			})
	}) // end 댓글 작성
	
	
	/* 댓글 삭제*/
	$("div#replylistarea").on("click","input.deletebtn",function(){
			bno = $(this).data("bno");
			let rno = $(this).data("rno");
			console.log("rno : "+rno);
			
			let result = confirm("댓글을 삭제하시겠습니까?");
			if(result){
				$.ajax({
					url : "/db/reply/delete",
					type : "post",
					data : { rno : rno },
					success : function(){
						alert("삭제되었습니다.");
						location.reload();
					},
					error : function(){
						
					} 
				})
			}
			
	}) // end 댓글 삭제*/
	
	
	/*댓글 수정 버튼 눌렀을 때 */
	$("div#replylistarea").on("click","input.modifybtn",function(){
		
		bno = $(this).data("bno");
		rno = $(this).data("rno");
		replytext = $(this).parent().prev().text();
		
		$("#replytext"+bno).val(replytext);
		$("#replybutton"+bno).attr("type","hidden");
		$("#updatebutton"+bno).attr("type","button");
		
		/*수정처리*/
		$("#updatebutton"+bno).on("click",function(){

			replytext = $("#replytext"+bno).val();
			console.log("수정 후 내용 :"+replytext);
			
			$.ajax({
					url : "/db/reply/update",
					type : "post",
					data : { rno : rno, replytext : replytext},
					success : function(){
						alert("수정되었습니다.");
						location.reload();
					},
					error : function(){
						
					} 
			}) // end ajax
		}) //end click event
	})
	
	//첨부파일 리스트 불러오기 (X버튼 없음)
	$.getJSON("/db/notice/filelist",{bno:bno},function(attach){
		
		let str="";
		
		$(attach).each(function(i,attach){
			let fileCallPath = attach.uploadpath+"/"+attach.uuid+"_"+attach.filename;
			if(attach.filetype){
				str+= "<li><a href='"+fileCallPath+"' target='_blank'><img src='"+fileCallPath+"'/></a> "+
					"<a href='/db/awsFileDownload?filename="+attach.filename+"&fileuuid="+attach.uuid+"'>"+attach.filename+"</a></li>"	
			} else{
				str+= "<li><span class='far fa-file'/>"
					+"<a href='/db/awsFileDownload?filename="+attach.filename+"&fileuuid="+attach.uuid+"'>"+attach.filename+"</a></li>"
				
			}
		})
		$("#uploadfileList ul").html(str);
		
	})	

}) // end document.ready