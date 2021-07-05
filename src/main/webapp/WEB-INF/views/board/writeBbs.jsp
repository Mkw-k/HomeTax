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
</head>

<body >

<c:import url="/header.jsp" charEncoding="utf-8"/> 

  <div class="py-3">
    <div class="container">
      <div class="row">
        <div class="mx-auto p-4 col-lg-7">
          <h1 class="mb-4">Write Bbs</h1>
          <form method="post" enctype="multipart/form-data" id="_bbsFrm">
            <div class="form-row">
              <div class="form-group col-md-6"> <input type="text" class="form-control" id="form27" placeholder="Name" name="name" value="${login.name }" readonly="readonly"> </div>
              <div class="form-group col-md-6"> <input type="text" class="form-control" id="form28" placeholder="myid" name="myid" value="${login.myid }" readonly="readonly"> </div>
            </div>
            <div class="form-group"> <input type="text" class="form-control" id="form29" placeholder="title" name="title" value="${vo.title }"> </div>
            <div class="form-group">
            	<div class="form-control"><span>${vo.filename}</span><input type="file" id="form31" placeholder="file" name="fileload" >
            	</div> 
            </div>
            <div class="form-group"> <textarea class="form-control" id="form30" rows="3" placeholder="content" name="content">${vo.content }</textarea> </div> 
          	
          	<c:choose>
          		<c:when test="${isUpdate == 'YES' }">
          			<button type="button" class="btn btn-primary" onclick="update()">수정하기</button>
          		</c:when>
          		<c:otherwise>
		            <button type="button" class="btn btn-primary" onclick="write()">작성하기</button>
          		</c:otherwise>
          	</c:choose>
          
          </form>
        </div>
      </div>
    </div>
  </div>
  
    
   <c:import url="/footer.jsp" charEncoding="utf-8"/> 
   
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  <pingendo onclick="window.open('https://pingendo.com/', '_blank')" style="cursor:pointer;position: fixed;bottom: 20px;right:20px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:220px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">Made with Pingendo Free&nbsp;&nbsp;<img src="https://pingendo.com/site-assets/Pingendo_logo_big.png" class="d-block" alt="Pingendo logo" height="16"></pingendo>

<script type="text/javascript">
function update() {
	$("#_bbsFrm").attr('action', 'updateBbs').submit();
}

function write() {
	$("#_bbsFrm").attr('action', 'writeBbsAf').submit();
}
</script>

</body>

</html>