<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>메인 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	
	<style type="text/css">
		.sttnBtn{
			width: 120px;
			margin: 3px;
			display: inline-block;
			
		}
	
		th, td {
			padding-top: 7px;
			padding-bottom: 7px;
			width: 150px;
			text-align: center;
		}

		table {
			border: 2px solid #dfdfdf;
		}

		td {
			border-bottom: 2px solid black;
			border-top: 2px solid black;
			width: 160px;
			text-align: center;
		}
		
	</style>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2809cd9eeb3b40bf96021d4e1526d1ef"></script>
	
	</head>
	
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>버스도착정보 - views/BusArriveInfo.jsp</h1>
			</div>
			
			<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
			
			<div class="contents">
				<h2>컨텐츠 영역</h2>
				
				
				<div id="map" style="width:500px;height:400px;"></div>
				
				<hr>
				
				<div id="busSttnArea" style="text-align: center;">
				</div>
				
				<hr>
				
				<div id="busInfoArea">
				</div>
				
				<hr>
				
				<div id="busNodeList">
					
				</div>
			
			</div>
			
		</div>
		
	</body>
	
	
	<script type="text/javascript">
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(37.4387, 126.6750), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};
	
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	</script>
	
	<script type="text/javascript">
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.4387, 126.6750), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
		
	
		var map = new kakao.maps.Map(mapContainer, mapOption);
	
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng;
	    
	    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
	    message += '경도는 ' + latlng.getLng() + ' 입니다';
	    
	    console.log(message);
	    getBusSttnBtn(latlng.getLat(), latlng.getLng());
	    
		});
		
	</script>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<!-- 버스 도착정보 -->
	<script type="text/javascript">
		function getBusArrInfo(nodeId, routeno) {
			console.log("nodeId : " + nodeId);
			console.log("routeno : " + routeno);
			//1. 도착정보 조회 ajax
			$.ajax({
				type : "get",
				url : "getBusArr",
				data : {"nodeId" : nodeId, "routeno" : routeno},
				dataType : "json",
				success : function(arrInfoList){
					//버스 도착정보 출력 기능 호출
					printBusArrInfo(arrInfoList);
					
				}
			});
		}
	
	</script>
	
	<script type="text/javascript">
		function printBusArrInfo(arrInfoList) {
			console.log("버스 도착정보 출력 기능 호출"); 
			console.log(arrInfoList);
			// <div id="busInfoArea"></div>
			let busInfoArea_div = document.querySelector("#busInfoArea");
			busInfoArea_div.innerHTML = "";
			
			let tableTag = document.createElement('table'); //<table></table>

			let trTag = document.createElement('tr'); //<tr></tr>

			let thTag1 = document.createElement('th'); //<th></th>
			thTag1.innerText = "번호"; //<th>번호</th>
			trTag.appendChild(thTag1); //<tr> <th>번호</th> </tr>
			
			let thTag2 = document.createElement('th'); //<th></th>
			thTag2.innerText = "남은정류장"; //<th>남은정류장</th>
			trTag.appendChild(thTag2); //<tr> <th>번호</th> <th>남은정류장</th> </tr>
			
			let thTag3 = document.createElement('th'); //<th></th>
			thTag3.innerText = "도착예정시간"; //<th>도착예정시간</th>
			trTag.appendChild(thTag3); //<tr> <th>번호</th> <th>남은정류장</th> <th>도착예정시간</th> </tr>
			
			tableTag.appendChild(trTag);
			console.log(tableTag);
			
			busInfoArea_div.appendChild(tableTag);
			
			for(let info of arrInfoList) {
				let infoTrTag = document.createElement('tr'); //<tr></tr>
				
				let tdTag_routeno = document.createElement('td'); //<td></td>
				
				tdTag_routeno.setAttribute("onclick", "getBusGpsInfo('"+info.routeid+"')");
				
				tdTag_routeno.innerText = info.routeno;
				infoTrTag.appendChild(tdTag_routeno);
				
				let tdTag_cnt = document.createElement('td');
				tdTag_cnt.innerText = info.arrprevstationcnt+"번째전";
				infoTrTag.appendChild(tdTag_cnt);
				
				let tdTag_arrtime = document.createElement('td');
				tdTag_arrtime.innerText = info.arrtime+"초 후 도착예정";
				infoTrTag.appendChild(tdTag_arrtime);
				
				busInfoArea_div.appendChild(infoTrTag);
				
			}
			
			
		}
	</script>
	
	
	<script type="text/javascript">
		$(document).ready(function(){
			getBusSttnBtn(37.4387, 126.6750);
			
		});	
		
		function getBusSttnBtn(lati, longti) {
			$.ajax({
				type : "get",
				url : "getBusSttn",
				data : {"lati" : lati, "longti" : longti },
				dataType : "json",
				success : function(sttnList){
					// 국토교통부_(TAGO)_버스정류소정보 - 좌표기반근접정류소 목록조회
					printBusSttnInfo(sttnList);
					
				}
			});
			
		}
	
	</script>
	
	<script type="text/javascript">
		function printBusSttnInfo(sttnList) {
			let btn_div = document.querySelector("#busSttnArea");
			btn_div.innerHTML = "";
			
			let idx = 0;
			for (let sttn of sttnList) {
				let sttnBtn = document.createElement('button');
				sttnBtn.classList.add('sttnBtn'); //<button class="sttnBtn">  
				sttnBtn.setAttribute("onclick", "getBusArrInfo('"+sttn.nodeid+"')");
				//<button class="sttnBtn" onclick="getBusArrInfo('ICB00000')"> 속성="값"
				
				sttnBtn.innerHTML = sttn.nodeno+"<br>"+sttn.nodenm;
				//<button class="sttnBtn" onclick="getBusArrInfo('ICB00000')">
				// 30000<br>영남아파트 (br = 줄바꿈)
				btn_div.appendChild(sttnBtn);
				idx++;
				if (idx % 5 == 0) {
					let br = document.querySelector('br');
					btn_div.appendChild(br);
				}
				
			}
			
			
		}
	</script>
	
	
	<script type="text/javascript">
		function getBusGpsInfo(routeid) {
			console.log("routeId : " + routeid);
			
			$.ajax({
				type : "get",
				url : "getBusGps",
				data : { "routeid" : routeid },
				dataType : "json",
				success : function(busbus){
					busNode(busbus);
					
				}
			});
		}
	</script> 
	
	<script type="text/javascript">
		function busNode(busbus) {
			
			
			let busNodeList_div = document.querySelector("#busNodeList");
			busNodeList_div.innerHTML = "";
			
			let tbTag = document.createElement('table');

			let trTag = document.createElement('tr');

			let thTag1 = document.createElement('th');
			thTag1.innerText = "번호";
			trTag.appendChild(thTag1);
			
			let thTag2 = document.createElement('th');
			thTag2.innerText = "현재정류장";
			trTag.appendChild(thTag2);
			
			let thTag3 = document.createElement('th');
			thTag3.innerText = "차량번호"; 
			trTag.appendChild(thTag3);
			
			tbTag.appendChild(trTag);
			
			busNodeList_div.appendChild(tbTag);
			
			for(let list of busbus) {
				let infoTrTag = document.createElement('tr');
				
				let tdTag_routenm = document.createElement('td');
				tdTag_routenm.innerText = list.routenm;
				infoTrTag.appendChild(tdTag_routenm);
				
				let tdTag_nodenm = document.createElement('td');
				tdTag_nodenm.innerText = list.nodenm;
				infoTrTag.appendChild(tdTag_nodenm);
				
				let tdTag_vehicleno = document.createElement('td');
				tdTag_vehicleno.innerText = list.vehicleno;
				infoTrTag.appendChild(tdTag_vehicleno);
				
				busNodeList_div.appendChild(infoTrTag);
				
			}
			
		}	
	</script>
	
	
	
</html>