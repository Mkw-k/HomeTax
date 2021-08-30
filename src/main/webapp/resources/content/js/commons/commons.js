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