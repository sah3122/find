<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>커스텀 오버레이 생성하기1</title>
<style>
.label {
	margin-bottom: 96px;
}

.label * {
	display: inline-block;
	vertical-align: top;
}

.label .left {
	background:
		url("http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png")
		no-repeat;
	display: inline-block;
	height: 24px;
	overflow: hidden;
	vertical-align: top;
	width: 7px;
}

.label .center {
	background:
		url(http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png)
		repeat-x;
	display: inline-block;
	height: 24px;
	font-size: 12px;
	line-height: 24px;
}

.label .right {
	background:
		url("http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png")
		-1px 0 no-repeat;
	display: inline-block;
	height: 24px;
	overflow: hidden;
	width: 6px;
}
</style>
<script type="text/javascript" src="/js/lib/jquery-1.8.2.min.js"></script>
</head>
<body>
<div id="map" style="width: 100%; height: 350px;"></div>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=72f942428a6e8168e68231f112966195"></script>
<script>
	$(document).ready(function(){
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(35.159518125194644, 129.0738626830551), // 지도의 중심좌표
			level : 7
		// 지도의 확대 레벨
		};

		map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new daum.maps.ZoomControl();
		map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

		// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
		daum.maps.event.addListener(map, 'zoom_changed', function() {        
			createCustomOverlay(test);
		});
		// 지도가 이동, 확대, 축소로 인해 지도영역이 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다// 지도가 이동, 확대, 축소로 인해 지도영역이 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다.
		daum.maps.event.addListener(map, 'bounds_changed', function() {             
		    
		    // 지도 영역정보를 얻어옵니다 
		    var bounds = map.getBounds();
		    
		    // 영역정보의 남서쪽 정보를 얻어옵니다 
		    var swLatlng = bounds.getSouthWest();
		    
		    // 영역정보의 북동쪽 정보를 얻어옵니다 
		    var neLatlng = bounds.getNorthEast();
		    
		    /* var message = '<p>영역좌표는 남서쪽 위도, 경도는  ' + swLatlng.toString() + '이고 <br>'; 
		    message += '북동쪽 위도, 경도는  ' + neLatlng.toString() + '입니다 </p>'; 
		    
		    var resultDiv = document.getElementById('result');   
		    resultDiv.innerHTML = message; */
		    
		});
		
		jsonData = ${lossData};
		lossData = JSON.stringify(jsonData);
		test = eval(lossData);
		
		//alert(lossData[0]);
		//alert(test[0].loss_title);
		
		createCustomOverlay(test);
	});

	function createCustomOverlay(test){
		//여러개의 커스텀 오버레이 생성
		for(var i = 0; i < test.length; i++){
			// 커스텀 오버레이에 표시할 내용입니다     
			// HTML 문자열 또는 Dom Element 입니다 
			var content =  '<div id="test'+i+'" class ="label" onclick="overlayClick(this)">';
				content +=     '<span class="left"></span>';
				content +=     '<span class="center">'+test[i].loss_title+'</span>';
				content +=     '<span class="right"></span>';
				content += '</div>';
	
			// 커스텀 오버레이가 표시될 위치입니다 
			var position = new daum.maps.LatLng(test[i].loss_lat, test[i].loss_long);
	
			// 커스텀 오버레이를 생성합니다
			var customOverlay = new daum.maps.CustomOverlay({
				position : position,
				content : content
			});
	
			// 커스텀 오버레이를 지도에 표시합니다
			customOverlay.setMap(map);
		}
	}
	
	function overlayClick(obj){
		alert($(obj).attr("id"));
	}
	
</script>
</body>
</html>