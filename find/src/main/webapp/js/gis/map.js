$(document).ready(function() {
	var mapContainer = document.getElementById('map_div'), // 지도를 표시할 div 
	mapOption = {
		center : new daum.maps.LatLng(35.141576950973885, 129.0462544864037 ), // 지도의 중심좌표
		level : 5
	// 지도의 확대 레벨
	};

	map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 주소-좌표 변환 객체를 생성합니다
	geocoder = new daum.maps.services.Geocoder();
	
	var marker = new daum.maps.Marker(); // 클릭한 위치를 표시할 마커입니다
    
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

	// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
	daum.maps.event.addListener(map, 'zoom_changed', function() {        
		createCustomOverlay(jsonLossData);
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
	
	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
	daum.maps.event.addListener(map, 'click', function(mouseEvent) {
	    searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
	        if (status === daum.maps.services.Status.OK) {
	            //var detailAddr = !!result[0].roadAddress.name ? '<div>도로명주소 : ' + result[0].roadAddress.name + '</div>' : '';
	            var detailAddr = result[0].jibunAddress.name;
				$("#loss_place1").val(detailAddr);	
				
				// 마커를 클릭한 위치에 표시합니다 
	            marker.setPosition(mouseEvent.latLng);
	            marker.setMap(map);
	        }   
	    });
	});
	
	jsonData = ${lossData};
	lossData = JSON.stringify(jsonData);
	jsonLossData = eval(lossData);
	
	createCustomOverlay(jsonLossData);
});

function createCustomOverlay(jsonLossData){
	//여러개의 커스텀 오버레이 생성
	for(var i = 0; i < jsonLossData.length; i++){
		// 커스텀 오버레이에 표시할 내용입니다     
		// HTML 문자열 또는 Dom Element 입니다 
		var content =  '<div id="jsonLossData'+i+'" class ="label" onclick="overlayClick(this)">';
			content +=     '<span class="left"></span>';
			content +=     '<span class="center">'+jsonLossData[i].loss_title+'</span>';
			content +=     '<span class="right"></span>';
			content += '</div>';

		// 커스텀 오버레이가 표시될 위치입니다 
		var position = new daum.maps.LatLng(jsonLossData[i].loss_lat, jsonLossData[i].loss_long);

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

function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 상세 주소 정보를 요청합니다
    geocoder.coord2detailaddr(coords, callback);
}