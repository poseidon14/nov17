<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<link href="./css/join.css" rel="stylesheet" type="text/css">
<script>
$(function(){
	//$("span").text("변경되나요?");
	//$("#id").mouseover(function(){$("#checkResult").text("ID를 입력하세요.");});
	//$("#id").mouseout(function(){$("#checkResult").text("입력하셨습니다.");});
	$("#id").change(function(){
		if(    $("#id").val().length < 4   ){
			//alert("아이디는 4글자 이상이어야 합니다.");
			$("#checkResult").text("아이디는 4글자 이상이어야 합니다.");
			$("#joinBtn").attr("disabled", true);//비활성화하기
		} else {
			//alert("서버와 통신을 시작합니다.");
			//$("#checkResult").text("서버와 통신을 시작합니다.");
			$.ajax({
						url : "./idCheck",
						method : "post",
						data : { "id" : $("#id").val()},
						dataType : "json"
			}).done(function(data){
				//alert("성공 : " + data.result);
				var result = data.result;
				if(result == 1){
					//alert("이미 가입된 ID입니다\n다른 ID를 입력하세요.");
					$("#checkResult").css("color", "red");
					$("#checkResult").css("font-weight", "bold");
					$("#checkResult").text($("#id").val()+ "(은)는 이미 가입된 ID입니다. 다른 ID를 입력하세요.");
					$("#id").val("");
					$("#joinBtn").attr("disabled", true);//비활성화하기
				}else{
					//alert("가입할 수 있는 ID입니다.");
					$("#checkResult").css("font-weight", "bold");
					$("#checkResult").css("color", "green");
					$("#checkResult").text("가입할 수 있는 ID입니다.");
					$("#joinBtn").attr("disabled", false);//활성화 하기
				}
			}).fail(function(xhr, status, errorThrown){
				alert("문제가 발생했습니다. 다시 시도하세요");
			});
		}
		//$("#checkResult").text(     "라고 입력하셨습니다."   );
	});
	
	$("#joinBtn").click(function(){
		alert("가입하기 버튼을 눌렀습니다.");
		//input에 들어있는 값들 가져오기
		var id = $("#id").val();
		var pw1 = $("#pw1").val();
		var pw2 = $("#pw2").val();
		var name = $("#name").val();
		if(pw1 == pw2){
			//여기서 던지기 -> 서버로 동적 form생성하기
			var form = $('<form></form>');
			form.attr("name","이름지정");
			form.attr("method","post");
			form.attr("action","./join");
			form.attr("id","form");
			
			form.append(   $('<input>', {'type':'hidden', 'name':'name', 'value':name})   );
			form.append(   $('<input>', {'type':'hidden', 'name':'id', 'value':id  })   );
			form.append(   $('<input>', {'tepe':'hidden', 'name':'pw', 'value':pw1 })   );
			
			form.appendTo('body');
			form.submit();
			
			
		}else{
			//여긴 입력한  pw가 맞지 않으므로 pw일치하여야 합니다
			//메시지 나가게 하기
		}
		//alert(id + " : " + pw1 + " : " + pw2 + " : " + name);
	});
});//jquery 문 
</script>
</head>
<body>
	<%@include file="menu.jsp"%>
	<div class="container">
		<!-- 여기에 적어주세요 -->
		<!-- <span>여기에 이 말을 적었습니다.</span> -->
		
		<div class="joinForm">

			<div class="mb-3">
				<label class="form-label">아이디</label>
				<input type="text" class="form-control" id="id" placeholder="아이디를 입력해주세요">
				<p id="checkResult"></p>
			</div>
			<div class="mb-3">
				<label class="form-label">비밀번호</label>
				<input type="password" id="pw1" class="form-control" placeholder="암호를 입력해주세요" required="required">
			</div>
			<div class="mb-3">
				<label class="form-label">비밀번호 재입력</label>
				<input type="password" id="pw2" class="form-control" placeholder="암호를 다시 입력해주세요">
			</div>
			<div class="mb-3">
				<label class="form-label">이름</label>
				<input type="text" id="name" class="form-control" placeholder="이름을 입력하세요">
			</div>
			<div class="mb-3" style="text-align: right;">
				<button class="btn btn-danger" type="reset">초기화</button>
				<button class="btn btn-success" type="button" id="joinBtn" disabled="disabled">회원가입하기</button>
			</div>
		</div>
	</div>
	<%@include file="footer.jsp"%>
</body>
</html>