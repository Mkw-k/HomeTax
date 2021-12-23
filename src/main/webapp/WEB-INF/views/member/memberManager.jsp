<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://static.pingendo.com/bootstrap/bootstrap-4.3.1.css">
<title>Insert title here</title>
</head>
<body>

<c:import url="/header.jsp" charEncoding="utf-8"/> 
<div style="text-align: center;">
<h1>회원관리 페이지</h1>
</div>
<div style="text-align: center;">
	<table style="margin: 0 auto;">
		<thead>
			<tr>
				<th>NAME</th>
				<th>CLASSIFY</th>
				<th>EMAIL</th>
				<th>PHONE</th>
				<th>ISSALE</th>
				<th>MYID</th>
				<th>AUTH</th>
				<th>삭제여부(y/n)</th>
				<th>수정</th>
				<th>회원강퇴</th>
			</tr>
		</thead>
		<tbody id="member_table_body">
		
		</tbody>
	</table>
</div>
 <c:import url="/footer.jsp" charEncoding="utf-8"/> 
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
 <!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>
<!-- js파일 임포트 -->        
 <script src="./resources/content/js/commons/commons.js"></script> 

</body>

<script type="text/javascript">
var result;

getMemberData();
setDataGrid();

function getMemberData() {
	var URL = './getAllMemberData';
	var type = 'post';
	var param = {};
	
	result = run_ajax(URL, type, param);
	
	console.log(result);
}


function setDataGrid() {
	var memberApp = '';

	for (var i = 0; i < result.length; i++) {
		memberApp += '<tr class="memberData">';
		memberApp += '<td>'+result[i].NAME+'</td>';
		memberApp += '<td>'+result[i].CLASSIFY+'</td>';
	 	memberApp += '<td>'+result[i].EMAIL+'</td>';
	 	memberApp += '<td>'+result[i].PHONE+'</td>';
	 	memberApp += '<td>';
		memberApp += '<select>';
		if(result[i].ISSALE == 0){
			memberApp += '	<option value="0" selected>일반</option>';
			memberApp += '	<option value="1">할인</option>';
			memberApp += '	<option value="9">운영자</option>';
		}else if(result[i].ISSALE == 1){
			memberApp += '	<option value="0">일반</option>';
			memberApp += '	<option value="1" selected>할인</option>';
			memberApp += '	<option value="9">운영자</option>';
		}else{//9
			memberApp += '	<option value="0">일반</option>';
			memberApp += '	<option value="1">할인</option>';
			memberApp += '	<option value="9" selected>운영자</option>';
		}
		memberApp += '</select>';
		memberApp += '</td>';
		memberApp += '<td>'+result[i].MYID+'</td>';
		memberApp += '<td>';
		memberApp += '<select>';
		if(result[i].AUTH == 1){
			memberApp += '	<option value="1" selected>일반(홈멤버)</option>';
			memberApp += '	<option value="9">일반(기본)</option>';
			memberApp += '	<option value="3">운영자</option>';
		}else if(result[i].AUTH == 9){
			memberApp += '	<option value="1">일반(홈멤버)</option>';
			memberApp += '	<option value="9" selected>일반(기본)</option>';
			memberApp += '	<option value="3">운영자</option>';
		}else{//3
			memberApp += '	<option value="1">일반(홈멤버)</option>';
			memberApp += '	<option value="9">일반(기본)</option>';
			memberApp += '	<option value="3" selected>운영자</option>';
		}
		memberApp += '</select>';
		memberApp += '</td>';
		memberApp += '<td>'+result[i].DEL+'</td>';
		memberApp += '<td><input type="button" value="수정" id="memberUpdate" onclick="updateMember(event)" ></td>';
		memberApp += '<td><input type="button" value="강퇴" id="memberKick" onclick="kickMember(event)" ></td>';
		memberApp += '</tr>';
	}	
	
	
	$('#member_table_body').append(memberApp);
}

function updateMember(event) {
	
}

function kickMember(event) {
	console.log('멤버강퇴 클릭');
	var result = confirm('해당 유저를 삭제하시겠습니까'); 
	
	if(result){
		
		console.log(event);
		var delete_member_id = event.path[2].childNodes[5].innerHTML;
		console.log('아이디 확인');
		console.log(delete_member_id);
		
		var result = run_ajax('deleteMember', 'post', delete_member_id);
		console.log(result);
		
		$('.memberData').remove();
		
		getMemberData();
		setDataGrid();
	}
	
}




</script>
</html>