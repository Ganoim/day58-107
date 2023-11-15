<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>영화예매프로젝트 - MOVIESPROJECT</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="${pageContext.request.contextPath }/resources/users/css/styles.css" rel="stylesheet" />
        
        <style type="text/css">
        	.selectList{
        		cursor: pointer;
        		border: 3px solid black;
        		border-radius: 5px;
        		margin-bottom: 3px;
        		margin-top: 3px;
        		padding: 3px;
        		
        		
        	}
        	.selectList:hover{
        		background-color: black;
        		color:white;
        	}
        	.selectObj{
        		background-color: black !important;
        		color:white;
        		font-weight: bold;
        	}
        	.selectArea{
        		height: 600px;
        		overflow: scroll;
        	}
        	.selMoviePoster{
        		max-width: 100%;
        		height: auto;
        		border-radius: 10px;
        	}
        	.unselectList{
        		cursor: pointer;
        		border-radius: 5px;
        		margin-bottom: 3px;
        		margin-top: 3px;
        		padding: 3px;
        		border: 1px solid lightgray;
        		color: lightgray;
        	}
        	.title{
        		border: 1px solid black;
        		text-align: center;
        		border-radius: 5px;
        		margin-bottom: 3px;
        		padding: 5px;
        	}
        	.selInfo{
        		font-weight: bold;
        	}
        	.selEl{
        		white-space: nowrap;
        		overflow: hidden;
        		text-overflow: ellipsis;
        	}
        	
        	.timeInfo{
        		width: 20%;
        		
        	}
        	.hallInfo{
        		
        	}
        	
        </style>
        
        
    </head>
    <body>
    	<!-- 메뉴 시작 -->
        <!-- Responsive navbar includes-->
        
        <%@include file="/WEB-INF/views/includes/menu.jsp" %>
        
        <!-- 메뉴 끝 -->
        
        <!-- Page header with logo and tagline-->
        <header class="py-5 bg-light border-bottom mb-4">
            <div class="container">
                <div class="text-center my-5">
                    <h1 class="fw-bolder">영화 예매 페이지</h1>
                    <p class="lead mb-0">영화, 극장, 날짜 선택 및 결제 페이지</p>
                </div>
            </div>
        </header>
        
        <!-- Page content-->
        <div class="container">
            
        <!-- 컨텐츠 시작 -->
        <div class="row">
        
        	<div class="col-lg-3 col-md-6 p-1">
        		<div class="card mb-4">
        		<div class="card-header text-center">영화</div>
        			<div class="card-body p-2 selectArea" id="movArea">
	        			<c:forEach items="${movList}" var="mv">
	        				<div class="selectList selEl" id="${mv.mvcode}" onclick="movieClick(this, '${mv.mvcode}', '${mv.mvposter }' )" tabindex="0">${mv.mvtitle}</div>
	        			</c:forEach>
        			</div>
        		</div>
        		
        	</div>
        	
        	
        	<div class="col-lg-3 col-md-6 p-1">
        		<div class="card mb-4">
        		<div class="card-header text-center">극장</div>
        			<div class="card-body p-2 selectArea" id="thArea">
        				<c:forEach items="${thList}" var="th">
	        				<div class="selectList selEl" id="${th.thcode }" onclick="theaterClick(this, '${th.thcode}')">${th.thname}</div>
	        			</c:forEach>
        			</div>
        		</div>        		
        	</div>
        	
        	
        	<div class="col-lg-2 col-md-6 p-1">
        		<div class="card mb-4">
        		<div class="card-header text-center">날짜</div>
        			<div class="card-body p-2" id="scArea">
        				
        			</div>
        		</div>
        	</div>
        	
        	<div class="col-lg-4 col-md-6 p-1">
        		<div class="card mb-4">
        		<div class="card-header text-center">시간</div>
        			<div class="card-body p-2" id="timeArea">
        				
        				
        			</div>
        		</div>
        	</div>
        	
        </div>
        	
        	<div class="row">
	        	<div class="col-lg-3 col-md-6">
	        		<div class="card mb-4">
	        			<div class="card-header text-center">선택영화</div>
	        			<div class="card-body p-2" style="text-align: center;">
	        				<p class="card-text m-1" id="selTitle">영화 제목</p>
	        				<img class="selMoviePoster" id="selPoster" src="" alt="">
	        			</div>
	        		</div>        		
	        	</div>
        		<div class="col-lg-6 col-md-6">
        			<div class="card md-4 h-100">
        			<div class="card-header text-center">선택극장</div>
        				<div class="card-body-p-2">
        					<div class="" id="selThname">
								<p class="p-2 m-1 w-100">극장 <span class="selInfo" id="selTheater">극장이름</span> </p>
								<p class="p-2 m-1 w-100">날짜 <span class="selInfo" id="selDate">스케줄</span><span class="selInfo" id="selTime"> 시간</span> </p>
								<p class="p-2 m-1 w-100">상영관 <span class="selInfo" id="selHall"></span> </p>
        					</div>
        				</div>
        			</div>
        		</div>
        		<div class="col-lg-3">
        			<div class="card md-4">
        				<div class="card-body p-2">
        					<button class="btn btn-danger w-100 h-100 p-5 reserveBtn" onclick="movieReserve()">예매하기</button>
        				</div>
        			</div>
        		</div>
				
        	</div>
        <!-- 컨텐츠 끝 -->
            
        </div>
        
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Your Website 2023</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        
        <!-- jQuery -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
        
        <script type="text/javascript">
        	function movieReserve() {
        		let loginCheck = '${sessionScope.loginId }';
        		if(loginCheck.length == 0){
        			alert('로그인 후 이용 가능합니다.')
        			location.href = "memberLoginForm";
        		} else if(reserve_mvcode ==  null){
					alert('영화를 선택해 주세요');
				} else if(reserve_thcode == null){
					alert('극장를 선택해 주세요');
				} else if(reserve_scdate == null){
					alert('날짜를 선택해 주세요');
				} else if(reserve_sctime == null || reserve_schall == null){ // reserve_schall == null
					alert('시간를 선택해 주세요');
				} else {
					console.log("예매처리 요청");
					
					regustReserveInfo();
					
				}
			}	
        	
        	
        	function reserveResult_success() {
				/* 예매 성공시 호출 */
				alert('예매 되었습니다.')
				location.href ="/";
			}
        	
        	
        	function kakaoPay_ready(recode) {
        		console.log("카카오페이 결제 준비");
        		$.ajax({
        			type : "post",
        			url : "kakaoPay_ready",
        			data : {'recode' : recode,
        					'mvcode' : reserve_mvcode, 
        					'thcode' : reserve_thcode, 
							'schall' : reserve_schall, 
							'scdate' : reserve_scdate+" "+reserve_sctime },
        			success : function(result) {
        				console.log(result);
						window.open(result, "pay", "width=400, height=600");
						
					}
        			
        		});
				
			}
        	
        	let reserveCode = null;
        	function regustReserveInfo() {
        		$.ajax({
					type : "post",
					url : "regustReserveInfo",
					data : {'mvcode' : reserve_mvcode, 'thcode' : reserve_thcode, 
							'schall' : reserve_schall, 'scdate' : reserve_scdate+" "+reserve_sctime },
					async : false,
					success : function(result) {
						console.log('예매처리 결과');
						if(result == 'login') {
							alert('로그인 후 이용해주세요.');
							location.href = "memberLoginForm";
						}
						else if(result.length > 0){
							console.log('예매 insert 성공');
							//1. 카카오페이API 결제준비요청
							kakaoPay_ready(result); // result = recode
							reserveCode  = result;
							
							
						} else {
							console.log('예매 insert 실패');
							alert('예매 처리에 실패하였습니다.');
						}
						
						
					}
				});
        		
			}
        	
        	function failReserve() {
        		alert('예매 처리에 실패하였습니다.');
    			$.ajax({
    				/* DELETE FROM RESERVE WHERE RECODE = ? */
    			})
        		location.reload();
			}
        	
        	
        </script>
        
        
        <script type="text/javascript">
        
        	let reserve_mvcode = null; // 선택한 영화 코드 저장
        	let reserve_thcode = null; // 선택한 극장 코드 저장
        	let reserve_scdate = null; // 선택한 날짜 = "2023-09-14"
        	let reserve_sctime = null; // 선택한 시간 = "12:00"
        	let reserve_schall = null; // 선택한 상영관 = "1관 2층"
        	
        	function resetSelectInfo(sel) {
				// 선택정보 초기화 
				// 페이지 : 시간, 상영관 초기화
				document.querySelector('#selTime').innerText = "";
				document.querySelector('#selHall').innerText = "";
				
				// 시간, 상영관 목록 초기화
				document.querySelector('#timeArea').innerHTML = "";
				
				// 변수 : reserve_cstime, reserve_schall 초기화
				let reserve_sctime = null;
        		let reserve_schall = null;
				
				if(sel){
					// 페이지 : 날짜 초기화
					document.querySelector('#selDate').innerText = "";
					
					// 변수 :reserve_scdate 초기화
					reserve_scdate = null;
				}
				
				
				switch(sel){
				case 'date':
					// 날짜를 클릭한 경우에 초기화 해줄 내용
					// 페이지 : 시간, 상영관 초기화
					// 변수 : reserve_cstime, reserve_schall 초기화
					
					break;
					
				case 'movie':	
				case 'theater':
					//영화, 극장응 클릭한 경우에 초기화 해줄내용
					// 페이지 : 시간, 상영관 초기화 + 날짜
					// 변수 : reserve_cstime, reserve_schall 초기화 + reserve_scdate
					
					break;
				}
				
			}
        	
        	
        	
        	function movieClick(selectMVObj, mvcode, mvposter) {
				console.log("movieClick() 호출");
				console.log(selectMVObj); // style 변경
				console.log("선택한 영화코드 : " + mvcode); // 극장 목록조회
				console.log("선택한 영화제목 : " + selectMVObj.innerText); // 선택항목 출력
				console.log("선택한 영화포스터 : " + mvposter); // 선택항목 출력
				
				if(selectMVObj.classList.contains('unselectList')){
					console.log('예매가 불가능한 영화선택');
					let reloadCheck = confirm('선택한 영화에 원하시는 극장이 없습니다. \n계속하시겠습니까?');
					if(reloadCheck){
						location.reload();
					}
				} else{
					//timeArea.innerHTML = "";  // 상영관, 시간출력 DIV초기화
					reserve_mvcode = mvcode; // 선택한 영화 코드 저장
					//선택정보 초기화 함수 호출
					resetSelectInfo(true);
					
					//1. 선택항목 출력
					document.querySelector('#selTitle').innerText = selectMVObj.innerText;
					document.querySelector('#selPoster').setAttribute('src', mvposter);
					
					//2. 선택항목 style 변경
					addSelectStyle(selectMVObj);
					
					//3. 선택한 영화를 예매를 할 수 있는 극장목록 조회
					let thList = getReserveTheaterList(mvcode);
					changeTheaterList(thList);
					//console.log(thList.length);
					
					//4. 영화 & 극장이 모두 선택이 되어 있으면 날짜 목록 조회 출력
					if((reserve_mvcode != null) && (reserve_thcode != null)){
						getReserveScheduleDateList();
						
					}
						
				}
			}
        	
        	function changeTheaterList(thList) {
				console.log("changeTheaterList() 호출");
				let thCodeList = [];
				for(let th of thList){
					thCodeList.push(th.thcode);
				}
				console.log(thCodeList);
				
				let theaterEls = document.querySelectorAll("#thArea>div.selEl");
				
				let thArea = document.querySelector('#thArea');
				
				for(let thEl of theaterEls){
					thEl.classList.remove('selectList');
					thEl.classList.remove('unselectList');
					
					if( thCodeList.includes(thEl.getAttribute('id')) ){
						// 예매 가능한 극장
						thEl.classList.add('selectList');
					} else{
						// 예매 불가능한 극장
						thEl.classList.add('unselectList');
						thArea.appendChild(thEl);
					}
					
				}
			}
        	
        	
        	function addSelectStyle(selObj) {
				console.log('addSelectStyle() 호출')
        		let movDivs = selObj.parentElement.querySelectorAll('div.selEl');
				for(let movEl of movDivs){
					movEl.classList.remove('selectObj');
				}
				selObj.classList.add('selectObj');
			}
        	
        	function getReserveTheaterList(selectMovieCode) {
				console.log("예매 가능한 극장 목록 조회")
				let thaeaterList = [];
				$.ajax({
					type : "get",
					url : "getTheaterList_json",
					data : {"selMvCode" : selectMovieCode},
					async : false,
					dataType : "json",
					success : function(result) {
						theaterList = result;
					}
				});
				return theaterList;
				
			}
        </script>
       
        <script type="text/javascript">
        	function theaterClick(selectTHObj, thcode) {
				console.log("theaterClick() 호출");
				console.log(selectTHObj);
				console.log("선택한 극장코드 : " + thcode);
				if(selectTHObj.classList.contains('unselectList')){
					console.log('예매가 불가능한 극장 선택')
					let reloadCheck = confirm('선택한 극장에 원하시는 상영스케줄이 없습니다. \n계속하시겠습니까?');
					if(reloadCheck){
						location.reload();
					}
				} else{
					//timeArea.innerHTML = "";  // 상영관, 시간출력 DIV초기화
					
					resetSelectInfo(true);
					
					reserve_thcode = thcode;
					console.log('예매가 가능한 극장 선택');
					//1. 선택 항목 출력
					document.querySelector('#selTheater').innerText = selectTHObj.innerText;
					
					//2. 선택 항목 style 변경
					addSelectStyle(selectTHObj);
					
					//3. 선택한 극장에서 예매할 수 있는 영화 목록 조회
					let mvList = getReserveMovieList(thcode)
					changeMovieList(mvList);
					//4. 영화 & 극장이 모두 선택이 되어 있으면 날짜 목록 조회 출력
					if((reserve_mvcode != null) && (reserve_thcode != null)){
						getReserveScheduleDateList();
					}
				}
				
			}
        	
        </script>
		       
        <script type="text/javascript">
        	function getReserveMovieList(selectThCode) {
				console.log("예매가능한 영화목록 조회");
				//console.log("선택한 극장코드 : " + selectThCode);
				let movieList = [];
				$.ajax({
					type : 'get',
					url : 'getMovieList_json',
					data : {'selThCode' : selectThCode},
					async : false,
					dataType : 'json',
					success : function(result) {
						movieList = result;
					}
				});
				return movieList;
			}
        	
        	function changeMovieList(mvList) {
				console.log("changeMovieList() 호출");
				let mvCodeList = [];
				for(let mv of mvList){
					mvCodeList.push(mv.mvcode);
				}
				
				let movieEls = document.querySelectorAll('#movArea>div.selEl');
				
				let movArea = document.querySelector('#movArea');
				
				for(let mvEl of movieEls){
					mvEl.classList.remove('selectList');
					mvEl.classList.remove('unselectList');
					
					if(mvCodeList.includes(mvEl.getAttribute('id'))){
						// 예매가 가능한 영화
						mvEl.classList.add('selectList');
					}else{
						// 예매가 불가능한 영화
						mvEl.classList.add('unselectList');
						movArea.appendChild(mvEl);
					}
					
				}
        		
			}
        </script>
       
        <script type="text/javascript">
        	function getReserveScheduleDateList() {
				console.log('예매가능한 날짜목록 조회 요청');
				console.log('선택한 영화코드 : ' + reserve_mvcode);
				console.log('선택한 극장코드 : ' + reserve_thcode);
				//document.querySelector('#scArea').innerText = "";
				$.ajax({
					type : 'get',
					url : 'getSchduleDateList_json',
					data : {'mvcode' : reserve_mvcode, 'thcode' : reserve_thcode},
					async : false,
					dataType : 'json',
					success : function(result) {
						console.log(result);
						printScheduleDate(result);
						
					}
				});
				
			}
        	
        	function printScheduleDate(scDateList) {
				console.log('printScheduleDate() 호출');
				
				let scArea_div = document.querySelector('#scArea'); // 날짜출력 div
				scArea_div.innerHTML = ""; 
				let nowMM = null; // 월 출력
				for(let sc of scDateList){ // [2023-09-14, 2023-09-13]
					let dateArr = sc.scdate.split("-");
					if(nowMM != dateArr[1]){ // 몇월인지 출력
						nowMM = dateArr[1];
						let mmdiv = document.createElement('div');
						mmdiv.innerText = dateArr[1]+"월";
						mmdiv.classList.add('text-center');						
						scArea_div.appendChild(mmdiv);
					}
					let datediv = document.createElement('div')
					datediv.classList.add('selectList');
					datediv.classList.add('selEl');
					datediv.classList.add('text-center');
					datediv.innerText = dateArr[2]+"일";
					datediv.addEventListener('click', function(e) {
						console.log("날짜선택 : " + sc.scdate);
						//1. 선택항목 Style 변경
						addSelectStyle(e.target);
						//2. 선택항목 출력
						document.querySelector('#selDate').innerText = dateArr[1]+"월 "+dateArr[2]+"일";
						//3. SCHALL(상영관), SCDATE(시간) [ [1관, 12:00] ]
						//WHERE : 선택 영화코드, 선택 극장코드, 선택 날짜
						let scTimeList = getReserverScheduleTimeList(reserve_mvcode, reserve_thcode, sc.scdate);
						reserve_scdate = sc.scdate;
						
					})
					scArea_div.appendChild(datediv);
					
				}
				
			}
        	
        	function getReserverScheduleTimeList(mvcode, thcode, scdate) {
				console.log("scTimeList - 상영관");
				console.log(mvcode);
				console.log(thcode);
				console.log(scdate);
				resetSelectInfo(false);
				
				$.ajax({
					type : 'get',
					url : 'getTimeList_json',
					data : { 'mvcode' : mvcode, 'thcode' : thcode, 'scdate' : scdate },
					async : false,
					dataType : 'json',
					success : function(result) {
						console.log(result);
						pringScheduleTime(result);
					}
				});
				
			}
        	
			let timeArea = document.querySelector('#timeArea');
        	function pringScheduleTime(scList) {
				timeArea.innerHTML = "";  // 상영관, 시간출력 DIV초기화
				let nowHall = null;
				for(let sc of scList){
					// 상영관출력
					if(nowHall != sc.schall){
						if(nowHall != null){ // 상영관 구분선
							let hrEl = document.createElement('hr');
							timeArea.appendChild(hrEl);
						}
						
						 nowHall = sc.schall;
						 let hallDiv = document.createElement('div');
						 hallDiv.classList.add('hallInfo');
						 hallDiv.classList.add('selEl');
						 hallDiv.innerText = sc.schall;
						 timeArea.appendChild(hallDiv);
					}
					// 시간출력
					let timeDiv = document.createElement('div');
					timeDiv.classList.add('selectList');
					timeDiv.classList.add('selEl');
					timeDiv.classList.add('text-center');
					timeDiv.classList.add('mx-1');
					timeDiv.classList.add('p-1');
					timeDiv.classList.add('timeInfo');
					timeDiv.innerText = sc.scdate;
					timeDiv.addEventListener('click', function(e) {
						
						// 선택항목 Style
						addSelectStyle(e.target);
						
						//선택 항목출력
						document.querySelector('#selTime').innerText = sc.scdate;
						document.querySelector('#selHall').innerText = sc.schall;
						
						reserve_sctime = sc.scdate;
						reserve_schall = sc.schall;
					})
					timeArea.appendChild(timeDiv)
				}
        		
			}
        	
        </script>
        
        <c:if test="${param.mvcode != null}">
        <script type="text/javascript">
        	document.querySelector("#${param.mvcode}").click();
        	document.querySelector("#${param.mvcode}").focus();
        </script>
        </c:if>
        
        
        
        
        
        
        
        
        
        
        
         
    </body>
</html>

