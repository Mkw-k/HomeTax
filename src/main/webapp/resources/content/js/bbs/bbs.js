/**
 * bbs 문의사항 게시판 js파일
 * 210826
 * @author MKW-K
 *
 */
 
 
getBbsListData(0);

//글쓰기
function writeBbs(myid) {
	
	if(myid == null){
		alert('로그인해주세요');
		location.href = "login";
	}else{
		location.href = "writeBbs?myid="+myid;
	}
	
}


//문의사항 게시판 데이터 가져오기
//pnum : 선택한 페이지 넘버 (페이지네이션용)
function getBbsListData(pnum){

	let search = "";
	let title = "";
	
   $.ajax({
      url : "./getBbsListData",
      type : "get",
      data: {
			"pnum" : pnum, 
			"search" : search, 
			"title" : title
			},
      success:function(data){
         //alert('success');
         //alert(list);
         
          var count = data.count;
          console.log(data);
          console.log("총 카운트 : "+count);
          
          //페이지네이션 생성
          loadPage(count);
         
         //어팬드로 중복 데이터 생기는거 삭제
         $(".list_col").remove();
         
         for(var i in data.list) {
        	 var newfilename = data.list[i].newfilename;
        	 var bbsseq = data.list[i].hometaxbbs_seq;
            console.log(bbsseq);
            
            let j = parseInt(i);
            let board_data_html;
            
            board_data_html = "<tr class= 'list_col'>";
            board_data_html +="<th scope='row'>" + (j+1) +"</th>";
                     
	           if(data.list[i].del==0){
		        	 board_data_html +="<td>"+"<a href=detailBbs?seq="+data.list[i].hometaxbbs_seq+">"+data.list[i].title+"</a>"+"</td>";
		        	 board_data_html +="<td>"+data.list[i].readcount+"</td>";
		        	 board_data_html +="<td>"+data.list[i].downcount+"</td>";
		        	 board_data_html +="<td><input type='button' name='btnDown' value='다운로드'  onclick="+"filedown('"+data.list[i].newfilename+"','"+data.list[i].seq+"','"+data.list[i].filename+"')> </td>";
		        }else{
        	   		 board_data_html +="<td colspan='4'>";
	        		 board_data_html +="	<font color='#ff0000'>********* 이 글은 작성자에 의해서 삭제되었습니다</font>";
	                 board_data_html +="</td>";
	           }
                board_data_html +="</tr>";
                  
			$("#table").append(board_data_html);
   
         }//for
      }//success
   });//ajax
}//function


//paging 처리
function loadPage( totalCount ) {

    //alert("토탈카운트"+totalCount);

   //페이지당 글수 
   let pageSize = 10;
   let nowPage = 1;

//   let totalCount = 51;      //글의 총수
//   let pageSize = 10;         //페이지의 크기 [1]~[10]
//   let nowPage = 1;         //현재페이지

   _totalPages = totalCount/pageSize;     
   if(totalCount % pageSize > 0 ){
      _totalPages++;
   }else{
	_totalPages = Math.floor(_totalPages);
	}

   //alert('몇개냐 :'+_totalPages);
    
  //페이지네이션 초기화작업 :: 현재는 주석처리해야 정상 작동함
  //기존 문제점 :: 디스토리를 해버리는 바람에 자꾸 1페이지로 넘어갔음  
  //추후 분석이 더 필요한 코드임 
  /*
  if($('#pagination').data('twbs-pagination')){
   	$("#pagination").twbsPagination('destroy');
   }
   */

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
		 //debugger;
         nowPage = page;
         console.log('nowPage:'+ page);
         
         getBbsListData(page -1);

         //console.log(event);
         //console.log("startPage: 1 "+"// totalPages : " + _totalPages + " // visiblePages : 7");
         //console.log(this);
        }
   });
} 

  
//이렇게 하면 자바스크립트를 사용하면서도 post형태로 보낼수가 있다 
//파일 다운로드 
function filedown(newfilename, seq, filename) {
	alert('눌렸음');
	let doc = document.file_Down;
	doc.newfilename.value = newfilename; 
	doc.filename.value = filename;
	doc.seq.value = seq; 
	doc.submit();
}



/*
 var children_obj;
 children_obj = document.getElementById("pagination").childNodes;
 console.log("체크!!!!");
 
 //page+2가 실제 페이지 
 console.log(children_obj[page+2]);
 
 var ACTIVECLASSNAME = "active";  
 let length = children_obj.length;
  		 
for(var i = 0; i<length; i++){
			//액티브 페이지만 active클래스 추가
			if(page+2 == i){
				children_obj[i].classList.remove(ACTIVECLASSNAME);
			}
			//나머지는 삭제
			else{
				children_obj[page+2].classList.add(ACTIVECLASSNAME);
			}
}
*/
