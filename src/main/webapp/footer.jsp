<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

 <!-- 카카오맵스 -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <!-- 카카오맵스 -->
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=685fcbb766340d7c8812f4e0a29a6661&libraries=services"></script>
  
    
<div class="py-5 text-white" style="background-image: linear-gradient(to bottom, rgba(0, 0, 0, .75), rgba(0, 0, 0, .75)), url(https://static.pingendo.com/cover-bubble-dark.svg);  background-position: center center, center center;  background-size: cover, cover;  background-repeat: repeat, repeat;">
    <div class="container">
      <div class="row">
        <div class="col-md-6 text-center align-self-center p-4">
          <p class="mb-5"> <strong>MK SOFT Inc.</strong> <br>1265 Ori-ro, Guro-gu <br>Seoul, Republic of Korea 08257 <br> <abbr title="Phone">P :</abbr> +82(010) 2607-4128 </p>
          <div class="row">  
            <div class="col-md-12 d-flex align-items-center justify-content-around"> 
            <a href="https://www.facebook.com/">
                <i class="d-block fa fa-facebook-official text-light fa-lg mx-2"></i>
              </a> 
              <a href="https://www.instagram.com/">
                <i class="d-block fa fa-instagram text-light fa-lg mx-2"></i>
              </a> 
              <a href="https://www.google.co.kr/">
                <i class="d-block fa fa-google-plus-official text-light fa-lg mx-2"></i>
              </a>
               <a href="https://www.pinterest.co.kr/">
                <i class="d-block fa fa-pinterest-p text-light fa-lg mx-2"></i>
              </a>
               <a href="https://www.reddit.com/">
                <i class="d-block fa fa-reddit text-light fa-lg mx-2"></i>
              </a>
               <a href="https://twitter.com/?lang=ko">
                <i class="d-block fa fa-twitter text-light fa-lg ml-2"></i>
              </a> 
              </div>
          </div>
        </div>
        <div class="col-md-6 p-0"> <div id="map" style="width:100%;height:350px;"></div></div>
      </div>
    </div>
  </div>
  
  
 <script type="text/javascript">

 var mapContainer = document.getElementById('map'), // 지도를 표시할 div
 mapOption = {
     center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
     level: 3 // 지도의 확대 레벨
 };

//지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var dAdress = '서울 구로구 궁동 213-21';

//주소로 좌표를 검색합니다
geocoder.addressSearch(dAdress, function(result, status) {

 // 정상적으로 검색이 완료됐으면
  if (status === kakao.maps.services.Status.OK) {

     var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

     // 결과값으로 받은 위치를 마커로 표시합니다
     var marker = new kakao.maps.Marker({
         map: map,
         position: coords
     });

     // 인포윈도우로 장소에 대한 설명을 표시합니다
     var infowindow = new kakao.maps.InfoWindow({
         content: '<div style="width:150px;text-align:center;padding:6px 0;color:black;">this here</div>'
     });
     infowindow.open(map, marker);

     // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
     map.setCenter(coords);
 }
});


</script>