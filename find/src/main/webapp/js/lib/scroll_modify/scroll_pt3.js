//groupModify page
$(function(){
//스크롤바 없애기
    $("#wrap").css('height',$(window).height()-165);//IE 스크롤 없애기 위해 1줄이고 footer의 크기를 1 늘림
	$("#wrap").css('top',104);
	$(".help-content").css('height',$(window).height()-165);
	$(".help-content").css('padding-top','26px');
	$("#footer").css('position','relative');
	$("#footer").css('bottom','-103px');
	$("#footer").css('left','0px');
});