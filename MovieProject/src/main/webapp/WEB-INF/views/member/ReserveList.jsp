<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                    <h1 class="fw-bolder">예매 내역 페이지</h1>
                    <p class="lead mb-0">영화 예매 내역 출력</p>
                </div>
            </div>
        </header>
        
        <!-- Page content-->
        <div class="container">
            
        <!-- 컨텐츠 시작 -->
        <div class="row">
        	<div class="col">
        		<table>
        			<thead>
        				<tr>
        					<th>제목</th>
        					<th>극장</th>
        					<th>상영관</th>
        					<th>날짜</th>
        					<th>비고</th>
        				</tr>
        			</thead>
        			
        			<tbody>
        				
        				<%@ page import="java.util.Date" %>
        				
        				<c:set var="today" value="<%= new Date() %>"></c:set>
        				<c:forEach items="${reList}" var="re">
        				<%-- re.SCDATE "2023-09-15 14:50" >> scdate_fmt 2023년 09월 15일 --%>
        					<fmt:parseDate value="${re.SCDATE }" var="scdate_fmt" pattern="yyyy-MM-dd HH:mm"></fmt:parseDate>
        					<tr>
        						<td> <a href="detailMovie?mvcode=${re.MVCODE }">${re.MVTITLE}</a> </td>
								<td>${re.THNAME }</td> 
								<td>${re.SCHALL }</td>
								<td>${re.SCDATE }</td>
								<td> 
								<c:choose>
									<c:when test="${today < scdate_fmt }">
										<a href="/cancelReserve?recode=${re.RECODE }" class="btn btn-danger">예매취소</a>
									</c:when>
									<c:otherwise>
									
										<c:choose>
										<%-- 관람평 작성 유무 --%>
											<c:when test="${re.RVCODE == null}">
												<a href ="/reviewWriteForm?recode=${re.RECODE }" class="btn btn-success">관람평작성</a>
											</c:when>
											<c:otherwise>
												<a href="/detailMovie?mvcode=${re.MVCODE }" class="btn btn-info">관람평확인</a>
											</c:otherwise>
										</c:choose>
										
									</c:otherwise>
								</c:choose>
								</td>      					
        					</tr>      				
	        			</c:forEach>
        			</tbody>
        			
        		</table>
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
    </body>
</html>

