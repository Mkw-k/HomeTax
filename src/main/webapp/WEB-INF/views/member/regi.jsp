<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://static.pingendo.com/bootstrap/bootstrap-4.3.1.css">
  
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
	
	<div class="py-5 text-center">
		<div class="container">
			<div class="row">
				<div class="mx-auto col-lg-6 col-10">
					<h1>회원가입</h1>
					<p class="mb-3">관리자 허가없는 회원가입은 강제탈퇴처리 될수 있습니다</p>
					
					<form class="text-left" action="regiAf" method="post" enctype="multipart/form-data">
						
						<div class="form-control userPicArea" style="height: 300px;">
							<div id="image_container" style="text-align: center;"></div>
							<label for="form24">사진</label> 
							<input type="file" name="userPic"accept="image/*" onchange="setThumbnail(event);" id="userPic">
						</div>

						<div class="form-group">
							<label for="form16">이름</label> 
							<input type="text" class="form-control" name="name" id="_name" oninput="handleOnInput(this, 'name')"  placeholder="고명우">
						</div>
						<div class="form-group">
							<label for="form23">아이디</label> 
							<input type="text" class="form-control" name="myid" id=_id  oninput="handleOnInput(this, 'userId')" placeholder="아이디">
						</div>
						<div class="form-group">
							<label for="form17">소속</label> 
							<input type="text" class="form-control" name="classify" id="_classify" oninput="handleOnInput(this, 'classify')" placeholder="우신빌라">
						</div>
						<div class="form-group">
							<label for="form18">이메일</label> 
							<input type="email" class="form-control" name="email" id="_email" oninput="handleOnInput(this, 'email')" placeholder="j.goethe@werther.com">
						</div>
						<div class="form-group">
							<label for="form22">전화번호</label> 
							<input type="number" class="form-control" name="phone" id="_phone" oninput="handleOnInput(this, 'phone')" placeholder="-없이 숫자만 입력해주세요">
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="form19">비밀번호</label> 
								<input type="password" name="pwd" class="form-control" oninput="handleOnInput(this, 'pw')" id="_pw" placeholder="비밀번호">
							</div>
							<div class="form-group col-md-6">
								<label for="form20">비밀번호 확인</label> 
								<input type="password" class="form-control"  id="_pwcheck" oninput="handleOnInput(this, 'pwCheck')" placeholder="비밀번호체크">
								<span id="comparePw" ></span>
							</div>
						</div>
						<div class="form-group">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" id="form21" value="on"> 
									<label class="form-check-label" for="form21">
									<a href="#">이용약관</a>에 동의합니다 
									</label>
							</div>
						</div>
						<button type="submit" class="btn btn-primary">Sign in</button>
					</form>
				</div>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


<script> 
	
	function setThumbnail(event) { 
		for (var image of event.target.files) { 
			var reader = new FileReader(); 
			
				reader.onload = function(event) { 
				var img = document.createElement("img"); 
				img.setAttribute("src", event.target.result); 
				document.querySelector("div#image_container").appendChild(img);
				var imgArea = document.querySelector("div#image_container").appendChild(img);
				imgArea.style.height = "250px";
				imgArea.style.width = "200px";
				
				}; 
				
				console.log(image); 
				reader.readAsDataURL(image); 
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
	
	
	
	
	
</script>



</body>

</html>