<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
	<meta charset="UTF-8">
	<title>글작성 페이지</title>
	<link href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet">
	<style>
		form>p{
			margin: 0 5px;
			font-size: 13px;
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
		.formRow>input[type="submit"]{
			width: 100%;
			cursor: pointer;
			border: 1px solid black;
			border-radius: 15px;
			height: 40px;
		}
		.formRow>input{
			outline: none;
			width: 100%;
			box-sizing: border-box;
			border: none;
			height: 30px;
			padding: 3px;
			font-size: 15px;
		}
	</style>
	</head>
	
	<body>
	<div class="mainWrap">
	
		<div class="header">
			<h1>글작성 페이지 - views/board/BoardWriteForm.jsp</h1>
		</div>
		
		<%@ include file="/WEB-INF/views/includes/Menu.jsp" %>	
		
		<div class="contents">
			
			<!-- 글제목, 글내용, 파일 -->
			
			<div class="formWrap">
				<form action="${pageContext.request.contextPath }/boardWrite" method="post" enctype="multipart/form-data">
					<h2>글작성 페이지</h2>
				
					<div class="formRow">
						<input type="text" name="btitle" placeholder="글제목">
					</div>
					
					<div class="formRow">
						<textarea name="bcontents" rows="20" cols="100" placeholder="글내용"></textarea>
					</div>
					
					<div class="formRow">
						<input type="file" name="bfile">
					</div>
					
					<div class="formRow" style="border: none;">
						<input type="submit" value="글등록">
					</div>
					
				</form>
			</div>
			
		</div>
	</div>
		
	</body>
	
	<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>

</html>