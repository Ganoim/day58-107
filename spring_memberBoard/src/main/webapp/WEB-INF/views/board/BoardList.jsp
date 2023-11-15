<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet">

<!-- TOASTR CSS (<head> 태그 안쪽에) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css" integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


<style type="text/css">
.boardWrap {
	padding: 10px;
	background-color: white;
	border-radius: 10px;
	margin-left: auto;
	margin-right: auto;
	width: 700px;
}

.boardWrap>table {
	width: 100%;
	text-align: center;
	border-collapse: collapse;
}

th, td {
	padding-top: 7px;
	padding-bottom: 7px;
}

table {
	border: 2px solid #dfdfdf;
}

td {
	border-bottom: 2px solid black;
	border-top: 2px solid black;
}

.btitle {
	text-align: left;
	padding-left: 15px;
}

.boardUtil {
	border: 0px;
	margin-top: 10px;
}
</style>
</head>

<body>
	<div id="wrap">
		<div id="header">BoardList.jsp</div>
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>
		<div id="contents">
			<h1>게시판 - ${noticeMsg } <!--  ${param.searchTitle } --></h1>
			<div class="boardWrap">
				<table>
					<thead>
						<tr>
							<th style="width: 100px;">번호</th>
							<th class="btitle">제목</th>
							<th style="width: 115px;">작성자</th>
							<th style="width: 80px;">조회수</th>
							<th style="width: 115px;">작성일</th>
						</tr>
					</thead>
					
					<tbody>
					<!-- 글 목록 반복  -->
					<c:forEach items="${boardList }" var="bList">
						<tr>
							<td>${bList.bno }</td>
							<td class="btitle">
								<a href="${pageContext.request.contextPath}/boardView?bno=${bList.bno }">
									${bList.btitle }
								</a>
								<c:if test="${bList.bfilename !=null }">
									<span><i class="fa-regular fa-image"></i></span>
								</c:if>
								
								<span><i class="fa-regular fa-comment-dots"></i></span>${bList.recount }
								
							</td>
							<td>${bList.bwriter }</td>
							<td>${bList.bhits }</td>
							<td>${bList.bdate }</td>
						</tr>
					</c:forEach>
					<!-- 글 목록 반복  -->
					</tbody>
					
				</table>

				<div class="boardUtil">
					<c:if test="${sessionScope.LoginMemberId != null }">
						<button onclick="location.href='${pageContext.request.contextPath}/BoardWriteForm'">글작성</button>
					</c:if>

					<form action="${pageContext.request.contextPath}/boardSearch" method="get">
					
						<input type="text" name="searchTitle" placeholder="제목 검색...">
						<input type="submit" value="검색">
						<li><a href="${pageContext.request.contextPath }/boardWriteForm">글쓰기</a> </li>
					</form>
					
				</div>
			</div>
			
			<button onclick="sendTest()">클릭!</button>
			
			<hr>
			
			<div class="boardWrap">
				<table>
					<thead>
						<tr>
							<th style="width: 100px;">번호</th>
							<th class="btitle">제목</th>
							<th style="width: 115px;">작성자</th>
							<th style="width: 80px;">조회수</th>
							<th style="width: 115px;">작성일</th>
						</tr>
					</thead>
					
					<tbody>
					<!-- 글 목록 반복  -->
					<c:forEach items="${bListMap }" var="bomap">
						<tr>
							<td>${bomap.BNO }</td>
							<td class="btitle">
								<a href="${pageContext.request.contextPath}/boardView?bno=${bomap.BNO }">
									${bomap.BTITLE }
								</a>
								<c:if test="${bomap.BFILENAME !=null }">
									<span><i class="fa-regular fa-image"></i></span>
								</c:if>
								
								<i class="fa-regular fa-comment-dots"></i>
								<span style="font-size: 10px;">${bomap.RECOUNT }</span>
								
							</td>
							<td>${bomap.BWRITER }</td>
							<td>${bomap.BHITS }</td>
							<td>${bomap.BDATE }</td>
						</tr>
					</c:forEach>
					<!-- 글 목록 반복  -->
					</tbody>
					
				</table>
			
			
			<hr>
			
			
			
		</div>
	</div>
</body>

<!-- 
<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
 -->

<script src="https://kit.fontawesome.com/c8056a816e.js" crossorigin="anonymous"></script>

	
	<script type="text/javascript">
		function sendTest() {
			noticeSock.send("test");
		}
	</script>

	<!-- jQuery ( <body> 태그 하단) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<!-- TOASTR JS (jQuery 보다 아래쪽에) -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js" integrity="sha512-lbwH47l/tPXJYG9AcFNoJaTMhGvYWhVM9YI43CT+uteTRRaiLCui8snIgyAN8XWgNjNhCqlAUdzZptso6OCoFQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- sockJS  --> 
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<!-- Notice JS  -->
	<script src="${pageContext.request.contextPath }/resources/js/noticeJS.js"></script>
	
	<!-- 
	<script type="text/javascript">
		function noticeCheck() {
			let noticeMsg = '${noticeMsg}';
			if(noticeMsg.length > 0){
				noticeSock.send(noticeMsg);
				
			}
		}
	</script>
	 -->
	
	<script type="text/javascript">
		let noticeSock = connectNotice('${noticeMsg}');
	</script>
	
	<script type="text/javascript">
		function sendTest() {
			noticeSock.send('메세지 전송 테스트')
			
		}
	</script>











</html>