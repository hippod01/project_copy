let pwcheck = true; // 비밀번호 유효성 검사
let repwcheck = true; // 비밀번호 재확인 유효성 검사
	
let pwreg; // 비밀번호 정규식
let pwval;	// 비밀번호 입력한 값
let repwval; // 비밀번호 확인 입력한 값

$(document).ready(function(){
	
	
	/*탈퇴 처리*/
	$("input#delete").on("click",function(e){
		let result = confirm("탈퇴하시겠습니까?");
		if(result){
			$("form").attr("action","deletemem")
			$("form").attr("method","post")
			$("form").submit();
			alert("탈퇴되었습니다.");
		}
		
	}) // end 탈퇴
	
	
	
	/*비밀번호 유효성 검사 (대문자, 소문자, 숫자, 특수문자 모두 포함하여 총 길이는 8자 이상)*/
	$("input#userpw").on("keyup",function(){
		pwreg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*]).{8,}$/;
		pwval = $("input#userpw").val();
		
		if(pwreg.test(pwval)){
			$("#pwmsg").html("<p class='checkok'> 사용할 수 있는 비밀번호 입니다.</p>");
				pwcheck = true;
				/*비밀번호 재확인 = 비밀번호 검사*/
				$("input#checkpw").on("keyup",function(){
					repwval = $("input#checkpw").val();
					
					if(pwval != repwval){
						$("#repwmsg").html("<p class='checkno'>비밀번호가 일치 하지 않습니다.</p>");
						repwcheck = false;
					} else{
						$("#repwmsg").html("<p class='checkok'>비밀번호가 일치 합니다.</p>");
						repwcheck = true;
					}
					
				}) 
		}else{
			$("#pwmsg").html("<p class='checkno'> 비밀번호는 최소 한 자의 영소문자+영대문자+특수문자+숫자가 포함 8자 이상이어야 합니다.</p>");
			$("#repwmsg").html("");
			pwcheck = false;
		}
			
	}) // end 비밀번호 유효성 검사
	
	
})	//end document.ready


function checkmem(){
	
	let curpwd = $("input#curpwd").val();
	pwval = $("input#userpw").val();
	
	
	if(curpwd != ""){
		
		if(pwval ==""){
			alert("새로운 비밀번호를 입력해주세요.");
			return false;
		}
		
		if(pwcheck && repwcheck){
			return true;
			
		}else{
			alert("새로운 비밀번호를 다시 확인해주세요");
			return false;
		}
	
	} 
	
	
	
} // end checkmem

