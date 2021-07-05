<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
    
<nav class="navbar navbar-expand-md navbar-dark bg-dark sticky-top">
    <div class="container"> <button class="navbar-toggler navbar-toggler-right border-0" type="button" data-toggle="collapse" data-target="#navbar12">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbar12"> <a class="navbar-brand d-none d-md-block" href="home">
          <img alt="" src="https://i1.sndcdn.com/artworks-000055434563-cno6ba-t500x500.jpg" style="height: 50px; width: 50 px;"></img>
          <b>HomeTax</b>
        </a>
        <ul class="navbar-nav mx-auto">
          <li class="nav-item"> <a class="nav-link" href="detailTax?myid=${login.myid}&day=2106">상세요금확인/납부</a> </li>
          <li class="nav-item"> <a class="nav-link" href="chkTax?myid=${login.myid}">납부내역</a> </li>
          <li class="nav-item"> <a class="nav-link" href="bbs">문의사항</a> </li>
		<c:if test="${login.auth == 3}">
          <li class="nav-item"> <a class="nav-link" href="toCreateTax">월세입력</a> </li>
		</c:if>
		
        </ul>
        <ul class="navbar-nav">
        	<c:choose>
        		<c:when test="${login ne null}">
        			<li class="nav-item"> <a class="nav-link" href="mypage">${login.name} 님 환영합니다.</a> </li>
        			<li class="nav-item"> <a class="nav-link text-primary" href="logout">로그아웃</a> </li>
        		</c:when>
        		<c:otherwise>
        			<li class="nav-item"> <a class="nav-link" href="login">로그인</a> </li>
        		    <li class="nav-item"> <a class="nav-link text-primary" href="regiMember">회원가입</a> </li>
        		</c:otherwise>
        	</c:choose>
		  	        
          
        
        </ul>
      </div>
    </div>
  </nav>