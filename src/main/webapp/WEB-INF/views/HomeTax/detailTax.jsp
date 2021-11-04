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
                  <th scope="col">납부승인</th>
                </tr>
              </thead>
              
            </table>
            
            <button onclick="inputModal()">납부하기</button>
            <p style="color: red;">*최종납부승인은 관리자가 납부금액을 확인한 후 납부내역이 일치할시 승인하여 최종월세 납부를 승인한 내역을 확인하는 부분입니다.</p>
            <p>
          	<span id="payment_chk_tax_day"></span>
          	&nbsp;&nbsp;
          	<c:choose>
          		<c:when test="${login.myid == 'admin' && login.myid != null && login.myid != ''}">
          			<input type="checkbox" class="dues_payment_btn" id="BWATER" value="BWATER" onchange="input_dues_check_box_click()">수도세 
		          	<input type="checkbox" class="dues_payment_btn" id="BELEC" value="BELEC" onchange="input_dues_check_box_click()">전기세 
		          	<input type="checkbox" class="dues_payment_btn" id="BGAS" value="BGAS" onchange="input_dues_check_box_click()">가스비 
		          	<input type="checkbox" class="dues_payment_btn" id="BINTER" value="BINTER" onchange="input_dues_check_box_click()">인터넷 
		          	<input type="checkbox" class="dues_payment_btn" id="BMANAGERFEE" value="BMANAGERFEE" onchange="input_dues_check_box_click()">관리비 
		          	<input type="checkbox" class="dues_payment_btn" id="BMONTHFEE" value="BMONTHFEE" onchange="input_dues_check_box_click()">월세 
          		</c:when>
          		<c:otherwise>
          			<span>
          			수도세 : <span id="water">None</span>
          			</span>
          			<span>
          			전기세 : <span id="elec">None</span>
          			</span>
          			<span>
          			가스비 : <span id="gas">None</span>
          			</span>
          			<span>
          			인터넷 : <span id="inter">None</span>
          			</span>
          			<span>
          			관리비 : <span id="manage">None</span>
          			</span>
          			<span>
          			월세 : <span id="month">None</span>
          			</span>
          		</c:otherwise>	
          	</c:choose>
          	
          </p>
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
          <c:if test="${login.auth == 3}">
          	<p>
          		<select id="memberSelector" onchange="inputMemberSelector()">
          		</select>
          	</p>
          </c:if>
          <p><span id="_inputYear"></span>년 <span id="_inputMonth"></span>월 납부 - 금액 : <span id="_fee"></span></p>
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
let monthIsZero = day.charAt(2);
let year; 
let yearIsZero = day.charAt(0);

//alert("isZero : "+ isZero);
//해당월이 0으로 시작할경우 2번째 1글자만 표시되도록 
if(monthIsZero == 0){
	month = day.substr(3, 3);
}else{
	month = day.substr(2, 3);
}
//해당 년이 0으로 시작할경우 2번째 1글자만 표시되도록 
if(yearIsZero == 0){
	year = day.substr(1, 1);
}else{
	year = day.substr(0, 2);
}

//넘어온 년 월을 유저가 확인할수 있게 셋팅해줌 (21년 12월)
$("#_month").text(month);
$("#_year").text(year);

//모달창 셀렉트 박스 내용 셋팅 (관리자용)
function set_admin_modal_selectbox_data() {
	
}

//관리자가 공과금 납입여부 확인해주는 체크박스 클릭시 
//관리자 기능 : 공과금 및 월세 납입 체크 
function input_dues_check_box_click() {
	console.log('클릭됨');
	console.log(event.target.checked);
	console.log(event.target.defaultValue);
	
	var isChecked = event.target.checked;	//체크박스 체크여부확인
	var bValue = event.target.defaultValue;	//체크된건지 체크해제된건지
	var text_day = $('#payment_chk_tax_day').text();
	text_day = text_day.substr(0, 2) + text_day.substr(3, 2);
	
	console.log('bday : ' + text_day);
	
	var param = {
			bValue : bValue, 
			isChecked : isChecked,	
			bday : text_day,
	};
	
	 $.ajax({
	      url : "./inputDues",
	      type : "post",
	      data:JSON.stringify(param),
	      dataType:"json",
	  	  contentType : "application/json;charset=UTF-8",
	      success:function(data){
	    	  console.log('업데이트성공');
	    	  console.log(data);
	           },//success
	      error: function() {
			console.log('아작스 실패');
		} 
	   });//ajax
	
}

getDuesStatus();
function getDuesStatus() {
	console.log('getDuesStatus 체크체크 !!');
	
	var text_day = $('#payment_chk_tax_day').text();
	text_day = text_day.substr(0, 2) + text_day.substr(3, 2);
	
	console.log("day chk : " + text_day);
	
	var param = {
			bday : text_day,			
	};
	
	$.ajax({
	      url : "./getDuesStatus",
	      type : "post",
	      data:JSON.stringify(param),
	      dataType:"json",
	  	  contentType : "application/json;charset=UTF-8",
	      success:function(data){
	    	  console.log('공동납부 상태확인 !!!');
	    	  console.log(data);
	    	  
	    	  if(data.BELEC == "Y"){
	    		  $("input:checkbox[id='BELEC']").prop("checked", true);
	    		  $('#water').text('Y');
	    		  
	    	  }else if(data.BELEC == "N"){
	    		  $("input:checkbox[id='BELEC']").prop("checked", false);
	    		  $('#water').text('N');
	    	  }
	    	  
	    	  if(data.BGAS == "Y"){
	    		  $("input:checkbox[id='BGAS']").prop("checked", true);
	    		  $('#gas').text('Y');
	    	  }else if(data.BGAS == "N"){
	    		  $("input:checkbox[id='BGAS']").prop("checked", false);
	    		  $('#gas').text('N');
	    	  }
	    	  
	    	  if(data.BINTER == "Y"){
	    		  $("input:checkbox[id='BINTER']").prop("checked", true);
	    		  $('#inter').text('Y');
	    	  }else if(data.BINTER == "N"){
	    		  $("input:checkbox[id='BINTER']").prop("checked", false);
	    		  $('#inter').text('N');
	    	  }
	    	  
	    	  if(data.BMANAGERFEE == "Y"){
	    		  $("input:checkbox[id='BMANAGERFEE']").prop("checked", true);
	    		  $('#manage').text('Y');
	    	  }else if(data.BMANAGERFEE == "N"){
	    		  $("input:checkbox[id='BMANAGERFEE']").prop("checked", false);
	    		  $('#manage').text('N');
	    	  }
	    	  
	    	  if(data.BMONTHFEE == "Y"){
	    		  $("input:checkbox[id='BMONTHFEE']").prop("checked", true);
	    		  $('#month').text('Y');
	    	  }else if(data.BMONTHFEE == "N"){
	    		  $("input:checkbox[id='BMONTHFEE']").prop("checked", false);
	    		  $('#month').text('N');
	    	  }
	    	  
	    	  if(data.BWATER == "Y"){
	    		  $("input:checkbox[id='BWATER']").prop("checked", true);
	    		  $('#water').text('Y');
	    	  }else if(data.BWATER == "N"){
	    		  $("input:checkbox[id='BWATER']").prop("checked", false);
	    		  $('#water').text('N');
	    	  }
	    	  
	    	  
	           },//success
	      error: function() {
			console.log('아작스 실패');
		}
	   });//ajax
	   
}

//월세 리스트 가져오는 함수 
function getDetailData( day ){
	var myid = '<c:out value="${login.myid}"/>';
	
	console.log('ajax day 확인 : '+day);
	
	$('#payment_chk_tax_day').text(day.substr(0, 2) + "년" + day.substr(2, 2) + "월");
	
   //alert('데이터취득');
   $.ajax({
      url : "./detailData",
      type : "get",
      data: {"day" : day, "myid" : myid },
      success:function(voList){
         //alert('success');
         //alert(vo);

         $(".list_col").remove();
         $(".popup_col").remove();
         
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
                     +"<th scope='row'>" + i +"</th>";
            let popApp = "";
                     
                   //삭제여부(미삭제)일 경우에만 
                   if(voList[i].del==0){
                	 
                	  //1.메인페이지 셋팅  
                	  app +="<td id='_name"+i+"'>"+voList[i].name+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].water)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].elec)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].gas)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].inter)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].managerfee)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].monthfee)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].totalfee)+"원"+"</td>"
                	 	 +"<td>"+threeAddComma(voList[i].inputfee)+"원"+"</td>"
                	 	 +"<td id='_restfee"+i+"'>"+threeAddComma(voList[i].restfee)+"원"+"</td>";
                	 	 
                	   if(voList[i].restfee == 0 || voList[i].restfee < 0){
	                	   app+= "<td>완납</td>";
	                   }else{
	                	   app+= "<td>미납</td>";
	                   }
                	   
                	   
                	   if(voList[i].restfee == voList[i].restfeemaster 
                			   && voList[i].inputfee == voList[i].inputfeemaster 
                			   && voList[i].inputfee != '0'){
                		   app += "<td>"+"Y"+"</td>";
                	   }else if(voList[i].inputfee == '0'){
                		   app += "<td>"+"None"+"</td>";   
                	   }else{
                		   app += "<td>"+"N"+"</td>";
                	   }
                	   
                	   //2.팝업페이지 셋팅
                	   popApp += '<option class="popup_col" value="'+i+'" id="member'+i+'">'+voList[i].name+'</option>';
                	   
                   //삭제일 경우에는 
                   }else{
                	   app += "<td colspan='10'>"
                			 +"<font color='#ff0000'>********* 이 글은 존재하지 않거나 작성자에 의해서 삭제되었습니다</font>"
                           +"</td>";
                   }
                     
                app +="</tr>";
                  
			$("#taxtable").append(app);
			$("#memberSelector").append(popApp);
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
	getDuesStatus();
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
	getDuesStatus();
}


function inputModal() {
	$("#_inputBtn").show();
	$("#_alertMsg").hide();
	
	let year;
	let month; 
	let restfee;
	
	year = $("#_year").text();
	month = $("#_month").text();
	//중간에 콤마가 끼어있으면 콤마 뒤에 숫자들이 다 날라가버림 (방지용)
	restfee = $("#_restfee0").text().replace(',', '');
	
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

//관리자 전용
//모달창에서 멤버를 셀렉트 박스에서 선택할경우 그 선택된 해당 멤버의 월세를 대신 납부 입력해줄수 있는 기능(관리자기능)
function inputMemberSelector() {
	$("#_inputBtn").show();
	$("#_alertMsg").hide();
	
	var selector = $("#memberSelector").val();
	var SELECTID = "_restfee" + selector;
	console.log("이게 선택된 아이디값 = " + SELECTID);
	
	year = $("#_year").text();
	month = $("#_month").text();
	restfee = $("#" + SELECTID).text().replace('원','');
	
	console.log('나온 값 = ' + restfee);
	
	restfee = parseInt(restfee.replace(',', ''));
	console.log('변형된 값 = ' + restfee);
	$("#_fee").text(threeAddComma(restfee) + '원');
	$("#_inputfee").val(restfee);
	
	if(restfee == 0 || restfee < 0){
		$("#_inputBtn").hide();
		$("#_alertMsg").css('color', 'red');
		$("#_alertMsg").show();
		$("#_alertMsg").text("이미 전액납부가 완료되었습니다.");
	}
	
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
	var auth;
	//아이디가 없고 이름만 있을 경우
	var name;
	var param;
	
	year = $("#_inputYear").text();
	month = $("#_inputMonth").text();
	fee = $("#_fee").text();
	auth = '<c:out value="${login.auth}"/>';
	console.log('관리자 확인 : ' + auth);
	
	//관리자 일경우에는 이름만 넘김 
	//관리자가 아닐경우에는 아이디가 바로 넘어감 
	if(auth == '3'){
		name = $('#memberSelector option:selected').text();
		myid = '<c:out value="${login.myid}"/>';
	}else{
		myid = '<c:out value="${login.myid}"/>';	
		
	}
	
	
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
	
	//param은 아이디 또는 네임으로 넘어감 
	inputAf(day, myid, inputfee, name);
	
	
	
}

function inputAf(day, myid, inputfee, name) {
	
location.href = "inputTax?day="+day+"&myid="+myid+"&inputfee="+inputfee + "&name=" + name;
	
}


</script>
  




</html>