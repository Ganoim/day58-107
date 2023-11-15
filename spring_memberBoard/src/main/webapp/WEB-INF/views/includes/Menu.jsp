<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- TOASTR CSS 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css" integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
-->



	<div class="nav">
	
		<ul>
			<li><a href="${pageContext.request.contextPath }/memberChatPage">회원채팅</a></li>
		
			<li><a href="${pageContext.request.contextPath }/tagoBus">tagoBus</a></li>
  
			<li><a href="${pageContext.request.contextPath }/busapi">버스도착정보</a></li>
			<!-- 
			<li><a href="${pageContext.request.contextPath }/busapi_ajax">버스도착정보_ajax</a></li>
			 -->

			<c:choose>
				<%-- 로그인이 X --%>
				<c:when test="${sessionScope.loginMemberId == null}">
					<li onclick="location.href='${pageContext.request.contextPath }/memberJoinForm'">회원가입</li>
					<li onclick="location.href='${pageContext.request.contextPath }/memberLoginForm'">로그인</li>
				</c:when>
			
				<%-- 로그인이 O --%>
				<c:otherwise>
					<li onclick="location.href='${pageContext.request.contextPath }/MyInfo'">${sessionScope.loginMemberId }</li>
					<li onclick="location.href='${pageContext.request.contextPath }/boardList'">게시판</li>
					<li onclick="location.href='${pageContext.request.contextPath }/boardWriteForm'">글쓰기</li>
					<li onclick="location.href='${pageContext.request.contextPath }/memberLogout'">로그아웃</li>					
				</c:otherwise>
			
			</c:choose>
		</ul>
	</div>	
	
	<%--
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
	
	--%>
	
	
	
	<%-- 
	
	<script type="text/javascript">
		function toastrOn() {
			toastr.options.positionClass = "toast-bottom-right";
			toastr.info('새 글이 등록되었습니다.');
			
		}
	</script>
	
	<script type="text/javascript">
	 var noticeSock = new SockJS('noticeSocket');
	 noticeSock.onopen = function() {
	     console.log('noticeSocket 접속');
	 };
	 noticeSock.onmessage = function(e) {
	     toastrOn();
	 };
	 noticeSock.onclose = function() {
	     console.log('noticeSocket 접속해제');
	 };
	
	</script>
	
	--%>
	
	