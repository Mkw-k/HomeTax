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

/* 레이어팝업 */
/* reset */
button {
  padding:0;
  background:none;
  border:0;
  cursor:pointer;
}

/* 버튼 영역 */
.btnBox {
  text-align:center;
}

.popOpenBtnCmmn {
  width:200px; 
  height:60px; 
  background:#000; 
  color:#fff; 
  font-size:16px;
  opacity:0.7;
  transition:all 0.3s;
}

.popOpenBtnCmmn:hover {
  opacity:1;
}

/* 팝업 영역 */
.popCmmn {
  display:none;
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
}

.popBg {
  position:absolute;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background:rgba(0,0,0,0.7);
}

.popInnerBox {
  display:flex;
  justify-content:space-between;
  flex-direction:column;
  position:absolute;
  top:50%;
  left:50%;
  width:400px;
  height:250px;
  margin:-125px 0 0 -200px;
  text-align:center;
  background:#fff;
  border-radius:5px;
}

.popHead {
  padding:15px;
  background:#000;
  color:#fff;
  font-size:18px;
}

.popBody {
  padding:10px;
  box-sizing:border-box;
  font-size:14px;
}

.popCloseBtnCmmn {
  width:30%;
  margin:10px;
  padding:10px;
  font-size:16px;
  background:#999;
  color:#fff;
  transition:all 0.3s;
}

.popCloseBtnCmmn:hover {
  background:#666;
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
  
  <!-- 레이어팝업 --> 
   <div id="popUp_1" class="popCmmn" style="overflow : auto;">
    <div class="popBg" data-num="1"></div>
    <div class="popInnerBox">
      <div class="popHead">
      	<span id="pop_tax_year" style='color:white;'></span>
      	<span id="pop_tax_month" style='color:white;'></span>
      </div>
      <div class="popBody" id="pop_tax_list" style="margin: 0 auto; text-align: center;">
      	<table style="border-spacing: 5px; border-collapse: separate;">
      		<thead>
				<tr>
					<th>아이디</th>
					<th>납부시간</th>
					<th>납부금액</th>
					<th>비고</th>
				</tr>
      		</thead>
      		<tbody id="pop_tax_table_body">
      		</tbody>
      	</table>
      </div>
      <div class="popFoot">
        <button class="popCloseBtnCmmn" type="button" data-num="1">확인</button>
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
		                	 app +="<td><a href='#' class='pop_tax_href' data-num='1' onclick='getMonthInputListPop()'>"+year+"년"+month+"월"+"</a></td>"
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
	      type : "post",
	      data : JSON.stringify(param),
	      contentType : 'application/json; charset="utf-8"', 
	      dataType : "json",
	      success:function(list){
	         console.log(list);
	         //레이어 팝업 제목 셋팅 (연월 셋팅)
	         $('#pop_tax_year').text(day.substr(0,2) + "년");
	         $('#pop_tax_month').text(day.substr(2,4) + "월");
	         
	         var app;
	         $('.pop_tax_list_data').remove();
	         
	         if(list.length == 0){
	        	 app += '<tr class="pop_tax_list_data">';
		         app += '	<td colspan="3" id="pop_tax_id" style="color:red; text-align:center;">데이터가 존재하지 않습니다</td>      	';
		         app += '</tr>';
	         }else{
	        	 for (var i = 0; i < list.length; i++) {
					 var myid = list[i].MYID;
	 		 	 	 var inputtime = (list[i].INSERTDAY).substr(0,4) + "." + (list[i].INSERTDAY).substr(4,2) + "." + (list[i].INSERTDAY).substr(6,2) + "." + (list[i].INSERTDAY).substr(8,2) 
	 								+ ":" + (list[i].INSERTDAY).substr(10,2) + ":" + (list[i].INSERTDAY).substr(12,2);				 				
					 var htcustomer = list[i].HTCUSTOMER1;
//함수가 동작하지 않고 있음 원인확인 필요
					 var inputfee = threeAddComma(list[i].INPUTFEE);
					 
					 
			         app += '<tr class="pop_tax_list_data">';
			         app += '	<td id="pop_tax_id">'+myid+'</td>      	';
			         app += '	<td id="pop_tax_input_time">'+inputtime+'</td>   ';
			         app += '	<td id="pop_tax_input_amount">'+inputfee+'원</td>  ';
			         app += '	<td id="pop_tax_custome">'+htcustomer+'</td>      ';
			         app += '</tr>';
						
			        
				}	         
	         }
	         
			 
	          
			 $('#pop_tax_table_body').append(app);
			 
			 //팝업띄우기 			 
			 $('#popUp_1').fadeIn(200);
	      },//success
	      error : function(){
			alert('error');
			}
	   });//ajax
	   
	   

}



//레이어팝업
$(function(){
	  setPop();
	});


	// 팝업 세팅
	function setPop() {
	  /*
	  var popOpenBtn = $('.pop_tax_href');
	  
	  //팝업 열기
	 
	  popOpenBtn.on('click',function(){
	    var clickNum = $(this).attr('data-num');
	    
	    $('#popUp_'+clickNum).fadeIn(200);
	  })
	  */
	  
	  //팝업 닫기
	  $('.popBg, .popCloseBtnCmmn').on('click',function(){
	    var clickNum = $(this).attr('data-num');
	    
	    $('#popUp_'+clickNum).fadeOut(200);
	  })
	}


</script>
  

</body>
</html>