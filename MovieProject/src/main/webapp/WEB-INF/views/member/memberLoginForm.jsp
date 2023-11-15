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
			.card-title{
			    margin:4px;
			    width: 458px;
			    height: 400px;
			    padding:40px;
			    background-color: floralwhite;
			    border : 1px solid lightgray; 
			}
			.card-title > h1{
			    color : plum;
			    font-weight: bold;
			}
			#login-form> #id,#password{
			    width: 100%;
			    height: 48px;
			    padding : 0 20px;
			    margin-bottom: 5px;
			    background-color: lightgray;
			    border : 1px solid lightgray; 
			    border-radius: 12px;
			}
			#login-form> #check{
			    margin-top: 10px;
			    font-size: 10px;
			}
			#login-form> #btn{
			    width:100%;
			    height: 48px;
			    background-color: plum;
			    border : 1px solid plum; 
			    border-radius: 12px;
			    margin-top:20px;
			}
			#kakao_btn{
			    width:100%;
			    height: 48px;
			    background-color: #ffeb01;
			    border : 1px solid #ffeb01; 
			    border-radius: 12px;
			    margin-top:2px;
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
                    <h1 class="fw-bolder">로그인 페이지</h1>
                    <p class="lead mb-0">로그인을 위한 아이디, 비밀버호를 입력</p>
                </div>
            </div>
        </header>
        
        <!-- Page content-->
        <div class="container">
            
        <!-- 컨텐츠 시작 -->
        <div class="card mb-4 mx-auto" style="width: 500px;">
        	<div class="card-body">
        		
        		<div class="card-title">
        			<h1>Login</h1>
        			
	        		<form id="login-form" action="${pageContext.request.contextPath }/memberLogin" method="post" onsubmit="return formCheck(this)">
	        			<input type="text" id="id" name="mid" placeholder="id">
	        			<input type="text" id="password" name="mpw" placeholder="password">
	        			<input type="checkbox" id="check">아이디 저장
	        			<input type="submit" id="btn" value="로그인">
	        		</form>
	        			<button onclick="memberLogin_kakao()" id="kakao_btn">카카오 로그인</button>
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
        	function formCheck(formObj) {
				console.log("formCheck() 호출");
				// 아이디가 입력되지 않았으면 false;
				let inputId = formObj.mid;
				if(inputId.value.length == 0){
					alert('아이디를 입력 해주세요');
					inputId.focus();
					return false;
				}
				// 비밀번호가 입력되지 않았으면
				let inputPw = formObj.mpw;
				if(inputPw.value.length == 0){
					alert('비밀번호를 입력 해주세요');
					inputPw.focus();
					return false;
				}
        		
				
			}	
        </script>
        
        
        
        
        
        <!-- 카카오 로그인 JS -->
        <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js" integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh" crossorigin="anonymous"></script>
        <script type="text/javascript">
	        Kakao.init('2809cd9eeb3b40bf96021d4e1526d1ef');
	        Kakao.isInitialized();
        </script>
        
        <script type="text/javascript">
        	function memberLogin_kakao() {
				console.log('카카오 로그인 호출()');
				Kakao.Auth.authorize({
					redirectUri: 'http://localhost:8080/memberLoginForm'
				});
			}
				
        	let authCode = '${param.code}';
        	console.log("authCode : " + authCode);
        	
        	if(authCode.length > 0){
        		console.log("카카오_인가코드 있음");
        		console.log("인증토큰 요청");
        		$.ajax({
        			type : 'post',
        			url : 'https://kauth.kakao.com/oauth/token',
        			contentType : 'application/x-www-form-urlencoded;charset=utf-8',
        			data : { 'grant_type' : 'authorization_code', 
        					 'client_id' : 'd3ae2fd7abcbe9b523f4626d1158d4e1',
        					 'redirect_uri' : 'http://localhost:8080/memberLoginForm',
        					 'code' : authCode
        				   },
        			success : function(response) {
        				console.log("인증토큰" + response.access_token);
        				Kakao.Auth.setAccessToken(response.access_token);
        				
        				Kakao.API.request({
        					  url: '/v2/user/me',
        					})
        					  .then(function(response) {
        						console.log("카카오 계정 정보")
        						console.log(response)
        						console.log("id : " + response.id);
        						console.log("email : " + response.kakao_account.email);
        						console.log("nickname : " + response.properties.nickname);
        						console.log("profile_image : " + response.properties.profile_image);
								
        						/* ajax 카카오계정 정보가 members 테이블에서 select */
        						$.ajax({
        							type : 'get',
        							url : 'memberLogin_kakao',
        							data : { 'id' : response.id },
        							success : function(checkMember_kakao) {
										if(checkMember_kakao == 'Y'){
											alert('로그인 되었습니다');
											location.href="/";
										} else{
											let check = confirm('가입된 정보가 없습니다\n 카카오 계정으로 가입하시겠습니까?')
											if(check){
												console.log("카카오 회원가입 기능 호출");
												memberJoin_kakao(response);
												
											}
										}
        								
									}
        						});

        						
        					  })
        					  .catch(function(error) {
        					    console.log(error);
        					  });
        				
					}
        				   
        		});
        		
        	}
		
        </script>
        
        <script type="text/javascript">
        	function memberJoin_kakao(res) {
        		console.log('memberJoin_kakao()')
        		$.ajax({
        			type : 'get',
        			url : 'memberJoin_kakao',
        			data : { 'mid' : res.id, 
        					 'mname' : res.properties.nickname,
        					 'memail' : res.kakao_account.email,
        					 'mprofile' : res.properties.profile_image 
        			},
        			success : function(joinResult) {
						alert('카카오 계정으로 회원가입되었습니다.\n다시 로그인 해주세요.')
						location.href = '/memberLoginForm';
					}
        		});
				
			}	
        </script>
        
        
        
    </body>

</html>

