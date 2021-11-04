/**
 * 공통 js 함수 보관용 js파일 
 */
 
 //모바일인지 확인하는 함수 
 function Mobile(){
	return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
	
 }
	
//모바일일 경우에는 메인페이지 버튼 추가해줌 
if (Mobile()){// 모바일일 경우
	console.log('모바일임');
	var app = '<li class="nav-item"> <a class="nav-link" href="javascript:window.location.replace("home");">메인페이지로</a> </li>';
    $('#top_menu_ul').append(app);
} else {// 모바일 외
    console.log('모바일아님');
}

 //잠시 쉬었다가게 하는 콜백함수??? 조금 더 분석 필요 
	function sleep(ms) {
	  return new Promise((r) => setTimeout(r, ms));
	}
 
 
  //현재 년 월을 불러와서 셋팅 
    function setYearMonth() {
    	var date = new Date();
    	
    	var year = date.getFullYear();
    	year = year + "";
    	var twoYear = year.substr(2,2);
    	var $year = document.getElementById('_year');
    	$year.text = twoYear;
    	console.log('년도 확인');
    	console.log($year.text);
    	
    	var month = date.getMonth();
    	var nowMonth = month +1;
    	var $month = document.getElementById('_month');
    	$month.text = nowMonth;
    	console.log('월 확인');
    	console.log($month.text);
	} 
    
    //08월이 8월로 찍히는거 방지 그럴경우 앞에 0을 붙여주고 리턴 
    function safeDate(day) {
    	console.log('safe작동');
    	console.log(day);
		if(day.toString().length === 1){
			day = '0' + day.toString();
		}
		console.log('교체된 day : ' + day);
		return day;
	}
	
	/**
	*<pre>숫자 3자리 마다 콤마를 찍어주는 함수</pre>
	*1000 => 1,000 <br>
	*@author K <br>
	*@param money <br>
	*@returns money <br>
	*/
	function threeAddComma(money){
		money = money.toLocaleString('ko-KR');
		//console.log('변경된 금액 문자열 : ' + money);
		return money;
	}
	
	
//21년09월 => 2109 숫자로 변경해줌 
function deleteYearNMonthText(day){
	day = day.replace(/[^0-9]/ig, '');
	console.log(day);
	return day;
}
	
	
	/** <pre>
	 * AJAX 공통함수 
	 * JSON 형식으로 가고 JSON 형식으로 받음 <br>
	 * 211104 보수 완료
	 * @author K  
	 * @param : url(action)    
	 * @param : type(get/post)	 - 일단 post만 테스트 완료
	 * @param : param(parameter)
	 * @return JSON data.result (맵.result)
	 * </pre>	
	 */
function run_ajax(url, type, param){
	var result;
	
	// url에 mehod 방식에 맞게 데이터를 보냄.
	var request = $.ajax({
	    url: url,
	    method: type,
	    data: JSON.stringify(param),
	    //data: param,
	    //dataType : 'json',
	    contentType: "application/json; charset=UTF-8",
	    async: false ,
	});
	// 성공 시, 받아온 데이터가 msg에 담김
	request.done(function(msg) {
	    console.log("ajax completed: " + msg)
	    console.log(msg); 
	    result = msg;
	});
	// 실패 시, 결과 출력
	request.fail(function(jqXHR, textStatus) {
	    console.log('ajax fail'); 
	    console.log("ajax failed: " + textStatus)
	});
	
	return result;
}
/*
function run_ajax(url, type, data){
	var return_data;
	$.ajax({
		url : url,
		data : JSON.stringify(data),
		type : type,
		aysnc : false,
		ContentType : 'application/json; charset="utf-8"',
		Traditional : true, 
		success:function(data){
			console.log('내부확인');
			console.log(data);
			return_data = data;
		}, 
		error:function(){
			alert('에러발생');
			return;
		} 
		}); 
		
	return return_data;
} 
*/
	
	
	//YYYYMMDDHHMMSS 년 월 일 시 분 초 추가
	function date_remodelling(time){
		let date = time.slice(0,4) + '.' + time.slice(4, 6) + '.' + time.slice(6,8) + '. ' + time.slice(8, 10) + ':' + time.slice(10, 12);
		return date;
	}
	
	
	//객체째로 필요한 데이터만 콤마 추가 
	//추후 수정은 키값으로 비교가 아닌 typeof의 형태로 비교하는 방식으로 리팩토링이 필요함 
	function object_threeAddComma(listObj){
		
		var reformattedList = listObj.map(function(obj){
		  	    var rObj = {};
		  	    
		  	  /*  for (const key in obj){ 
		  	    	if(key === 'day' || key === 'inputfee' || key === 'totalfee' || key === 'restfee' || key === 'name'|| key === 'del'){
					  //console.log(key + ' : ' + obj[key]);
						  if(key !== 'name' || key !== 'day' || key !== 'del'){
							  rObj[key] = threeAddComma(obj[key]);
						  }else{
							  rObj[key] = obj[key];  
						  }
				 }
	  	    	}
	  	    	*/
	  	    	for (const key in obj){ 
		
					if(key === 'day' || key === 'inputfee' || key === 'totalfee' || key === 'restfee' || key === 'name'|| key === 'del'){
					  //console.log(key + ' : ' + obj[key]);
						  if(key !== 'name' || key !== 'day' || key !== 'del'){
							  rObj[key] = threeAddComma(obj[key]);
						  }else{
							  rObj[key] = obj[key];  
						  }
				 }
	  	    	}
	  	   		return rObj;
	  	    });
	  	    
	  return reformattedList;
	}


function getGeoData(position){
	const lat = position.coords.latitude;
	const lon = position.coords.longitude;
	//console.log("You live in", lat, lon);
	const url = "https://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+lon+"&appid=fa4393e1052b7e6c525e9debabc64d8d&units=metric";
	fetch(url).then(response => response.json()).then(data => {
		//console.log(data);
		const weatherContainer = document.querySelector("#weather span:first-child");
		const cityContainer = document.querySelector("#weather span:last-child");
		cityContainer.innerText = data.name;
		weatherContainer.innerText = data.weather[0].main + " / " + Math.round(data.main.temp) + " °C";
	});
}
function getGeoDataError(){
	alert("Can't find you. No weather for you.");
}

navigator.geolocation.getCurrentPosition(getGeoData, getGeoDataError);




