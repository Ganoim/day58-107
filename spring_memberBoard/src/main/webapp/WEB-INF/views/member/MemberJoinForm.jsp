<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>회원가입 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style>
		form>p{
			margin: 0 5px;
			font-size: 13px;
		}
		
		.colorGreen{
			color: green;
		}
		
		.colorRed{
			color: Red;
		}
		
		.formRow{
			border: 1px solid black;
		
			display: flex;
            align-items: center;
            
            justify-content: flex-start;

            margin: 10px 0;
            /* border: 1px solid black; */
            border-radius: 7px;
            padding: 5px;
            flex-wrap: wrap;
		}
		
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
		
		h2{
			text-align: center;
		}
		
		.formRow>input{
			outline: none;
			box-sizing: border-box;
			border: none;
			height: 30px;
			padding: 3px;
			font-size: 15px;
		}
		
		.formRow>input[type="submit"]{
			width: 100%;
			cursor: pointer;
			border: 1px solid black;
			border-radius: 15px;
			height: 40px;
		}
		
	</style>
	</head>
	
	<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>회원가입 페이지 - views/member/MemberJoinForm.jsp</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
			
			<!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
			
			<div class="formWrap">
				<form action="${pageContext.request.contextPath }/memberJoin" method="post">
					<h2>회원가입 페이지</h2>
				
					<div class="formRow">
						<input type="text" id="inputId" name="mid" placeholder="아이디">
						<button type="button" onclick="idCheck()">중복확인</button>
					</div>
					<p id="idMsg">중복확인 메세지</p>
					
					<div class="formRow">
						<input type="text" name="mpw" placeholder="비밀번호">
					</div>
					
					<div class="formRow">
						<input type="text" name="mname" placeholder="이름">
					</div>
					
					<div class="formRow">
						<input type="date" name="mbirth">
					</div>
					
					<div class="formRow">
						<input type="text" name="memailId" placeholder="이메일 아이디">
						@
						<input type="text" id="eDomain" name="memailDomain" placeholder="이메일 도메인">
						<select onchange="selectDomain(this)">
							<option value="">직접입력</option>
							<option value="naver.com">네이버</option>
							<option value="daum.net">다음</option>
							<option value="google.com">구글</option>
						</select>
					</div>
					
					<div class="formRow" style="border: none;">
						<input type="submit" value="가입">
					</div>
					
				</form>
			</div>
			
		</div>
	</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	
	<script type="text/javascript">
		function selectDomain(selObj){
			document.getElementById('eDomain').value = selObj.value;
		}
	</script>
	
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<!-- 아이디 중복 체크 -->
	<script type="text/javascript">
		function idCheck(){
			// 중복 확인할 아이디 VALUE 확인
			let idEl = document.querySelector('#inputId');
			console.log(idEl.value);
			// ajax - 아이디 중복 확인요청(memberIdCheck)
			$.ajax( { type: "get", // 전송 방식
					  url: "memberIdCheck", // 전송 URL
					  data: { "inputId" : idEl.value }, // 전송 파라메터
					  success: function(re){ // 전송에 성공했을 경우
						  // re : 응답받은 데이터
						  console.log("확인결과 : " + re);
		                    if(re == "Y"){
		                    	/* 사용 가능한 아이디입니다. 출력 */
		                    	let msgEl = document.getElementById('idMsg');
		                    	msgEl.innerText = '사용 가능한 아이디입니다.';
		                    	msgEl.classList.add('colorGreen');
		                    	msgEl.classList.remove('colorRed');
		                    	
		                    	// document.querySelector('#idmsg').innerText = '사용 가능한 아이디입니다.';
		                        // $("#idMsg").css("color", 'green').text("사용 가능한 아이디입니다.");
		                    }
		                    else{
		                    	/* 중복된 아이디입니다. 출력 */
		                    	let msgEl = document.getElementById('idMsg');
		                    	msgEl.innerText = '이미 가입된 아이디입니다.';
		                    	msgEl.classList.add('colorRed');
		                    	msgEl.classList.remove('colorGreen');
		                    	
		                    	// document.querySelector('#idmsg').innerText = '이미 가입된 아이디입니다.';
		                        // $("#idMsg").css("color", 'red').text("이미 가입된 아이디입니다.");
		                    }
		                }
					  } );
		}
	</script>
	
	<script type="text/javascript">
		let msg = '${msg }';
		if(msg.length > 0){
			alert(msg);
		}
	</script>

</html>