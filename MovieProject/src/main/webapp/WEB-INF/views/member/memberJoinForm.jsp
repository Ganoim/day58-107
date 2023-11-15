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
        	
        	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700&display=swap');

			*{
			  box-sizing: border-box; /*전체에 박스사이징*/
			  outline: none; /*focus 했을때 테두리 나오게 */
			}
			
			body{
			    font-family: 'Noto Sans KR', sans-serif;
			    font-size:14px;
			    background-color: #f5f6f7;
			    line-height: 1.5em;
			    color : #222;
			    margin: 0;
			}
			
			a{
			  text-decoration: none;
			  color: #222;
			}
			
			/*member sign in*/
			.member{
			    width: 400px;
			    /* border: 1px solid #000; */
			    margin: auto; /*중앙 정렬*/
			    padding: 0 20px;
			    margin-bottom: 20px;
			}
			
			.member .field{
			    margin :5px 0; /*상하로 좀 띄워주기*/
			}
			
			.member b{
			    /* border: 1px solid #000; */
			    display: block; /*수직 정렬하기 */
			    margin-bottom: 5px;
			}
			
			/*input 중 radio 는 width 가 100%면 안되니까 */
			.member input:not(input[type=radio]),.member select{
			    border: 1px solid #dadada;
			    padding: 15px;
			    width: 100%;
			    margin-bottom: 5px;
			}
			
			.member input[type=button],
			.member input[type=submit]{
			background-color: #2db400;
			color:#fff
			}
			
			.member input:focus, .member select:focus{
			    border: 1px solid #2db400;
			}
						
			.userpw{
			    background:url(./images/images2/icon-01.png) no-repeat center right 15px;
			    background-size: 20px;
			    background-color: #fff;
			}
			
			.userpw-confirm{
			    background:url(./images/images2/icon-02.png) no-repeat center right 15px;
			    background-size: 20px;
			    background-color: #fff;
			}
			
			.member-footer div a:last-child:after{
			    display: none;
			}
			
			@media (max-width:768px) {
			    .member{
			        width: 100%;
			    }
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
                    <h1 class="fw-bolder">회원가입 페이지</h1>
                    <p class="lead mb-0">회원가입을 위한 정보 입력</p>
                </div>
            </div>
        </header>
        
        <!-- Page content-->
        <div class="container">
            
        <!-- 컨텐츠 시작 -->
        
        
        
        <div class="member">
        	<form action="${pageContext.request.contextPath }/memberJoin" method="post" enctype="multipart/form-data" onsubmit="return joinFormCheck(this)">
		        <h1 style="text-align: center;">회원가입</h1>
		
		        <!-- 필드 -->
		        <div class="field">
		            <b>아이디</b>
		           <input type="text" name="mid inputId" id="inputId" <%-- onkeyup="idCheck(this)" --%> >
		           <button type="button" onclick="idCheck(this)">중복확인</button>  <span id="idMsg"></span>
		        </div>
		        
		        
		        <div class="field">
		            <b>비밀번호</b>
		            <input class="userpw" name="mpw" type="text">
		        </div>
		        
		        <div class="field">
		            <b>이름</b>
		            <input type="text" name="mname">
		        </div>
		
		        <!-- 이메일 -->
		        		<b>이메일</b>
		        		<input type="text" name="memailId" placeholder="이메일 아이디">
						@
						<input type="text" id="eDomain" name="memailDomain" placeholder="이메일 도메인">
						<select onchange="selectDomain(this)">
							<option value="">직접입력</option>
							<option value="naver.com">네이버</option>
							<option value="daum.net">다음</option>
							<option value="google.com">구글</option>
						</select>
		        
		        <div class="field porfile">
		            <b>프로필</b>
		            <div>
		                <input type="file" name="mfile" placeholder="첨부파일">
		            </div>
		        </div>
		
		        <!-- 6. 가입하기 버튼 -->
		        <input type="submit" value="가입하기">

        	</form>
        	
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
        	function joinFormCheck(formObj) {
				let inputId = formObj.mid;
				if(inputId.value.length == 0){
					alert('아이디를 입력해주세요!');
					inputId.focus();
					return false;
				}
				
				if(!idChecked){
					alert('아이디를 중복확인 해주세요!');
					inputId.focus();
					return false;
				}
				
				let inputPw = formObj.mpw;
				if(inputPw.value.length == 0){
					alert('비밀번호를 입력해주세요!');
					inputPw.focus();
					return false;
				}
				let inputName = formObj.mname;
				if(inputName.value.length == 0){
					alert('이름를 입력해주세요!');
					inputName.focus();
					return false;
				}
        		
			}
        </script>
        
        <script type="text/javascript">
        	let idChecked = false; // 아이디 중복학인 
        	
        	function idCheck(inputObj) {
        		let idEl = document.querySelector('#inputId');
				let msgEl = document.querySelector('#idMsg');
				$.ajax({
					type : "get",
					url : "memberIdCheck",
					data : { "inputId" : idEl.value },
					success : function(checkResult){
						console.log(checkResult);
						if (checkResult.length > 0) { //(checkResult == 'Y')
							console.log("중복된 아이디 입니다.");
							msgEl.innerText = "중복된 아이디 입니다.";
							msgEl.style.color = "red";
							idChecked = false;
						} else {
							console.log('사용 가능한 아이디 입니다.');
							msgEl.innerText = "사용 가능한 아이디 입니다..";
							msgEl.style.color = "green";
							idChecked = true;
						}
					}
					
				})
        		
			}
        </script>
        
        
        
        
    </body>
    
    <script type="text/javascript">
		function selectDomain(selObj){
			document.getElementById('eDomain').value = selObj.value;
		}
	</script>
	
</html>

