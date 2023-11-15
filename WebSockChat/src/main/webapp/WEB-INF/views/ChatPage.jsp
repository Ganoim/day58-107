<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 페이지</title>
	<style type="text/css">
		#chatArea{
			box-sizing: border-box;
			border: 3px solid black;
			border-radius: 10px;
			width: 650px;
			padding: 10px;
			background-color: #9bbbd4;
			height: 500px;
			overflow: scroll;
		}
		.sendMsg{
			text-align: right;
		}
		.msgComment{
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
			background-color: yellow;
		}
		
		.receiveMsg>.msgComment{
			background-color: white;
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
	</style>


</head>
<body>
	<h1>ChatPage.jsp - ${sessionScope.loginId }</h1>
	
	
	<div id="chatArea">
		<div class="receiveMsg">
			<div class="msgId">아이디</div>
			<div class="msgComment">받은메세지</div>
		</div>
		
		<div class="sendMsg">
			<div class="msgComment">보낸메세지</div>
		</div>
		<div class="connMsg">접속</div>
	</div>
	
    
	<div id="inputMsg"> 
		<input type="text" id="sendMsg">
		<button onclick="sendMsg()">전송</button>
	</div>
	
	
	
</body>
	
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	
	<script type="text/javascript">
	 var sock = new SockJS('chatPage');
	 sock.onopen = function() {
	     console.log('open');
	     //sock.send('test');
	 };
	
	 sock.onmessage = function(e) {
	     //console.log('message', e.data);  // // {"msgcomm" : "접속 했습니다.", "msgid" : loginId, "msgtype" : "c"}
	     //console.log("msgtype : " + msgObj.msgtype); // "c" "m" "d"
	     //console.log("msgid : " + msgObj.msgid);
	     //console.log("msgcomm : " + msgObj.msgcomm);
	     
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
			
			
		}
	</script>
	
	<script type="text/javascript">
		function printConnect(msgObj) {
			console.log("접속정보 출력 기능");
			let connMsgDiv = document.createElement('div');
			connMsgDiv.classList.add('connMsg');
			connMsgDiv.innerText = msgObj.msgid+"이/가 "+ msgObj.msgcomm;
			
			chatAreaDiv.appendChild(connMsgDiv);
			
		}
	</script>
	



</html>