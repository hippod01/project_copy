$(document).ready(function(){

    let form = $("form");
    /* 기존 첨부파일 불러오기(X버튼 있음) */
	let bno = $("#bno").val();
	let originstr="";
	
	$.getJSON("/db/notice/filelist",{bno:bno},function(attach){
		console.log(attach);
		
		$(attach).each(function(i,attach){
			let fileCallPath = attach.uploadpath+"/"+attach.uuid+"_"+attach.filename;
			console.log(fileCallPath);
			//이미지 파일일 때
			if(attach.filetype){
				let fileCallPaths = attach.uploadpath+"/s_"+attach.uuid+"_"+attach.filename;
				originstr += "<li data-filename='"+attach.filename+"' data-uuid='"+attach.uuid+"' data-uploadpath ='"+attach.uploadpath+"' data-filetype='"+attach.filetype+"'><a href='/db/display?filename="+fileCallPath+"'><img src='/db/display?filename="+fileCallPaths+"'/></a> "+
				"<a href='/db/download?filename="+fileCallPath+"'>"+attach.filename+"</a><span class='fas fa-times deleteicon' data-file='"+fileCallPaths+"' data-type='image' data-uuid='"+attach.uuid+"'> </span></li>"
			//이미지 파일 아닐 때		
			} else{
				originstr += "<li data-filename='"+attach.filename+"' data-uuid='"+attach.uuid+"' data-uploadpath ='"+attach.uploadpath+"' data-filetype='"+attach.filetype+"'>"+
				"<span class='far fa-file'/><a id='filename' href='/db/download?filename="+fileCallPath+"'>"+attach.filename+"</a><span class='fas fa-times deleteicon' data-file='"+fileCallPath+"' data-type='image' data-uuid='"+attach.uuid+"'></span></li>"
			}
		})
		$("#uploadfileList ul").html(originstr);
		
		
	})  // end getjson
    
    /*새로운 첨부파일 올렸을 때*/
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
		
		/*업로드 경로에 이미지 파일 생성*/
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
		
		
	}) // end 새로운 파일 첨부 했을 때

    /*파일 사이즈, 확장자 체크*/	
    let maxsize = 10485760; // 10MB
    let regex = new RegExp("(.*?\.(exp|sh|zip|alz)$)");

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
    } // end 파일 사이즈, 확장자 체크 

    let newstr = "";
	/* 새로운 첨부파일 리스트 보여지는 곳*/
	function attachfilelist(filelist){
        
		let addstr = "";
		$(filelist).each(function(i,obj){
			let fileCallPath = obj.uploadpath+"/"+obj.uuid+"_"+obj.filename;
			
			/*이미지 파일이 아니라면*/
			if(!obj.filetype){
				addstr += "<li data-filename='"+obj.filename+"' data-uuid='"+obj.uuid+"' data-uploadpath ='"+obj.uploadpath+"' data-filetype='"+obj.filetype+"'>"
					+ "<span class='far fa-file'></span><a href='/db/download?filename="+fileCallPath+"'>"+filelist[i].filename+"</a><span class='fas fa-times deleteicon' data-file='"+fileCallPath+"' data-type='notimage'></span></li>";		
			} else{
			//이미지 파일이라면
				let fileCallPaths = obj.uploadpath+"/s_"+obj.uuid+"_"+obj.filename;
				console.log(fileCallPath);
			 	addstr += "<li data-filename='"+obj.filename+"' data-uuid='"+obj.uuid+"' data-uploadpath ='"+obj.uploadpath+"' data-filetype='"+obj.filetype+"'>"
					+"<img src='/db/display?filename="+fileCallPaths+"'/><a href='/db/download?filename="+fileCallPath+"'>"+filelist[i].filename+"</a><span class='fas fa-times deleteicon' data-file='"+fileCallPaths+"' data-type='image'></span></li>";	
			}
		})
		newstr += addstr;		
		$("#uploadfileList ul").append(addstr);
	} // 새로운 첨부파일 리스트 보여지는 곳
    
    /* 첨부파일 삭제 버튼 이벤트 */
	
	let filename ="";
	let filetype ="";
	let fileuuid ="";
	
	$("div#uploadfileList").on("click","span.deleteicon",function(e){
		filename =$(this).data("file");
		filetype =$(this).data("type");
		fileuuid =$(this).data("uuid");
		
		let removeli = $(this).closest("li");
		
		/*li 목록 삭제*/
		removeli.remove();
		
		
    })	
    
    /*수정하기 버튼 눌렀을 때 처리 */
	$("input#modify").on("click",function(e){
		e.preventDefault();
		
		let str="";
		
        /*새로운 첨부 파일 input 창 만들어줌 */
        
		$(newstr).each(function(i,obj){
			let jobj = $(obj);
			console.log(jobj);
			
			str += "<input type='hidden' name='attachlist["+i+"].filename' value='"+jobj.data("filename")+"' />";
			str += "<input type='hidden' name='attachlist["+i+"].uuid' value='"+jobj.data("uuid")+"' />";
			str += "<input type='hidden' name='attachlist["+i+"].uploadpath' value='"+jobj.data("uploadpath")+"' />";
			str += "<input type='hidden' name='attachlist["+i+"].filetype' value='"+jobj.data("filetype")+"' />";
			
		})
		$("div#uploadfileinfo").html(str);
		
		/* x 아이콘 누른 파일 업로드 위치 파일 삭제 처리*/
		/* 데이터 베이스의 파일도 같이 삭제 처리한다*/
		$.ajax({
			url : "/db/deletefile",
			data : {filename : filename, filetype : filetype, fileuuid : fileuuid},
			dataType : "text",
			type : "POST",
			success:function(data){

			}
			
		})
		
		form.submit();
	})


})