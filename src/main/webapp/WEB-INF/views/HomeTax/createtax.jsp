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
  <div class="py-3">
    <div class="container">
      <div class="row" >
        <div class="col-md-8 p-4">
          <h1>월세입력페이지</h1>
          <p>what matters to me most is how i live, that you wold not judge, that you would show up early, that you'd be kind, that you'd make sure that servants towel is hege and used that if you're gonna do smething you do it the rightway</p>
        </div>
      </div>
      <div class="row">
        <div class="col-md-5 p-4">
          <h3>how i live</h3>
          <p> that how you do anything is how you do everything</p>
          <p class="lead mt-3"> <b>Support</b> </p>
          <p> <a href="#">+1 234 567 89</a> </p>
          <p> <a href="#">support@hello.com</a> </p>
          <p class="lead mt-3"> <b>Sales</b> </p>
          <p> <a href="#">+1 234 567 89</a> </p>
          <p> <a href="#">sales@hello.com</a> </p>
          <p class="lead mt-3"> <b>General</b> </p>
          <p> <a href="#">info@hello.com</a> </p>
        </div>
        <div class="col-md-7 p-4">
          <h3 class="mb-3">월세입력</h3>
          <form action="createTax" method="post">
            <div class="form-row">
              <div class="form-group col-md-6"> <input type="text" class="form-control" name="day" id="form36" placeholder="yymm"> </div>
              <div class="form-group col-md-6"> <input type="text" class="form-control" id="form37" name="water" placeholder="수도세"> </div>
            </div>
            <div class="form-group"> <input type="text" class="form-control" id="form38" name="elec" placeholder="전기세"> </div>
            <div class="form-group"> <input type="number" class="form-control" id="form39" name="gas" placeholder="가스비"> </div>
            <div class="form-row">
              <div class="form-group col-md-6"> <input type="number" class="form-control" id="form40" name="inter" placeholder="인터넷비"> </div>
              <div class="form-group col-md-6"> <input type="text" class="form-control" id="form41" name="managerfee" placeholder="관리비"> </div>
            </div>
            <div class="form-group"> <input type="text" class="form-control" id="form42" name="monthfee" placeholder="월세"> </div>
            <div class="form-group"> <textarea class="form-control" id="form43" rows="3" placeholder="Your message"></textarea> </div> <button type="submit" class="btn btn-primary">Send</button>
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