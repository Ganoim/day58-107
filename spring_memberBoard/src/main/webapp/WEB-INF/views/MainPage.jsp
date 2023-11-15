<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>메인 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	
	<!-- TOASTR CSS -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css" integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	
	
	</head>
	
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>메인 페이지 - views/MainPage.jsp</h1>
			</div>
			
			<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
			
			<div class="contents">
				<h2>컨텐츠 영역</h2>
				<img alt="" src="${pageContext.request.contextPath }/resources/boardUpload/b741c0fd-2694-4ea6-871b-5a022339d140_다운로드3.jpg">
				
				<button onclick="sendTest()">클릭!</button>
				
			</div>
			
		</div>
		
	</body>
	
	<script type="text/javascript">
		function sendTest() {
			noticeSock.send("test");
		}
	</script>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<script type="text/javascript">
		let msg = '${msg }';
		if(msg.length > 0){
			alert(msg);
		}
	</script>
	
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	<!-- TOASTR JS  -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.min.js" integrity="sha512-lbwH47l/tPXJYG9AcFNoJaTMhGvYWhVM9YI43CT+uteTRRaiLCui8snIgyAN8XWgNjNhCqlAUdzZptso6OCoFQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- sockJS  -->
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	<!-- Notice JS  -->
	<script src="${pageContext.request.contextPath }/resources/js/noticeJS.js"></script>
	
	<script type="text/javascript">
		let noticeSock = connectNotice('${noticeMsg}');
	</script>
	
	<script type="text/javascript">
		function sendTest() {
			let noticeObj = { "noticeType" : "board" };
			noticeSock.send( JSON.stringify(noticeObj) );
		}
	</script>
	
	
	
	

</html>