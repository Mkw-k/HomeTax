<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://static.pingendo.com/bootstrap/bootstrap-4.3.1.css">

<style type="text/css">
#_title, #_subdata, #_downbtn, #_content{
	border: 1px solid black;
}

</style>


</head>

<body >

<c:import url="/header.jsp" charEncoding="utf-8"/> 

  <div class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12" id="_title">제목 : ${vo.title}
        	<span style="float: right;">
        		<button onclick="toUpdate('${vo.hometaxbbs_seq}')">수정하기</button>
        		<button onclick="deleteBbs('${vo.hometaxbbs_seq}')">삭제하기</button>
        	</span>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6" id="_subdata">
        	<ul>
        		<li>작성자ID : ${vo.myid }</li>
        		<li>조회수 : ${vo.readcount }</li>
        		<li>다운로드수 : ${vo.downcount }</li>
        	</ul>
        </div>
        <div class="col-md-6" id="_downbtn">
        	<c:choose>
        		<c:when test="${vo.filename == null || vo.filename == '' }">
        			<span>업로드된 파일이 없습니다</span>	
        		</c:when>
        		<c:otherwise>
        			<span> ${vo.filename} </span>	
        		</c:otherwise>
        	</c:choose>
        	<input type='button' name='btnDown' value='다운로드'  onclick="filedown('${vo.newfilename}', '${vo.hometaxbbs_seq }', '${vo.filename }')"> 
        </div>
      </div>
      <div class="row">
        <div class="col-md-12" id="_content">
        	<div style="white-space:pre;"><c:out value="${vo.content}" /></div>
        </div>
      </div>
    </div>
  </div>
  
  
  <form name="file_Down" action="fileDownload" method="post">
 	<input type="hidden" name="newfilename" >
 	<input type="hidden" name="filename" >
 	<input type="hidden" name="seq"> 
 </form>
 
    <c:import url="/footer.jsp" charEncoding="utf-8"/> 
 
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  
  <!-- JQuery -->
  <script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>

  
  <pingendo onclick="window.open('https://pingendo.com/', '_blank')" style="cursor:pointer;position: fixed;bottom: 20px;right:20px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:220px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">Made with Pingendo Free&nbsp;&nbsp;<img src="https://pingendo.com/site-assets/Pingendo_logo_big.png" class="d-block" alt="Pingendo logo" height="16"></pingendo>
  
  <script type="text/javascript">
//이렇게 하면 자바스크립트를 사용하면서도 post형태로 보낼수가 있다 
  function filedown(newfilename, seq, filename) {
  	alert('눌렸음');
  	let doc = document.file_Down;
  	doc.newfilename.value = newfilename; 
  	doc.filename.value = filename;
  	doc.seq.value = seq;
  	doc.submit();
  }
  
  function toUpdate(seq) {
	location.href = "toUpdateBbs?seq="+seq;
}
  
function deleteBbs(seq) {
	location.href = "deleteBbs?seq="+seq;
}
  </script>
</body>

</html>