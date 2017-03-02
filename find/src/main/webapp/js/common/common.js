var pollTimer;
jQuery(function($){
	
	$('.i_label').each(function(){
		
		$(this).css("padding-top",$(this).next('input').css("padding-top"));
		$(this).css("padding-left",$(this).next('input').css("padding-left"));
		$(this).css("padding-bottom",$(this).next('input').css("padding-bottom"));
		$(this).css("margin-top",$(this).next('input').css("margin-top"));
		$(this).css("margin-left",$(this).next('input').css("margin-left"));
		$(this).css("margin-bottom",$(this).next('input').css("margin-bottom"));
		$(this).css("height",$(this).next('input').css("height"));
		$(this).find("p").css("margin-top",Math.floor(($(this).height()-$(this).find("p").height())/2));
	});
	
	var i_text = $('.i_label').next('input');
	$('.i_label').click(function(){
		$(this).next('input').focus();
	});
	
	i_text.focus(function() {
		$(this).prev('.i_label').css('visibility', 'hidden');
	}).blur(function() {
		if ($(this).val() == '') {
			$(this).prev('.i_label').css('visibility', 'visible');
		} else {
			$(this).prev('.i_label').css('visibility', 'hidden');
		}
	}).change(function() {
		if ($(this).val() == '') {
			$(this).prev('.i_label').css('visibility', 'visible');
		} else {
			$(this).prev('.i_label').css('visibility', 'hidden');
		}
	}).blur();
	
	$(".date").datepicker({
    	dateFormat:"yy-mm-dd",
		changeYear: true,
		changeMonth: true,
		shortYearCutoff:"+30",
		dayNamesMin: ["일","월","화","수","목","금","토"],
		monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		yearSuffix: "년",
		showOn: "both", //이미지로 사용 , both : 엘리먼트와 이미지 동시사용
		buttonImage: "/images/page/btn/calendar-icon.png", //버튼으로 사용할 이미지 경로
		showMonthAfterYear: true,
        buttonText: "날짜 선택",
        
    });
	
	$(".loss-date").datepicker({
    	dateFormat:"yy-mm-dd",
		changeYear: true,
		changeMonth: true,
		shortYearCutoff:"+30",
		dayNamesMin: ["일","월","화","수","목","금","토"],
		monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		yearSuffix: "년",
		showOn: "both", //이미지로 사용 , both : 엘리먼트와 이미지 동시사용
		buttonImage: "/images/page/btn/calendar-icon.png", //버튼으로 사용할 이미지 경로
		showMonthAfterYear: true,
        buttonText: "날짜 선택",
        
    });
	
	$(".find-date").datepicker({
    	dateFormat:"yy-mm-dd",
		changeYear: true,
		changeMonth: true,
		shortYearCutoff:"+30",
		dayNamesMin: ["일","월","화","수","목","금","토"],
		monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		yearSuffix: "년",
		showOn: "both", //이미지로 사용 , both : 엘리먼트와 이미지 동시사용
		buttonImage: "/images/page/btn/calendar-icon.png", //버튼으로 사용할 이미지 경로
		showMonthAfterYear: true,
        buttonText: "날짜 선택",
        
    });
	
    $(".ui-helper-clearfix").hide();
});

	/**
 	* 숫자만 입력가능
 	* @param event
 	* @returns {Boolean}
 	*/
	function onlyNumber(event) {
	    var key = window.event ? event.keyCode : event.which;    

    	if ((event.shiftKey == false) && ((key  > 47 && key  < 58) || (key  > 95 && key  < 106)
    	|| key  == 35 || key  == 36 || key  == 37 || key  == 39  // 방향키 좌우,home,end  
    	|| key  == 8  || key  == 46 
    	|| key  == 13 || key    ==  9
    	) // del, back space
    	) {
	        return true;
	    }else {
        	return false;
    	}    
	}
	//getTextLength ---> _fn_getByteLength 이거 쓰세요
	/*function getTextLength(str) 
	{
	    var len = 0;
	    for (var i = 0; i < str.length; i++) 
	    {
	        if (escape(str.charAt(i)).length == 6) 
	        {
		    	len++;
		    }
		    len++;
		}
		return len;
	}*/
		
	function bytes(obj, className ){
	    var text = $(obj).val();
	    //$(obj).val(text);
	    $(className).text(_fn_getByteLength(text));
	}
	
	//cutStr ---> _fn_cutStr 이거 쓰세요
	/*function cutStr(str,limit)
	{
		var tmpStr = str;
		var byte_count = 0;
		var len = str.length;
		var dot = "";

		for(i=0; i<len; i++){
			byte_count += chr_byte(str.charAt(i)); 
			if(byte_count == limit-1){
				if(chr_byte(str.charAt(i+1)) == 2){
					tmpStr = str.substring(0,i+1);
					dot = "...";
				}else {
					if(i+2 != len) dot = "...";
					tmpStr = str.substring(0,i+2);
				}
				break;
			}else if(byte_count == limit){
				if(i+1 != len) dot = "...";
				tmpStr = str.substring(0,i+1);
				break;
			}
		}
		document.writeln(tmpStr+dot);
		return true;
	}*/
	
	/*function chr_byte(chr)
	{
		if(escape(chr).length > 4)
			return 2;
		else
			return 1;
	}*/
	
	//콤마찍기
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	//콤마풀기
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
	
	function openSmsPop(proc){
		var url;
		var splitPop;
		var wid;
		var hei;
		var opener;
		
		if(proc == "singleSms"){
			wid = 508;
			hei = 345;
			url = "/sms/singleSmsPop.do";
		}else if(proc == "multiSms"){
			wid = 508;
			hei = 412;
			url = "/sms/multiSmsPop.do";
		}else if(proc == "receptionSms"){
			wid = 508;
			hei = 673;
			url = "/sms/receptionSmsPop.do";
		}else if(proc == "selectMberSms"){
			wid = 508;
			hei = 728;
			url = "/sms/selectMberSmsPop.do";
		}
		
		if(_fn_getBrowserType() == "IE11") {
			url = url +"?"+ $("#smsform").serialize();
			splitPop = windowOpenPopup( url, 'smsPop', wid, hei);
		}else{
			splitPop = windowOpenPopup( "", 'smsPop', wid, hei);
		    
			$("#smsform").attr("target","smsPop");
			$("#smsform").attr("method","POST");
			$("#smsform").attr("action",url).submit();
		}
		opener = splitPop.opener;
		
		pollTimer = window.setInterval(function() {
		    if (splitPop.closed !== false) { 
		        window.clearInterval(pollTimer);
		        $("#sms_mask").hide();
		        if(typeof opener.popCallBack != "undefined"){
		    		opener.popCallBack();
		    	}
		    }
		}, 200);
	}