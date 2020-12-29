$(document).ready(function(){
	
	pricecal();
	
	/*제품 계산 함수*/
	function pricecal(){
	/*상품 별 금액에서 숫자만 추출*/
	
        let productprice = 0;

        // 배송비 정수 전환
		let shipprice = parseInt($("td#shipprice").text().replace(/[^0-9]/g,""));
		
		/* (상품 금액*갯 수) 정수 전환 해서 합계*/
		$("td#pricetd").each(function(){
			productprice += parseInt($(this).text().replace(/[^0-9]/g,""));
		})
        
		/*총 상품 금액 : 다시 통화 형식으로 출력*/
		$("td#productprice").html("₩ "+numberFormat(productprice));
		
		/*(토탈 금액 : 총 상품금액 + 배송비) 계산해서 통화형식으로 전환 출력*/
		let totalprice = productprice+shipprice;
		$("td#totalprice").html("₩ "+numberFormat(totalprice));
		
		$("input#totalpriceinput").val(totalprice);
		
		/*천 단위마다 콤마 찍는 함수*/
		function numberFormat(inputNumber) {
	 	  return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
	}
	
	
	/*카카오페이 */
	$("#orderbtn").on("click",function(e){
		e.preventDefault();
	
	  $(function(){
    	
        var IMP = window.IMP; // 생략가능
        IMP.init('imp57214985'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : 'Magazine B',
            amount : $("#totalpriceinput").val(),
            // buyer_email : $("totalpriceinput").val(),
            buyer_name : $("#oname").val(),
            buyer_tel : $("#ocont").val(),
            buyer_addr : $("#address").val()+$("#extraadd").val(),
            // buyer_postcode : '123-456',
            //m_redirect_url : 'http://www.naver.com'
        }, function(rsp) {
            if ( rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        alert(msg);
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 이동할 페이지
                $("#form_id").submit();
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 이동할 페이지
                location.href="/db/product/cart";
                alert(msg);
            }
        });
        
    });
	
	})
	
	
	
	
})


function checkform(){
	
	alert("확인");
	
	let name = $("input#oname").val();
	let postcode = $("input#post").val();
	let address = $("input#address").val();
	let extraadd = $("input#extraadd").val();
	let cont = $("input#ocont").val();
	
	
	if(name == "" || postcode == "" || address == "" || extraadd == "" || cont == ""){
		alert("모든 항목을 작성해주세요");
		return false;
		
	} else{
		return true;
		
	}
	
}

