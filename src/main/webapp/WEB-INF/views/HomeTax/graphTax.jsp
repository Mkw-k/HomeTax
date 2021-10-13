<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
</head>
<body>
<div>
	<select>
		<option>수도세</option>
		<option>전기세</option>
		<option>가스비</option>
		<option>관리비</option>
		<option>인터넷</option>
		<option>월세</option>
	</select>
	<select>
		<option>1</option>
		<option>2</option>
		<option>3</option>
	</select>
</div>
<canvas id="line-chart" width="300" height="250"></canvas>

<script>

var 2020Arr = [];
var 2021Arr = [];



new Chart(document.getElementById("line-chart"), {
	  type: 'line',
	  data: {
	    labels: [1,2,3,4,5,6,7,8,9,10,11,12],
	    datasets: [
	      { 
	        data: [86,114,106,106,107,111,133,221,783,2478],
	        label: "2020",
	        borderColor: "#3e95cd",
	        fill: false
	      }, { 
	        data: [282,350,411,502,635,809,947,1402,3700,5267],
	        label: "2021",
	        borderColor: "#8e5ea2",
	        fill: false
	      }
	    ]
	  },
	  options: {
	    title: {
	      display: true,
	      text: '연도별 월세 분석'
	    }
	  }
	});
</script>

</body>
</html>