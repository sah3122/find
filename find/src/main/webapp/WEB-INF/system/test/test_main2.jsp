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
<script src="https://www.gstatic.com/firebasejs/3.7.4/firebase.js"></script>
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
	
	<script>
		var auth, database, userInfo;
		
		// Initialize Firebase
		var config = {
		  apiKey: "AIzaSyCkfCzhCIqMSBTyh9E2AS5Uh_ohFcpL8GU",
		  authDomain: "practical-mason-97013.firebaseapp.com",
		  databaseURL: "https://practical-mason-97013.firebaseio.com",
		  projectId: "practical-mason-97013",
		  storageBucket: "practical-mason-97013.appspot.com",
		  messagingSenderId: "412948176805"
		};
		firebase.initializeApp(config);
		
		auth = firebase.auth();
		database = firebase.database();
		
		var authProvider = new firebase.auth.GoogleAuthProvider();
		
		//auth.signInWithPopup(authProvider);
		//인증여부
		 auth.onAuthStateChanged(function(user){
			if(user){//인증성공
				console.log(user.displayName);
				console.log("success");
				userInfo = user;
				
				console.log(userInfo.uid);
				$("#login_span").text(userInfo.displayName + "님이 로그인 하셨습니다.  |  ");
				$("#logout_text").css("display","");
				$("#login_text").css("display","none");
				/* var chattingRef = database.ref('chatting/'+userInfo.uid);
				chattingRef.push({
					txt:'test',
					title:'test'
				}) */
				
			} /* else {//인증실패
				auth.signInWithPopup(authProvider);
				$("#login_span").text("");
				$("#login_text").css("display","");
				$("#logout_text").css("display","none");
			} */
		}) 
	
	</script>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#loss").hide();
			$("#find").hide();
			$("#detail").hide();
			$("#chat").hide();
			$("#chatList").hide();
			
			$('table.tb01 tr:odd').addClass('odd');
			$('table.tb01 tr:even').addClass('Even');
			
			$('#chat').on( 'keyup', 'textarea', function (e){
		        $(this).css('height', 'auto' );
		        $(this).height( this.scrollHeight );
		      });
		    $('#chat').find( 'textarea' ).keyup();
		    
		    dogData = ${dogData};
		    catData = ${catData};
		    
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
		        disableClickZoom : false,
		        minLevel: 6 // 클러스터 할 최소 지도 레벨 
		    });
			//클러스터할 최소 마커 개수
		    clusterer.setMinClusterSize(2);
			jsonData = ${lossData};
			lossData = JSON.stringify(jsonData);
			jsonLossData = eval(lossData);
			
			createCustomOverlay(jsonLossData);
			
			// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
			daum.maps.event.addListener(map, 'zoom_changed', function() {    
				fn_search_select();
			    //createCustomOverlay(jsonLossData);
			});
			// 지도가 드래그되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
			daum.maps.event.addListener(map, 'dragend', function() {
				fn_search_select();
				//createCustomOverlay(jsonLossData);
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
			            $("#place").val(detailAddr);	
			            $("#lat").val(latlng.getLat());
			            $("#lng").val(latlng.getLng());
			            
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
		    	console.log( cluster.getMarkers()[1].getPosition() );
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
			$("#chat").hide();
			$("#chatList").hide();
			$("#map_click_check").val("true");
			
			$("#loss_li").text("분실신고");
			$("#find_type").val("loss");
			fn_ajax_select('loss');
		}
		
		function fn_find_insert(){
			$("#main").hide();
			$("#find").hide();
			$("#loss").show();
			$("#detail").hide();
			$("#chat").hide();
			$("#chatList").hide();
			$("#map_click_check").val("true");
			$("#find_type").val("find");
			
			$(".chat-div").remove();
			
			$("#loss_li").text("습득신고");
			fn_ajax_select('loss');
		}
		
		function fn_find_main(){
			$("#loss").hide();
			$("#main").show();
			$("#detail").hide();
			$("#find").hide();
			$("#chat").hide();
			$("#chatList").hide();
			$("#map_click_check").val("false");
		}
		
		function fn_open_chat(user_id, user_name){
			$("#loss").hide();
			$("#main").hide();
			$("#detail").hide();
			$("#find").hide();
			$("#chat").show();
			$("#chatList").hide();
			$("#map_click_check").val("false");
			
			$("#chat > li").text($("#chat_userName").val());
			
			if(user_id != null){
				$("#chat > li").text(user_name);
				$("#chat_userId").val(user_id);
				$("#chat_userName").val(user_name);
			}
			
			var user = [userInfo.uid+","+userInfo.displayName, $("#chat_userId").val()+","+$("#chat_userName").val()];
			user.sort();
			
			//방목록 저장
			var param = "";
			param = {"user1_id":user[0].split(',')[0], "user2_id":user[1].split(',')[0], "user1_name":user[0].split(',')[1], "user2_name":user[1].split(',')[1]};
			$.ajax({
				type : "POST",
				url : "/test/testChatInsert.do",
				data : param, // 보내는 폼 데이터
				dataType : "json", // 받는 데이터 타입
				success : function(data) {
					// r = 리턴받는 json객체
					if (data.result == 'success') {
						alert("채팅방이 개설되었습니다.");
					} 
				}
			});
			
			$("#chat_list").html("");
			var commentsRef = database.ref('chatting/' + user[0].split(',')[0] + "," + user[1].split(',')[0]);
			commentsRef.on('child_added', function(snapshot) {
				console.log("child_added : " + snapshot.val());
				  
				var snapVal = snapshot.val();
			    //console.log("snapshot.val()", snapVal);
			    var count = 0;
			    var chartArray = [];
			    for (var key in snapVal) {
			        //key는 유저 id
			        console.log(count++);
			        if (snapVal.hasOwnProperty(key)) {                
			            console.log("key/value", key, snapVal[key]);   
			        }
			    }
			    html = "";
	            html += "<div class='chat-div' style='display:flex; flex-direction: row; margin-bottom:20px; height:auto;'; >";
	            html += "	<div style='display:flex;flex-basis:60px'>";
	            html += snapVal["sendUser"];
	            html += "	</div>";
	            html += "	<div style=''>";
	            html += snapVal["text"];
	            html += "	</div>";
	            html += "</div>";
	            $("#chat_list").append(html);
			});
		}
		
		function fn_chat_List(){
			$("#loss").hide();
			$("#main").hide();
			$("#detail").hide();
			$("#find").hide();
			$("#chat").hide();
			$("#chatList").show();
			
			$("#chatList_list").html("");
			
			//채팅 목록 가져오기
			var param = "";
			param = {"user_id":userInfo.uid};
			$.ajax({
				type : "POST",
				url : "/test/testChatList.do",
				data : param, // 보내는 폼 데이터
				dataType : "json", // 받는 데이터 타입
				success : function(data) {
					// r = 리턴받는 json객체
					if (data.result == 'success') {
						jsonData = eval(data.jsonData);
						
						for(var i = 0; i < jsonData.length; i++){
							var html = ""
							if(jsonData[i].user1_id == userInfo.uid){
								html += "<div style='height:50px; display:flex; flex-direction: row; border-bottom : 1px solid #c3c3c3' onclick=fn_open_chat('"+jsonData[i].user2_id+"','"+jsonData[i].user2_name+"')>";
							} else {
								html += "<div style='height:50px; display:flex; flex-direction: row; border-bottom : 1px solid #c3c3c3' onclick=fn_open_chat('"+jsonData[i].user1_id+"','"+jsonData[i].user1_name+"')>";
							}
							html += "	<div style='display:flex; flex-grow:1; align-items: center;'>	";
							if(jsonData[i].user1_id == userInfo.uid){
								html += jsonData[i].user2_name;	
							} else {
								html += jsonData[i].user1_name;
							}
							html += "	</div>";
							html += "	<div style='display:flex; flex-grow:4; text-align:center; align-items: center;'>";
							html += "		<span>내용</span>";
							html += "	</div>";
							html += "</div>";
							$("#chatList_list").append(html);
						}
					} else {
						var html = ""
						html += "<div style='height:50px; display:flex; flex-direction: row; border-bottom : 1px solid #c3c3c3' onclick=fn_open_chat('"+jsonData[i].user1_id+"','"+jsonData[i].user1_name+"')>";
						html += "	<div style='display:flex; flex-grow:1; align-items: center;'>	";
						html += "	</div>";
						html += "	<div style='display:flex; flex-grow:4; text-align:center; align-items: center;'>";
						html += "		<span>채팅목록이 없습니다.</span>";
						html += "	</div>";
						html += "</div>";
						$("#chatList_list").append(html);
					}
				}
			});
		}
		
		function fn_chat_send(){
			var now = new Date();
			var nowTime = now.getFullYear();
			nowTime += '-' + now.getMonth() + 1 ;
			nowTime += '-' + now.getDate();
			nowTime += ' ' + now.getHours();
			nowTime += ':' + now.getMinutes();
			nowTime += ':' + now.getSeconds();
			if($("#chat_userId").val() == ""){
				alert("메시지를 전송할수 없습니다.");
				return false;
			}
			
			if($("#chat_message").val() != "") {
				var text = $("#chat_message").val().replace(/\n/g,"<br/>");
				console.log(text);
				var user = [userInfo.uid, $("#chat_userId").val()];
				user.sort();
				
				//데이터베이스 저장
				var chattingRef = database.ref('chatting/'+ user[0] + ',' + user[1]);
				 chattingRef.push({
					sendUser: userInfo.displayName,
					sendId: userInfo.uid,
					/* receiveUser: $("#chat_userName").val(),
					receiveId: $("#chat_userId").val(), */
					text: text,
					sendDate : nowTime
				}); 
				 $("#chat_message").val(""); 
			} else {
				alert("내용을 입력해주세요.");
			}
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
					if(fn_Latlng_check(jsonLossData[i].lat, jsonLossData[i].lng)){
						var position = new daum.maps.LatLng(jsonLossData[i].lat, jsonLossData[i].lng);
						var marker = new daum.maps.Marker({
							/* title : jsonLossData[i].title, */
							title : jsonLossData[i]._id,
						    position : position
						});
						// 마커에 표시할 인포윈도우를 생성합니다 
						var infowindow;
						if(jsonLossData[i].img_std != null && jsonLossData[i].img_std != ""){
						    infowindow = new daum.maps.InfoWindow({
						        content: "<div style='text-align:center'>"+jsonLossData[i].title+"</div>"+"<img src='/images/find/"+jsonLossData[i].img_std+"' width='148px'/>" // 인포윈도우에 표시할 내용
						    });
						} else {
							infowindow = new daum.maps.InfoWindow({
						        content: "<div style='text-align:center'>"+jsonLossData[i].title+"</div>" // 인포윈도우에 표시할 내용
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
						if(jsonLossData[i].img_std != null && jsonLossData[i].img_std != ""){
							html += "	<div style='float:left'>";
							html += "	<img src='/images/find/"+jsonLossData[i].img_std+"' width='175px' height:'100px' style='width:175px; height:100px'/>";
							html += "	</div>";
						}
						html += "		<div style='float:left'>";
						html += "			<span style='display:block'>"+jsonLossData[i].title+"</span>";
						html += "			<span style='display:block'>"+jsonLossData[i].place+"</span>";
						html += "			<span style='display:block'>"+jsonLossData[i].date+"</span>";
						html += "		</div>";
						
						html += "</div>";

						$("#main").append(html);

						(function(marker, infowindow) {
							$("#main_list"+list_count).mouseover(function () {
								displayInfowindow(marker, infowindow);
				            });

							$("#main_list"+list_count).mouseout(function (){
				                infowindow.close();
				            });
				        })(marker, infowindow);
						
						list_count += 1;
					}
				}
			}
			daum.maps.event.addListener( clusterer, 'clustered', function( clusters ) {
			});
			
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
			    	var param = {"id":marker.getTitle(),"map_type":$("#map_type").val()};
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
		        $("#main_li").text("분실 목록");
		    } else {
		    	btnLoss.className = 'btn';
		        btnFind.className = 'selected_btn';
		        $("#main_li").text("습득 목록");
		    }
	        
	        $("#map_type").val(maptype);
	        
	        var param = {"map_type":$("#map_type").val()};
	        $.ajax({
				type : "POST",
				url : "/test/testLossList.do",
				data : param,
				dataType : "json", // 받는 데이터 타입
				success : function(data) {
					// r = 리턴받는 json객체
					if (data.result == 'success') {
						fn_search_init();
						jsonLossData = eval(data.lossData);
						createCustomOverlay(jsonLossData);
					} else {
						alert("알수없는 오류가 발생하였습니다.");
					}
				}
			});
		}
		
		function fn_file(obj, index) {
			if (obj.files && obj.files[0]) {
				var file = obj.files[0];
				var fileName = "";
				fileName = $("#img_file").val();
				
				fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();

				if(fileName != "jpg" && fileName != "png" &&  fileName != "gif" &&  fileName != "bmp"){
					alert("이미지 파일은 (jpg, png, gif, bmp) 형식만 등록 가능합니다.");
					$("#img_file").val("");
					return;
				}

				var reader = new FileReader();
				reader.onload = function(event) {
					var img = new Image();
					img.src = event.target.result;
					
					img.width = 300;
					if (img.width > 300) { 
						img.width = 300;
					}
					$("#preimg").text('');
					$("#preimg").append(img);
				};
				reader.readAsDataURL(file);

				return false;
			}
		}
		
		function fn_insert() {
			if(fn_insert_check()){
				$("#insert_date").val($.datepicker.formatDate($.datepicker.ATOM, new Date()));
				$("#user_name").val(userInfo.displayName);
				$("#user_id").val(userInfo.uid);
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

		    if((lat > swLat) && (lat < neLat) && (lng > swLng) && (lng < neLng)){
		    	result = true;
		    }
		    return result;
		}
		
		function fn_insert_check(){
			if($("#title").val() == "" ||  $("#feature").val() == ""){
				alert("필수정보를 입력해주세요.");
				return false;
			}
			if($("#place").val() == ""){
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
			$("#chat_userName").val(jsonObject.user_name);
			$("#chat_userId").val(jsonObject.user_id);
			
			$("#chat").hide();
			$("#loss").hide();
			$("#find").hide();
			$("#main").hide();
			$("#login").hide();
			$("#chatList").hide();
			$("#detail").show();
			$("#map_click_check").val("false");
			
			$("#detail_title").val(jsonObject.title);
			$("#detail_date").val(jsonObject.date);
			$("#detail_place").val(jsonObject.place);
			$("#detail_feature").val(jsonObject.feature);
			
			if(typeof jsonObject.img_std === "undefined" || jsonObject.img_std == ""){
				$("#detail_img_label").hide();
			} else {
				$("#detail_img_label").show();
				$("#detail_img").attr("src","/images/find/"+jsonObject.img_std);
			}
			if(jsonObject.kind == ""){
				$("#detail_kind_label").hide();
			} else {
				$("#detail_kind_label").show();
				$("#detail_kind").val(jsonObject.kind);
				$("#detail_kind").attr("disabled","disabled");
			}
			if(jsonObject.kind_detail == ""){
				$("#detail_kind_label").hide();
			} else {
			    if(jsonObject.kind == "dog"){
			    	dogData = ${dogData};
			    	for(var i = 0; i < dogData.length; i++){
				    	if(dogData[i].dog_kind_num == jsonObject.kind_detail){
				    		$("#detail_kind_detail").val(dogData[i].dog_kind);
				    	}
				    }
			    } else if (jsonObject.kind == "cat"){
			    	catData = ${catData};
			    	for(var i = 0; i < catData.length; i++){
				    	if(catData[i].cat_kind_num == jsonObject.kind_detail){
				    		$("#detail_kind_detail").val(catData[i].cat_kind);
				    	}
				    }
			    } else {
			    	$("#detail_kind_detail").val(jsonObject.kind_detail);
			    }
				$("#detail_kind_label").show();
			}
			if(jsonObject.sex == ""){
				$("#detail_sex_label").hide();
			} else {
				$("#detail_sex_label").show();
				$("#detail_sex").val(jsonObject.sex);
				$("#detail_sex").attr("disabled","disabled");
			}
			if(jsonObject.age == ""){
				$("#detail_age_label").hide();
			} else {
				$("#detail_age_label").show();
				$("#detail_age").val(jsonObject.age);
			}
			if(jsonObject.place_detail == ""){
				$("#detail_place_detail_label").hide();
			} else {
				$("#detail_place_detail_label").show();
				$("#detail_place_detail").val(jsonObject.place_detail);
			}
			if(jsonObject.color == ""){
				$("#detail_color_label").hide();
			} else {
				$("#detail_color_label").show();
				$("#detail_color").val(jsonObject.color);
			}
			if(jsonObject.process == ""){
				$("#detail_process_label").hide();
			} else {
				$("#detail_process_label").show();
				$("#detail_process").val(jsonObject.process);
			}
			if(jsonObject.regis_num == ""){
				$("#detail_regis_num_label").hide();
			} else {
				$("#detail_regis_num_label").show();
				$("#detail_regis_num").val(jsonObject.regis_num);
			}
			if(jsonObject.rfid_cd == ""){
				$("#detail_rfid_cd_label").hide();
			} else {
				$("#detail_rfid_cd_label").show();
				$("#detail_rfid_cd").val(jsonObject.rfid_cd);
			}
		}
		
		function fn_open_login(){
			auth.signInWithPopup(authProvider);
			if(userInfo) {
				$("#login_span").text(userInfo.displayName + "님이 로그인 하셨습니다.  |  ");
				$("#logout_text").css("display","");
				$("#login_text").css("display","none");
			} else {
				$("#login_text").css("display","none");
				$("#logout_text").css("display","");
				$("#login_span").text("");
			}
		}
		
		function fn_open_logout(){
			firebase.auth().signOut().then(function() {
				console.log("logout");
				$("#login_text").css("display","");
				$("#logout_text").css("display","none");
				$("#login_span").text("");
			}, function(error) {
				console.log("logout error");
			});
		}
		
		
		//메인페이지 셀렉트 박스 관련 함수
		function fn_ajax_select(gubun){
			var kind = "";
			var param = "";
			var html = "";
			if(gubun == "main"){
				kind = $("#kind").val();
				if(kind != "all"){
					$("#sex").removeAttr("disabled");
					$("#kind_detail").removeAttr("disabled");
				} else {
					$("#sex").val("all");
					$("#sex").attr("disabled","disabled");
					$("#kind_detail").attr("disabled","disabled");
				}
				param = {"kind":$("#kind").val(),"sex":$("#sex").val()};
				html = "<option value='all'>전체</option>";
			} else if (gubun == "loss") {
				kind = $("#kind_data").val();
				param = {"kind":$("#kind_data").val()};
			} else {
				
			}
			if(kind != ""){
				$.ajax({
					type : "POST",
					url : "/test/testKindAjax.do",
					data : param, // 보내는 폼 데이터
					dataType : "json", // 받는 데이터 타입
					success : function(data) {
						// r = 리턴받는 json객체
						if (data.result == 'success') {
						    kindData = JSON.stringify(data.kindData);
							jsonKindData = eval(data.kindData);
						    
							for(var i = 0; i < jsonKindData.length ; i++){
								if(kind == "dog"){
									html += "<option value='"+jsonKindData[i].dog_kind_num+"'>"+jsonKindData[i].dog_kind+"</option>";	
								} else {
									html += "<option value='"+jsonKindData[i].cat_kind_num+"'>"+jsonKindData[i].cat_kind+"</option>";
								}
							}
							if(gubun == "main"){
								if(kind != "etc"){
									$("#kind_detail").html(html);	
								} else {
									$("#kind_detail").html("<option value=''>전체</option>");
								}
							} else if(gubun == "loss"){
								if(kind != "etc"){
									$("#kind_detail_data").html(html);	
								} else {
									$("#kind_detail_data").html("");
								}
								
																
							} else {
								
							}
						} else {
							alert("알수없는 오류가 발생하였습니다.");
						}
					}
				});
			} else {
				var html = "<option value=''>전체</option>";
				if(gubun == "main"){
					$("#kind_detail").html(html);
				} else if(gubun == "loss"){
					$("#kind_detail_data").html(html);								
				} else {
					
				}
			}
		}
		
		function fn_search_select(){
			var param = "";
			param = {"kind":$("#kind").val(),"sex":$("#sex").val(),"kind_detail":$("#kind_detail").val(),"map_type":$("#map_type").val()};
			$.ajax({
				type : "POST",
				url : "/test/testSearchAjax.do",
				data : param, // 보내는 폼 데이터
				dataType : "json", // 받는 데이터 타입
				success : function(data) {
					// r = 리턴받는 json객체
					if (data.result == 'success') {
						jsonData = eval(data.jsonData);
						console.log(jsonData);
						createCustomOverlay(jsonData);
					} else {
						alert("알수없는 오류가 발생하였습니다.");
					}
				}
			});
		}
		
		function fn_search_init(){
			$("#kind").val("all");
			$("#sex").val("all");
			$("#kind_detail").val("all");
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
				<span id="login_span"></span>
				<a href="javascript:void(0)" id="login_text" onclick="fn_open_login()">로그인</a> <!-- &nbsp&nbsp|&nbsp&nbsp   -->  
				<a href="javascript:void(0)" id="logout_text" onclick="fn_open_logout()" style="display:none" >로그아웃</a>
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
				<li class="header-menu"><a href="#" onclick="fn_chat_List()">채팅</a>
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
							<input type="hidden" id="map_type" name="map_type" value="loss"/>
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
								<li id="main_li">
									분실 목록
								</li>
								<li style="overflow: auto; display: flex; border-bottom: 1px solid #c3c3c3; height:75px; padding-top:8px" class="form-style-2"> 
									<label for="field2" style="margin-left:3px">
										종류
										<select id="kind" name="kind" class="select-field" onchange="fn_ajax_select('main')" style="height:30px">
											<option value="all">전체</option>
											<option value="dog">개</option>
											<option value="cat">고양이</option>
											<option value="etc">기타</option>
										</select>
									</label>
									<label for="field2" style="margin-left:3px">
										성별 
										<select id="sex" name="sex" class="select-field" onchange="fn_ajax_select('main')" style="height:30px" disabled="disabled">
											<option value="all">전체</option>
											<option value="male">수컷</option>
											<option value="female">암컷</option>
										</select>
									</label>
									<label for="field2" style="margin-left:3px">
										품종
										<select id="kind_detail" name="kind_detail" class="select-field" style="height:30px" disabled="disabled">
											<option value="all">전체</option>
										</select>
									</label>
									<label for="field2" style="margin-left:3px">
										<input class="insert-btn form-style-2" type="button" value="검색" style="margin-top:15px" onclick="fn_search_select()"/>
									</label>
								</li>
							</div>
							<div id="loss" style="height:100%; overflow-y:auto">
								<li id="loss_li">
									분실신고
								</li>
								<div class="form-style-2">
									<form id="dataForm" name="dataForm" enctype="multipart/form-data" method="post">
										<input type="hidden" id="lat" name="lat" value=""/>
										<input type="hidden" id="lng" name="lng" value=""/>
										<input type="hidden" id="user_id" name="user_id" value=""/>
										<input type="hidden" id="insert_date" name="insert_date" value=""/>
										<input type="hidden" id="user_name" name="user_name" value=""/>
										<input type="hidden" id="find_type" name="find_type" value="loss"/>
										<label for="field1">
											<span>제목 <span class="required">*</span></span><input type="text" class="input-field" id="title" name="title" value="" />
										</label>
										<label for="field2">
											<span>날짜</span>
											<div class="date-content">
												<input type="text" id="date" name="date" readonly="readonly" value="" class="loss-date statistics-date lost-field">
											</div>
										</label>
										<label for="field2">
											<span>성별</span>
											<select id="sex_data" name="sex_data" class="select-field">
												<option value="male">수컷</option>
												<option value="female">암컷</option>
											</select>
										</label>
										<label for="field2">
											<span>나이</span><input type="text" class="input-field" id="age" name="age" value="" />
										</label>
										<label for="field4">
											<span>품종</span>
											<select id="kind_data" name="kind_data" onchange="fn_ajax_select('loss')" class="select-field">
												<option value="dog">개</option>
												<option value="cat">고양이</option>
												<option value="etc">기타</option>
											</select>
											<select id="kind_detail_data" name="kind_detail_data" type="text" class="kind-field" value="" >
												
											</select>
										</label>
										<label for="field2">
											<span>장소 <span class="required">*</span></span><input type="text" class="input-field" id="place" name="place" value="" readonly="readonly"/>
										</label>
										<label for="field2">
											<span></span><input type="text" class="input-field" id="place_detail" name="place_detail" value="" />
										</label>
										<label for="field2">
											<span>색상</span><input type="text" class="input-field" id="color" name="color" value="" />
										</label>
										<label for="field5">
											<span>특징 <span class="required">*</span></span><textarea id="feature" name="feature" class="textarea-field"></textarea>
										</label>
										<label for="field2">
											<span>신고경위</span><input type="text" class="input-field" id="process" name="process" value="" />
										</label>
										<label for="field2">
											<span>등록번호</span><input type="text" class="input-field" id="regis_num" name="regis_num" value="" />
										</label>
										<label for="field2">
											<span>RFID_CD</span><input type="text" class="input-field" id="rfid_cd" name="rfid_cd" value="" />
										</label>
										<label for="field2">
											<span>사진</span>
											<input type="file" id="img_file" name="img_file" onchange="fn_file(this,'loss')" style="margin-top : 5px; margin-bottom : 5px"/>
											<div id="preimg" name="preimg"></div>
										</label>
										<label>
											<span>&nbsp;</span>
											<input class="insert-btn" type="button" id="insert" name="insert" onclick="fn_insert('loss')" value="등록" />
											<span>&nbsp;</span>
											<input class="calcel-btn" type="button" id="cancel" name="cancel" value="취소" />
										</label>
									</form>
								</div>
							</div>
							<div id="detail" style="height:100%; overflow-y:auto">
								<li>
									<span style="float:left; margin-left:10px; cursor:pointer;" onclick="fn_find_main()"><</span> 상세보기
								</li>
								<div class="form-style-2">
									<form id="dataForm" name="dataForm" method="post">
										<input type="hidden" id="chat_userName" value="" />
										<input type="hidden" id="chat_userId" value="" />
										<label for="field1" id="detail_title_label">
											<span>제목</span><input type="text" class="input-field" readonly="readonly" id="detail_title" name="detail_title" value="" />
										</label>
										<label for="field2" id="detail_date_label">
											<span>날짜</span><input type="text" id="detail_date" name="detail_date" readonly="readonly" value="" class="statistics-date lost-field">
										</label>
										<label for="field2" id="detail_sex_label">
											<span>성별</span>
											<select id="detail_sex" name="detail_sex" class="select-field">
												<option value="male">수컷</option>
												<option value="female">암컷</option>
											</select>
										</label>
										<label for="field2" id="detail_age_label">
											<span>나이</span><input type="text" class="input-field" id="detail_age" name="detail_age" readonly="readonly" value="" />
										</label>
										<label for="field4" id="detail_kind_label">
											<span>품종</span>
											<select id="detail_kind" name="detail_kind" class="select-field">
												<option value="dog">개</option>
												<option value="cat">고양이</option>
												<option value="etc">기타</option>
											</select>
											<input type="text" id="detail_kind_detail" name="detail_kind_detail" readonly="readonly" value="" class="kind-field">
										</label>
										<label for="field2" id="detail_place_label">
											<span>장소</span><input type="text" class="input-field" id="detail_place" name="detail_place" value="" readonly="readonly"/>
										</label>
										<label for="field2" id="detail_place_detail_label">
											<span></span><input type="text" class="input-field" id="detail_place_detail" readonly="readonly" name="detail_place_detail" value="" />
										</label>
										<label for="field2" id="detail_color_label">
											<span>색상</span><input type="text" class="input-field" readonly="readonly" id="detail_color" name="detail_color" value="" />
										</label>
										<label for="field5" id="detail_feature_label">
											<span>특징</span><textarea id="detail_feature" readonly="readonly" name="detail_feature" class="textarea-field"></textarea>
										</label>
										<label for="field2" id="detail_process_label">
											<span>신고경위</span><input type="text" class="input-field" readonly="readonly" id="detail_process" name="detail_process" value="" />
										</label>
										<label for="field2" id="detail_regis_num_label">
											<span>등록번호</span><input type="text" class="input-field" readonly="readonly" id="detail_regis_num" name="detail_regis_num" value="" />
										</label>
										<label for="field2" id="detail_rfid_cd_label">
											<span>RFID_CD</span><input type="text" class="input-field" readonly="readonly" id="detail_rfid_cd" name="detail_rfid_cd" value="" />
										</label>
										<label for="field2" id="detail_img_label">
											<span>사진</span>
											<img id="detail_img" name="detail_img" src="" width="300px" style="margin-top : 5px; margin-bottom : 5px"/>
										</label>
										<label>
											<span>&nbsp;</span>
											<span>&nbsp;</span>
											<input class="calcel-btn" type="button" id="find_chat" name="find_chat" onclick="fn_open_chat(null,null)" style="margin-left:50px" value="채팅" />
										</label>
									</form>
								</div>
							</div>
							<div id="chatList" style="height:100%; overflow-y:auto; display:flex; flex-direction:column">
								<li>
									채팅 목록
								</li>
								<div id="chatList_list" class="form-style-2" style="flex-direction: column; flex-grow:1; overflow: auto; padding:0">
									<div style="height:50px; display:flex; flex-direction: row; border-bottom : 1px solid #c3c3c3">
										<div style="display:flex; flex-grow:1; align-items: center;">	
											이름									
										</div>
										<div style="display:flex; flex-grow:4; text-align:center; align-items: center;">
											<span>내용</span>
										</div>
									</div>
								</div>
							</div>
							<div id="chat" style="height:100%; overflow-y:auto; display:flex; flex-direction:column">
								<li>
									USER ID
								</li>
								<div id="chat_list" class="form-style-2" style="flex-direction: column; flex-grow:1; overflow: auto;">
								</div>
								<div class="form-style-3" style="flex-basis:75px">
									<textarea id="chat_message" class="chat-field" ></textarea>
									<input type="button" id="chat_send" name="chat_send" onclick="fn_chat_send()" value="전송" />
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
		Copyright © <span style="font-weight: bold; color: #666;">AP Team</span> All rights reserved.
	</div>
</body>
</html>