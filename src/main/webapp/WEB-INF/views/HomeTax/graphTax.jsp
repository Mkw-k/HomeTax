<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="https://static.pingendo.com/bootstrap/bootstrap-4.3.1.css">
</head>

<style>
#graph_container {
	margin-top: 8px;
	margin-bottom: 8px;
}

#line-chart{
	margin: 0 auto !important;
}
</style>
<body>


<c:import url="/header.jsp" charEncoding="utf-8"/> 

<div id="graph_container">
	<div>
		<select id="select_content" onchange="createChart()"  class="form-control selectpicker">
			<option value="WATER">수도세</option>
			<option value="ELEC">전기세</option>
			<option value="GAS">가스비</option>
			<option value="MANAGERFEE">관리비</option>
			<option value="INTER">인터넷</option>
			<option value="MONTHFEE">월세</option>
		</select>
		<select class="form-control selectpicker" style="margin-top: 10px; display: none;">
			<option>1</option>
			<option>2</option>
			<option>3</option>
		</select>
	</div>

	<div id="chart_box" class="chart_box_area" style="position: relative; height:80vh; width:100vw">
		<canvas id="line-chart"></canvas>
	</div>
</div>

 <c:import url="/footer.jsp" charEncoding="utf-8"/> 
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
 <!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>
<!-- js파일 임포트 -->        
 <script src="../resources/content/js/commons/commons.js"></script> 
<script>

var fArr = new Array();
var sARr = new Array();
var select_data = "";
var tempObj = {};

createChart();

function createChart() {
	
	$.ajax({
	      url : "./getMonthTaxListData",
	      type : "get",
	      dataType:"json",
	      success:function(data){
	    	console.log(data);
	    	  //데이터 전처리 
	    	  for (var i = 0; i < data.length; i++) {
				
				var key =  data[i].DAY; 
				//eval("var " + key + "= new Array();"); 
				console.log('데이터 확인 !!!!');
				console.log(key);

				
				select_data = $('#select_content').val();
				
				switch (select_data) {
				  case 'ELEC':
				    console.log( '선택값 : ELEC' );
				    tempObj[key] =data[i].ELEC;
				    break;
				  case 'WATER':
				  	console.log( '선택값 : WATER' );
				  	tempObj[key] =data[i].WATER;
				    break;
				  case 'GAS':
				  	console.log( '선택값 : GAS' );
				  	tempObj[key] =data[i].GAS;
				    break;
				  case 'INTER':
				  	console.log( '선택값 : INTER' );
				  	tempObj[key] =data[i].INTER;
				    break;
				  case 'MANAGERFEE':
				  	console.log( '선택값 : MANAGERFEE' );
				  	tempObj[key] =data[i].MANAGERFEE;
				    break;
				  default:
				    console.log('디폴트는 MONTHFEE');
				  	tempObj[key] =data[i].MONTHFEE;
				}
					
					
				
			}
	    	  
	    	  console.log('tempObj >>>');
	    	  console.log(tempObj);
	    	  
	    	  let array = Object.keys(tempObj);
	    	  
	    	  const a2020 = array.filter(item => item.substr(0, 2) == '20');
	    	  const a2021 = array.filter(item => item.substr(0, 2) == '21');
	    	  
	    	  let arrayOfNumbers2020 = a2020.map( item => parseInt(item));
	    	  let arrayOfNumbers2021 = a2021.map( item => parseInt(item));
	    	  
	    	  const realArray2020 = new Array();
	    	  const realArray2021 = new Array();
	    	  
	    	  
	    	  //2020년일떄 
	    	  for (var i = 0; i < 12; i++) {
	    		  if(arrayOfNumbers2020.indexOf(i+1)){
	    			  realArray2020[i] = tempObj['20'+safeDate(i+1)];
	    		  }else{
	    			  realArray2020[i] = '0';
	    		  }
			}
	    	  
	    	  //2021년일때 
	    	  for (var i = 0; i < 12; i++) {
	    		  if(arrayOfNumbers2021.indexOf(i+1)){
	    			  realArray2021[i] = tempObj['21'+safeDate(i+1)];
	    		  }else{
	    			  realArray2021[i] = '0';
	    		  }
			}
	    	  
	    	  console.log('realArray2020 >>> '); 
	    	  console.log(realArray2020);
	    	  console.log('realArray2021 >>> '); 
	    	  console.log(realArray2021);
	    	  
	    	  new Chart(document.getElementById("line-chart"), {
	    		  type: 'line',
	    		  data: {
	    		    labels: [1,2,3,4,5,6,7,8,9,10,11,12],
	    		    datasets: [
	    		      { 
	    		        data: realArray2020,
	    		        label: "2020",
	    		        borderColor: "#3e95cd",
	    		        fill: false
	    		      }, { 
	    		        data: realArray2021,
	    		        label: "2021",
	    		        borderColor: "#8e5ea2",
	    		        fill: false
	    		      }
	    		    ]
	    		  },
	    		  options: {
	    				//responsive: false,
	    				maintainAspectRatio: false,
	    				scales: {
	    					yAxes: [{
	    						ticks: {
	    							beginAtZero: true
	    						}
	    					}]
	    				},
	    				title: {
	  	    		      display: true,
	  	    		      text: '연도별 월세 분석'
	  	    		    }
	    			}
	    		});
	    	  
	    	  
	    	  
	      }//success
	   });//ajax
}


</script>

</body>
</html>