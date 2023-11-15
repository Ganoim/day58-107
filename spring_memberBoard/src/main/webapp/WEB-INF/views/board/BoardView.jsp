<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>글 상세보기 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	
	<!-- TOASTR CSS (<head> 태그 안쪽에) -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.1.4/toastr.css" integrity="sha512-oe8OpYjBaDWPt2VmSFR+qYOdnTjeV9QPLJUeqZyprDEQvQLJ9C5PCFclxwNuvb/GQgQngdCXzKSFltuHD3eCxA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	
	
	<style>
		.formRow>button, .formRow>select{
			margin-left: 10px;
		}
		
		.formWrap{
			margin-left: auto;
			margin-right: auto;
			border: 3px solid black;
			border-radius: 14px;
			width: 600px;
			padding: 20px;
		}
		.formRow{
			border: 1px solid black;		
			display: flex;
            align-items: center;          
            justify-content: flex-start;
            margin: 10px 0;
            border-radius: 7px;
            padding: 5px;
            flex-wrap: wrap;
		}
		
		h2{
			text-align: center;
		}
		
		div>ul{
			display: flex;
			list-style-type: none;
			justify-content: flex-end;
			padding: 0;
			text-decoration: none;
			align-items: center;
		}
		
		div>ul>li{
			padding: 8px;
			margin: 0 5px;
			font-weight: bold;
		}
		
		#btitle{
			padding: 5px;
			height: 60px;
			border-radius: 7px;
			border: 1px solid black;
			display: flex;
			align-items: center;
		}
		
	</style>
	
	<style type="text/css">
		.replyArea{
			border: 3px solid black;
			border-radius: 10px;
			wudth: 500px;
			margin: 15px;
			padding: 15px;
			
		}
		
		.replyWrite textarea{
			border-radius: 7px;
			width: 100%;
			min-height: 70px;
			font-family: auto;
			resize: none;
			padding: 8px;
		}
		
		.replyWrite button{
			width: 100%;
			margin-top: 5px;
			cursor: pointer;
			padding: 5px;
			border-radius: 7px;
		}
		
		
		
		.reply{
			display: flex;
			
		}
		
		.reply>p{
			padding: 0;
			margin: 3px;
			
		}
	
		.recomm{
		margin-top: 5px;
			border-radius: 7px;
			width: 96%;
			min-height: 70px;
			font-family: auto;
			resize: none;
			padding: 8px;
		}
	
	</style>
	
	
	</head>
	
	<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>글 상세보기 페이지 - views/board/BoardView.jsp</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
			
			<!-- 아이디, 비밀번호 -->
			
			<div class="formWrap">
			
				<h2>글 상세보기</h2>
				
				<div id="btitle">
					<h3>${board.btitle }</h3>
				</div>
				
				<div id="boardInfo" class="formRow">
					<ul>
						<li>작성자 : ${board.bwriter }</li>
						<li>${board.bdate }</li>
						<li>조회수 : ${board.bhits }</li>
					</ul>
				</div>
					
				<div style="border: none" class="formRow">
					<img alt="" src="${pageContext.request.contextPath }/resources/boardUpload/${board.bfilename }">
				</div>
				
				<div class="formRow" style="min-height: 300px; align-items: flex-start;">
					<p style="">${board.bcontents }</p>
				</div>
					
				<div class="formRow" style="border: none">
					<button onclick="location.href='${pageContext.request.contextPath }/boardList'">목록</button>
				</div>
				
			</div>
			
			<!-- 댓글 관련 시작 -->
			
			<hr>
			<div class="replyArea">
				
				<c:if test="${sessionScope.loginMemberId != null }"> <!-- 로그인한경우 -->
				<div class="replyWrite">
					<h3>댓글 작성 양식 - 로그인한 경우 출력</h3>
					<form onsubmit="return replyWrite(this)">
						<input type="hidden" name="rebno" value="${board.bno }">
						<input type="hidden" name="bwriter" value="${board.bwriter }">
						<textarea name="recomment" placeholder="댓글 내용 작성"></textarea>
						<button type="submit">댓글 등록</button>
					</form>			
				</div>
				<hr>
				
				</c:if>
				
				
				<h3>댓글 출력</h3>
					
				<div id="replyList">
				<%-- 
					<div class="reply">
						<p>작성자출력</p>
						<p>작성일출력</p>
						<button>댓글삭제</button>
					</div>
					<textarea class="recomm" disabled="disabled">댓글내용 출력</textarea>
						
				</div>
				<hr>
				--%>
				
				
					
			</div>
			
			
		</div>
			
			<!-- 댓글 관련 시작 -->
			
		</div> <!-- div.contents 끝 -->
	</div> <!-- div.mainWrap 끝 -->
		
	</body>
	
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
		function replyWrite(formObj) {
			console.log("replyWrite 호출 "+ formObj.rebno.value);
			/* ajax 댓글 등록 요청 전송 */
			$.ajax({
				type :  "get",
				url : "replyWrite",
				data : {"rebno" : formObj.rebno.value, "recomment" : formObj.recomment.value },
				success : function(result){
					console.log("result : " + result);
					if(result == "1"){
						alert("댓글이 등록되었습니다.")
						formObj.recomment.value = ""; // 댓글내용 작성 textarea 초기화
						//댓글 목록 갱신
						getReplyList(formObj.rebno.value);
						//document.querySelector("#focusDiv").focus();
						
						/* NoticeSock에 send("{ "noticeType" : "댓글알림"  -> "키" : "value"
											  	"bon" : "10"
											  	"bwriter" : "글작성자" }" );
						*/
						
						let noticeObj = { "noticeType" : "reply", 
										  "noticeMsg" : formObj.rebno.value,
										  "receiveId" : formObj.bwriter.value
										};
						
						// 공지타입, 글번호, 작성자 >> JSON
						noticeSock.send( JSON.stringify(noticeObj) );
						
						
						
					} else {
						alert("댓글 등록 실패되었습니다.")
					}
				}
				
			});
			
			return false;
		}
		
		//댓글 목록 조회 및 출력
		function getReplyList(rebno){
			console.log("getReplyList() 호출")
			console.log("댓글 조회할 글번호 : " + rebno);
			$.ajax({
				type : "get",
				url : "replyList",
				data : { "rebno" : rebno },
				dataType : "json", 
				success : function(reList){
					printReplyList(reList);
					
				}
			});
			
			
		}
		
	</script>
	
	
	 <script type="text/javascript">
	 	let loginId = '${sessionScope.loginMemberId}';
	 	console.log("로그인된 아이디 : " + loginId);
	 
	 
	 	// 댓글 출력기능
	 	function printReplyList(reList) {
	 		let reListDiv = document.querySelector("#replyList");
			reListDiv.innerHTML = "";  // 댓글을 출력할 div 자식요소 초기화
			
			for(let reInfo of reList) { //let i = 0; i < reList.length; i++
				let reDiv = document.createElement('div');  // <div></div>
	
				let replyDiv = document.createElement('div'); // <div></div>
				replyDiv.classList.add('reply'); // <div class="reply"></div>
	
				let reWriterP = document.createElement('p'); // <p></p>
				reWriterP.innerText = reInfo.remid; // reList[index].remid - <p작성자</p>
				replyDiv.appendChild(reWriterP); // <div class="reply"> <p작성자</p> </div>
	
				let redateP = document.createElement('p');
				redateP.innerText = reInfo.redate; // <p작성일</p>
				replyDiv.appendChild(redateP); // <div class="reply"> <p작성자</p> <p작성일</p> </div>
				
				
				
				// 댓글 작성자와 로그인된 아이디가 같을 경우애 실행
				
				if(reInfo.remid == loginId){
					let rebtn = document.createElement('button'); // <button></button>
					rebtn.innerText = "삭제"; // <button>삭제</button>
					rebtn.setAttribute('onclick', 'delReply("'+reInfo.renum+'")');
					replyDiv.appendChild(rebtn);
				}
				// <div class="reply"> 
				//	 <p작성자</p> 
				//	 <p작성일</p> 
				//	 <button>삭제</button>
				// </div>
	
				let recomment = document.createElement('textarea'); // <textarea></textarea>
				recomment.innerText = reInfo.recomment;
				recomment.classList.add('recomm');
				recomment.setAttribute('disabled', 'disabled');
				//<textarea class="recomm" disabled="disabled">댓글내용</textarea>
				
				reDiv.appendChild(replyDiv);
				reDiv.appendChild(recomment);
				console.log(reDiv);
				reListDiv.appendChild(reDiv);
				
			}
			


		}
	 
	 </script>
	
	<script type="text/javascript">
		function delReply(delrenum) {
			console.log('삭제할 댓글 번호 : ' + delrenum);
			let confirmVal = confirm('댓글을 삭제 하시겠습니까?');
			if (confirmVal) {
				$.ajax({
					type : "get",
					url : "deleteReply",
					data : { "renum" : delrenum },
					success : function(result) {
						if (result == '1') {
							getReplyList(bno);
							alert('댓글 삭제완료!')
						} else{
							alert('댓글 삭제실패ㅠㅠ')
						}
					}
					
				})
			}
		}	
	
	</script>
	
	
	
	<script type="text/javascript">
		let bno = '${board.bno}'; // 현재 글번호
			
		$(document).ready(function(){
			getReplyList(bno);
		});
	</script>
	 
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<script type="text/javascript">
		let msg = '${msg }'
		if(msg.length > 0){
			alert(msg);
		}
	</script>

</html>