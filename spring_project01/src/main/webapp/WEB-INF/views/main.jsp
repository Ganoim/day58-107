<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>main.jsp maindate출력 : ${maindate }</h1>
	<hr>
	<a href="${pageContext.request.contextPath}/testPage?testnum=100&teststr=ABC">페이지 이동</a>
	<button onclick="location.href='${pageContext.request.contextPath}/testPage?testnum=200&teststr=DEF'">페이지2동</button>
	<hr>
	<form action="${pageContext.request.contextPath}/testPage" method="get">
	<input type="text" name="testnum" placeholder="숫자입력">
	<input type="text" name="teststr" placeholder="문자입력">
	<input type="text" name="testval" placeholder="문자입력">
	<input type="submit" value="전송">
	</form>
	
	<hr>
	
	<form action="${pageContext.request.contextPath}/testJoin" method="get">
		<input type="text" name="mid" placeholder="아이디">
		<input type="text" name="mpw" placeholder="비밀번호">
		<input type="text" name="mname" placeholder="이름">
		<input type="date" name="mbirth">
		<input type="submit" value="전송">
	
	</form>
	
	
	
</body>
</html>