/*-------------------------------------------------------------------------
 * 공통함수 생성규칙 : 1.첫글자는 _fn_로 시작
 * 					   2.함수명은 camelcase 형태로 
-------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------
 * Notes     	: jquery ajax call function
 *  
 * Parameter 	: async 	 	- true '비동기식' ; false '동기식'	
	 			  type 		 	- post/ get 방식						
	 			  url			- 요청 되는 url 정보					
 				  dataType		- json , text , xml , jsonp 등의 반환되는 dataType 
 				  isForm		- dataOrFormId 가 form 아이디 인지
 				  dataOrFormId	- data 형태나 form 아이디
 				  params		- 파라메터
 				  callback		- 콜백 함수	
 * Return    	: 
 * Use       	: _fn_callAjax(true, "post", "./intro/login.ub", "json", true ,"formid", params, callback);
 * 
 * ref 			: 응답 코드 
 * 				  200	=> 	OK							요청 성공
 *				  401	=> 	Unauthorized			권한 없음
 *				  403	=> 	Forbidden				접근 거부
 *				  404	=> 	Not Found				페이지 없음
 *				  500	=> 	Internal Server Error	서버 내부 오류
-------------------------------------------------------------------------*/
function _fn_callAjax( async, type, url, dataType, isForm ,dataOrFormId, params, callback ){
	
	if(url.indexOf('?') == -1){
		url = url + '?hash='+ Math.random();
	}else{
		url = url + '&hash='+ Math.random();
	}
	
	var data;
	if(isForm){
		data = jQuery("#"+dataOrFormId).serialize();
	}else{
		data = dataOrFormId;
	}
	
	jQuery.ajax({
		async : async
		,type : type
		,url : url
		,dataType : dataType
		,data: data
		,success : function(jsonData) {
			if(jsonData.intercept == 'login'){
				_fn_location('/result/login_redirect.jsp');
			}
			if(typeof callback == 'function') {
				callback(async, type, url, dataType, isForm , dataOrFormId, params, jsonData);
			}
		}
		,error : function (xhr, option, error){
			//alert("죄송합니다. 해당 요청을 처리할 수 없습니다.");
		}
	});	
};

/*-------------------------------------------------------------------------
 * Notes     	: 인자로 넘어온 url로 화면 전환
 * 
 * Parameter 	: url
 * Use       	: _fn_location(url)
-------------------------------------------------------------------------*/
function _fn_location(url){
	document.location.href=url;
};

/*-------------------------------------------------------------------------
 * [입력값 체크 관련 함수]
 * Notes     	: 값이 있는지 없는지를 판단하느 함수 
 * 
 * Parameter 	: value 
 * Return    	: Boolean 
 * Use       	: _fn_isNull(val) 
-------------------------------------------------------------------------*/
function _fn_isNull( val ) {
	if(val == null || val == "" || val.length <= 0) return true;
	return false;
};

/*-------------------------------------------------------------------------
 * [입력값 체크 관련 함수]
 * Notes     	: 이메일 형식인지 체크
 * 
 * Parameter 	: value 
 * Return    	: Boolean 
 * Use       	: _isEmail(val) 
-------------------------------------------------------------------------*/
function _fn_isEmail(val){
	
	//이메일 주소를 판별하기 위한 정규식
	var reg_email=/^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/;
	
	// 인자 email_address를 정규식 format 으로 검색
	if (val.search(reg_email) == -1) return false;

	return true;
};

/*-------------------------------------------------------------------------
 * [입력값 체크 관련 함수]
 * Notes     	: maxLength인 경우 nextObjId로 focus 이동
 * 
 * Parameter 	: ObjId 			- maxLength를 구할  element id
 * 				  nextObjId 		- maxLength 시 이동할 element id
 * 				  maxLength 		- maxLength 값
 * Use			: onkeyup=_fn_onMoveNext(objId, nextObjId, 3)
 -------------------------------------------------------------------------*/
function _fn_onMoveNext(objId, nextObjId, maxLength){
	var obj = jQuery("#"+objId);
	var nextObj = jQuery("#"+nextObjId);
	
    if (obj.val().length >= maxLength){
    	nextObj.focus();
    }
};

/*-------------------------------------------------------------------------
 * [입력값 체크 관련 함수]
 * Notes     	: 입력값의 바이트 길이를 구하는 함수.
 * 
 * Parameter 	: str 			- 바이트 길이를 구할 문자열
 * Use			: _fn_getByteLength(str);
 -------------------------------------------------------------------------*/
function _fn_getByteLength(str){	
	
	var byteLength= 0;
	for(var inx=0; inx < str.length; inx++) {
		var oneChar = escape(str.charAt(inx));
		if( oneChar.length == 1 ) byteLength ++;
		else if(oneChar.indexOf("%u") != -1) byteLength += 2;
		else if(oneChar.indexOf("%") != -1) byteLength += oneChar.length/3;
	}

	return byteLength;
};

/*-------------------------------------------------------------------------
 * [입력값 체크 관련 함수]
 * Notes     	: 입력값의 maxLength Check
 * 
 * Parameter 	: obj 			- 체크 할 object
 * 				  msgTitle 	- maxLength가 초과시 메시지 
 * 				  maxLen 	- maxLength 길이
 * Return    	: boolean 
 * Use			: _fn_limitInputMaxlen(obj, "아이디는", maxLen);
 -------------------------------------------------------------------------*/
function _fn_limitInputMaxlen(objId, msgTitle, maxLen){
	
	var obj = jQuery("#"+objId);
	var str = obj.val();
	var nbytes = _fn_getByteLength(str);

	if(typeof(maxLen) != "undefined") {
	    if(nbytes > maxLen){
	        alert(msgTitle + " 총 영문기준 "+ maxLen + "자, 한글기준 "+(maxLen/2)+"자까지 입력 할 수 있습니다.(현재 영문기준 " + nbytes + "자를 입력하셨습니다.)");
	        obj.val(_fn_cutStr(str, maxLen));
	        obj.focus();
	        return false;
	    }
	}
	return true;
};

/*-------------------------------------------------------------------------
 * [입력값 체크 관련 함수]
 * Notes     	: textarea 입력값의 maxLength Check
 * 
 * Parameter 	: obj 		- 체크 할 object
 * 				  maxlen 	- maxLength 길이
 * Use			: _fn_limitTextareaMaxlen(this,"아이디는",20);
 -------------------------------------------------------------------------*/
function _fn_limitTextareaMaxlen(objId,msgTitle,maxLen) {
	
	var obj = jQuery("#"+objId);
	var str = obj.val();
	var nbytes = _fn_getByteLength(str);
	
	if( nbytes > maxLen ) {
		alert(msgTitle + " 총 영문기준 "+ maxLen + "자, 한글기준 "+(maxLen/2)+"자까지 입력 할 수 있습니다.(현재 영문기준 " + nbytes + "자를 입력하셨습니다.)");
		obj.val( _fn_enterCutStr( str, maxLen ));
		obj.focus();
		return false;
	}
	return true;
};

/*-------------------------------------------------------------------------
 * [입력값 체크 관련 함수]
 * Notes     	: 입력값의 maxLength Check
 * 
 * Parameter 	: obj 			- 체크 할 obj
 * 				  msgTitle 	- maxLength가 초과시 메시지 
 * 				  maxLen 	- maxLength 길이
 * Return    	: boolean 
 * Use			: _fn_textMaxlen(obj, maxLen, msgTitle);
 -------------------------------------------------------------------------*/
function _fn_textMaxlen(objId, maxLen, msgTitle){
	
	var obj = jQuer("#"+objId);
	var str = obj.val();
	var nbytes = _fn_getByteLength(str);

	    if(nbytes > maxLen){
	        alert( msgTitle + " 총 영문기준 "+ maxLen + "자, 한글기준 "+(maxLen/2)+"자까지 입력 할 수 있습니다.(현재 영문기준 " + nbytes + "자를 입력하셨습니다.)");
	        obj.val(_fn_cutStr(str, maxLen));
	        obj.focus();
	        return false;
	    }
	    
	return true;
};

/*-------------------------------------------------------------------------
 * [입력값 체크 관련 함수]
 * Notes     	: 영문숫자만 가능하게 입력
 * 
 * Parameter 	: objId - 체크 대상 element id
 * 			      chkCase - int
 * 				  1 : 숫자만 입력
 *           	  2 : 영문만 입력
 *           	  3 : 영숫자만 입력
 * Use       	: onkeyup=_fn_formInputControl('id', 1);
-------------------------------------------------------------------------*/
function _fn_formInputControl(objId, chkCase){
	
	var tempObj;
	
	if (document.getElementById(objId) == null ) {
	    tempObj = document.getElementsByName(objId)[0];
    } else {
	    tempObj = document.getElementById(objId);
    }

    if (tempObj.readOnly == true) return;

    var regVal = null;

    switch (chkCase){
        case 1:
            regVal = /[^0-9]/g;
            break;
        case 2:
            regVal = /[^a-zA-Z]/g;
            break;
        case 3:
            regVal = /[^a-zA-Z0-9]/g;
            break;
        case 4:
            regVal = /[^0-9.]/g;
            break;
        default:
            regVal = /[^a-zA-Z0-9]/g;
    }

    var idVal = tempObj.value;
    tempObj.value = idVal.replace(regVal,"");
};


/*-------------------------------------------------------------------------
 * [입력값 체크 관련 함수] 
 * Notes     	: 영문숫자만 가능하게 입력
 * 					  
 * Parameter 	: obj  	체크할 입력값
 * 				  role 	
 * 					1 : 숫자만 입력
 *           		2 : 영문만 입력
 *           		3 : 영숫자만 입력
 * return		: true/ false
 * Use       	: _fn_inputControlRtnMsg('id', 1);
-------------------------------------------------------------------------*/
function _fn_inputControlRtnMsg( objId, role, msgTitle ) {
	
	var tempObj;
	
	if (document.getElementById(objId) == null ) {
	    tempObj = document.getElementsByName(objId)[0];
    } else {
	    tempObj = document.getElementById(objId);
    }

    if (tempObj.readOnly == true) return;
    
	str = tempObj.value;
	len = str.length; 
	ch = str.charAt(0);
	
	if(typeof(msgTitle) == "undefined") {
		msgTitle = "";
	}
	
	for(var i = 0; i < len; i++) { 
		
		ch = str.charAt(i); 
			
		if( role == 1 ){
			if( (ch >= '0' && ch <= '9') ) { 
				continue; 
			} else { 
				alert(msgTitle+ " 는 숫자만 입력이 가능합니다.");
				obj.focus();
				return false; 
			}
	    }else if(role == 2){
	    	if( (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') ) { 
				continue; 
			} else { 
				alert(msgTitle+ " 는 영문만 입력이 가능합니다.");
				obj.focus();
				return false; 
			}
	    }else{
	    	if( (ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') ) { 
				continue; 
			} else { 
				alert(msgTitle+ " 는 영문과 숫자만 입력이 가능합니다.");
				obj.focus();
				return false; 
			}
	    }
	}
	return true;
};

/*-------------------------------------------------------------------------
 * [문자열 관련 함수] 
 * Notes     	: 해당 문자열의 앞뒤공백을 제거하는 함수.  
 * 
 * Parameter 	: 문자열  
 * Return    	: String  
 * Use       	: _fn_getTrimStr(val);  
-------------------------------------------------------------------------*/
function _fn_getTrimStr(val) {
	return val.replace(/^\s+|\s+$/g,"");
};

/*-------------------------------------------------------------------------
 * [문자열 관련 함수] 
 * Notes     	: 해당 문자열의 앞공백을 제거하는 함수.
 * 
 * Parameter 	: 문자열 
 * Return    	: String 
 * Use       	: _fn_getLTrimStr(val); 
-------------------------------------------------------------------------*/
function _fn_getLTrimStr(val) {
	return val.replace(/^\s+/,"");
};

/*-------------------------------------------------------------------------
 * [문자열 관련 함수] 
 * Notes     	: 해당 문자열의 뒤공백을 제거하는 함수.
 * 
 * Parameter 	: 문자열 
 * Return    	: String 
 * Use       	: _fn_getRTrimStr(val); 
-------------------------------------------------------------------------*/
function _fn_getRTrimStr(val) {
	return val.replace(/\s+$/,"");
};

/*-------------------------------------------------------------------------
 * [문자열 관련 함수] 
 * Notes     	: 해당 문자열의 모든공백을 제거하는 함수.
 * 
 * Parameter 	: 문자열 
 * Return    	: String 
 * Use       	: _fn_getAllTrimStr(val); 
-------------------------------------------------------------------------*/
function _fn_getAllTrimStr(val) {
	return val.replace(/(\s*)/g, "");
};

/*-------------------------------------------------------------------------
 * [문자열 관련 함수] 
 * Notes     	: 자릿수에 맞는 숫자형식으로 바꿔주는 함수.
 * 				  숫자의 자리수가, 인수로 지정해 준 자리수에 모자라면, 그 빈 자리를 숫자 영(0)으로 채웁니다. 즉, 앞의 빈자리에 제로를 추가하는 것입니다.
 * 
 * Parameter 	: n 변환하기전 숫자
 * 				  digits 추가될 0의 갯수
 * Return    	: String 문자열 오늘 날짜
 * Use       	: _fn_getLsToNumber();
-------------------------------------------------------------------------*/
function _fn_getLsToNumber(n, digits) {
	var zero = '';
	n = n.toString();

	if (n.length < digits) {
		for (var i = 0; i < digits - n.length; i++){
			zero += '0';
		}
	}
	return zero + n;
}

/*-------------------------------------------------------------------------
 * [문자열 관련 함수] 
 * Notes     	: 입력값의 maxLength Check
 * 
 * Parameter 	: str 			- 자를 문자열
 * 				  limit 		- maxLength 길이
 * Return    	: tmpStr 	자른 후의 문자열  
 * Use			: _fn_cutStr(str, 20);
 -------------------------------------------------------------------------*/
function _fn_cutStr( str, limit ){

	var tmpStr = str;
    var byte_count = 0;
    var len = str.length;
    
	for(var i=0; i<len; i++){
        
		byte_count += _fn_getByteLength(str.charAt(i));
        
    	if(byte_count == limit-1){
    		if(_fn_getByteLength(str.charAt(i+1)) == 2){
    			tmpStr = str.substring(0,i+1);
    		}else{
            	tmpStr = str.substring(0,i+2);
            }

            break;
    	}else if(byte_count == limit){
        	tmpStr = str.substring(0,i+1);
            
            break;
        }
    }
    return tmpStr;
}

/*-------------------------------------------------------------------------
 * [문자열 관련 함수] 
 * Notes     	: 엔터 입력값 포함 maxLength Check
 * 
 * Parameter 	: str 			- 자를 문자열
 * 				  limit 		- maxLength 길이
 * Return    	: tmpStr 	자른 후의 문자열  
 * Use			: _fn_enterCutStr(str, 20);
 -------------------------------------------------------------------------*/
function _fn_enterCutStr( str, limit ){

	var tmpStr;
	var temp=0;
	var onechar;
	var tcount = 0;

	tmpStr = new String(str);
	temp = tmpStr.length;

	for (var k = 0; k < temp; k++){

		onechar = tmpStr.charAt(k);
		
		if( escape(onechar).length > 4 ) {
			tcount += 2;
		} else {
			// 엔터값이 들어왔을때 값(\r\n)이 두번실행되는데 첫번째 값(\n)이 들어왔을때 tcount를 증가시키지 않는다.
			if(escape(onechar)=='%0A') {} else { tcount++; }
		}

		if( tcount >  limit ) {
			tmpStr = tmpStr.substring( 0, k );
			break;
		}
	}
	
	return tmpStr;
}

/*-------------------------------------------------------------------------
 * [문자열 관련 함수] 
 * Notes     	: null 문자를 공백으로 변환
 * 
 * Parameter 	: str 			변환할 문자
 * Return    	: tmpStr 	공백  
 * Use			: _fn_nullToEmpty(str);
 -------------------------------------------------------------------------*/
function _fn_nullToEmpty( str ){

	tmpStr = new String(str);
	var empty = "";
	
	if(tmpStr != null){
		tmpStr = _getTrimStr(tmpStr);
	}
	
	if( tmpStr == null || tmpStr == "" || tmpStr == "null"){
		return empty;
	}
	else return tmpStr;
};

/*-------------------------------------------------------------------------
 * [통화 currency 관련 함수] 
 * Notes     	: 숫자나 문자열을 통화(Money) 형식으로 만든다.
 * 				  단, 양수로만 허용한다.
 * Parameter 	: amount  	- 통화형식으로 변경할 숫자형 data
 * return		: 통화형식으로 변경된 data
 * Use       	: _fn_toCurrencyPositive('123456789');
-------------------------------------------------------------------------*/
function _fn_toCurrencyPositive( amount ){
	
	var firstChar = amount.substr(0,1);
	
	if(firstChar == "-"){
		amount = amount.substring(1, amount.length);
	}
	
	return toCurrency(amount);
};

/*-------------------------------------------------------------------------
 * [통화 currency 관련 함수] 
 * Notes     	: 숫자나 문자열을 통화(Money) 형식으로 만든다.
 * 
 * Parameter 	: amount  	- 통화형식으로 변경할 숫자형 data
 * return		: 통화형식으로 변경된 data
 * Use       	: _fn_toCurrency('123456789');
-------------------------------------------------------------------------*/
function _fn_toCurrency( amount ){
	
	amount = String(amount);

	var data = amount.split('.');

	var sign = "";

	var firstChar = data[0].substr(0,1);
	
	if(firstChar == "-"){
		sign = firstChar;
		data[0] = data[0].substring(1, data[0].length);
	}

	data[0] = data[0].replace(/\D/g,"");
	if(data.length > 1){
		data[1] = data[1].replace(/\D/g,"");
	}

	firstChar = data[0].substr(0,1);
	
	if(firstChar == "0"){ //0으로 시작하는 숫자들 처리
		if(data.length == 1){
			return sign + parseFloat(data[0]);
		}
	}

	var comma = new RegExp('([0-9])([0-9][0-9][0-9][,.])');

	data[0] += '.';
	
	do {
		data[0] = data[0].replace(comma, '$1,$2');
	} while (comma.test(data[0]));

	if (data.length > 1) {
		return sign + data.join('');
	} else {
		return sign + data[0].split('.')[0];
	}
};

/*-------------------------------------------------------------------------
 * [Number 관련 함수] 
 * Notes     	: 소수점 들어가는 숫자 자릿수 체크하는 함수.
 * 					  
 * Parameter 	:  val  				체크할 값
 *					   constantCnt  	정수부분 자리수
 *					   decimalCnt  		소수부분 자리수
 *					   title  	타이틀
 * return		: Boolean
 * Use       	: _fn_isDecimalCheck('100.11', 5, 2, '금액');
-------------------------------------------------------------------------*/
function _fn_isDecimalCheck( val, constantCnt, decimalCnt, title ){

	var chkVal = _fn_getTrimStr( val );
    var preCnt = 0; // 정수부분 자리수
    var posCnt = 0; // 소수부분 자리수
    var dotPos = 0; // 소수점 위치
    var totalLen = 0;
    var chkConstantCnt = 0;

    if( isNaN( chkVal ) ){
        
    	/*alert("\"" + val + "\""+"은(는) 올바른 금액 형식 아닙니다.");*/
    	alert("\"" + val + "\""+"은(는) 올바른 " + title + "형식 아닙니다.");
        return false;
        
    } else {
    	
    	dotPos = chkVal.indexOf("."); //소수점의 위치
    	
    	// '-'부호 입력시
        if(chkVal.substring(0,1) == '-') chkConstantCnt = constantCnt + 1;
        else chkConstantCnt = constantCnt;

        if(dotPos == -1){
        	
            preCnt = chkVal.length;
            
            if(preCnt > chkConstantCnt){
                alert(title + "의 정수부분은 " + constantCnt + "자리이하로 입력하십시오.");
                return false;
            }
            
        } else if(dotPos > 0) {
            
        	preCnt = dotPos;
            totalLen = chkVal.length;

            if(totalLen == ++dotPos){
            	alert("\"" + chkVal + "\""+"은(는) 올바른 " + title + "형식 아닙니다.");
                return false;
            } else {
                posCnt = chkVal.substring(preCnt+1).length;
            }

            if(preCnt > chkConstantCnt){
                alert(title + "의 정수부분은 " + constantCnt + "자리이하로 입력하십시오.");
                return false;
            }

            if(posCnt > decimalCnt){
                alert(title + "의 소수부분은 " + decimalCnt + "자리이하로 입력하십시오.");
                return false;
            }
        } else {
        	alert(title + "의 정수부분은 " + constantCnt + "자리이하로 입력하십시오.");
            return false;
        }
    }

    return true;
};
  
/*-------------------------------------------------------------------------
 * [Number 관련 함수] 
 * Notes     	: 주어진 값(val)을 소수점이하 num자리수에서 반올림한값을 리턴한다.
 * 					  
 * Parameter 	: val  	반올림할 값
 * return		: num 	반올림할 자리수
 * Use       	: _fn_round(0.1, 1)
-------------------------------------------------------------------------*/
function _fn_round( val, num ){
	val = val * Math.pow(10, num - 1);
	val = Math.round(val);
	val = val / Math.pow(10, num - 1);
	return val;
};

/*-------------------------------------------------------------------------
 * [Number 관련 함수] 
 * Notes     	: ,이 있는 숫자를 순수한 숫자로 바꿔준다. (+), (-) 허용
 * 					  
 * Parameter 	: num  	,변환되기전 data
 * return		: num 	변환 후 숫자형 data
 * Use       	: _fn_toNormalNum('1,1')
-------------------------------------------------------------------------*/
function _fn_toNormalNum( num ) {
    num = num.replace(/,/g, '');
	return Number(num);
};

/*-------------------------------------------------------------------------
 * [DATE 관련 함수] 
 * Notes     	: 현재 년 월 일을 가져오는 함수
 * 
 * Return    	: String 문자열 오늘 날짜
 * Use       	: _fn_getToday();
-------------------------------------------------------------------------*/
function _fn_getToday() {
	
	var d = new Date();

	var s =
		_fn_getLsToNumber(d.getFullYear(), 4) + '-' +
		_fn_getLsToNumber(d.getMonth() + 1, 2) + '-' +
		_fn_getLsToNumber(d.getDate(), 2);

	return s;
};


/*-------------------------------------------------------------------------
 * [DATE 관련 함수] 
 * Notes     	: 현재 시 분 초를 가져오는 함수
 * 
 * Return    	: String 문자열 오늘 날짜
 * Use       	: _fn_getTimeStamp();
-------------------------------------------------------------------------*/
function _fn_getTimeStamp() {
	var d = new Date();

	var s =
		_fn_getLsToNumber(d.getHours(), 2) + ':' +
		_fn_getLsToNumber(d.getMinutes(), 2) + ':' +
		_fn_getLsToNumber(d.getSeconds(), 2);

	return s;
};

/*-------------------------------------------------------------------------
 * [DATE 관련 함수] 
 * Notes     	: 날짜형식인지 체크하는 함수
 * 
 * Parameter   : d - String date
 * Return    	: boolean
 * Use       		: isDate('20120717');
-------------------------------------------------------------------------*/
function _fn_isDate(d) {
	
	d = d.replace("-","");
	d = d.replace("/","");
	d = d.replace(":","");
	d = d.replace(" ","");

	if(d < 6) return false;

	var yyyy = d.substring(0,4);
	var MM = d.substring(4,6);
	  
	var dd="01";
	if(d.length>6) dd=d.substring(6,8);

	var hh="01";
	if(d.length>8) hh=d.substring(8,10);
  
	var mm="00";
	if(d.length>10) mm=d.substring(10,12);
  
	var ss="00";
	if(d.length>12) {
		if( d.length<15) ss=d.substring(12,14);
		else return false;
	}

	var _d = new Date( yyyy, parseInt(MM)-1, dd, hh, mm, ss );
	
	if( _fn_getLsToNumber(_d.getFullYear(), 4) == yyyy && _fn_getLsToNumber(_d.getMonth() + 1, 2) == MM &&  _fn_getLsToNumber(_d.getDate(), 2) == dd 
		  && _fn_getLsToNumber(_d.getHours(), 2)  == hh && _fn_getLsToNumber(_d.getMinutes(), 2) == mm && _fn_getLsToNumber(_d.getSeconds(), 2) == ss ){
		return true;
	} else {
		return false;
	}
};

/*-------------------------------------------------------------------------
 * [DATE 관련 함수] 
 * Notes     	: 날짜를 비교하는 함수
 * 
 * Parameter    : srcDate - String 기준일자
 * 					  compDate - String 비교일자  
 * Return    	: ( srcDate > compDate )		= 1 
 * 				  ( srcDate == compDate )		= 0
 * 				  ( srcDate < compDate )  		= -1
 * 				  error( date자료가 아님 ) 		= -2 
 * Use       	: _fn_isCompareDate('20050101', "20000507");
-------------------------------------------------------------------------*/
function _fn_isCompareDate(srcDate, compDate){

	var strSrcDate 	= srcDate.replace("-","");
	var strCompDate = compDate.replace("-","");
	
	if( !( _isDate(strSrcDate) && _isDate(strCompDate) ) ) return -2;

	if(strSrcDate > strCompDate) return 1;
	else if (strSrcDate == strCompDate) return 0;
	else return -1;
};
	
/*-------------------------------------------------------------------------
 * [DATE 관련 함수] 
 * Notes     	: Date 함수에 format화 한다
 * 				  Date를 주어진 포멧의 문자열로 변환한다.
 * 
 * Parameter    : fmt : 변환하기 위한 포멧 문자열
 * Return    	: 포멧화된 날짜 형식
 * Use       	: new Date().format("yyyymmdd");
-------------------------------------------------------------------------*/
Date.prototype.format = function(fmt) {
    
	if (!this.valueOf()) return "";
 
    var dt = this;
    return fmt.replace(/(yyyy|yy|mm|dd|hh|hh24|mi|ss|am|pm)/gi, function($1){
            switch ($1){
                case 'yyyy'	: 	return _fn_getLsToNumber( dt.getFullYear(), 4 );
                case 'yy'	:   return dt.getFullYear().toString().substr(2);
                case 'mm'	:   return _fn_getLsToNumber( dt.getMonth() + 1, 2 );
                case 'dd'	:   return _fn_getLsToNumber( dt.getDate() , 2 );
                case 'hh'	:   return (h = _fn_getLsToNumber(dt.getHours() % 12) ? h : 12 , 2);
                case 'hh24'	: 	return _fn_getLsToNumber( dt.getHours(), 2 );
                case 'mi'		:   return _fn_getLsToNumber( dt.getMinutes(), 2 );
                case 'ss'		:   return _fn_getLsToNumber( dt.getSeconds(), 2 );
                case 'am'	:   return _fn_getLsToNumber( dt.getHours() < 12 ? 'am' : 'pm' , 2 ) ;
                case 'pm'	:   return _fn_getLsToNumber( dt.getHours() < 12 ? 'am' : 'pm' , 2 ) ; ;
            }
        } 
    );
};

/*-------------------------------------------------------------------------
 * [금액체크 관련 함수] 
 * Notes     	: 금액 체크(허용값 체크 -> maxlen 체크 -> isNull 체크)
 * 
 * Parameter 	: objId			- 금액 obj
 * 				  objName		- 금액 obj 명  
 * 				  maxLen		- 금액의 maxlen 체크
 * 				  nullYN		- 필수값 체크(Y/N)
 * Use      	: _fn_checkAmt($("#objId"), "obj 이름", 14, "Y" );
-------------------------------------------------------------------------*/
function _fn_checkAmt( objId, objName, maxLen, nullYN) {
	
	var obj = jQuery("#"+objId);
	var objVal = obj.val();
	
	// 체크순서 1. 금액 허용값(숫자와 ,) 체크
	if (objVal != objVal.replace(/[^0-9,]/g, ""))	{
		alert(objName+ " 는 숫자만 입력이 가능합니다.");
		obj.focus();
		return false; 
	}
	
	// 체크순서 2. 금액 maxlen 체크(숫자만 계산)
	if (maxLen < objVal.replace(/[^0-9]/g, "").length)	{
		alert(objName+ " 는 " + maxLen +"자까지 입력 할 수 있습니다.(현재 " + objVal.replace(/[^0-9]/g, "").length + "자를 입력하셨습니다.)");
		obj.focus();
		return false; 
	}
	
	// 체크순서 3. 금액 필수값 체크(Y 일 경우만 체크)
	if (nullYN == "Y")	{
		if ( _fn_isNull( objVal ) )	{
			alert(objName+ " 를 입력하여 주십시요.");
			obj.focus();
			return false; 
		}
	}
	return true;
}

/*-------------------------------------------------------------------------
 * [소숫점 포함한 숫자 체크 관련 함수] 
 * Notes     	: 소수점 포함한 숫자 체크(허용값 체크 -> 정수부/소수부 체크 -> isNull 체크)
 * 
 * Parameter 	: objId			- 소숫점 obj
 * 				  objName		- 소숫점 obj 명  
 * 				  consMaxLen  	- 정수부분 maxlen 자리수
 *				  decMaxLen  	- 소수부분 maxlen 자리수
 * 				  nullYN		- 필수값 체크(Y/N)
 * Use      	: _fn_checkFloatNum($("#objId"), "obj 이름", 6, 2, "Y",  );
-------------------------------------------------------------------------*/
function _fn_checkFloatNum( objId, objName, consMaxLen, decMaxLen, nullYN) {
	
	var obj = jQuery("#"+objId);
	var objVal = obj.val();	
	
	// 체크순서 1. 소숫점 포함한 숫자 허용값(숫자와 , 그리고 .) 체크
	if ( isNaN( objVal.replace(/[^0-9.]/g, "") ) ){
		alert(objName+"은(는) 올바른 금액 형식 아닙니다.");
		obj.focus();
        return false;
	}

	if (objVal != objVal.replace(/[^0-9,.]/g, ""))	{
		alert(objName+ " 는 숫자만 입력이 가능합니다.");
		obj.focus();
		return false; 
	}
	
	// 체크순서 2. 소숫점 포함한 숫자 정수부/소수부 체크(숫자만 계산)
	if ( !_fn_isDecimalCheck( objVal, consMaxLen, decMaxLen, objName ) ) {
		obj.focus();
		return false; 
	}
	
	// 체크순서 3. 금액 필수값 체크(Y 일 경우만 체크)
	if (nullYN == "Y")	{
		if ( _fn_isNull( objVal ) )	{
			alert(objName+ " 를 입력하여 주십시요.");
			obj.focus();
			return false; 
		}
	}
	
	return true;
};

/*-------------------------------------------------------------------------
 * [check box 관련 함수] 
 * Notes     	: 전체 선택 / 해제 기능 
 * 
 * Parameter 	: obj 			- 전체 선택/해제를 컨트롤 하는 obj  
 * 				  chkedId	- 전체 선택 / 해제가 되어야 할 check box id
 * Use       	: selectAllChk(this, 'chkedId' );
-------------------------------------------------------------------------*/
function selectAllChk( obj, chkedId ){
	var checks = document.getElementsByName(chkedId);
    var is_checked = true;
     
    if (obj.checked == false) is_checked = false;

    for(var i = 0; i < checks.length ; i++){
    	
    	if(checks[i].disabled == false){ //체크박스 상태가 활성화 된 상태만 체크
    		checks[i].checked = is_checked;	
    	}
	}
};

var winPop = [];
/*-------------------------------------------------------------------------
 * [popup 관련 함수] 
 * Notes     	: 팝업 open 함수 
 * 
 * Parameter 	: url  			- 주소
 * 				  popId	- 전체 선택 / 해제가 되어야 할 check box id  
 * 				  width	- 넓이
 * 				  height	- 높이 
 * Use       	: windowOpenPopup( 'http://ublis.com', 'id', 300, 400 );
-------------------------------------------------------------------------*/
function windowOpenPopup( url, popId, width, height ){
	
	var stats ="";
 
	var menubarval     	= 'no'; 	//메뉴바표시여부
	var scrollbarsval  	= 'no'; 	//스크롤바표시여부
	var resizablesval  	= 'no'; 	//창크기조정여부
	var tolbarval      	= 'no';  	//툴바표시여부
	var locationval    	= 'no'; 	//주소창표시여부 
	var directoriesval 	= 'no'; 	//스크롤바표시여부
	var statusval      	= 'no';		//상태바표시여부
	
	var left = ((screen.width-parseInt(width))/2);
    var top = ((screen.height-parseInt(height))/2);
    
	stats = 'toolbar=' 		+ tolbarval + ', ';
	stats += 'location=' 	+ locationval + ', ';
	stats += 'directories=' + directoriesval + ', ';
	stats += 'status=' 		+ statusval + ', ';
	stats += 'menubar=' 	+ menubarval + ', ';
	stats += 'scrollbars='	+ scrollbarsval + ', ';  
	stats += 'resizable='	+ resizablesval + ', ';
	stats += 'width='		+ width + ', ';
	stats += 'height='		+ height +', ';   
	stats += 'top='			+ top +', ';
	stats += 'left='		+ left+'';
 
	
	winPop[winPop.length] = window.open( url, popId, stats );	// window 열기
	winPop[winPop.length-1].focus();

	return winPop[winPop.length-1];
};

/*-------------------------------------------------------------------------
 * [popup 관련 함수] 
 * Notes     	: 열려있는 팝업 전체 닫기 기능
 * Use       	: _fn_allPopClose();
-------------------------------------------------------------------------*/
function _fn_allPopClose(){
	for(var i = 0 ; i < winPop.length ; i++){
		if(!winPop[i].closed){
			winPop[i].close();
		}
	}
};

/*-------------------------------------------------------------------------
 * 숫자금액 문자 변환 스크립트
 * chknum - 금액
 * Parameter    : chknum - 금액
 * 				  inputId - id
 * Return    	: 문자 변환된 금액
 * Use       	: _fn_numberFormat('12,000','id');
-------------------------------------------------------------------------*/
function _fn_numberFormat(chknum,inputId) {
	
	num = chknum;
	num = num.split(',').join('');
	var arr = num.split('.');
	var num = new Array();
	
	for (var i = 0; i <= arr[0].length-1; i++) {
		num[i] = arr[0].substr(arr[0].length-1-i,1);
		if(i%3 == 0 && i != 0) num[i] += ',';
	}
	num = num.reverse().join('');
	
	if (!arr[1]){
		chknum.value = num;
	}else{
		chknum.value = num+'.'+arr[1];
	}
	
	_fn_num2won(chknum,inputId);
}

function _fn_num2won(chknum,inputId) {
	val = chknum;
	var won = new Array();
	re = /^[1-9][0-9]*$/;
	num = val.toString().split(',').join('');
	if (!re.test(num)) {
		chknum.value = '';
		jQuery("#" + inputId).val('');
	} else {
		var price_unit0 = new Array('','일','이','삼','사','오','육','칠','팔','구');
		var price_unit1 = new Array('','십','백','천');
		var price_unit2 = new Array('','만','억','조','경','해','시','양','구','간','정');
		for(var i = num.length-1; i >= 0; i--) {
		won[i] = price_unit0[num.substr(num.length-1-i,1)];
		if(i > 0 && won[i] != '') won[i] += price_unit1[i%4];
		if(i % 4 == 0) won[i] += price_unit2[(i/4)];
	}
	for(var i = num.length-1; i >= 0; i--) {
		if(won[i].length == 2) won[i-i%4] += '-';
		if(won[i].length == 1 && i > 0) won[i] = '';
		if(i%4 != 0) won[i] = won[i].replace('일','');
	}
	won = won.reverse().join('').replace(/-+/g,'');
	jQuery("#" + inputId).val(won);
	}
}

/*-------------------------------------------------------------------------
 * 브라우저 체크
 * Notes     	: IE11 의 경우 반환값 IE11
 * Return    	: 브라우저
 * Use       	: _fn_getBrowserType();
-------------------------------------------------------------------------*/
function _fn_getBrowserType(){
    
    var _ua = navigator.userAgent;
    var rv = -1;
     
    //IE 11,10,9,8
    var trident = _ua.match(/Trident\/(\d.\d)/i);
    if( trident != null )
    {
        if( trident[1] == "7.0" ) return rv = "IE" + 11;
        if( trident[1] == "6.0" ) return rv = "IE" + 10;
        if( trident[1] == "5.0" ) return rv = "IE" + 9;
        if( trident[1] == "4.0" ) return rv = "IE" + 8;
    }
     
    //IE 7...
    if( navigator.appName == 'Microsoft Internet Explorer' ) return rv = "IE" + 7;
     
    /*
    var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
    if(re.exec(_ua) != null) rv = parseFloat(RegExp.$1);
    if( rv == 7 ) return rv = "IE" + 7; 
    */
     
    //other
    var agt = _ua.toLowerCase();
    if (agt.indexOf("chrome") != -1) return 'Chrome';
    if (agt.indexOf("opera") != -1) return 'Opera'; 
    if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
    if (agt.indexOf("webtv") != -1) return 'WebTV'; 
    if (agt.indexOf("beonex") != -1) return 'Beonex'; 
    if (agt.indexOf("chimera") != -1) return 'Chimera'; 
    if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
    if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
    if (agt.indexOf("firefox") != -1) return 'Firefox'; 
    if (agt.indexOf("safari") != -1) return 'Safari'; 
    if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
    if (agt.indexOf("netscape") != -1) return 'Netscape'; 
    if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla';
}


function getURLParam(url,strParamName){

	  var strReturn = "";

	  var strHref = url;

	  var bFound=false;

	  

	  var cmpstring = strParamName + "=";

	  var cmplen = cmpstring.length;


	  if ( strHref.indexOf("?") > -1 ){

	    var strQueryString = strHref.substr(strHref.indexOf("?")+1);

	    var aQueryString = strQueryString.split("&");

	    for ( var iParam = 0; iParam < aQueryString.length; iParam++ ){

	      if (aQueryString[iParam].substr(0,cmplen)==cmpstring){

	        var aParam = aQueryString[iParam].split("=");

	        strReturn = aParam[1];

	        bFound=true;

	        break;

	      }

	      

	    }

	  }

	  if (bFound==false) return null;

	  return strReturn;

	}