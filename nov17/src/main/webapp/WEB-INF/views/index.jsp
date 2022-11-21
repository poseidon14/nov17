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
<link href="./css/index.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function login(){
	//alert("로그인 버튼을 눌렀습니다.");
	var id = document.getElementById("id");
	//alert(id.value);
	if(id.value == "" || id.value.length < 3){
		alert("아이디를 입력하세요.");
		id.focus();
		return false;
	}
	var pw = document.getElementById("pw");
	if (pw.value.length < 3 || pw.value == "") {
		alert("비밀번호를 입력해주세요.");
		pw.focus();
		return false;
	}
	//return false; 다 성공하면 진행하기 위해서
	//주석처리합니다.
}
</script>
</head>
<body>
<%@include file="menu.jsp"%>
<div class="container">
	<div id="logindiv">
		<img alt="" src="./images/main.jpg" width="700px;">
		<article id="loginform">
		<form class="row" action="./login" method="post" onsubmit="return login()">
			<div class="col-sm-5">
				<input class="form-control" type="text" name="id" id="id" placeholder="아이디를 입력해주세요"> 
			</div>
			<div class="col-sm-5">
				<input class="form-control" type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요">
			</div>
			<div class="col-sm-auto">
				<button class="btn btn-primary" type="submit" style="width: 90px">로그인</button>
			</div>
		</form>
		</article>
	</div>
</div>
<%@include file="footer.jsp"%>
</body>
</html>