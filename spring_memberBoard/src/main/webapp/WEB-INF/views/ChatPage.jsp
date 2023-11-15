<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>채팅 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	
		<style type="text/css">
		
		#chatArea{
			box-sizing: border-box;
			border: 3px solid black;
			border-radius: 10px;
			width: 650px;
			padding: 10px;
			background-color: white;
			height: 500px;
			overflow: scroll;
		}
		.sendMsg{
			text-align: right;
		}
		.msgComment{
			color: white;
			display: inline-block;
			padding: 7px;
			border-radius: 7px;
			max-width: 220px;
		}
		
		.connMsg{
			min-width: 200px;
			max-width: 300px;
			margin: 5px auto;
			text-align: center;
			border-radius: 10px;
			padding: 5px;
			background-color: gray;
			color: white;
		}
		.msgid{
			font-weight: bold;
			font-size: 12px;
			margin-bottom: 2px;
		}
		
		.sendMsg>.msgComment{
			background-color: #5AD2FF;
		}
		
		.receiveMsg>.msgComment{
			background-color: #A0A0FF;
		}
		
		.receiveMsg, .sendMsg{
			margin-bottom: 5px;
		}
		
		#inputMsg{
			display: flex;
			box-sizing: border-box;
			border: 3px solid black;
			border-radius: 10px;
			width: 650px;
			padding: 10px;
		}
		
		#inputMsg{
			display: flex;
		}
		#inputMsg>input{
			width: 100%;
			padding: 5px;
		}
		#inputMsg>button{
			width: 20%;
			padding: 5px;
		}
		
		#chatContents{
			display: flex;
			width: 900px;
			margin: 0 auto;
		}
		#leftContent{
			margin: 5px;
		}
		#rightContent{
			margin: 5px;
			width: 230px;
		}
		#connMembersArea{
			box-sizing: border-box;
			border: 3px solid black;
			border-radius: 10px;
			height: 558px;
			overflow: scroll;
			padding: 7px; 
			
		}
		.connMember{
			border: 2px solid black;
			border-radius: 77px;
			padding: 5px;
			margin-bottom: 3px;
		}
	</style>
	
	</head>
	
	<body>
		<div class="mainWrap">
		
			<div class="header">
				<h1>채팅 페이지 - views/ChatPage.jsp</h1>
			</div>
			
			<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
			
			<div class="contents">
				<div id="chatContents">
					<div id="leftContent">
						<div id="chatArea"></div>
						<div id="inputMsg"> 
							<input type="text" id="sendMsg">
							<button onclick="sendMsg()">전송</button>
						</div>
					</div>
				
					<div id="rightContent">
						<div id="connMembersArea">
							<div class="connMember">접속 아이디</div>
							
						</div>
					</div>
				</div> <!-- chatContents -->
				
			</div>
			
		</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

	<script type="text/javascript">
	 var sock = new SockJS('chatSocket');
	 sock.onopen = function() {
	     console.log('open');
	 };
	
	 sock.onmessage = function(e) {
	     let msgObj = JSON.parse(e.data);
	     let mtype = msgObj.msgtype;
	     switch(mtype) {
	     case "m":
	    	 printMessage(msgObj); // 메세지 출력 기능
	    	 
	    	 break;
	     case "c":
	    	 
	     case "d":
	    	 printConnect(msgObj); // 접속 정보 출력 기능
	    	 
	    	 break;
	     }
	     
	 };
	
	 sock.onclose = function() {
	     console.log('close');
	 };
	
	</script>
	
	<script type="text/javascript">
		let msgInputTag = document.querySelector("#sendMsg");
		msgInputTag.addEventListener('keyup', function(e) {
			if (e.keyCode == 13) { // 13 = enter
				sendMsg();
			}
			
		})
	</script>
	
	<script type="text/javascript">
	
		let chatAreaDiv = document.querySelector("#chatArea");
		
		function sendMsg() {
			let msgInput = document.querySelector("#sendMsg");
			sock.send(msgInput.value);
			let sendDiv = document.createElement('div');
			sendDiv.classList.add('sendMsg');
			
			let msgCommDiv = document.createElement('div');
			msgCommDiv.classList.add('msgComment');
			msgCommDiv.innerText = msgInput.value;
			
			sendDiv.appendChild(msgCommDiv);
			
			chatAreaDiv.appendChild(sendDiv);
			
			msgInput.value = "";
			
			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
		}
	</script>
	
	<script type="text/javascript">
		function printMessage(msgObj) {
			
			
			let receiveMsgDiv = document.createElement('div');
			receiveMsgDiv.classList.add('receiveMsg');
			
			let msgIdDiv = document.createElement('div');
			msgIdDiv.classList.add('msgid');
			msgIdDiv.innerText = msgObj.msgid;
			receiveMsgDiv.appendChild(msgIdDiv);
			
			let msgCommentDiv = document.createElement('div');
			msgCommentDiv.classList.add('msgComment');
			msgCommentDiv.innerText = msgObj.msgcomm;
			
			receiveMsgDiv.appendChild(msgCommentDiv);
			
			chatAreaDiv.appendChild(receiveMsgDiv);
			
			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
		}
	</script>
	
	<script type="text/javascript">
		function printConnect(msgObj) {
			console.log("접속정보 출력 기능");
			// 접속정보 >> 채팅창에 출력
			let connMsgDiv = document.createElement('div');
			connMsgDiv.classList.add('connMsg');
			connMsgDiv.innerText = msgObj.msgid+"이/가 "+ msgObj.msgcomm;
			chatAreaDiv.appendChild(connMsgDiv);
			
			chatAreaDiv.scrollTop = chatAreaDiv.scrollHeight;
			
			// 접속 정보 >> 접속자 목록 (id="connMembersArea")
			let connMembersAreaDiv = document.querySelector("#connMembersArea");
			if (msgObj.msgtype == 'c') {
				// msgtype == 'c' >> 접속자 목록에 추가
				let connMemberDiv = document.createElement('div');
				connMemberDiv.classList.add('connMember');
				connMemberDiv.setAttribute('id', msgObj.msgid);
				
				connMemberDiv.innerText = msgObj.msgid;
				
				console.log(msgObj.msgid.length);
				
				connMembersAreaDiv.appendChild(connMemberDiv);
				
			} else{
				// msgtype == 'd' >> 접속자 목록에서 제거
				// msgObj.msgid >> 접속을 해제한 아이디
				document.querySelector("#"+msgObj.msgid).remove();
				
				
			}
			
			
			
			
		}
	</script>
	
	

</html>