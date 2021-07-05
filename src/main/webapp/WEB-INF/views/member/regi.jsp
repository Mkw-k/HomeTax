<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://static.pingendo.com/bootstrap/bootstrap-4.3.1.css">
</head>

<body>
  <div class="py-5 text-center">
    <div class="container">
      <div class="row">
        <div class="mx-auto col-lg-6 col-10">
          <h1>회원가입</h1>
          <p class="mb-3">관리자 허가없는 회원가입은 강제탈퇴처리 될수 있습니다</p>
          <form class="text-left" action="regiAf" method="post">
            <div class="form-group"> <label for="form16">이름</label> <input type="text" class="form-control" name="name" id="form16" placeholder="고명우" > </div>
            <div class="form-group"> <label for="form23">아이디</label> <input type="text" class="form-control" name="myid" id="form23" placeholder="아이디" > </div>
            <div class="form-group"> <label for="form17">소속</label> <input type="text" class="form-control" name="classify" id="form17" placeholder="우신빌라"> </div>
            <div class="form-group"> <label for="form18">이메일</label> <input type="email" class="form-control" name="email" id="form18" placeholder="j.goethe@werther.com"> </div>
            <div class="form-group"> <label for="form22">전화번호</label> <input type="number" class="form-control" name="phone" id="form22" placeholder="-없이 숫자만 입력해주세요"> </div>
            <div class="form-row">
              <div class="form-group col-md-6"> <label for="form19">비밀번호</label> <input type="password" name="pwd" class="form-control" id="form19" placeholder="••••"> </div>
              <div class="form-group col-md-6"> <label for="form20">비밀번호 확인</label> <input type="password" class="form-control" id="form20" placeholder="••••"> </div>
            </div>
            <div class="form-group">
              <div class="form-check"> <input class="form-check-input" type="checkbox" id="form21" value="on"> <label class="form-check-label" for="form21"><a href="#">이용약관</a>에 동의합니다 </label> </div>
            </div> <button type="submit" class="btn btn-primary">Sign in</button>
          </form>
        </div>
      </div>
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  
  
  
  
</body>

</html>