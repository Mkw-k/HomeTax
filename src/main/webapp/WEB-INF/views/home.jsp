<!DOCTYPE html>
<html>

<meta charset="utf-8">
<%@ page language="java" contentType="text/HTML;charset=UTF-8" pageEncoding="UTF-8" %>
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
<%-- <c:import url="./script.jsp" charEncoding="utf-8"/>  --%>



  <div class="py-5 text-center text-white h-100 align-items-center d-flex" style="background-image: linear-gradient(to bottom, rgba(0, 0, 0, .75), rgba(0, 0, 0, .75)), url(https://static.pingendo.com/cover-bubble-dark.svg);  background-position: center center, center center;  background-size: cover, cover;  background-repeat: repeat, repeat;">
    <div class="container py-5">
      <div class="row">
        <div class="mx-auto col-lg-8 col-md-10">
          <h1 class="display-3 mb-4">A wonderful serenity</h1>
          <p class="lead mb-5">Has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence.</p> <a href="#" class="btn btn-lg btn-primary mx-1">Take me there</a> <a class="btn btn-lg mx-1 btn-outline-primary" href="#">Let's Go</a>
        </div>
      </div>
    </div>
  </div>
  <div class="py-5" >
    <div class="container-fluid">
      <div class="row">
      <h1 class="title"><a href="javascript:prev()"><img alt="" class="arrow" src="./resources/images/왼쪽화살표.png"></a>
      <span id="_year">21</span>년 <span id="_month">06</span>월 내역
      	<a href="javascript:next()"><img alt="" class="arrow" src="./resources/images/오른쪽화살표.png"></a>
      </h1>
        <div class="col-md-12">
          <div class="table-responsive">
            <table class="table table-striped table-dark" id="taxtable">
              <thead>
                <tr>
                  <th scope="col">#</th>
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

  <script type="text/javascript">
  		
  getTaxListData('2106');
  	 
  	//월세 리스트 가져오는 함수 
  	function getTaxListData( day ){

  	   //alert('데이터취득');
  	   $.ajax({
  	      url : "./getTaxListData",
  	      type : "get",
  	      data: {"day" : day},
  	      success:function(list){
  	         //alert('success');
  	         //alert(list);

  	         $(".list_col").remove();

  	         $.each(list, function(i, val){
  	            //alert(val.jobSeq);
  	            let app = "<tr class= 'list_col'>"
  	                     +"<th scope='row'>" + (i+1) +"</th>";
  	                     
  	                   if(val.del==0){
  	                	 app +="<td>"+val.name+"</td>"
  	                	 	 +"<td>"+val.totalfee+"원"+"</td>"
  	                	 	 +"<td>"+val.inputfee+"원"+"</td>"
  	                	 	 +"<td>"+val.restfee+"원"+"</td>";
  	                		
  	                	 	if(val.restfee == 0 || val.restfee < 0){
		                	   app+= "<td>완납</td>";
		                    }else{
		                	   app+= "<td>미납</td>";
		                    }
  	                	 	
  	                   }else{
  	                	   app += "<td colspan='4'>"
  	                			 +"<font color='#ff0000'>********* 이 글은 작성자에 의해서 삭제되었습니다</font>"
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
  	
  	function prev() {
		let month;
		month = $("#_month").text();
		//alert(month);
		
		month = parseInt(month);
		
		month = (month-1);
		
		//alert('변경된 month:' + month);
		
		let year;
		year = $("#_year").text();
		year = parseInt(year);
		
		if(month == 0){
			year = (year-1);
			month = 12;
		}
		
		$("#_year").text(year);
		$("#_month").text(month);
		
		let day;
		yearLength = year.toString().length;
		if(yearLength==1){
			year = year.toString();
			year = 0 + year;
		}
		
		monthLength = month.toString().length;
		if(monthLength==1){
			month = month.toString();
			month = 0 + month;
		}
		
		day = year + month;
		getTaxListData(day);
	}
  	
  	function next() {
  		let month;
  		month = $("#_month").text();
		//alert(month);
		
		month = parseInt(month);
		
		month = (month+1);
		
		//alert('변경된 month:' + month);
		
		let year;
		year = $("#_year").text();
		year = parseInt(year);
		
		if(month == 13){
			year = (year+1);
			month = 1;
		}
		
		$("#_year").text(year);
		$("#_month").text(month);
		
		let day;
		yearLength = year.toString().length;
		if(yearLength==1){
			year = year.toString();
			year = 0 + year;
		}
		
		monthLength = month.toString().length;
		if(monthLength==1){
			month = month.toString();
			month = 0 + month;
		}
		
		day = year + month;
		getTaxListData(day);
	}
  </script>
  
  
</body>

</html>