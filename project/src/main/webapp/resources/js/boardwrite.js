$(document).ready(function(){
	
	let userid = $("input#writer").val();

	/*모달창 부르기(제품불러오기)*/
	$("#selectbtn").on("click",function(){
		/*주문리스트 불러오기*/
		$.getJSON("/db/board/orderlist", {userid : userid}, function(orderlist){
	
			let orderno ="";
			let str = "";	
				
			/*주문 목록 있을 때 */
			if(orderlist != ""){
				/*모달창 열기*/
				$("div.modal").fadeIn();
				$("body").css("overflow-y","hidden");
				
				$(orderlist).each(function(){
					if(orderno != this.orderno){
							str += "</div>"
					}					
					if(orderno != this.orderno){
					str += "<div class='orderno'><p>"+this.orderno+"</p>"+
							"<div class='clickbox "+this.reviewchk+"' data-reviewchk='"+this.reviewchk+"'>"+
							"<img style='width : 90px' src='../resources/image/product/"+this.pimgname+"' />"+
							"<p data-orderno='"+this.orderno+"' data-pno='"+this.pno+"' data-pname='"+this.pname+"' data-pimgname='"+this.pimgname+"'>"+this.pname+"</p></div>";
							orderno = this.orderno;							
					} else{
						str += "<div class='clickbox "+this.reviewchk+"' data-reviewchk='"+this.reviewchk+"'>"+
							"<img style='width : 90px' src='../resources/image/product/"+this.pimgname+"' />"+
							"<p data-orderno='"+this.orderno+"' data-pno='"+this.pno+"' data-pname='"+this.pname+"' data-pimgname='"+this.pimgname+"'>"+this.pname+"</p></div>";
					}						
				})
				
				/*모달 창 밖 영역 눌렀을 때 모달 창 닫기*/
				$("body").on("click",function(e){
					let result = $("div.modal").is(e.target);
					if(result){
						$("div.modal").fadeOut();
						$("body").css("overflow-y","scroll");
					}
				})
					
			} else{
				/*주문 목록 없을 때*/
				alert("주문목록이 없습니다.");
			}
			$("#userorderlist").html(str);
				
		}) // end json
		
	}) // end selectbtn event
	
	
	/*모달 창 제품 클릭 이벤트*/
	$("div#userorderlist").on("click",".clickbox",function(){
		
		let reviewchk = $(this).data("reviewchk");
		let pno = $(this).children("p").data("pno");
		let orderno = $(this).children("p").data("orderno");
		let pname = $(this).children("p").data("pname");
		let pimgname = $(this).children("p").data("pimgname");
		
		
		if(reviewchk){
			alert("이미 리뷰를 작성하였습니다.");
		} else{
			$("input#pnoinput").val(pno);
			$("input#review_orderno").val(orderno);
			$("p#pnameinput").html(pname);
			$("img#pimgname").attr("src","../resources/image/product/"+pimgname);
			
			/*모달창 끄기*/
			$("div.modal").fadeOut();
			$("body").css("overflow-y","scroll");
		
		}
		
		
	})

	/* 공지사항 제목 input 크기 자동 조절*/
	let inputlength = $("input#noticetitle").val().length;
	$("input#noticetitle").css("width",(inputlength+1)*20+"px");
	
	
	$("input#noticetitle").on("keyup",function(){
		inputlength = $("input#noticetitle").val().length;
		$("input#noticetitle").css("width",(inputlength+1)*20+"px");
		
	})



	/*첨부파일 관련*/
	let formObj = $("form[role='form']")
	
	$("input[type=submit]").on("click",function(e){
		e.preventDefault();
		let str ="";
		$("div#uploadfileList ul li").each(function(i,obj){
			let jobj = $(obj);
			console.log(jobj);
			str += "<input type='hidden' name='attachlist["+i+"].filename' value='"+jobj.data("filename")+"' />";
			str += "<input type='hidden' name='attachlist["+i+"].uuid' value='"+jobj.data("uuid")+"' />";
			str += "<input type='hidden' name='attachlist["+i+"].uploadpath' value='"+jobj.data("uploadpath")+"' />";
			str += "<input type='hidden' name='attachlist["+i+"].filetype' value='"+jobj.data("filetype")+"' />";
			
		})
		$("div#uploadfileinfo").append(str);
		formObj.submit();
	})
	
	let maxsize = 10485760; // 10MB
	let regex = new RegExp("(.*?\.(exp|sh|zip|alz)$)");
	
	/*파일 사이즈, 확장자 체크*/	
	function checkfile(fileSize,filename){
		if(fileSize>maxsize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(filename)){
			alert("업로드 할 수 없는 파일입니다.");
			return false;
		}
		return true;
	}
	
	/*첨부파일 올렸을 때*/
	$("input[type=file]").change(function(e){
		let formData = new FormData();
		let inputfile = $("input[name='file']")
		let files = inputfile[0].files;
		
		for (let i=0; i<files.length; i++){
			/*파일 사이즈,확장자 체크*/
			if(!checkfile(files[i].size, files[i].name)){
				return false;
			}
			/*컨트롤러에서 Multipartfile로 받는 이름과 같아야 한다*/
			formData.append("uploadfile",files[i]);
		}
		
		$.ajax({
			url : '/db/uploadfile',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			dataType : 'json',
			success:function(result){
				console.log(result);
				attachfilelist(result);
			}
		}) //end ajax
	}) // end 파일 첨부 했을 때
	
	
	/*첨부파일 리스트 보여지는 곳*/
	function attachfilelist(filelist){
		let str = "";
		
		$(filelist).each(function(i,obj){
			let fileCallPath = obj.uploadpath+"/"+obj.uuid+"_"+obj.filename;
			
			/*이미지 파일이 아니라면*/
			if(!obj.filetype){
				str += "<li data-filename='"+obj.filename+"' data-uuid='"+obj.uuid+"' data-uploadpath ='"+obj.uploadpath+"' data-filetype='"+obj.filetype+"'>"
					+ "<span class='far fa-file'></span><a href='/db/download?filename="+fileCallPath+"'>"+filelist[i].filename+"</a><span class='fas fa-times deleteicon' data-file='"+fileCallPath+"' data-type='notimage'></span></li>";		
			} else{
			//이미지 파일이라면
				let fileCallPaths = obj.uploadpath+"/s_"+obj.uuid+"_"+obj.filename;
				console.log(fileCallPath);
			 	str += "<li data-filename='"+obj.filename+"' data-uuid='"+obj.uuid+"' data-uploadpath ='"+obj.uploadpath+"' data-filetype='"+obj.filetype+"'>"
					+"<a href='/db/display?filename="+fileCallPath+"'><img src='/db/display?filename="+fileCallPaths+"'/></a><a href='/db/download?filename="+fileCallPath+"'>"+filelist[i].filename+"</a><span class='fas fa-times deleteicon' data-file='"+fileCallPaths+"' data-type='image'></span></li>";	
			}
		})		
		$("#uploadfileList ul").append(str);
	}
	
	/*첨부파일 삭제 버튼 이벤트*/
	$("div#uploadfileList").on("click","span.deleteicon",function(e){
		let filename =$(this).data("file");
		let filetype =$(this).data("type");
		
		let removeli = $(this).closest("li");
		
		$.ajax({
			url : "/db/deletefile",
			data : {filename : filename, filetype : filetype},
			dataType : "text",
			type : "POST",
			success:function(data){
				alert("삭제 되었습니다.");
				removeli.remove();
			}
		})
	})
	
	
	
}) // end document ready




	
	




