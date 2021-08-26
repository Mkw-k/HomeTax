<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<!--   <link rel="stylesheet" href="https://static.pingendo.com/bootstrap/bootstrap-4.3.1.css"> -->
 
  <script type="text/javascript" src="./resources/jquery/jquery.twbsPagination.min.js"></script>
  <script src="./resources/content/js/bbs/bbs.js"></script>
  
</head>

<body >
<c:import url="/header.jsp" charEncoding="utf-8"/> 
	

  <div class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="table-responsive">
            <table class="table table-striped table-borderless" id="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">title</th>
                  <th scope="col">조회수</th>
                  <th scope="col">다운로드수</th>
                  <th scope="col">다운로드</th>
                </tr>
              </thead>
             
             
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
 
	<nav aria-label="Page navigation">
         <ul class="pagination" id="pagination"
            style="justify-content: center;">
         </ul>
      </nav>
  <div class="container">
  	<div class="row">
  		<div class="col-12"  style="padding-right: 100 px; margin-right: 20px;">
  			<input type="button" style="float: right;" class="btn btn-primary" onclick="javascript:writeBbs('${login.myid}')" id="_writeBbs" value="글쓰기"><br>			
  		</div>
  	</div>
  </div>
  
		

  
  
  <form name="file_Down" action="fileDownload" method="post">
 	<input type="hidden" name="newfilename" >
 	<input type="hidden" name="filename" >
 	<input type="hidden" name="seq"> 
 </form>
 
   
  <c:import url="/footer.jsp" charEncoding="utf-8"/> 
 


</body>

</html>


