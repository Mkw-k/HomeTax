<%@page import="java.util.ArrayList"%>
<%@page import="com.mkw.a.domain.HomeTaxVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<meta charset="utf-8">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
request.setCharacterEncoding("UTF-8");
ArrayList<HomeTaxVo> voList = (ArrayList<HomeTaxVo>)request.getAttribute("voList");
HomeTaxVo vo = voList.get(0);
String day = vo.getDay();

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
                  <th scope="col">수도세</th>
                  <th scope="col">전기세</th>
                  <th scope="col">가스비</th>
                  <th scope="col">인터넷비</th>
                  <th scope="col">관리비</th>
                  <th scope="col">월세</th>
                  <th scope="col">총액</th>
                  <th scope="col">납부금액</th>
                  <th scope="col">잔여금액</th>
                  <th scope="col">완납여부</th>
                </tr>
              </thead>
              
            </table>
            
            <button onclick="inputModal()">납부하기</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  
   <c:import url="/footer.jsp" charEncoding="utf-8"/> 
   
   
   <!-- 납부모달 -->
   <div class="modal" id="_inputModal">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">납부하기</h5> <button type="button" class="close" data-dismiss="modal" onclick="closeModal()" > <span>×</span> </button>
        </div>
        <div class="modal-body">
          <p><span id="_inputYear"></span>년 <span id="_inputMonth"></span>월 납부 - 금액 : <span id="_fee"></span>원</p>
          <P><input type="number" placeholder="납부할금액입력" id="_inputfee" size="20"></P>
          <p id="_alertMsg"></p>
        </div>
        <div class="modal-footer"> <button type="button" class="btn btn-primary" id="_inputBtn" onclick="inputTax()">납부하기</button> <button type="button" class="btn btn-secondary" onclick="closeModal()" data-dismiss="modal">취소</button> </div>
      </div>
    </div>
  </div>
  
  
  
  
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
  
  <!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>
<!-- js파일 임포트 -->        
 <script src="./resources/content/js/commons/commons.js"></script> 
<script type="text/javascript">

var day;

day = "<%=day%>"; 

console.log("day 체크 ::" + day);

getDetailData(day);

let month;
let isZero = day.charAt(2);

//alert("isZero : "+ isZero);
if(isZero == 0){
	month = day.substr(3, 3);
}else{
	month = day.substr(2, 3);
}

//alert("이게달"+month);
$("#_month").text(month);

  	 
//월세 리스트 가져오는 함수 
function getDetailData( day ){
	var myid = '<c:out value="${login.myid}"/>';
	
	console.log('ajax day 확인 : '+day);
	
   //alert('데이터취득');
   $.ajax({
      url : "./detailData",
      type : "get",
      data: {"day" : day, "myid" : myid },
      success:function(voList){
         //alert('success');
         //alert(vo);

         $(".list_col").remove();
         
         if(voList.length === 0){
        	 var app;
        	 app += "<tr class='list_col'><td colspan=12 style='color:red;'>";
        	 app += "해당 월의 월세 내역이 아직 입력되지 않았거나 없습니다. 자세한 사항은 운영자에게 문의하세요.";
        	 app += "</td></tr>";
        	 $("#taxtable").append(app);
         }
         	 
				
         for (var i = 0; i < voList.length; i++) {
			//alert(val.jobSeq);
            let app = "<tr class= 'list_col'>"
                     +"<th scope='row'>" + 1 +"</th>";
                     
                   if(voList[i].del==0){
                	 app +="<td>"+voList[i].name+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].water)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].elec)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].gas)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].inter)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].managerfee)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].monthfee)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].totalfee)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].inputfee)+"원"+"</td>"
                	 	 +"<td id='_restfee'>"+threeAddComma(voList[i].restfee)+"원"+"</td>";
                	 	 
                	   if(voList[i].restfee == 0 || voList[i].restfee < 0){
	                	   app+= "<td>완납</td>";
	                   }else{
	                	   app+= "<td>미납</td>";
	                   }
                	 
                   }else{
                	   app += "<td colspan='10'>"
                			 +"<font color='#ff0000'>********* 이 글은 존재하지 않거나 작성자에 의해서 삭제되었습니다</font>"
                           +"</td>";
                   }
                     
                app +="</tr>";
                  
			$("#taxtable").append(app);
         	}
         
      },
      error:function(){
         alert('error');
      }

   });

}

//왼쪽 화살표클릭시
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
		year = '0' + year;
	}
	
	monthLength = month.toString().length;
	if(monthLength==1){
		month = month.toString();
		month = '0' + month;
	}
	
	day = year.toString() + month.toString();
	getDetailData(day);
}
 	
//오른쪽 화살표 클릭시 	
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
	
	day = year.toString() + month.toString();
	getDetailData(day);
}


function inputModal() {
	$("#_inputBtn").show();
	$("#_alertMsg").hide();
	
	let year;
	let month; 
	let restfee;
	
	year = $("#_year").text();
	month = $("#_month").text();
	restfee = $("#_restfee").text();
	
	$("#_inputYear").text(year);
	$("#_inputMonth").text(month);
	$("#_fee").text(restfee);
	
	
	restfee = parseInt(restfee); 
	$("#_inputfee").val(restfee);
	
	if(restfee == 0 || restfee < 0){
		$("#_inputBtn").hide();
		$("#_alertMsg").css('color', 'red');
		$("#_alertMsg").show();
		$("#_alertMsg").text("이미 전액납부가 완료되었습니다.");
	}
	
	$("#_inputModal").show();
}

function closeModal() {
	$("#_inputModal").hide();
}
 	
//납부하기 클릭시 	
function inputTax() {
	//alert('클릭');
	
	var year;
	var month;
	var fee;
	var myid;
	
	year = $("#_inputYear").text();
	month = $("#_inputMonth").text();
	fee = $("#_fee").text();
	myid = '<c:out value="${login.myid}"/>';
	
	//alert('진행1');
	
	var day;
	var yearLength;
	yearLength = year.toString().length;
	if(yearLength==1){
		year = year.toString();
		year = 0 + year;
	}
	
	var monthLength;
	monthLength = month.toString().length;
	if(monthLength==1){
		month = month.toString();
		month = 0 + month;
	}
	
	//210831 K 
	//이쪽 부분도 숫자로 더해질 가능성 있으므로 투스트링 추가했음 
	//day = year + month;
	day = year.toString() + month.toString();
	//alert('진행2');
	
	var inputfee; 
	inputfee = $('#_inputfee').val();
	
	//alert(inputfee);
	//alert("이게날짜:"+day);
	
	inputAf(day, myid, inputfee);
	
	
	
}

function inputAf(day, myid, inputfee) {
	
location.href = "inputTax?day="+day+"&myid="+myid+"&inputfee="+inputfee;
	
}
</script>
  




</html>