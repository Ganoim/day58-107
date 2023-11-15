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
			    height: 500px;
			    padding:40px;
			    background-color: floralwhite;
			    border : 1px solid lightgray; 
			}
			.card-title > h1{
			    color : plum;
			    /*font-weight: bold;*/
			}
			#login-form> #id,#password,#name,#email{
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
                    <h1 class="fw-bolder">회원가입 페이지</h1>
                    <p class="lead mb-0">회원가입을 위한 정보 입력</p>
                </div>
            </div>
        </header>
        
        <!-- Page content-->
        <div class="container">
            
        <!-- 컨텐츠 시작 -->
        <div class="card mb-4 mx-auto" style="width: 500px;">
        	<div class="card-body">
        		
        		<div class="card-title">
        			<h1>회원가입</h1>
        			
	        		<form id="login-form" action="${pageContext.request.contextPath }/memberJoin" method='post' enctype='multipart/form-data'>
	        			<input type="text" id="id" neme="userId" placeholder="id">
	        			<input type="text" id="password" neme="userPw" placeholder="password">
	        			<input type="text" id="name" neme="userName" placeholder="name">
	        			<input type="text" id="email" neme="userMail" placeholder="email">
	        			<input type="submit" id="btn" value="회원가입">
	        		</form>
	        		
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
        
        
        
        
        
        
        
        
    </body>

</html>

