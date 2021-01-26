$(document).ready(function(){

    let form = $("form");
    
    /* 기존 첨부파일 불러오기(X버튼 있음) */
	let bno = $("#bno").val();
	let originstr="";
	
	$.getJSON("/db/notice/filelist",{bno:bno},function(attach){
		console.log(attach);
		
		$(attach).each(function(i,attach){
			let fileCallPath = attach.uploadpath+"/"+attach.uuid+"_"+attach.filename;
			
			//이미지 파일일 때
			if(attach.filetype){
				originstr += "<li data-filename='"+attach.filename+"' data-uuid='"+attach.uuid+"' data-uploadpath ='"+attach.uploadpath+"' data-filetype='"+attach.filetype+"'>"
				+ "<a href='"+fileCallPath+"' target='_blank'><img src='"+fileCallPath+"'/></a> "
				+ "<a href='/db/awsFileDownload?filename="+attach.filename+"&fileuuid="+attach.uuid+"'>"+attach.filename+"</a><span class='fas fa-times deleteicon' data-file='"+attach.filename+"' data-type='image' data-uuid='"+attach.uuid+"'> </span></li>"
			//이미지 파일 아닐 때		
			} else{
				originstr += "<li data-filename='"+attach.filename+"' data-uuid='"+attach.uuid+"' data-uploadpath ='"+attach.uploadpath+"' data-filetype='"+attach.filetype+"'>"+
				"<span class='far fa-file'/><a id='filename' href='/db/awsFileDownload?filename="+attach.filename+"&fileuuid="+attach.uuid+"'>"+attach.filename+"</a><span class='fas fa-times deleteicon' data-file='"+attach.filename+"' data-type='notimage' data-uuid='"+attach.uuid+"'></span></li>"
			}
		})
		$("#uploadfileList ul").html(originstr);
		
		
	})  // end
	
    
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
			formData.append("boardFile",files[i]);
		}
		
		/*aws 파일 업로드*/
		$.ajax({
			url : '/db/upload',
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
		
		
	})

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
    }  

	/* 새로운 첨부파일 리스트 보여지는 곳*/
    let newstr = "";
	function attachfilelist(filelist){
        
		let addstr = "";
		$(filelist).each(function(i,obj){
			let fileCallPath = obj.uploadpath+"/"+obj.uuid+"_"+obj.filename;
			
			/*이미지 파일이 아니라면*/
			if(!obj.filetype){
				addstr += "<li data-filename='"+obj.filename+"' data-uuid='"+obj.uuid+"' data-uploadpath ='"+obj.uploadpath+"' data-filetype='"+obj.filetype+"'>"
					+ "<span class='far fa-file'></span><a href='/db/awsFileDownload?filename="+obj.filename+"&fileuuid="+obj.uuid+"'>"+filelist[i].filename+"</a><span class='fas fa-times deleteicon' data-file='"+obj.filename+"' data-type='notimage' data-uuid='"+obj.uuid+"'></span></li>";		
			} else{
			//이미지 파일이라면
			 	addstr += "<li data-filename='"+obj.filename+"' data-uuid='"+obj.uuid+"' data-uploadpath ='"+obj.uploadpath+"' data-filetype='"+obj.filetype+"'>"
					+"<a href='"+fileCallPath+"' target='_blank'><img src='"+fileCallPath+"'/></a> "
					+"<a href='/db/awsFileDownload?filename="+obj.filename+"&fileuuid="+obj.uuid+"'>"+filelist[i].filename+"</a><span class='fas fa-times deleteicon' data-file='"+obj.filename+"' data-type='image' data-uuid='"+obj.uuid+"'></span></li>";	
			}
		})
		newstr += addstr;		
		$("#uploadfileList ul").append(addstr);
	} 
    
    
    
    /* 첨부파일 삭제 버튼 이벤트 : 삭제 파일 정보 배열에 저장*/
	
	let filenames = [];
	let filetypes = [];
	let fileuuids = [];
	
	$("div#uploadfileList").on("click","span.deleteicon",function(e){
		let filename =$(this).data("file");
		let filetype =$(this).data("type");
		let fileuuid =$(this).data("uuid");
		
		filenames.push(filename);
		filetypes.push(filetype);
		fileuuids.push(fileuuid);
		
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
		$("div#newfileinfo").append(str);
		
		/* x 아이콘 누른 파일 업로드 위치 파일 삭제 처리*/
		/* 데이터 베이스의 파일도 같이 삭제 처리한다*/
		let deleteFilelist = "";
		for(var i=0; i<filenames.length; i++){
		
			//데이터 베이스 삭제
			deleteFilelist += "<input type='hidden' name='deletelist["+i+"].uuid' value='"+fileuuids[i]+"' />";
		
			//aws에서 파일 삭제
			$.ajax({
				url : "/db/awsFileDelete",
				data : {filename : filenames[i], filetype : filetypes[i], fileuuid : fileuuids[i]},
				dataType : "text",
				type : "POST",
				success:function(data){
	
				}
			
			})
		}
		$("div#deletefileinfo").append(deleteFilelist);
		form.submit();
	})


})