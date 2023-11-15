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
        	.movie_poster{
        		max-width: 70%;
        		height: auto;
        		border-radius: 10px;
        			
        	}
        	/* omg-fluid */
        	.img-profile{
        		width: 50px;
			    height: 50px;
			    border-radius: 50%;
			    /*object-fit: cover;*/
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
                    <h1 class="fw-bolder">영화 정보 페이지</h1>
                    <p class="lead mb-0">영화 랭킹 1위~6위 목록 출력</p>
                </div>
            </div>
        </header>
        
        <!-- Page content-->
        <div class="container">
            
        <!-- 컨텐츠 시작 -->
        <!-- 영화정보 출력 - row 시작 -->
        <div class="row my-4">
        	<div class="col-lg-5" style="text-align: center;">
				<img class="movie_poster" src="${movie.mvposter }" alt="" >
        	</div>
        	<div class="col-lg-7 pt-2">
               <div class="card-body pt-5">
                   <div class="small text-muted mb-1">예매율</div>
                   <h2 class="card-title mb-2" title="" >${movie.mvtitle }</h2>
                   <p class="card-text mb-1"> 감독 : ${movie.mvdirector } / 배우 : ${movie.mvactors } </p>
                   <p class="card-text mb-1"> 장르 : ${movie.mvgenre } / 기본정보 : ${movie.mvinfo } </p>
                   <p class="card-text mb-4"> 개봉일 : ${movie.mvopen }</p>
                   <a class="btn btn-danger" href="#!">예매하기</a>
               </div>        		
        	</div>
        </div>    	
        <!-- 영화정보 출력 - row 끝 --> 
        
        <!-- 관람평 출력 - row 시작 -->
        	<div class="row">
			
			<p class="h3">관람평</p>
			
			<c:forEach items="${rvList}" var="rv">
			<div class="card md-1" style="max-width: 540px;">
				<div class="row g-0">
					<div class="col-md-4">
							<c:choose>
								<c:when test="${rv.MSTATE == 'YC'}">
									<c:choose>
										<c:when test="${rv.MPROFILE == null}">
											<%-- 등록된 프로필이 없는 경우 --%>
											<img class="img-fluid rounded-start" src="${pageContext.request.contextPath }/resources/users/mprofile/기본이미지.png">
										</c:when>
										<c:otherwise>
											<%-- 등록된 프로필이 있는 경우 --%>
											<img class="img-fluid rounded-start"" src="${pageContext.request.contextPath }/resources/users/mprofile/${sessionScope.loginProfile }">
										</c:otherwise>
									</c:choose>
								</c:when>

								<c:otherwise>
									<img src="${rv.MPROFILE }" class="img-fluid rounded-start" alt="...">
								</c:otherwise>
							</c:choose>
					</div>
					
					<div class="col-md-8">
						<div class="card-body">
							<h5 class="card-title">${rv.MID}</h5>
							<p class="card-text">${rv.RVCOMMENT }</p>
							<p class="card-text">
								<small class="text-body-secondary">${rv.RVDATE }</small>
							</p>
						</div>
					</div>
				</div>
				
				<c:if test="${sessionScope.loginId == rv.MID }">
					<a href="/deleteReview?${rv.RVOCDE }$mvcode=${param.mvcode}" class="btn btn-danger w-100">삭제</a>
				</c:if>
				
			</div>
			
			</c:forEach>

		</div>
           	
        <!-- 관람평 출력 - row 끝 -->
        
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

