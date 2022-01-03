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
<input type="button" value="수정" id="memberUpdate" style="text-align: right !important;" onclick="updateMember(event)" >
</div>
<div style="text-align: center;">
	<table style="margin: 0 auto;">
		<thead>
			<tr>
				<th></th>
				<th>NAME</th>
				<th>CLASSIFY</th>
				<th>EMAIL</th>
				<th>PHONE</th>
				<th>ISSALE</th>
				<th>MYID</th>
				<th>AUTH</th>
				<th>삭제여부(y/n)</th>
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
		var issale = result[i].ISSALE;
		var auth = result[i].AUTH;
		var del = result[i].DEL;
		console.log(i+'번째 셀렉 데이터' + 'issale, auth, del :: ' + issale +', ' + auth + ', ' + del);
		
		memberApp += '<tr class="memberData">';
		memberApp += '<td>';
		memberApp += '<input type="checkbox" name="user_checkbox">';
		memberApp += '</td>';
	 	memberApp += '<td>'+'<input type="text" value="'+result[i].NAME+'">'+'</td>';
	 	memberApp += '<td>'+'<input type="text" value="'+result[i].CLASSIFY+'">'+'</td>';
	 	memberApp += '<td>'+'<input type="text" value="'+result[i].EMAIL+'">'+'</td>';
	 	memberApp += '<td>'+'<input type="text" value="'+result[i].PHONE+'">'+'</td>';
	 	
	 	memberApp += '<td>';
		memberApp += '<select>';
		if(result[i].ISSALE == 0){
			memberApp += '	<option value="0" selected="selected">일반</option>';
			memberApp += '	<option value="1">할인</option>';
			memberApp += '	<option value="9">운영자</option>';
		}else if(result[i].ISSALE == 1){
			memberApp += '	<option value="0">일반</option>';
			memberApp += '	<option value="1" selected="selected">할인</option>';
			memberApp += '	<option value="9">운영자</option>';
		}else{//9
			memberApp += '	<option value="0">일반</option>';
			memberApp += '	<option value="1">할인</option>';
			memberApp += '	<option value="9" selected="selected">운영자</option>';
		}
		memberApp += '</select>';
		memberApp += '</td>';
		memberApp += '<td>'+result[i].MYID+'</td>';
		memberApp += '<td>';
		memberApp += '<select>';
		if(result[i].AUTH == 1){
			memberApp += '	<option value="1" selected="selected">일반(홈멤버)</option>';
			memberApp += '	<option value="9">일반(기본)</option>';
			memberApp += '	<option value="3">운영자</option>';
		}else if(result[i].AUTH == 9){
			memberApp += '	<option value="1">일반(홈멤버)</option>';
			memberApp += '	<option value="9" selected="selected">일반(기본)</option>';
			memberApp += '	<option value="3">운영자</option>';
		}else{//3
			memberApp += '	<option value="1">일반(홈멤버)</option>';
			memberApp += '	<option value="9">일반(기본)</option>';
			memberApp += '	<option value="3" selected="selected">운영자</option>';
		}
		memberApp += '</select>';
		memberApp += '</td>';
		memberApp += '<td>';
		memberApp += '<select>';
		if(result[i].DEL == 'Y'){
			memberApp += '	<option value="Y" selected="selected">Y</option>';
			memberApp += '	<option value="N">N</option>';
		}else{
			memberApp += '	<option value="Y">Y</option>';
			memberApp += '	<option value="N" selected="selected">N</option>';
		}
		memberApp += '</select>';
		memberApp += '</td>';
		memberApp += '<td><input type="button" value="강퇴" id="memberKick" onclick="kickMember(event)" ></td>';
		memberApp += '</tr>';
	}	
	
	
	$('#member_table_body').append(memberApp);
}

function updateMember(event) {
	console.log('수정버튼 클릭됨');
//	user_checkbox
	var rowData = new Array();
	var tdArr = new Array();
	var checkbox = $('input[name=user_checkbox]:checked');
	console.log(checkbox);
	//tr
	//var checkbox_list = checkbox[0].offsetParent.nextSibling.parentElement.cells;
	//console.log(checkbox_list);

	checkbox.each(function(i) {
		/*
		var tr = checkbox.parent()[i);
		var td = tr.children();
		*/
		var td = checkbox[i].parentNode.parentElement.childNodes;
		
		console.log('td확인');
		console.log(td);

		var name = td[1].firstChild.value + "";
		var classify = td[2].firstChild.value + "";
		var email = td[3].firstChild.value + "";
		var phone = td[4].firstChild.value + "";
		var issale = td[5].children[0].value+ "";
		var myid = td[6].outerText + "";
		var auth = td[7].children[0].value + "";
		var delyn = td[8].children[0].value + "";

		var tempMap = {
				name : name,
				classify : classify,
				email : email,
				phone : phone,
				issale : issale,
				myid : myid,
				auth : auth,
				del : delyn,
		}
		
		
		tdArr.push(tempMap);
	});
	
	console.log('td 데이터확인');
	console.log(tdArr);
	
	//컨트롤러 연결해야되는 부분 
	var result = run_ajax('updateMemberAdmin', 'post', tdArr);
	$('.memberData').remove();
	getMemberData();
	setDataGrid();
}

function kickMember(event) {
	console.log('멤버강퇴 클릭');
	var result = confirm('해당 유저를 삭제하시겠습니까'); 
	
	if(result){
		
		console.log(event);
		var delete_member_id = event.path[2].childNodes[6].innerHTML;
		console.log('아이디 확인');
		console.log(delete_member_id);
		
		var result = run_ajax('deleteMember', 'post', delete_member_id);
		console.log(result);
		
		if(result.result === 'SUCCESS'){
			alert('강퇴성공');
			$('.memberData').remove();
			getMemberData();
			setDataGrid();
		}else{
			alert('강퇴실패');
		}
	}
	
}




</script>
</html>