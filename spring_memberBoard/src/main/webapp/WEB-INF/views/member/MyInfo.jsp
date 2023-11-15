<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>내정보확인</title>
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
			<h1>내정보 페이지 - views/member/MyInfo</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
			
			<!-- 아이디, 비밀번호, 이름, 생년월일, 이메일 -->
			
			<div class="formWrap">
					<h2>내정보확인</h2>
					
					<div class="formRow">
						
						아이디 : ${mInfo.mid}
					</div>
					
					<div class="formRow">
						
						비밀번호 : ${mInfo.mpw}
					</div>
					
					<div class="formRow">
						
						이름 : ${mInfo.mname}
					</div>
						
					<div class="formRow">
						
						생년월일 : ${mInfo.mbirth}
					</div>
					
					<div class="formRow">
						
						이메일 : ${mInfo.memail}
					</div>
					
					<div class="formRow" style="border: none;">
						<button clsss="submitBtn" type="button" onclick="pwCheck('${mInfo.mpw }')">수정하기</button>
					</div>
			</div>
			
		</div>
	</div>
	<hr>
	작성한 글 : ${bInfo } 개
	<hr>
	작성한 댓글 : ${rInfo } 개 
	<hr>	
		
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
	<!-- jQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
	
	<script type="text/javascript">
		function pwCheck(mpw) {
			let inputpw = prompt("비밀번호 입력");
			if(mpw == inputpw){
				location.href = "memberModifyForm";
			} else{
				alert('비밀번호를 다시 확인 해주세요!');
			}
			
		}
		
	</script>
	
	
	
	
	
	
	
	

</html>