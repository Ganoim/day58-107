<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>

	<style type="text/css">
		#chatArea{
			border: 2px solid black;
			width: 500px;
			padding: 10px;
			
		}
		.receiveMsg{
			margin-bottom: 3px;
		}
		.sendMsg{
			text-align: right;
			margin-bottom: 3px;
		}
		
	</style>


</head>
<body>
	<h1>Hello world!</h1>

	<P>The time on the server is ${serverTime}.</P>

	<input type="text" id="sendMsg">
	<button onclick="msgSend()">전송</button>
	<hr>
	<div id="chatArea">
	
		
		
	</div>
	
	
	

</body>

	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	
	<script type="text/javascript">
		var sock = new SockJS('chatSocket');
		sock.onopen = function() { // 접속을했을때
			console.log('open');
			// sock.send('test');// 서버로 메세지 전송
		};
	
		sock.onmessage = function(e) { //데이터를 보내줄때
			console.log('받은 메세지 : ', e.data);
			//sock.close();
			let receiceMsgDiv = document.createElement('div');
			receiceMsgDiv.classList.add('receiceMsg');
			receiceMsgDiv.innerText = e.data;
			chatAreaDiv.appendChild(receiceMsgDiv);
			
			
		};
	
		sock.onclose = function() { // 서버를 닫을때
			console.log('close');
		};
	</script>

	<script type="text/javascript">
	
		let chatAreaDiv = document.querySelector("#chatArea");
	
		function msgSend() {
			let msgInput = document.querySelector("#sendMsg");
			//console.log("보낸 메세지 : " + msgInput.value);
			sock.send(msgInput.value);  // chat 서버로 메세지 전송 
			
			let sendDiv = document.createElement('div');
			sendDiv.classList.add('sendMsg');
			sendDiv.innerText = msgInput.value;
			chatAreaDiv.appendChild(sendDiv);
			
			msgInput.value = ""; // input태그 초기화
			
			
		}
	</script>


</html>
