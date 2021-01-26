let useremail;
let userid;

$(document).ready(function(){

    // 로딩창
    $(".loading").hide();

    // 비밀번호 찾기 누르면 모달창 활성화
	$("p#idpwsearch").on("click",function(){
        $("div.modal").fadeIn();
        $("div#findpw").css("display","flex");
        $("body").css("overflow-y","hidden");
        $("div#findpw").css("z-index","1001");
    })

    // 비회원 주문 조회 누르면 모달창 활성화
	$("input#findorder").on("click",function(){
        $("div.modal").fadeIn();
        $("div#findorder").css("display","flex");
        $("body").css("overflow-y","hidden");
        $("div#findorder").css("z-index","1001");
        
    })

    
    // 모달창 이외의 영역 누르면 모달 창 꺼지게
    $("div.modal").on("click",function(e){
        let result = $("div.modal").is(e.target);
        if(result){
            $("div.modal").fadeOut();
            $("div#findpw").css("display","none");
            $("div#findorder").css("display","none");
            $("body").css("overflow-y","scroll");
        }
        
    })

    // 모달창에서 회원 인증하기 버튼 눌렀을 때
    $("#findpwsubmit").on("click",function(){
        useremail = $("#useremail").val();
        userid = $("#userid").val();

        $.ajax({
            url : "/db/checkuser",
            type : "post",
            data : { useremail : useremail, userid : userid },
            success : function(result){
                if(result == 1){
                    alert("회원 인증 완료");
                    sendemail();
                } else {
                    alert("이메일이 잘못 되었거나 회원이 아님");
                }
            },
            error : function(){
                alert("인증 실패");
            } 
    	})
    })

    // 회원 인증 되었을 때 메일 보내는 함수
    function sendemail(){
        $.ajax({
                url : "/db/sendemail",
                type : "post",
                data : { receiveMail : useremail, userid : userid },

                success : function(){
	                alert(useremail+"로 임시 비밀번호 보냈습니다. ");
	                $("div.modal").fadeOut();
	                    $("body").css("overflow-y","scroll");
	                },

                error : function(request,status,error){
       				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					/*alert("메일 보내기 실패");*/
                },

                beforeSend: function(){
                    $(".loading").css("display","block");
                },

                complete:function(){
                    $(".loading").hide();
                }
        })
    }
    
    // 비회원 주문 조회 클릭 - 모달창에서
    $("#findOrderSubmit").on("click",function(){
        let orderno = $("input#orderno").val();
        let oname = $("input#ordername").val();
        let ocont = $("input#ordercont").val();

        $.ajax({
            url : "/db/product/orderdetailchk",
            type : "get",
            data : { orderno : orderno, oname : oname, ocont : ocont },
            success : function(result){
                $("div.modal").fadeOut();
                    $("body").css("overflow-y","scroll");
                    if(result){
                        alert("주문 조회 성공");
                        location.href = "/db/product/orderdetail?orderno="+orderno;
                    } else{
                        alert("입력한 항목을 다시 확인해주세요.");
                    } 
            },
            error : function(){
                alert("비회원 주문 조회 실패");
            }
            
    })
        
    })



})


