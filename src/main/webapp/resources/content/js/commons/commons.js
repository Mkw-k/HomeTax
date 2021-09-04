/**
 * 공통 js 함수 보관용 js파일 
 */
 
 
 
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
		if(day.toString().length == 1){
			day = '0' + day.toString();
		}
		console.log('교체된 day : ' + day);
		return day;
	}
	
	function threeAddComma(money){
		money = money.toLocaleString('ko-KR');
		//console.log('변경된 금액 문자열 : ' + money);
		return money;
	}
	
	
	/*
	 * AJAX 공통함수 <br>
	 * JSON 형식으로 가고 JSON 형식으로 받음 <br>
	 * @author K  <br>
	 * @param : url(action), type(get/post), param(parameter) <br>
	 * @return data.result (맵.result)	
	 */
	function run_ajax(url, type, param){
			var data;
			
			if(type == 'post'){
				param = JSON.stringify(param);
			}
			
			$.ajax({
			url: url,
			type: type,
			//cache: ,		//요청 페이지의 캐시 여부. false 또는 true
			dataType: "json",	//서버에서 받아올 데이터를 어떤 형태로 해석할 것인지. xml, json, html, script를 선택할 수 있다.
			data: param,
			//async: false,
			contentType: 'application/json; charset=utf-8',
			success: function(data) {
				console.log("결과 : ");
				console.log(data);
				return data;
			},
			error: function(request, status, error) {
				alert('error occured!');
				return data;
			}
		});
		

		//출처: https://shxrecord.tistory.com/108 [첫 발]
	}
	
	
	
	
	function run_get_ajax(url, type, param){
		var data;
		
		$.ajax({
		type : type,
		data : param,
		url : url,
		aysnc : false,
		success:function(data){
			console.log('내부확인');
			console.log(data);
			data = data;
		}, 
		error:function(){
			alert('에러발생');
			data = data;
		} 
		});
		
		return data;
	}
	
	//YYYYMMDDHHMMSS 년 월 일 시 분 초 추가
	function date_remodelling(time){
		let date = time.slice(0,4) + '.' + time.slice(4, 6) + '.' + time.slice(6,8) + '. ' + time.slice(8, 10) + ':' + time.slice(10, 12);
		return date;
	}