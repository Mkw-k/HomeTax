/**
 * 회원 가입시 이용약관 레이어 팝업
 * @author MKW-K 
 */
 
 
 //레이어 팝업 
 //출처 : https://webclub.tistory.com/189
 //원본은 레이어 팝업이 2개가 있기 때문에 3항 연산자로 조건이 걸려 있는거 같음 
 /*
 $('.btn-example, #form21').click(function(){
		//debugger;
		//href의 값을 변수에 저장	
        var $href = $(this).attr('href');	
        layer_popup($href);
});
*/
 
$('.btn-example, #terms').on({
	click: function () {
		console.log('a태그 방식');
   		//href의 값을 변수에 저장	
        var $href = $(this).attr('href');
        console.log('인자값 : ' + $href);	
        layer_popup($href);
  },
  change: function () {
		console.log('체크박스 방식');
		//체크박스는 체크 true일경우만, 해제일경우 동작안함 
		var isCheckTrue = $(this).prop('checked');
		console.log('체크여부 확인 : ' + isCheckTrue);
		if(isCheckTrue){
			//href의 값을 변수에 저장	
		    var $href = $(this).val();
		    console.log('인자값 : ' + $href);	
		    layer_popup($href);	
		}		
  },
});

function layer_popup(el){
	
	//레이어의 id를 $el 변수에 저장
    var $el = $(el);    
    //dimmed 레이어를 감지하기 위한 boolean 변수
    var isDim = $el.prev().hasClass('dimBg'); 

	//dimBg 클래스가 있는 요소이라면 .dim-layer.fadeIn 아니면 레이어아이디.fadeIn
	//딤레이어 팝업인지에 대한 판단 조건 
    isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

	//~~은 Math.floor와 같다
    var $elWidth = ~~($el.outerWidth()),
        $elHeight = ~~($el.outerHeight()),
        docWidth = $(document).width(),
        docHeight = $(document).height();

    // 화면의 중앙에 레이어를 띄운다.
    if ($elHeight < docHeight || $elWidth < docWidth) {
        $el.css({
            marginTop: -$elHeight /2,
            marginLeft: -$elWidth/2
        })
    } else {
        $el.css({top: 0, left: 0});
    }



    $el.find('a.btn-layerClose').click(function(){
        isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
        return false;
    });

    $('.layer .dimBg').click(function(){
        $('.dim-layer').fadeOut();
        return false;
    });

}