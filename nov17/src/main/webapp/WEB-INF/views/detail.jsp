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
<link href="./css/detail.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="text/javascript">
function del(bno){
	//alert("삭제 버튼을 클릭했습니다." + bno);
	if(confirm("삭제하시겠습니까?")){
		location.href="./delete?bno="+bno;
	}
}
function update(bno){
	//alert("수정 버튼을 클릭했습니다." + bno);
	if(confirm("수정하시겠습니까?")){
		location.href="./update?bno="+bno;	
	}	
}
//제이쿼리
//$(선택자).명령();
$(document).ready(function(){//이 jsp가 다 읽어졌다면
	$(".delComment").click(function(){
		if(confirm("삭제하시겠습니까?")){
			var p = $(this).parents("#comment");
			var c_no = $(this).siblings("#cid").text();		
			$.post("./commentDel",{bno : "${detail.board_no}",cno : c_no},
				function(data, status){
					if(data == 1){
						p.remove();								
					}else if(data == 9){
						alert("로그인하세요");
						location.href="./";
					}else {
						alert("에러가 발생했습니다.\n다시 시도하세요.");		
					}
				}
			);//post
		}//end if
	});//dele
	
	
	$(".repairComment").click(function(){
		if(confirm("수정하시겠습니까?")){
			var c_no = $(this).siblings("#cid").text();
			location.href="./repairComment?bno=${detail.board_no }&cno="+c_no;
		}
	});
	
});

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
		<button class="xi-sort-asc btn btn-primary" onclick="location.href='./main'"> 게시판으로</button>
		<div class="comment">
			<c:if test="${sessionScope.id ne null }">
			<div id="commentInput">
				<form action="./comment" method="post">
					<input type="hidden" name="bno" value="${param.bno }">
					<textarea name="comment"></textarea>
					<button type="submit" >댓글쓰기</button>
				</form>
			</div>
			</c:if>
			<!-- 댓글들은 여기에 -->
			<c:choose>
				<c:when test="${fn:length(commentList) gt 0 }">
					<div id="comments"> <!-- 댓글을 전체 감싸고 있는 외부 -->
						<c:forEach items="${commentList }" var="cm">
						<div id="comment"> <!-- 댓글 하나 내역 -->
							<div id="commentHead"> <!-- 댓글 머리부분 : 글쓴이, 날짜 등등 -->
								${cm.mname }
								<c:if test="${cm.mid eq sessionScope.id}">
									<img alt="del" src="./images/delete.png" title="삭제하기" class="delComment">
									<img alt="edit" src="./images/update.png" title="수정하기" class="repairComment">				
								</c:if>${cm.c_date }
								<div id="cid">${cm.c_no }</div> <!-- 댓글 번호 -->
							</div>
							<div id="commentBody">${cm.c_comment }</div> <!-- 댓글 내용 -->
						</div>
						</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					댓글이 없어요.
				</c:otherwise>
			</c:choose>
			
		</div>
	</div>	
</div>

</body>
</html>