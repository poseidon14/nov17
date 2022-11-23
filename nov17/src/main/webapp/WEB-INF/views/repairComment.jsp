<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>우리인재개발원</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="상세 설명이 여기 들어갑니다." />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="shortcut icon" href="./images/favicon.ico" type="image/x-icon" />
<link rel="icon" href="./images/woori.png" type="image/x-icon" />
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<style type="text/css">
#repairForm{
	margin: 0 auto;
	width: 800px;
	height: 400px;
	padding: 5px;	
}
#repairForm textarea{
	width: 100%;
	height: 350px;
}
#repairForm button{
	width: 100%;
	height: 50px;
}
#repairForm input[type=number]{
	height:0px;
	visibility: hidden;
}
</style>
</head>
<body>
<%@include file="menu.jsp"%>
<div class="container">
	<div id="repairForm">
		<!-- 주의, 다른 사람 댓글도 수정할 수 있습니다. 이거 잡아줘야 합니다. -->
		<form action="./repairComment" method="post">
			<textarea name="comment">${dto.c_comment }</textarea>
			<input type="number" name="cno" value="${dto.c_no }"> 
			<input type="number" name="bno" value="${dto.board_no }"> 
			<button>수정하기</button>
		</form>
	</div>
</div>
<%@include file="footer.jsp"%>
</body>
</html>