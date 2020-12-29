<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/store.css" />
</head>

<body>
<!-- header -->
<jsp:include page="header.jsp"></jsp:include>


<section style="min-height: 50vh;">

	<div id="store_wrap">
		<h3 id="title">STORE LOCATION</h3>
		
		<div id="grid_wrap">
		
		<c:forEach items="${storelist}" var="slist">
		<div id="store_grid">
		
			
			<div id="map${slist.store_no}" class="map" style="width :300px; height: 300px;">
				<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=67816ff3913743b54df18d1428f861b4&libraries=services"></script>
					
								<script>
								var mapContainer${slist.store_no} = document.getElementById('map${slist.store_no}'), // 지도를 표시할 div 
								    mapOption = {
								        //center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
								        center: new kakao.maps.LatLng(0, 0), // 지도의 중심좌표
								        level: 3 // 지도의 확대 레벨
								    };  
								
								// 지도를 생성합니다    
								var map${slist.store_no} = new kakao.maps.Map(mapContainer${slist.store_no}, mapOption); 
								
								// 주소-좌표 변환 객체를 생성합니다
								var geocoder = new kakao.maps.services.Geocoder();
								
								// 주소로 좌표를 검색합니다
								geocoder.addressSearch('${slist.store_add}', function(result, status) {
								
								    // 정상적으로 검색이 완료됐으면 
								     if (status === kakao.maps.services.Status.OK) {
								
								    	 //마커를 표시할 위치 
								        var coords${slist.store_no} = new kakao.maps.LatLng(result[0].y, result[0].x);
								
								         // 결과값으로 받은 위치를 마커로 표시합니다
								        var marker = new kakao.maps.Marker({
								            map${slist.store_no}: map${slist.store_no}, // 마커를 표시할 지도
								            position: coords${slist.store_no} // 마커를 표시할 위치
								        }); 
								
								        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								        map${slist.store_no}.setCenter(coords${slist.store_no});
								        
								    } 
								});    
				</script>
			</div> <!-- end map -->
			
			<div id="store_info">
				<p class="store_name">${slist.store_name}</p>
				<p><i class="fas fa-map-marker-alt"></i> ${slist.store_add}</p>
				<p><i class="fas fa-phone-alt"></i> ${slist.store_cont}</p>
			</div>
		</div> <!-- end grid -->
		</c:forEach>
		</div>
	</div>
</section>

<!-- footer -->
<jsp:include page="footer.jsp"></jsp:include>
</body>



</html>