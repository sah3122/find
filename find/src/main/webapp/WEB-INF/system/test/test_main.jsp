<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Cache-Control" content="No-Cache">
<meta name="viewport" content="width=device-width, user-scalable=no">

<title>test</title>
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" type="image/x-icon" href="/images/favicon.ico">
<link rel="icon" type="image/x-icon" href="/images/favicon.ico">
<link rel="stylesheet" type="text/css" href="/css/common/table.css">
<link rel="stylesheet" type="text/css" href="/css/common/reset.css">
<link rel="stylesheet" type="text/css" href="/css/common/powertel_page.css">
<link rel="stylesheet" type="text/css" href="/css/common/layout.css">
<!-- datepicker 수정-->
<link rel="stylesheet" type="text/css" media="screen" href="/js/lib/jquery-ui-1.8/themes/base/jquery-ui.css" />
<script type="text/javascript" src="/js/lib/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/js/lib/jquery-ui-1.8/ui/jquery-ui.js"></script>
<script type="text/javascript" src="/js/common/common.js"></script>
<script type="text/javascript" src="/js/common/utils.js"></script>
<script type="text/javascript" ansync src="//apis.daum.net/maps/maps3.js?apikey=72f942428a6e8168e68231f112966195&libraries=services,clusterer"></script>
<script type="text/javascript" src="/js/test/test_modal.modal.js"></script>
<style type="text/css">
	.date-content {position:relative; display:inline-block; padding-left:20px }
	.ui-datepicker-trigger img {position: absolute; left: 0; top: 10px; }
	select{bottom:0px;position:relative;}
	.wave{margin:0 3px;}
</style>
<!--[if lt IE 9]>
	<script type="text/javascript" src="/js/lib/html5shiv.js"></script>
	<![endif]-->
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
.main-list {
	height : auto;
	border-bottom : 1px solid #c3c3c3;
}
.radius_border{border:1px solid #919191;border-radius:5px;}     
.custom_typecontrol {position:absolute;top:10px;right:400px;overflow:hidden;width:133px;height:30px;margin:0;padding:0;z-index:2;font-size:12px;font-family:'Malgun Gothic', '맑은 고딕', sans-serif;}
.custom_typecontrol span {display:block;width:65px;height:30px;float:left;text-align:center;line-height:30px;cursor:pointer;}
.custom_typecontrol .btn {background:#fff;background:linear-gradient(#fff,  #e6e6e6);color:#a3a3a3; font-size:12px}       
.custom_typecontrol .btn:hover {background:#f5f5f5;background:linear-gradient(#f5f5f5,#e3e3e3);}
.custom_typecontrol .btn:active {background:#e6e6e6;background:linear-gradient(#e6e6e6, #fff);}    
.custom_typecontrol .selected_btn {color:#fff;background:#425470;background:linear-gradient(#425470, #5b6d8a); font-size:12px}
.custom_typecontrol .selected_btn:hover {color:#fff;}
#modal {display:none;background-color:#FFFFFF;position:absolute;top:300px;left:200px;padding:10px;border:2px solid #E2E2E2;z-Index:9999}
</style>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loss").hide();
			$("#find").hide();
			$("#detail").hide();
			$("#login").hide();
			
			$('table.tb01 tr:odd').addClass('odd');
			$('table.tb01 tr:even').addClass('Even');
	
			/* if ($.browser.version < 9) {
				$(window).resize(function() {
					resizeHt();
					resizeWt();
				});
				resizeHt();
				resizeWt();
			} else {
				$(window).resize(function() {
					resizeHt();
				});
				$("#content .dashboard .position-control").css({"width" : "calc(100% - 360px)"});
				resizeHt();
			} */
			$(window).resize(function() {
				resizeHt();
			});
			$("#content .dashboard .position-control").css({"width" : "calc(100% - 360px)"});
			$("#loss_date").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));
			$("#find_date").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));
			
			/* map */
			var mapContainer = document.getElementById('map_div'), // 지도를 표시할 div 
			mapOption = {
				center : new daum.maps.LatLng(35.13760, 129.10090 ), // 지도의 중심좌표
				level : 5
			// 지도의 확대 레벨
			};
			map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			// 주소-좌표 변환 객체를 생성합니다
			geocoder = new daum.maps.services.Geocoder();
			
			marker = new daum.maps.Marker(); // 클릭한 위치를 표시할 마커입니다
			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
			var zoomControl = new daum.maps.ZoomControl();
			map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
	
			// 마커 클러스터러를 생성합니다 
		    clusterer = new daum.maps.MarkerClusterer({
		        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		        minLevel: 1 // 클러스터 할 최소 지도 레벨 
		    });
			//클러스터할 최소 마커 개수
		    clusterer.setMinClusterSize(2);
			jsonData = ${lossData};
			lossData = JSON.stringify(jsonData);
			jsonLossData = eval(lossData);
			
			createCustomOverlay(jsonLossData);
			
			// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
			daum.maps.event.addListener(map, 'zoom_changed', function() {        
			    createCustomOverlay(jsonLossData);
			});
			// 지도가 드래그되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
			daum.maps.event.addListener(map, 'dragend', function() {
				createCustomOverlay(jsonLossData);
			});
			
			// 지도가 이동, 확대, 축소로 인해 지도영역이 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다// 지도가 이동, 확대, 축소로 인해 지도영역이 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다.
			daum.maps.event.addListener(map, 'bounds_changed', function() {             
			});
			
			// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
			daum.maps.event.addListener(map, 'click', function(mouseEvent) {
			    searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
			        if (status === daum.maps.services.Status.OK && $("#map_click_check").val() == "true") {
			            //var detailAddr = !!result[0].roadAddress.name ? '<div>도로명주소 : ' + result[0].roadAddress.name + '</div>' : '';
			            var detailAddr = result[0].jibunAddress.name;
			         	// 클릭한 위도, 경도 정보를 가져옵니다 
			            var latlng = mouseEvent.latLng; 
			            $("#loss_place").val(detailAddr);	
			            $("#loss_lat").val(latlng.getLat());
			            $("#loss_long").val(latlng.getLng());
			            
						// 마커를 클릭한 위치에 표시합니다 
			            marker.setPosition(mouseEvent.latLng);
			            marker.setMap(map);
			        }   
			    });
			});
			
			// 마커 클러스터러에 클릭이벤트를 등록합니다 
		    // 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우 
		    // 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다 
		    daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
				//alert("a");
		    });
		    daum.maps.event.addListener(clusterer, 'clusterover', function( cluster ) {
		    	console.log( cluster.getMarkers()[0].getPosition() );
		    });
		 
			/* map end*/
			
			resizeHt();
		});
	
		function resizeWt() {
			$("#content .dashboard .position-control").width(($(window).width() - 383) + "px");
			map.relayout();
		}
	
		function resizeHt() {
			$("#content .position-control").height(getHeight()+53 + "px");
			$("#content .position-control .position-control-box li:first-child + li").height((getHeight() - 80) + "px");
			$("#content .pid").height(getHeight()+53 + "px");
			//메인페이지 li설정위해 주석처리
			/* $("#content .pid .pid-box li:first-child + li").height((getHeight() - 44) + "px");
			var liHt = $("#content .pid .pid-box li:first-child + li").height();
			$("#content .tb01-content").height((liHt - 45) + "px");  */
			map.relayout();
		}
	
		var tbMinHt = 89;
		function getHeight() {
			var brHt = $(window).height();
			var hdHt = $("#header").outerHeight();
			var cttPddTop = parseInt($("#content .dashboard .dashboard-content").css("padding-top"));
			var ftHt = $("#footer").outerHeight();
	
			var result = brHt - (hdHt + cttPddTop + ftHt + 27);
			return result > tbMinHt ? result : tbMinHt;
		}
		
		function fn_loss_insert(){
			$("#main").hide();
			$("#loss").show();
			$("#find").hide();
			$("#detail").hide();
			$("#login").hide();
			$("#map_click_check").val("true");
		}
		
		function fn_find_insert(){
			$("#main").hide();
			$("#find").show();
			$("#loss").hide();
			$("#detail").hide();
			$("#login").hide();
			$("#map_click_check").val("true");
		}
		
		function fn_find_main(){
			$("#loss").hide();
			$("#main").show();
			$("#detail").hide();
			$("#find").hide();
			$("#login").hide();
			$("#map_click_check").val("false");
		}
		
		//map
		function displayInfowindow(marker, infowindow) {
		    infowindow.open(map, marker);
		}
		
		function createCustomOverlay(jsonLossData){
			var markerPositionJson = new Object();
			var markerPositionArray = new Array();
		    clusterer.clear();
		    $("#main div").each(function(obj) {
		    	this.remove();
		    });

		    var list_count = 0;
			//여러개의 커스텀 오버레이 생성
			if(jsonLossData != null){
				for(var i = 0; i < jsonLossData.length; i++){
					//현재 지도에 표시되는 데이터만 마커 및 리스트 생성
					if(fn_Latlng_check(jsonLossData[i].loss_lat, jsonLossData[i].loss_long)){
						var position = new daum.maps.LatLng(jsonLossData[i].loss_lat, jsonLossData[i].loss_long);
						var marker = new daum.maps.Marker({
							title : jsonLossData[i].loss_title,
						    position : position
						});
						// 마커에 표시할 인포윈도우를 생성합니다 
						var infowindow;
						if(jsonLossData[i].loss_img_std != null && jsonLossData[i].loss_img_std != ""){
						    infowindow = new daum.maps.InfoWindow({
						        content: "<div style='text-align:center'>"+jsonLossData[i].loss_title+"</div>"+"<img src='/images/find/"+jsonLossData[i].loss_img_std+"' width='148px'/>" // 인포윈도우에 표시할 내용
						    });
						} else {
							infowindow = new daum.maps.InfoWindow({
						        content: "<div style='text-align:center'>"+jsonLossData[i].loss_title+"</div>" // 인포윈도우에 표시할 내용
						    });
						}
						// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
					    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
					    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
						daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
					    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
					    daum.maps.event.addListener(marker, 'click', makeClickListener(map, marker));
						clusterer.addMarker(marker);
						
						//현재 지도에서 표시되는 데이터를 리스트로 만드는 작업
						var data = JSON.stringify(jsonLossData[i]);
						var html = "";
						html += "<div id='main_list"+list_count+"' name='main_list"+list_count+"' class='main-list' style='height:100px' onclick='fn_detail("+data+",001)'>";
						
						if(jsonLossData[i].loss_img_std != null && jsonLossData[i].loss_img_std != ""){
							html += "	<div style='float:left'>";
							html += "	<img src='/images/find/"+jsonLossData[i].loss_img_std+"' width='175px'/>";
							html += "	</div>";
						}
						html += "		<div style='float:left'>";
						html += "			<span style='display:block'>"+jsonLossData[i].loss_title+"</span>";
						html += "			<span style='display:block'>"+jsonLossData[i].loss_place+"</span>";
						html += "			<span style='display:block'>"+jsonLossData[i].loss_date+"</span>";
						html += "		</div>";
						
						html += "</div>";

						$("#main").append(html);
						
						(function(marker, infowindow) {
							$("#main_list"+list_count).mouseover(function () {
								if(marker.getVisible()){
									displayInfowindow(marker, infowindow);
								}
				            });

							$("#main_list"+list_count).mouseout(function (){
				                infowindow.close();
				            });
				        })(marker, infowindow);
						
						list_count += 1;
					}
				}
			}
			
			
			
			function makeOverListener(map, marker,infowindow) {
			    return function() {
			    	infowindow.open(map, marker);
			        console.log(marker.getTitle());
			    };
			}
			
			// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
			function makeOutListener(infowindow) {
			    return function() {
			        infowindow.close();
			    };
			}
			
			function makeClickListener(map, marker) {
			    return function() {
			    	var param = "loss_title="+marker.getTitle();
			    	$.ajax({
						type : "POST",
						url : "/test/testDetail.do",
						data : param, // 보내는 폼 데이터
						dataType : "json", // 받는 데이터 타입
						success : function(data) {
							// r = 리턴받는 json객체
							if (data.result == 'success') {
								fn_detail(data.lossData,002);
								console.log(data.lossData);
							} else {
								alert("알수없는 오류가 발생하였습니다.");
							}
						}
					});
			    };
			}
			//markerPositionJson.positions = markerPositionArray;
			// 데이터에서 좌표 값을 가지고 마커를 표시합니다
	        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	        /* var markers = $(markerPositionJson.positions).map(function(i, position) {
	            return new daum.maps.Marker({
	            	position : new daum.maps.LatLng(position.lat, position.lng),
	            });
	        }); 
	    	
	        // 클러스터러에 마커들을 추가합니다
	        clusterer.addMarkers(markers); */
			
		}
		
		//지도 클릭시 위치를 가져오기 위한 함수
		function searchDetailAddrFromCoords(coords, callback) {
		    geocoder.coord2detailaddr(coords, callback);
		}
		
		function setMapType(maptype) { 
		    var btnLoss = document.getElementById('btnLoss');
		    var btnFind = document.getElementById('btnFind'); 
		    if (maptype === 'loss') {
		    	btnLoss.className = 'selected_btn';
		        btnFind.className = 'btn';
		        $.ajax({
					type : "POST",
					url : "/test/testLossList.do",
					dataType : "json", // 받는 데이터 타입
					success : function(data) {
						// r = 리턴받는 json객체
						if (data.result == 'success') {
							jsonLossData = eval(data.lossData);
							createCustomOverlay(jsonLossData);
						} else {
							alert("알수없는 오류가 발생하였습니다.");
						}
					}
				});
		    } else {
		    	btnFind.className = 'selected_btn';
		    	btnLoss.className = 'btn';
		    	$.ajax({
					type : "POST",
					url : "/test/testFindList.do",
					dataType : "json", // 받는 데이터 타입
					success : function(data) {
						// r = 리턴받는 json객체
						if (data.result == 'success') {
							jsonFindData = eval(data.FindData);
							createCustomOverlay(jsonFindData);
						} else {
							alert("알수없는 오류가 발생하였습니다.");
						}
					}
				});
		    }
		}
		
		function fn_file(obj, index) {
			if (obj.files && obj.files[0]) {
				var file = obj.files[0];
				var fileName = "";
				if(index == 'loss'){
					fileName = $("#loss_img_file").val();
				} else {
					fileName = $("#find_img_file").val();
				}
				fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();

				if(fileName != "jpg" && fileName != "png" &&  fileName != "gif" &&  fileName != "bmp"){
					alert("이미지 파일은 (jpg, png, gif, bmp) 형식만 등록 가능합니다.");
					$("#loss_img_file").val("");
					$("#find_img_file").val("");
					return;
				}

				var reader = new FileReader();
				reader.onload = function(event) {
					var img = new Image();
					img.src = event.target.result;

					if (img.width > 300) { 
						img.width = 300;
					}
					if(index == 'loss'){
						$("#loss_preimg").text('');
						$("#loss_preimg").append(img);
					} else {
						$("#find_preimg").text('');
						$("#find_preimg").append(img);
					}
				};
				reader.readAsDataURL(file);

				return false;
			}
		}
		
		function fn_insert() {
			if(fn_insert_check()){
				$("#loss_insert_date").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));
				var form = $("#dataForm")[0];
		        var formData = new FormData(form);
				$.ajax({
					type : "POST",
					url : "/test/testInsert.do",
					//data : $("#dataForm").serialize(), // 보내는 폼 데이터
					data : formData, // 보내는 폼 데이터
					dataType : "json", // 받는 데이터 타입
					contentType: false,// multipart data전송시 필요함!
					processData: false,// multipart data전송시 필요함!
					success : function(data) {
						// r = 리턴받는 json객체
						if (data.result == 'success') {
							alert("등록 되었습니다.");
							
							jsonLossData = eval(data.lossData);
							createCustomOverlay(jsonLossData);
							location.reload();
						} else {
							alert("알수없는 오류가 발생하였습니다.");
						}
					}
				});
			}
		}
		//마커의 위치를 체크하여 현재 보이는 화면안에 정보만 가져오기
		function fn_Latlng_check(lat, lng){
			var result = false;
			var bounds = map.getBounds();
			// 영역정보의 남서쪽 정보를 얻어옵니다 
		    var swLatlng = bounds.getSouthWest();
		    var swLat = swLatlng.getLat();
		    var swLng = swLatlng.getLng();
		    // 영역정보의 북동쪽 정보를 얻어옵니다 
		    var neLatlng = bounds.getNorthEast();
		    var neLat = neLatlng.getLat();
		    var neLng = neLatlng.getLng();
		    //console.log(map.getCenter())
		    //console.log(lat + " " + lng);
		   	//console.log(swLatlng +" "+ neLatlng);
		    //console.log((lng > swLng) && (lng < neLng));
		    if((lat > swLat) && (lat < neLat) && (lng > swLng) && (lng < neLng)){
		    	result = true;
		    }
		    return result;
		}
		
		function fn_insert_check(){
			if($("#loss_title").val() == "" ||  $("#loss_feature").val() == ""){
				alert("필수정보를 입력해주세요.");
				return false;
			}
			if($("#loss_place").val() == ""){
				alert("분실장소를 지도에서 선택해주세요.");
				return false;
			}
			return true;
		}
		
		function fn_detail(data, gubun){
			//console.log("data : "+ data);
			if(gubun == 001){
				var jsonObject = eval(data);
			} else {
				var jsonObject = JSON.parse(data);
			}
			//console.log(jsonObject.loss_lat + " " + jsonObject.loss_long);
			$("#loss").hide();
			$("#find").hide();
			$("#main").hide();
			$("#login").hide();
			$("#detail").show();
			$("#map_click_check").val("false");
			
			$("#loss_detail_title").val(jsonObject.loss_title);
			$("#loss_detail_date").val(jsonObject.loss_date);
			$("#loss_detail_place").val(jsonObject.loss_place);
			$("#loss_detail_feature").val(jsonObject.loss_feature);
			
			if(typeof jsonObject.loss_img_std === "undefined" || jsonObject.loss_img_std == ""){
				$("#detail_img").hide();
			} else {
				$("#detail_img").show();
				$("#loss_detail_img").attr("src","/images/find/"+jsonObject.loss_img_std);
			}
			if(jsonObject.loss_kind == ""){
				$("#detail_kind").hide();
			} else {
				$("#detail_kind").show();
				$("#loss_detail_kind").val(jsonObject.loss_kind);
				$("#loss_detail_kind").attr("disabled","disabled");
			}
			if(jsonObject.loss_kind_detail == ""){
				$("#detail_kind").hide();
			} else {
				$("#detail_kind").show();
				$("#loss_detail_kind_detail").val(jsonObject.loss_kind_detail);
			}
			if(jsonObject.loss_sex == ""){
				$("#detail_sex").hide();
			} else {
				$("#detail_sex").show();
				$("#loss_detail_sex").val(jsonObject.loss_sex);
				$("#loss_detail_sex").attr("disabled","disabled");
			}
			if(jsonObject.loss_age == ""){
				$("#detail_age").hide();
			} else {
				$("#detail_age").show();
				$("#loss_detail_age").val(jsonObject.loss_age);
			}
			if(jsonObject.loss_place_detail == ""){
				$("#detail_place_detail").hide();
			} else {
				$("#detail_place_detail").show();
				$("#loss_detail_place_detail").val(jsonObject.loss_place_detail);
			}
			if(jsonObject.loss_color == ""){
				$("#detail_color").hide();
			} else {
				$("#detail_color").show();
				$("#loss_detail_color").val(jsonObject.loss_color);
			}
			if(jsonObject.loss_process == ""){
				$("#detail_process").hide();
			} else {
				$("#detail_process").show();
				$("#loss_detail_process").val(jsonObject.loss_process);
			}
			if(jsonObject.loss_regis_num == ""){
				$("#detail_regis_num").hide();
			} else {
				$("#detail_regis_num").show();
				$("#loss_detail_regis_num").val(jsonObject.loss_regis_num);
			}
			if(jsonObject.loss_rfid_cd == ""){
				$("#detail_rfid_cd").hide();
			} else {
				$("#detail_rfid_cd").show();
				$("#loss_detail_rfid_cd").val(jsonObject.loss_rfid_cd);
			}
		}
		//########################################modaltest
		
		// 모달창 인스턴트 생성
		var myModal = new Example.Modal({
		    id: "modal" // 모달창 아이디 지정
		});
		  
		function fn_open_modal(){
			myModal.show(); // 모달창 보여주기
			myModal.moveCenter();
		}
		function fn_confirm_button(){
			myModal.hide(); // 모달창 감추기
		}
	</script>
	<div id="header">
		<div>
			<!-- 로그인 상태일때 -->
			<!-- <div class="login-info">
				<span id="login_user_nm"> test
				</span>님께서 로그인하셨습니다.
				<div class="btn-logout" id="logout">로그아웃</div>
			</div> -->
			<!-- //로그인 상태일때 -->
			<!-- 로그인 상태가 아닐때 -->
			<!-- 로그인 -->
			<div class="login-info">
				<a href="javascript:void(0)">로그인</a> &nbsp&nbsp|&nbsp&nbsp    
				<!-- 모달 창을 여는 버튼 -->
				<a href="javascript:void(0)" id="modal_button" onclick="fn_open_modal()">회원가입</a>
			</div>
			<!-- // 로그인 -->
			<!-- //로그인 상태가 아닐때 -->
			<a href="/intro/intro.do" class="block logo">logo<!-- <img src="/images/page/header/powertel-logo.png" width="100px;" height="20px;" alt="powertel" title="powertel"> --></a>
			<ul class="header-menu">
				<li class="header-menu"><a href="#" onclick="fn_find_main()">메인페이지</a>
				</li>
				<li class="header-menu"><a href="#" onclick="fn_loss_insert()">분실신고</a>
				</li>
				<li class="header-menu"><a href="#" onclick="fn_find_insert()">습득신고</a>
				</li>
				<li class="header-menu"><a href="#" onclick="">채팅</a>
				</li>
			</ul>
			
		</div>
	</div>
	<div class="wrap" id="wrap">
		<div id="headerHeight"></div>
		<!-- content -->
		<div id="content">
			<div class="dashboard">
				<div class="dashboard-content">
					<div class="position-control">
						<ul class="position-control-box" style="height: 100%">
							<input type="hidden" id="map_click_check" name="map_click_check" value="false"/>
							<div id="map_div" style="width: 100%; height: 100%"></div>
							<div class="custom_typecontrol radius_border" >
						        <span id="btnLoss" class="selected_btn" onclick="setMapType('loss')" style="margin:0px">분실</span>
						        <span id="btnFind" class="btn" onclick="setMapType('find')" style="margin:0px">습득</span>
						    </div>
						</ul>
					</div>
					<div class="pid">
						<ul class="pid-box" style="height:100%">
							<div id="main" style="height:100%; overflow-y:auto">
								<li>
									종 기간
								</li>
							</div>
							<div id="loss" style="height:100%; overflow-y:auto">
								<li>
									분실신고
								</li>
								<div class="form-style-2">
									<form id="dataForm" name="dataForm" enctype="multipart/form-data" method="post">
										<input type="hidden" id="loss_lat" name="loss_lat" value=""/>
										<input type="hidden" id="loss_long" name="loss_long" value=""/>
										<input type="hidden" id="loss_user_id" name="loss_user_id" value=""/>
										<input type="hidden" id="loss_insert_date" name="loss_insert_date" value=""/>
										<label for="field1">
											<span>제목 <span class="required">*</span></span><input type="text" class="input-field" id="loss_title" name="loss_title" value="" />
										</label>
										<label for="field2">
											<span>분실날짜</span>
											<div class="date-content">
												<input type="text" id="loss_date" name="loss_date" readonly="readonly" value="" class="loss-date statistics-date lost-field">
											</div>
										</label>
										<label for="field2">
											<span>성별</span>
											<select id="loss_sex" name="loss_sex" class="select-field">
												<option value="male">수컷</option>
												<option value="female">암컷</option>
											</select>
										</label>
										<label for="field2">
											<span>나이</span><input type="text" class="input-field" id="loss_age" name="loss_age" value="" />
										</label>
										<label for="field4">
											<span>품종</span>
											<select id="loss_kind" name="loss_kind" class="select-field">
												<option value="dog">개</option>
												<option value="cat">고양이</option>
												<option value="etc">기타</option>
											</select>
											<input id="loss_kind_detail" name="loss_kind_detail" type="text" class="kind-field" value="" />
										</label>
										<label for="field2">
											<span>분실장소 <span class="required">*</span></span><input type="text" class="input-field" id="loss_place" name="loss_place" value="" readonly="readonly"/>
										</label>
										<label for="field2">
											<span></span><input type="text" class="input-field" id="loss_place_detail" name="loss_place_detail" value="" />
										</label>
										<label for="field2">
											<span>색상</span><input type="text" class="input-field" id="loss_color" name="loss_color" value="" />
										</label>
										<label for="field5">
											<span>특징 <span class="required">*</span></span><textarea id="loss_feature" name="loss_feature" class="textarea-field"></textarea>
										</label>
										<label for="field2">
											<span>신고경위</span><input type="text" class="input-field" id="loss_process" name="loss_process" value="" />
										</label>
										<label for="field2">
											<span>등록번호</span><input type="text" class="input-field" id="loss_regis_num" name="loss_regis_num" value="" />
										</label>
										<label for="field2">
											<span>RFID_CD</span><input type="text" class="input-field" id="loss_rfid_cd" name="loss_rfid_cd" value="" />
										</label>
										<label for="field2">
											<span>사진</span>
											<input type="file" id="loss_img_file" name="loss_img_file" onchange="fn_file(this,'loss')" style="margin-top : 5px; margin-bottom : 5px"/>
											<div id="loss_preimg" name="loss_preimg"></div>
										</label>
										<label>
											<span>&nbsp;</span>
											<input class="insert-btn" type="button" id="loss_insert" name="loss_insert" onclick="fn_insert('loss')" value="등록" />
											<span>&nbsp;</span>
											<input class="calcel-btn" type="button" id="loss_cancel" name="loss_cancel" value="취소" />
										</label>
									</form>
								</div>
							</div>
							<div id="find" style="height:100%; overflow-y:auto">
								<li>
									습득신고
								</li>
								<div class="form-style-2">
									<form id="dataForm" name="dataForm" enctype="multipart/form-data" method="post">
										<input type="hidden" id="find_lat" name="find_lat" value=""/>
										<input type="hidden" id="find_long" name="find_long" value=""/>
										<input type="hidden" id="find_user_id" name="find_user_id" value=""/>
										<input type="hidden" id="find_insert_date" name="find_insert_date" value=""/>
										<label for="field1">
											<span>제목 <span class="required">*</span></span><input type="text" class="input-field" id="find_title" name="find_title" value="" />
										</label>
										<label for="field2">
											<span>습득날짜</span>
											<div class="date-content">
												<input type="text" id="find_date" name="find_date" readonly="readonly" value="" class="find-date statistics-date lost-field">
											</div>
										</label>
										<label for="field2">
											<span>성별</span>
											<select id="find_sex" name="find_sex" class="select-field">
												<option value="male">수컷</option>
												<option value="female">암컷</option>
											</select>
										</label>
										<label for="field2">
											<span>나이</span><input type="text" class="input-field" id="find_age" name="find_age" value="" />
										</label>
										<label for="field4">
											<span>품종</span>
											<select id="find_kind" name="find_kind" class="select-field">
												<option value="dog">개</option>
												<option value="cat">고양이</option>
												<option value="etc">기타</option>
											</select>
											<input id="find_kind_detail" name="find_kind_detail" type="text" class="kind-field" value="" />
										</label>
										<label for="field2">
											<span>습득장소 <span class="required">*</span></span><input type="text" class="input-field" id="find_place" name="find_place" value="" readonly="readonly"/>
										</label>
										<label for="field2">
											<span></span><input type="text" class="input-field" id="find_place_detail" name="find_place_detail" value="" />
										</label>
										<label for="field2">
											<span>색상</span><input type="text" class="input-field" id="find_color" name="find_color" value="" />
										</label>
										<label for="field5">
											<span>특징 <span class="required">*</span></span><textarea id="find_feature" name="find_feature" class="textarea-field"></textarea>
										</label>
										<label for="field2">
											<span>습득경위</span><input type="text" class="input-field" id="find_process" name="find_process" value="" />
										</label>
										<label for="field2">
											<span>등록번호</span><input type="text" class="input-field" id="find_regis_num" name="find_regis_num" value="" />
										</label>
										<label for="field2">
											<span>RFID_CD</span><input type="text" class="input-field" id="find_rfid_cd" name="find_rfid_cd" value="" />
										</label>
										<label for="field2">
											<span>사진</span>
											<input type="file" id="find_img_file" name="find_img_file" onchange="fn_file(this,'find')" style="margin-top : 5px; margin-bottom : 5px"/>
											<div id="find_preimg" name="find_preimg"></div>
										</label>
										<label>
											<span>&nbsp;</span>
											<input class="insert-btn" type="button" id="find_insert" name="find_insert" onclick="fn_insert('find')" value="등록" />
											<span>&nbsp;</span>
											<input class="calcel-btn" type="button" id="find_cancel" name="find_cancel" value="취소" />
										</label>
									</form>
								</div>
							</div>
							<div id="detail" style="height:100%; overflow-y:auto">
								<li>
									상세보기
								</li>
								<div class="form-style-2">
									<form id="dataForm" name="dataForm" method="post">
										<label for="field1" id="detail_title">
											<span>제목</span><input type="text" class="input-field" readonly="readonly" id="loss_detail_title" name="loss_detail_title" value="" />
										</label>
										<label for="field2" id="detail_date">
											<span>분실날짜</span><input type="text" id="loss_detail_date" name="loss_detail_date" readonly="readonly" value="" class="statistics-date lost-field">
										</label>
										<label for="field2" id="detail_sex">
											<span>성별</span>
											<select id="loss_detail_sex" name="loss_detail_sex" class="select-field">
												<option value="male">수컷</option>
												<option value="female">암컷</option>
											</select>
										</label>
										<label for="field2" id="detail_age">
											<span>나이</span><input type="text" class="input-field" id="loss_detail_age" name="loss_detail_age" value="" />
										</label>
										<label for="field4" id="detail_kind">
											<span>품종</span>
											<select id="loss_detail_kind" name="loss_detail_kind" class="select-field">
												<option value="dog">개</option>
												<option value="cat">고양이</option>
												<option value="etc">기타</option>
											</select>
											<input type="text" id="loss_detail_kind_detail" name="loss_detail_kind_detail" readonly="readonly" value="" class="kind-field">
										</label>
										<label for="field2" id="detail_place">
											<span>분실장소</span><input type="text" class="input-field" id="loss_detail_place" name="loss_detail_place" value="" readonly="readonly"/>
										</label>
										<label for="field2" id="detail_place_detail">
											<span></span><input type="text" class="input-field" id="loss_detail_place_detail" readonly="readonly" name="loss_detail_place_detail" value="" />
										</label>
										<label for="field2" id="detail_color">
											<span>색상</span><input type="text" class="input-field" readonly="readonly" id="loss_detail_color" name="loss_detail_color" value="" />
										</label>
										<label for="field5" id="detail_feature">
											<span>특징</span><textarea id="loss_detail_feature" readonly="readonly" name="loss_detail_feature" class="textarea-field"></textarea>
										</label>
										<label for="field2" id="detail_process">
											<span>신고경위</span><input type="text" class="input-field" readonly="readonly" id="lossdetail_process" name="lossdetail_process" value="" />
										</label>
										<label for="field2" id="detail_regis_num">
											<span>등록번호</span><input type="text" class="input-field" readonly="readonly" id="loss_detail_regis_num" name="loss_detail_regis_num" value="" />
										</label>
										<label for="field2" id="detail_rfid_cd">
											<span>RFID_CD</span><input type="text" class="input-field" readonly="readonly" id="loss_detail_rfid_cd" name="loss_detail_rfid_cd" value="" />
										</label>
										<label for="field2" id="detail_img">
											<span>사진</span>
											<img id="loss_detail_img" name="loss_detail_img" src="" width="300px" style="margin-top : 5px; margin-bottom : 5px"/>
										</label>
									</form>
								</div>
							</div>
							<div id="login" style="height:100%; overflow-y:auto">
								<li>
									로그인
								</li>
								<div class="form-style-2">
									<form id="dataForm" name="dataForm" method="post">
										<label for="field1" id="detail_title">
											<span>아이디</span><input type="text" class="input-field" id="find_detail_title" name="loss_detail_title" value="" />
										</label>
										<label for="field2" id="detail_date">
											<span>비밀번호</span><input type="text" id="loss_detail_date" name="loss_detail_date"  value="" class="statistics-date lost-field">
										</label>
									</form>
								</div>
							</div>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div id="footerHeight"></div>
	</div>
	<div id="footer">
		Copyright © <span style="font-weight: bold; color: #666;">Lee Dong Chul</span> All rights reserved.
	</div>
	<!-- 모달창 -->
	<div id="modal" style="width:300px; height:500px">
	    <h3>Test Modal</h3>
	    <p>이 창은 모달창입니다.</p>
	    <button id="confirm_button" onclick="fn_confirm_button()">확인</button>
	    <button class="js_close">닫기</button>
	</div>
</body>
</html>