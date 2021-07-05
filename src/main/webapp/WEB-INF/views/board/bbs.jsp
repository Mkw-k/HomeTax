<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js" ></script>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<!--   <link rel="stylesheet" href="https://static.pingendo.com/bootstrap/bootstrap-4.3.1.css"> -->
 
  <script type="text/javascript" src="./resources/jquery/jquery.twbsPagination.min.js"></script>
</head>

<body >
<c:import url="/header.jsp" charEncoding="utf-8"/> 
	

  <div class="py-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <div class="table-responsive">
            <table class="table table-striped table-borderless" id="table">
              <thead>
                <tr>
                  <th scope="col">#</th>
                  <th scope="col">title</th>
                  <th scope="col">조회수</th>
                  <th scope="col">다운로드수</th>
                  <th scope="col">다운로드</th>
                </tr>
              </thead>
             
             
             
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
 
	<nav aria-label="Page navigation">
         <ul class="pagination" id="pagination"
            style="justify-content: center;">
         </ul>
      </nav>
  
  <input type="button" onclick="javascript:writeBbs('${login.myid}')" id="_writeBbs" value="글쓰기"><br>
		
this is bbs
  
  
  <form name="file_Down" action="fileDownload" method="post">
 	<input type="hidden" name="newfilename" >
 	<input type="hidden" name="filename" >
 	<input type="hidden" name="seq"> 
 </form>
 
   
  <c:import url="/footer.jsp" charEncoding="utf-8"/> 
 
  
  
  
 
  
  
<script type="text/javascript">

getBbsListData();
loadPage(20);

function writeBbs(myid) {
	
	if(myid == null){
		alert('로그인해주세요');
		location.href = "login";
	}else{
		location.href = "writeBbs?myid="+myid;
	}
	
}


//월세 리스트 가져오는 함수 
function getBbsListData(pnum){

	let search = "";
	let title = "";
   //alert('데이터취득');
   $.ajax({
      url : "./getBbsListData",
      type : "get",
      data: {"pnum" : pnum, "search" : search, "title" : title},
      success:function(list){
         //alert('success');
         //alert(list);

         $(".list_col").remove();

         $.each(list, function(i, val){
        	 
        	 var newfilename = val.newfilename;
        	 var bbsseq = val.hometaxbbs_seq;
            //alert(val.jobSeq);
            let app = "<tr class= 'list_col'>"
                     +"<th scope='row'>" + (i+1) +"</th>";
                     
                   if(val.del==0){
                	 app +="<td>"+"<a href=detailBbs?seq="+val.hometaxbbs_seq+">"+val.title+"</a>"+"</td>"
                	 	 +"<td>"+val.readcount+"</td>"
                	 	 +"<td>"+val.downcount+"</td>"
                	 	 +"<td><input type='button' name='btnDown' value='다운로드'  onclick="+"filedown('"+val.newfilename+"','"+val.seq+"','"+val.filename+"')> </td>";
                	 
                	}else{
                	   app += "<td colspan='4'>"
                			 +"<font color='#ff0000'>********* 이 글은 작성자에 의해서 삭제되었습니다</font>"
                            +"</td>";
                   }
                     
                app +="</tr>";
                  
		$("#table").append(app);
         });
      },
      error:function(){
         alert('error');
      }

   });

  }
  
  
//이렇게 하면 자바스크립트를 사용하면서도 post형태로 보낼수가 있다 
function filedown(newfilename, seq, filename) {
	alert('눌렸음');
	let doc = document.file_Down;
	doc.newfilename.value = newfilename; 
	doc.filename.value = filename;
	doc.seq.value = seq;
	doc.submit();
}

//paging 처리
function loadPage( totalCount ) {

    //alert("토탈카운트"+totalCount);

   let pageSize = 5;
   let nowPage = 1;

//   let totalCount = 51;      //글의 총수
//   let pageSize = 10;         //페이지의 크기 [1]~[10]
//   let nowPage = 1;         //현재페이지

   let _totalPages = totalCount/pageSize;
   if(totalCount % pageSize > 0 ){
      _totalPages++;
   }

   //alert('몇개냐 :'+_totalPages);
    
  if($('#pagination').data('twbs-pagination')){
   	$("#pagination").twbsPagination('destroy');
   }

   $("#pagination").twbsPagination({
      startPage: 1,
      totalPages : _totalPages,
      visiblePages : 7,
     /*  totalPages : 7,
      visiblePages :_totalPages, */
      first: '<span aria-hidden = "true">«</span>',
      prev : "이전",
      next : "다음",
      last : '<span aria-hidden = "true">»</span>',
      initiateStartPageClick:false,            //onPageClick 자동 실행되지 않도록 한다
      onPageClick : function(event, page) {
         nowPage = page;
         //alert('nowPage:'+ page);
         getBbsListData(page -1);
      }
   });
}

function getBbsDataCount(pnum) {
	
	let search = "";
	let title = "";
	
	$.ajax({
	      url : "./getBbsDataCount",
	      type : "get",
	      data: {"pnum" : pnum, "search" : search, "title" : title},
	      success:function(count){
	         //alert('success');
	         
			loadPage(count);
	      },
	      error:function(){
	         alert('error');
	      }

	   });

}

</script>

</body>

</html>


