<!DOCTYPE html>
<%@page import="javax.annotation.Resource"%>
<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
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
      	<div id="weather" style="float: right;"><span></span> <span></span> </div>
        <div class="mx-auto col-lg-8 col-md-10">
          <h1 class="display-3 mb-4">A wonderful serenity</h1>
          <p class="lead mb-5">Has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence.</p> 
          <a href="javascript:void(0)" id="_uploadTest" class="btn btn-lg btn-primary mx-1">Take me there</a> 
          <a class="btn btn-lg mx-1 btn-outline-primary" id="_imageTest" href="javascript:void(0)">업로드테스트로</a>
        </div>
      </div>
    </div>
  </div>
  
  <div class="py-5" >
    <div class="container-fluid">
      <div class="row">
      <h1 class="title"><a href="javascript:prev()"><img alt="" class="arrow" src="./resources/images/왼쪽화살표.png"></a>
      <span id="_year">21</span>년 <span id="_month">08</span>월 내역
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
  
  <div class="container">
  	<div class="row">
	  	<%-- <img style="width: 200px; height: 200px; margin: 0 auto" src="resources/upload/'${login.newfilename}'" onerror="this.src='https://e7.pngegg.com/pngimages/342/260/png-clipart-computer-icons-blog-people-shadow-silhouette-tomcat.png'" /> --%>
	  	<%-- <img style="width: 200px; height: 200px; margin: 0 auto" src="./upload/${login.newfilename}"/> --%>
	  	
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
  setYearMonth();    
  
  
  var now = document.getElementById('_year').text + safeDate(document.getElementById('_month').text);
  console.log("불러오는 현재 날짜 : " + now);
  
  getTaxListData(now);
  	 
  	//월세 리스트 가져오는 함수 
  	function getTaxListData( day ){

  	   //alert('데이터취득');
  	   var url =  "./getTaxListData";
  	   var type = 'get';
  	   var param = {day : day};
  	   
  	   /*
  	   var result = run_ajax(url, type, param);
  	   
  	   console.log(result);
  	   */
  	   
  	   
  	   $.ajax({
  	      url : "./getTaxListData",
  	      type : "get",
  	      data: {"day" : day},
  	      success:function(list){
  	         //alert('success');
  	         //alert(list);

  	         $(".list_col").remove();
  	         
  	        var reformattedList = object_threeAddComma(list);
  	       	console.log(reformattedList);
  	        
  	      	 $.each(reformattedList, function(i, val){
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
  	
  	
  			
        let button = document.getElementById('_imageTest');
        button.addEventListener('click', function() {
            alert('업로드 테스트 클릭');
  	  		location.href = "uploadTest";
        });
  			 
  	  		
       
        
        let upButton = document.getElementById('_uploadTest');
        upButton.addEventListener('click', function() {
            alert('클릭');
  	  		location.href = "upload";
        });
        
        
  	
        let skBtn = document.getElementById('_skTest');
        skBtn.addEventListener('click', function() {
            alert('_skTest 클릭');
            
            const data1 = {
            	VAR1 : "variable1",
            	VAR2 : "variable2"
            };
            
            const data2 = {
            	VAR1 : "variable3",
            	VAR2 : "variable4"
            }
            
            var arr = [];
            
            arr.push(data1);
            arr.push(data2);
            
            console.log(arr);
            
            
            //alert('데이터취득');
       	   $.ajax({
       	      url : "./skTest",
       	      type : "post",
       	      dataType : "json",
       	   	  contentType: 'application/json; charset=utf-8',
       	      data: JSON.stringify(arr),
       	      success:function(list){
       	         //alert('success');
       	         //alert(list);

       	      },
       	      error:function(){
       	         alert('error');
       	      }

       	   });
            
  	  		
        });
    
     
    //현재 년 월을 불러와서 셋팅 
    function setYearMonth() {
    	var date = new Date();
    	
    	var year = date.getFullYear();
    	year = year + "";
    	var twoYear = year.substr(2,2);
    	var $year = document.getElementById('_year');
    	$year.innerText = twoYear;
    	//console.log('년도 확인');
    	//console.log($year.text);
    	
    	var month = date.getMonth();
    	var nowMonth = (month +1);
    	var $month = document.getElementById('_month');
    	$month.innerText = nowMonth;
    	//console.log('월 확인');
    	//console.log($month.text);
	} 
    
    //08월이 8월로 찍히는거 방지 그럴경우 앞에 0을 붙여주고 리턴 
    function safeDate(day) {
    	//console.log('safe작동');
    	//console.log(day);
		if(day.toString().length == 1){
			day = '0' + day.toString();
		}
		//console.log('교체된 day : ' + day);
		return day;
	}
      
  </script>
  
  
</body>

</html>