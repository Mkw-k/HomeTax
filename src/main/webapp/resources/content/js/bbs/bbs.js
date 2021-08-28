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

	let searchCategory = document.getElementsByName('searchCategory')[0].value;
	let searchWord = document.getElementsByName('searchWord')[0].value;
	
	console.log("페이지확인 : "+typeof(pnum));
	console.log("카테고리확인 : " + searchCategory);
	console.log("검색어확인 : " + searchWord);
	
	//파라미터 값이 안들어왔을경우 0으로 설정
	//삭제금지!! 없으면 작동안함(에러)
	if(typeof(pnum) != 'number'){
		pnum = 0;
	}
	
   $.ajax({
      url : "./getBbsListData",
      type : "get",
      data: {
			"pnum" : pnum, 
			"search" : searchWord, 
			"title" : searchCategory
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
		        	 board_data_html +="<td>"+data.list[i].myid+"</td>";
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

//검색어 텍스트 창에서 엔터 키업시 검색 함수 실행 
var searchText = document.getElementById('searchInput');
searchText.addEventListener('keyup', (e)=>{
    if (e.keyCode === 13) {
        // code for enter
        getBbsListData();
  }  
});

//서치버튼 클릭시 검색 함수 실행 
var searchBtn = document.getElementById('searchBtn');
searchBtn.addEventListener('click', getBbsListData);


//서치바 사용하여 검색버튼 클릭시
function bbsSearchBtnClick(){
	
	getBbsListData();
	
}

getAutocomIdTitle();
//let autocompleteArr=[];
//백단과 연결하여 현재 있는 아이디와 타이틀을 가져옴 
function getAutocomIdTitle(){
   let autocompleteArr=[];
   $.ajax({
      url : "./getAutocomIdTitle",
      type : "get",
      dataType : "json",
      success:function(data){
         var count = data.length;
         
         //아이디값은 아이디값만 따로 중복 제거
         var tempIdArr = [];
         for (let i = 0; i < data.length; i++) {
            const myid = data[i].MYID;
            tempIdArr.push(myid);
         }
         const idSet = new Set(tempIdArr);
         const uniqueIdArr = [...idSet];
         //console.log("템프 아이디 어레이 확인");
         //console.log(uniqueIdArr);
         
         var tempTitleArr = [];
         for (let i = 0; i < data.length; i++) {
            const title = data[i].TITLE;
            tempTitleArr.push(title);
         }
         const titleSet = new Set(tempTitleArr);
         const uniqueTitleArr = [...titleSet];
         //console.log("템프 타이틀 어레이 확인");
         //console.log(uniqueTitleArr);

         autocompleteArr = autocompleteArr.concat(uniqueIdArr);
         autocompleteArr = autocompleteArr.concat(uniqueTitleArr);
         //console.log("자동완성 어레이 확인");
         //console.log(autocompleteArr);
         
         bbsSetAutoComplete(autocompleteArr);
      },//success
      error : function(){
		alert('error');
		}
   });//ajax

   return autocompleteArr;
}
 

//자동완성 기능 ::: 분석 더 필요함!!!!
//제이쿼리 ui 기능에 포함되어있음 (autocomplete)  
//return으로 값을 받으면 값을 못받아옴 파악 필요!!!
//화면 다뜨면 시작되는 방식으로 해서 밑에서 AJAX가 들어있는 함수를 호출해서 
//리턴값을 받으려하면 실행안됨 :: CUZ AJAX는 JS가 쌓아놨다가 마지막에 실행되기 떄문에 
 //$(function() {    //화면 다 뜨면 시작
 function bbsSetAutoComplete(autocompleteArr){
   //debugger;
       var searchSource = autocompleteArr;
      //var searchSource = getAutocomIdTitle();
       console.log("자동완성 어레이 확인");
       console.log(searchSource);
       //var searchSource = ["김치 볶음밥", "신라면", "진라면", "라볶이", "팥빙수","너구리","삼양라면","안성탕면","불닭볶음면","짜왕","라면사리" ]; // 배열 형태로 
        $("#searchInput").autocomplete({  //오토 컴플릿트 시작
            source : searchSource,    // source 는 자동 완성 대상
            select : function(event, ui) {    //아이템 선택시
                console.log(ui.item);
            },
            focus : function(event, ui) {    //포커스 가면
                return false;//한글 에러 잡기용도로 사용됨
            },
            minLength: 1,// 최소 글자수
            autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
            classes: {    //잘 모르겠음
                "ui-autocomplete": "highlight"
            },
            delay: 50,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
//            disabled: true, //자동완성 기능 끄기
            position: { my : "right top", at: "right bottom" },    //잘 모르겠음
            close : function(event){    //자동완성창 닫아질때 호출
                console.log(event);
            }
        });
    }
    //});




 
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