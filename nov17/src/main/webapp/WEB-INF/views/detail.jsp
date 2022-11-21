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
function del(bno){
	//alert("삭제 버튼을 클릭했습니다." + bno);
	if(confirm("삭제하시겠습니까?")){
		location.href="./delete?bno="+bno;
	}
}
function update(bno){
	alert("수정 버튼을 클릭했습니다." + bno);
	
}
</script>
</head>
<body>
<%@include file="menu.jsp"%>
<div class="container">
	<!-- 여기에 작성 -->
	<div class="main">
		<table class="table">
			<tr>
				<th class="col-sm-1">제목</th>
				<td class="col-sm-11">${detail.board_title }</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${detail.board_date }</td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td>${detail.name } / ${detail.mid } 
					<c:if test="${sessionScope.id eq detail.mid }">
						<img alt="del" src="./images/delete.png" title="삭제하기" onclick="del(${detail.board_no })">
						<img alt="edit" src="./images/update.png" title="수정하기" onclick="update(${detail.board_no })">
					</c:if>
				</td>
			</tr>
			<tr>
				<th>본문</th>
				<td>${detail.board_content }</td>
			</tr>
			
		</table>
	</div>	
</div>
<%@include file="footer.jsp"%>
</body>
</html>