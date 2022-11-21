<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<div class="header">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="./main">
    	<img alt="logo" src="./images/woori.png" height="30px" alt="logo"> 우리컴퓨터학원
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
   	<div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto">
        <li class="nav-item active">
          <a class="nav-link" href="./main">메인</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">게시판</a>
          <div class="dropdown-menu">
			<a class="dropdown-item" href="./freeboard">자유 게시판</a>
			<a class="dropdown-item" href="./notice">공지사항</a>
          </div>
        </li>
      </ul>
      <ul class="navbar-nav justify-content-end">
      	<li class="nav-item locks">
      		<c:choose>
      			<c:when test="${sessionScope.name ne null}">
					<div class="lock" onclick="logout();"> ${sessionScope.name } 님</div>
      			</c:when>
      			<c:otherwise>
      				<button onclick="location.href='./'">로그인</button>
      			</c:otherwise>
      		</c:choose>
        </li>
      </ul>
    </div>
  </div>
</nav>
</div>
<script>
function logout(){
	if(confirm("로그아웃 하시겠습니까?")){
		location.href="./logout";
	}
}
</script>