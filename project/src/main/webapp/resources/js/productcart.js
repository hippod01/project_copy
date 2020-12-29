$(document).ready(function(){
	
	pricecal();
	
	/*제품 계산 함수*/
	function pricecal(){
	/*상품 별 금액에서 숫자만 추출*/
	
		let productprice = 0;
		let shipprice = parseInt($("td#shipprice").text().replace(/[^0-9]/g,""));
		
		/*상품 금액 정수 전환*/
		$("td#pricetd").each(function(){
			productprice += parseInt($(this).text().replace(/[^0-9]/g,""));	
		})
		
		/*상품 금액 : 다시 통화 형식으로 전환*/
		$("td#productprice").html("₩ "+numberFormat(productprice));
		
		/*토탈 금액 계산해서 통화형식으로 전환 */
		let totalprice = productprice+shipprice;
		$("td#totalprice").html("₩ "+numberFormat(totalprice));
		
		/*천 단위마다 콤마 찍는 함수*/
		function numberFormat(inputNumber) {
	 	  return inputNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
	}
	
	/* 장바구니 갯수 버튼 이벤트 */
		//왼쪽 버튼
	$("span.btnleft").on("click",function(){
		
		let cartno = $(this).data("cartno");
		
		let cnt = parseInt($("span.cntnum"+cartno).html());
		console.log(cnt);
		console.log(cartno);
		if (cnt == "1"){
			return;
		} else{
			
			cnt -= 1;
			$("span.cntnum"+cartno).html(cnt);
			
			/*갯수 데이터 베이스 업데이트*/
			$.ajax({
			url : "/db/product/updatecart",
			type : "post",
			data : { cartno : cartno, cartstock : cnt },
			success : function(result){
				if(result ==1){
					location.href ="/db/product/cart"
				} else{
					alert("로그인이 필요합니다");
				}
			},
			error : function(result){
				alert("업데이트 실패");
			}
			
			}) // end ajax
			
		}  // end else
		
	}) // end 왼쪽 버튼
	
		//오른쪽 버튼
	$("span.btnright").on("click",function(){
		let cartno = $(this).data("cartno");
		let cnt = parseInt($("span.cntnum"+cartno).html());
		
		if (cnt != "5"){
			cnt += 1;
			$("span.cntnum"+cartno).html(cnt);
			
			/*갯수 데이터 베이스 업데이트*/
			$.ajax({
			url : "/db/product/updatecart",
			type : "post",
			data : { cartno : cartno, cartstock : cnt },
			success : function(result){
				if(result ==1){
					location.href ="/db/product/cart"
				} else{
					alert("로그인이 필요합니다");
				}
			},
			error : function(result){
				alert("업데이트 실패");
			}
			
			}) // end ajax
			
			
		} else{
			alert("최대 구매 가능 수량은 5개 입니다.");
			return;
		}
	}) // end 상품 갯수 선택 버튼 이벤트
	
	
	
	/*상품 삭제 이벤트 */
	$("span.cartdelete").on("click",function(){
		
		let deletecartno = $(this).data("cartno");
		console.log(deletecartno);
		
		$.ajax({
			url : "/db/product/deletecart",
			type : "post",
			data : { cartno : deletecartno },
			success : function(result){
				if(result == 1){
					location.href ="/db/product/cart"
				
				}
			},
			error : function(){
				
			}
		})
		/*$(this).parent().parent().parent().remove();
				pricecal();*/
		
	})
	
})

