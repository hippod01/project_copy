let idcheck = false; // 아이디 유효성 검사 
let ididcheck = false; // 아이디 중복 체크
let pwcheck = false; // 비밀번호 유효성 검사
let repwcheck = false; // 비밀번호 재확인 유효성 검사
	
let idreg; // 아이디 정규식
let idval; // 아이디 입력한 값
	
let pwreg; // 비밀번호 정규식
let pwval;	// 비밀번호 입력한 값
let repwval; // 비밀번호 확인 입력한 값

let nameval;
let emailval;
let postval;
let addval;


$(document).ready(function(){
	
	
	/*아이디 유효성 검사*/
	$("input#userid").on("keyup",function(){
		
		idreg = /^[a-zA-Z0-9]{4,12}$/;
		idval = $("input#userid").val();
		
		if(idreg.test(idval)){
			idcheck = true;
				$.getJSON("/db/member/idcheck/"+idval,function(data){
					if(data == 1){
						ididcheck = false;
						$("#idmsg").html("<p class='checkno'>중복된 아이디 입니다.</p>");
					} else{
						ididcheck = true;
						$("#idmsg").html("<p class='checkok'>사용가능한 아이디 입니다.</p>");
					}
				}) // end 아이디 중복 확인
			
		} else{
			idcheck = false;
			$("#idmsg").html("<p class='checkno'>아이디는 영대문자,영소문자,숫자를 포함한 4-12자리로 이루어져야 합니다.</p>");
		}
	}) // end 아이디 유효성 검사
	
	
	/*비밀번호 유효성 검사 (대문자, 소문자, 숫자, 특수문자 모두 포함하여 총 길이는 8자 이상)*/
	$("input#userpw").on("keyup",function(){
		pwreg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*]).{8,}$/;
		pwval = $("input#userpw").val()
		
		if(pwreg.test(pwval)){
			pwcheck = true;
			$("#pwmsg").html("<p class='checkok'> 사용할 수 있는 비밀번호 입니다.</p>");
				/*비밀번호 재확인 = 비밀번호 검사*/
				$("input#checkpw").on("keyup",function(){
					repwval = $("input#checkpw").val();
					
					if(pwval != repwval){
						repwcheck = false;
						//$("font[name=check]").text("");
						$("#repwmsg").html("<p class='checkno'>비밀번호가 일치 하지 않습니다.</p>");
					} else{
						repwcheck = true;
						//$("font[name=check]").text("");
						$("#repwmsg").html("<p class='checkok'>비밀번호가 일치 합니다.</p>");
					}
					
				}) 
		}else{
			pwcheck = false;
			$("#pwmsg").html("<p class='checkno'> 비밀번호는 최소 한 자의 영소문자+영대문자+특수문자+숫자가 포함 8자 이상이어야 합니다.</p>");
			$("#repwmsg").html("");
		}
			
	}) // end 비밀번호 유효성 검사
	

}) // end document.ready

function checkmem(){
	
	nameval = $("input#username").val();
	emailval = $("input#useremail").val();
	postval = $("input#postcode").val();
	addval = $("input#address").val();
	
	
	if(idval == "" || pwval == "" || repwval == "" || nameval == "" || emailval == "" || postval == "" || addval == ""){
		alert("모든 항목을 작성해주세요");
		return false;

	} else{
		
		if(idcheck && pwcheck && ididcheck && repwcheck){
			alert("회원가입 완료!");
			return true;
		}else{
			alert("아이디와 비밀번호를 다시 확인해주세요");
			return false;
		}
	}
	
} // end checkmem


