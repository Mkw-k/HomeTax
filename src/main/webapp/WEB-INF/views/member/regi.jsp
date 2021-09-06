<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://static.pingendo.com/bootstrap/bootstrap-4.3.1.css">
  
  <!-- 외부 css파일 -->	
  <link href="./resources/content/css/regi_layer_pop.css" rel="stylesheet" type="text/css" />
  
  <style type="text/css">
 	#image_container{
 		height: 250px;
 		width: 100%;
 	}
 	#userPic{
 		margin-top: 5px;
 	}
  </style>
</head>

<body>

<c:import url="/header.jsp" charEncoding="utf-8"/> 
	
	<div class="py-5 text-center">
		<div class="container">
			<div class="row">
				<div class="mx-auto col-lg-6 col-10">
					<c:choose>
						<c:when test="${isUpdate == 'YES'}">
							<h1>회원정보수정</h1>
						</c:when>
						<c:otherwise>
							<h1>회원가입</h1>
						</c:otherwise>
					</c:choose>
					
					<p class="mb-3">관리자 허가없는 회원가입은 강제탈퇴처리 될수 있습니다</p>
					
					<form class="text-left" id="memberFrm"  method="post" enctype="multipart/form-data">
						
						<div class="form-control userPicArea" style="height: 300px;">
							<div id="image_container" style="text-align: center;"></div>
							<label for="form24">사진명 : </label> 
							<span>${login.filename}</span>
							<input type="file" name="userPic" accept="image/*" value="${login.newfilename}" onchange="setThumbnail(event);" id="userPic">
						</div>

						<div class="form-group">
							<label for="form16">이름</label> 
							<input type="text" class="form-control" value="${login.name}" name="name" id="_name" oninput="handleOnInput(this, 'name')"  placeholder="insert name">
						</div>
						<div class="form-group">
							<label for="form23">아이디</label>  
							<input type="text" class="form-control" value="${login.myid}" name="myid" id=_id  oninput="handleOnInput(this, 'userId')" placeholder="insert id">
						</div>
						<div class="form-group">
							<label for="form17">소속</label> 
							<input type="text" class="form-control" value="${login.classify}" name="classify" id="_classify" oninput="handleOnInput(this, 'classify')" placeholder="insert classify">
						</div>
						<div class="form-group">
							<label for="form18">이메일</label> 
							<input type="email" class="form-control" value="${login.email}" name="email" id="_email" oninput="handleOnInput(this, 'email')" placeholder="xxx@xxx.com">
						</div>
						<div class="form-group">
							<label for="form22">전화번호</label> 
							<input type="number" class="form-control" value="${login.phone}" name="phone" id="_phone" oninput="handleOnInput(this, 'phone')" placeholder="-없이 숫자만 입력해주세요">
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="form19">비밀번호</label> 
								<input type="password" name="pwd" value="${login.pwd}" class="form-control" oninput="handleOnInput(this, 'pw')" id="_pw" placeholder="비밀번호">
							</div>
							<div class="form-group col-md-6">
								<label for="form20">비밀번호 확인</label> 
								<input type="password" class="form-control" value="${login.pwd}"  id="_pwcheck" oninput="handleOnInput(this, 'pwCheck')" placeholder="비밀번호체크">
								<span id="comparePw" ></span>
							</div>
						</div>
						<div class="form-group">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="terms"  value="#layer2"> 
									<label class="form-check-label" for="#layer2">
									<a href="#layer2" class="btn-example">이용약관</a>에 동의합니다 
									</label>
							</div>
						</div>
						<c:choose>
							<c:when test="${isUpdate == 'YES'}">
								<button type="button" id="_updateBtn" class="btn btn-primary">Update</button>
							</c:when>
							<c:otherwise>
								<button type="button" id="_regiBtn" class="btn btn-primary">Sign in</button>	
							</c:otherwise>
						</c:choose>
						
					</form>
				</div>
			</div>
		</div>
	</div>

  <div class="dim-layer">
    <div class="dimBg"></div>
    <div id="layer2" class="pop-layer">
        <div class="pop-container">
            <div class="pop-conts">
                <!--content //-->
                <p class="ctxt mb20"><h2>Terms of Use</h2><br>
                    This site is a website to efficiently share monthly rent management and basic inquiries and notices.<br>
                    Therefore, please refrain from using your existing password when signing up.<br>
                    In addition, the personal information provided when signing up for this site will not be used for any other purpose under any circumstances.<br><br>
                    Hope to see you soon!	
                </p>
				<div class="btn-r">
                    <a href="#" class="btn-layerClose">Close</a>
                </div>
                <!--// content-->
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
 
<script> 
	//JSTL로 받아온 지역 정보의 대분류 네임이 서울이면 (일단 자바스크립트 변수로 변경) selected 조건을 줌 
	var area1Name = '<c:out value="${login.newfilename}"/>';
	
	console.log(area1Name);
	
	var image_container = document.getElementById("image_container");
	var img = document.createElement("img"); 
	var imgArea = document.querySelector("div#image_container").appendChild(img);
	imgArea.style.height = "250px";
	imgArea.style.width = "200px";
	
	
	imgArea.src = "./upload/" + area1Name;
	//document.getElementById("imgId").src = "b.PNG";
	
	function setThumbnail(event) { 
		for (var image of event.target.files) { 
			var reader = new FileReader(); 
			
				reader.onload = function(event) { 
				
				var container = document.getElementById('image_container');
				
				var img = document.createElement("img"); 
				img.setAttribute("src", event.target.result); 
				document.querySelector("div#image_container").appendChild(img);
				var imgArea = document.querySelector("div#image_container").appendChild(img);
				imgArea.style.height = "250px";
				imgArea.style.width = "200px";
				
				
				
				}; 
				
				console.log(image); 
				reader.readAsDataURL(image); 
				
				var firchild = document.querySelector("div#image_container").firstChild;
				firchild.remove();
			} 
		} 
	
	function handleOnInput(e, type)  {
		//alert(type);
			
			//아이디
			if(type == 'userId'){
				e.value = e.value.replace(/[^A-Za-z0-9]/ig, '');
				let idChk = "N";
				$("#chkResult").text('');
				
				if(e.value.length > 15){
					//alert('실행');
					e.value = e.value.substring(0,15);
				}
			}
			
			//이름
			if(type == 'name'){
				var pattern = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
				e.value = e.value.replace(pattern, '');
				
				if(e.value.length > 5){
					//alert('실행');
					e.value = e.value.substring(0,5);
				}
			}
			
			//소속
//TODO 대문자 영어가 안들어 가고 있음 !!!!!
			if(type == 'classify'){
				var pattern = /[0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
				e.value = e.value.replace(pattern, '');
				
				if(e.value.length > 15){
					//alert('실행');
					e.value = e.value.substring(0,15);
				}
			}
			
			//전화번호
			if(type == 'phone'){
				e.value = e.value.replace(/[^0-9]/ig, '');
				if(e.value.length > 15){
					//alert('실행');
					e.value = e.value.substring(0,15);
				}
	     	}
			
			//이메일
			if(type == 'email'){
				if(e.value.length > 30){
					//alert('실행');
					e.value = e.value.substring(0,30);
				}
	     	}
			
			//패스워드
			if(type == 'pw'){
					e.value = e.value.replace(/\s/g, '');
					$("#comparePw").text('');
					
				if(e.value.length > 12){
					//alert('실행');
					e.value = e.value.substring(0,12);
				}
				
				if(e.value != $("#_pwcheck").val() && e.value != ""){
					$("#comparePw").text("");
					
					$("#comparePw").text('비밀번호가 다릅니다');
		    		$("#comparePw").css('color', 'red');
				}else if(e.value == $("#_pwcheck").val() && e.value != ""){
					$("#comparePw").text('비밀번호 동일 사용가능!');
		    		$("#comparePw").css('color', 'green');
				}
			}
			
			//패스워드 체크 
			if(type == 'pwCheck'){
					
					$("#comparePw").text('');	
					e.value = e.value.replace(/\s/g, '');
					
					if(e.value.length > 12){
						//alert('실행');
						e.value = e.value.substring(0,12);
					}
					
					if(e.value != $("#_pw").val() && e.value != ""){
						$("#comparePw").text('비밀번호가 다릅니다');
			    		$("#comparePw").css('color', 'red');
					}else if(e.value == $("#_pw").val() && e.value != ""){
						$("#comparePw").text('비밀번호 동일 사용가능!');
			    		$("#comparePw").css('color', 'green');
					}
				}
			
	}
	
	
	$("#_regiBtn").click(function() {
		var isCheckTrue = $("#terms").prop('checked');
		if(isCheckTrue){
			$("form").attr("action", "regiAf").submit();	
		}else{
			alert('약관에 동의해주세요');
			$('#terms').focus();
		}
		
	});
	
	$("#_updateBtn").click(function() {
		$("form").attr("action", "updateAf").submit();
	});
	
	
	
</script>



</body>
<!-- js파일 임포트 -->        
  <script src="./resources/content/js/regi/regi.js"></script> 
</html>