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
                    <h1 class="fw-bolder">관람평 작성페이지</h1>
                    <p class="lead mb-0">리뷰 작성및 목록</p>
                </div>
            </div>
        </header>
        
        <!-- Page content-->
        <div class="container">
            
        <!-- 컨텐츠 시작 -->
        	<div class="row">
        		
        		<form action="registReview" method="post">
        			<div class="mb-4 p-2">
        				<input for="exampleInputEmail1" class="form-label" type="text" name="recode" value="${param.recode }" readonly="readonly">
        				<input class="form-control" type="text" name="rvcomment" placeholder="관람평 내용">
        				<input class="btn btn-primary mt-2" type="submit" value="관람평 등록">
				  	</div>
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
    </body>
</html>

