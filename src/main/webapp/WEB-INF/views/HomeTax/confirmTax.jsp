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


</style>

</head>
<body>
<c:import url="/header.jsp" charEncoding="utf-8"/> 

  <div class="container">
  	<div class="row">
  		<div class="col-12">
  			<div style="margin-top: 10px;">
  				<h1 style="text-align: center;">
  					납부승인요청
  				</h1>
  			</div>
  			<div id="tax_confirm_table_box" class="table-responsive" style="margin-bottom: 30px;">
  				<table style="margin: 0 auto;" class="table table-striped table-dark" id="taxtable">
  					<tr>
  						<th scope="col">#</th>
  						<th scope="col">아이디</th>
  						<th scope="col">해당월</th>
  						<th scope="col">납부액</th>
  						<th scope="col">납부시간</th>
  						<th scope="col">비고1</th>
  						<th scope="col">납부승인</th>
  						<th scope="col">납부반려</th>
  					</tr>

  				</table>
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
 
  getNoConfirmData();
  	function getNoConfirmData() {
  		$.ajax({
  	      url : "./getNoConfirmData",
  	      type : "get",
  	      dataType : "json",
  	      success:function(data){
  	        console.log(data);
  	        console.log(data.length);
  	        
  	        $('.list_col').remove();
  	        
  	        for (var i = 0; i < data.length; i++) {
  	        	var app; 
  	  	        app += '<tr class= "list_col">';
  	  	        app += '<td>'+(i+1)+'</td>';
  	  	        app += '<td>'+data[i].myid+'</td>';
  	  	        app += '<td>'+data[i].day+'</td>';
  	  	        app += '<td>'+data[i].inputfee+'</td>';
  	  	        app += '<td>'+data[i].insertday+'</td>';
  	  	        app += '<td>'+data[i].htcustome+'</td>';
  	  	        app += '<td><button id="okayInput" class="btn btn-primary" onclick="confirmTax()" value="'+data[i].seq+'">승인</button></td>';
  	  	        app += '<td><button id="recallInput" class="btn btn-primary" onclick="recallTax()" value="'+data[i].seq+'">반려</button></td>';
  	  	        app += '</tr>';
  	  	        
			}
  	        
  	        $('#taxtable').append(app);
  	        
  	      },//success
  	      error : function(){
  			alert('error');
  			}
  	   });//ajax
	}
  	
  	function confirmTax() {
		console.log('승인 시작!!!');
		console.log(event);
		var taxseq = event.target.attributes.value.nodeValue;
		var insertday = event.path[2].childNodes[4].innerText;
		var myid = event.path[2].childNodes[1].innerText;
		var day = event.path[2].childNodes[2].innerText;
		var inputfee = event.path[2].childNodes[3].innerText;
		
		console.log('taxseq' + taxseq +'insertday' + insertday +'myid' + myid +'day' + day +'inputfee' + inputfee);
		
		//location.href = "confirmTaxAf?taxseq="+taxseq+"&insertday="+insertday+"&myid="+myid + "&day=" + day+ "&inputfee=" + inputfee;
		
		var data = {
				taxseq : taxseq,
				insertday : insertday, 
				myid : myid, 
				day : day, 
				inputfee : inputfee
		}
		
		 $.ajax({
		      url : "./confirmTaxAf",
		      type : "post",
		      data : JSON.stringify(data),
		      contentType : 'application/json; charset="utf-8"', 
		      dataType : "json",
		      success:function(data){
		        console.log(data);
		        
		        var msg = data.resultMsg === 'Y' ? '납부성공!' : '납부실패!';
		        alert(msg);
		      },//success
		      error : function(){
				alert('error');
				}
		   });//ajax
	    
		 sleep(500).then(() => location.reload());
		//getNoConfirmData();
	}
  	
  	function recallTax() {
		console.log('반려 시작!!!');
		console.log(event);
		var taxseq = event.target.attributes.value.nodeValue;
		var insertday = event.path[2].childNodes[4].innerText;
		var myid = event.path[2].childNodes[1].innerText;
		var day = event.path[2].childNodes[2].innerText;
		var inputfee = event.path[2].childNodes[3].innerText;
		
		console.log('taxseq' + taxseq +'insertday' + insertday +'myid' + myid +'day' + day +'inputfee' + inputfee);
		
		//location.href = "recallTaxAf?taxseq="+taxseq+"&insertday="+insertday+"&myid="+myid + "&day=" + day+ "&inputfee=" + inputfee;
		
		//var url ='/a/recallTaxAf';
		var type = 'post';
		var data = {
					taxseq : taxseq,
					insertday : insertday, 
					myid : myid, 
					day : day, 
					inputfee : inputfee
		}
		
		 $.ajax({
		      url : "./recallTaxAfter",
		      type : "post",
		      data : JSON.stringify(data),
		      contentType : 'application/json; charset="utf-8"', 
		      dataType : "json",
		      success:function(data){
		        console.log(data);
		        var msg = data.resultMsg === 'Y' ? '반려성공!' : '반려실패!';
		        alert(msg);
		      },//success
		      error : function(){
				alert('error');
				}
		   });//ajax
	 
		 sleep(500).then(() => location.reload());
		//getNoConfirmData();
  	}
  	
  	
  	
  	

  	

 
  </script>

</body>
</html>