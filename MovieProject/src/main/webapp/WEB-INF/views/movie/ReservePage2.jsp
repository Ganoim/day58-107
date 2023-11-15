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
        		border: 1px solid black;
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
        		max-width: 50%;
        		height: auto;
        		border-radius: 10px;
        	}
        	.btn-danger{
        		
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
        			<div class="card-body p-2 selectArea" id="movArea">
	        			
        			</div>
        		</div>
        		
        	</div>
        	
        	
        	<div class="col-lg-3 col-md-6 p-1">
        		<div class="card mb-4">
        			<div class="card-body p-2 selectArea" id="thArea">
        				
        			</div>
        		</div>        		
        	</div>
        	
        	
        	<div class="col-lg-2 col-md-6 p-1">
        		<div class="card mb-4">
        			<div class="card-body p-2">
        				<div>날짜1</div>
        				
        			</div>
        		</div>
        	</div>
        	
        	<div class="col-lg-4 col-md-6 p-1">
        		<div class="card mb-4">
        			<div class="card-body p-2">
        				상영관 및 시간1
        				
        			</div>
        		</div>
        	</div>
        	
        </div>
        	
        	<div class="row">
	        	<div class="col-lg-3 col-md-6 p-1">
	        		<div class="card mb-4">
	        			<div class="card-body p-2" style="text-align: center;">
	        				<p class="card-text m-1" id="selTitle">영화 제목</p>
	        				<img class="selMoviePoster" id="selPoster" src="" alt="">
	        			</div>
	        		</div>        		
	        	</div>
        		<div class="col-lg-6 col-md-6">
        			<div class="card md-4 h-100">
        				<div class="card-body-p-2">
        					<div class="" id="selThname">
        					</div>
        				</div>
        			</div>
        		</div>
        		<div class="col-lg-3">
        			<div class="card md-4">
        				<div class="card-body p-2">
        					<button class="btn btn-danger w-100 p-5">예매하기</button>
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
        	$(document).ready(function() {
				//1. 예매 가능한 영화목록 조회 - json
				//let mvList = getReserveMovieList();
				
				//2. 예매 가능한 극장목록 조회 - json
				//printMovieList(mvList); 
				printMovieList(getReserveMovieList('ALL')); // 1,2 한번에 처리
				
				//3. 영화목록 출력
				//let thList = getReserveTheaterList('ALL');
				
				//4. 극장목록 출력
				//printTheaterList(thList);
				printTheaterList(getReserveTheaterList('ALL')); // 3,4
			});	
        
        </script>
        
        <script type="text/javascript">
        	function getReserveMovieList(selectTheaterCode) {
				console.log("예매 가능한 영화목록 조회");
				let movieList = '';
				$.ajax({
					type : 'get',
					url : 'getMovieList_json',
					data : {'selThCode' : selectTheaterCode},
					dataType : 'json',
					async : false,
					success : function(result) {
						console.log("영화목록_json");
						console.log(result);
						movieList = result;
					}
				});
				console.log(movieList)
				return movieList;
			}
        	
        	let reserve_mvcode = null; // 선택한 영화 코드를 저장할 변수
        	let reserve_thcode = null; // 선택한 극장 코드를 저장할 변수
        	
        	function printMovieList(movList) {
				console.log('영화목록 출력')
				let movArea_div = document.querySelector('#movArea');
				movArea_div.innerHTML ="";
				for(let mvinfo of movList){
					let mv_div = document.createElement('div');
					mv_div.innerText = mvinfo.mvtitle;
					mv_div.classList.add('selectList');
					mv_div.classList.add('selEl');
					mv_div.addEventListener('click', function(e) {
						reserve_mvcode = mvinfo.mvcode;
						// 영화목록에 모든 영화에 강조 style(.selectObj) 제거
						removeSelectStyle('movArea');
						
						// 선택된 영화 강조 style 추가
						mv_div.classList.add('selectObj');
						
						console.log('선택영화코드 : ' + mvinfo.mvcode);
						console.log('선택영화제목 : ' + mvinfo.mvtitle);
						console.log('선택영화포스터 : ' + mvinfo.mvposter);
						document.querySelector('#selTitle').innerText = mvinfo.mvtitle;
						document.querySelector('#selPoster').setAttribute('src', mvinfo.mvposter);
						
						if(reserve_thcode == null){
							//1. 극장목록 조회 및 출력(영화코드)
							let thList = getReserveTheaterList(mvinfo.mvcode);
							printTheaterList(thList);
							
						}
						
						
					})
					movArea_div.appendChild(mv_div);
				}
			}
        	
        	function removeSelectStyle(areaId) {
        		// '#movArea>.selEl'
				let aredDiv = document.querySelectorAll('#'+areaId+">.selEl");
				for(let el of aredDiv){
					el.classList.remove('selectObj')
				}
				
				
			}
        	
        	function getReserveTheaterList(selectMovieCode) {
				console.log("예매 가능한 극장목록 조회 요청");
				let theaterList = [];
				$.ajax({
					type : 'get',
					url : "getTheaterList_json",
					data : {'selMvcode' : selectMovieCode },
					dataType : 'json',
					async : false,
					success : function(result) {
						theaterList = result;
					}
				});
				
				return theaterList;
			}
        	
        	function printTheaterList(thList) {
				console.log("극장 목록 출력");
				let thArea_div = document.querySelector('#thArea');
				thArea_div.innerHTML ="";
				for(let thinfo of thList){
					let th_div = document.createElement('div');
					th_div.innerText = thinfo.thname;
					th_div.setAttribute('id',thinfo.thinfo);
					th_div.classList.add('selectList');
					th_div.classList.add('selEl');
					th_div.addEventListener('click', function(e) {
						reserve_thcode = thinfo.thcode;
						// 영화목록에 모든 영화에 강조 style(.selectObj) 제거
						removeSelectStyle('thArea');
						// 선택된 영화 강조 style 추가
						th_div.classList.add('selectObj');
						// 영화 목록 조회
						if(reserve_mvcode == null){
							console.log('영화 목록 조회')
							let movList = getReserveMovieList(thinfo.thcode);
							printMovieList(movList);
						}
						
					})
					
					thArea_div.appendChild(th_div);
				}
			}
        	
        	
        </script>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        <script type="text/javascript">
        	let movAreaEl = document.querySelectorAll('#movArea div.selectList');
        	console.log(movAreaEl);
        	
        	for (let movEl of movAreaEl) {
				movEl.addEventListener('click', function(e) {
					console.log(e.target.innerText);
				})
			}
        </script>
        
        
    </body>
</html>

