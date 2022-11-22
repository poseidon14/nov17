<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>우리인재개발원</title>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="우리인재개발원" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="shortcut icon" href="./images/favicon.ico" type="image/x-icon" />
<link rel="icon" href="./images/woori.png" type="image/x-icon" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="./css/style.css" rel="stylesheet" type="text/css">
<link href="./css/main.css" rel="stylesheet" type="text/css">


<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>
<%@include file="menu.jsp"%>
<div class="container">
	<div class="main">
	
	<article>
		<!-- 데이터를 여기에 -->
		<table class="table table-hover">
			<tr class="row">
				<th class="col-sm-1">번호</th>
				<th class="col-sm-6">제목</th>
				<th class="col-sm-3">날짜</th>
				<th class="col-sm-2">글쓴이</th>
			</tr>
			<c:forEach items="${list }" var="row">
			<tr class="row">
				<td class="col-sm-1">${row.board_no }</td>
				<td class="col-sm-6">
					<a href="./detail?bno=${row.board_no }">${row.board_title }</a>
						<c:if test="${row.commentcount ne 0 }">
							<%-- <small>${row.commentcount }</small> --%>
							<span class="badge bg-danger">${row.commentcount }</span>
						</c:if>
				</td>
				<td class="col-sm-3">${row.board_date }</td>
				<td class="col-sm-2">${row.name }</td>
			</tr>
			</c:forEach>
		</table>
		
		<!-- <button class="btn btn-primary" onclick="location.href='./write'">글쓰기</button> -->
		
	</article>
	<c:if test="${sessionScope.id ne null }">
		<button class="xi-new btn btn-warning" data-bs-toggle="modal" data-bs-target="#new"> 신규등록</button>


<!-- 등록모달 시작 -->		
<div class="modal fade" id="new" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">글쓰기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
        <form action="./write" method="post">
        	<input type="text" name="title" id="title" style="width: 100%; height:40px; margin-bottom: 10px;">
        	<textarea id="summernote" name="content"></textarea>
        	<button type="submit">저장하기</button>
        </form>
        
	  </div>
      <div class="modal-footer">        
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 모달끝 -->
	</c:if>
	
	
	</div>
</div>
<script>
    $(document).ready(function() {
        $('#summernote').summernote({
        	height: 400
        });
    });
  </script>
<%@include file="footer.jsp"%>
<c:if test="${param.result ne null }">
	<script type="text/javascript">
		//alert("${param.result }이 들어왔습니다.");
		var result = "${param.result }";//읽는 순서때문에 가능합니다. java -> js
		if(result == "ok"){
			alert("글을 저장했습니다.");
		} else if(result == "error"){
			alert("글을 저장하지 못했습니다.\n다시 확인해주세요");
		}
	</script>
</c:if>

</body>
</html>