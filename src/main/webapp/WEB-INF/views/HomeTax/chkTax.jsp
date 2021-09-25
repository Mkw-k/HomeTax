<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<meta charset="utf-8">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
request.setCharacterEncoding("UTF-8");
%>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://static.pingendo.com/bootstrap/bootstrap-4.3.1.css">
  
  

<style type="text/css">
.title{
	margin: auto;
}



</style>

</head>
<body>
<c:import url="/header.jsp" charEncoding="utf-8"/> 

<div class="py-5" >
    <div class="container-fluid">
      <div class="row">
      <h1 class="title">전체 납부내역</h1><br> 
        <div class="col-md-12">
          <div class="table-responsive">
            <table class="table table-striped table-dark" id="taxtable">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">날짜</th>
                  <th scope="col">이름</th>
                  <th scope="col">총액</th>
                  <th scope="col">납부금액</th>
                  <th scope="col">잔여금액</th>
                  <th scope="col">완납여부</th>
                </tr>
              </thead>
              
            </table>
            
           
          </div>
        </div>
      </div>
    </div>
  </div>
  
   <c:import url="/footer.jsp" charEncoding="utf-8"/> 
   
   
   
  

  
  
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  
  <!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>
<!-- js파일 임포트 -->        
 <script src="./resources/content/js/commons/commons.js"></script> 

<script type="text/javascript">
getchkTax();
//월세 리스트 가져오는 함수 
function getchkTax( ){
	var myid = '<c:out value="${login.myid}"/>';
	
	   //alert('데이터취득');
	   $.ajax({
	      url : "./chkTaxAf",
	      type : "get",
	      data: {"myid" : myid },
	      success:function(list){
	         //alert('success');
	         //alert(vo);
		     
	         $(".list_col").remove();
	         
	         $.each(list, function(i, vo){
				 let day = vo.day;
				 let year = day.substr(0, 2);
				 let month = day.substr(2, 3);
		         
		            //alert(val.jobSeq);
		            let app = "<tr class= 'list_col'>"
		                     +"<th scope='row'>" + (i+1) +"</th>";
		                     
		                   if(vo.del==0){
		                	 app +="<td><a href='#' onclick='getMonthInputListPop()'>"+year+"년"+month+"월"+"</a></td>"
		                	 	 +"<td>"+threeAddComma(vo.name)+"</td>"
		                	 	 +"<td>"+threeAddComma(vo.totalfee)+"원"+"</td>"
		                	 	 +"<td>"+threeAddComma(vo.inputfee)+"원"+"</td>"
		                	 	 +"<td id='_restfee'>"+threeAddComma(vo.restfee)+"원"+"</td>";
		                	 	 
			                   if(vo.restfee == 0 || vo.restfee < 0){
			                	   app+= "<td>완납</td>";
			                   }else{
			                	   app+= "<td>미납</td>";
			                   }
		                   }else{
		                	   app += "<td colspan='5'>"
		                			 +"<font color='#ff0000'>********* 이 글은 존재하지 않거나 작성자에 의해서 삭제되었습니다</font>"
		                           +"</td>";
		                   }
		                     
		                app +="</tr>";
		                  
				$("#taxtable").append(app);
	        });
	      },
	      error:function(){
	         alert('error');
	      }

	   });
  	
}

//해당월의 앵커 태그 클릭스 그 해당하는 월의 납부 상세 내역을 가지고 오는 함수 
function getMonthInputListPop() {
	console.log(event);
	console.log(event.target.innerText);
	//var day = deleteYearNMonthText(event.target.innerText);
	var day = event.target.innerText;
	day = day.replace(/[^0-9]/ig, '');
	console.log(day);
	var name = event.path[2].cells[2].innerText;
	
	var param = {
				"day" : day,
				"name" : name	 
				};
	
	 $.ajax({
	      url : "./getMonthInputListData",
	      type : "get",
	      data : JSON.stringify(param),
	      contentType : 'application/json; charset="utf-8"', 
	      dataType : "json",
	      success:function(list){
	         console.log(list);
	      },//success
	      error : function(){
			alert('error');
			}
	   });//ajax

}




</script>
  

</body>
</html>