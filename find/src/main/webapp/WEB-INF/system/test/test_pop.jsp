<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
	.form-style-2{
	    max-width: 500px;
	    padding: 20px 12px 10px 20px;
	    font: 13px Arial, Helvetica, sans-serif;
	}
	.form-style-2-heading{
	    font-weight: bold;
	    font-style: italic;
	    border-bottom: 2px solid #ddd;
	    margin-bottom: 20px;
	    font-size: 15px;
	    padding-bottom: 3px;
	}
	.form-style-2 label{
	    display: block;
	    margin: 0px 0px 15px 0px;
	}
	.form-style-2 label > span{
	    width: 100px;
	    font-weight: bold;
	    float: left;
	    padding-top: 8px;
	    padding-right: 5px;
	}
	.form-style-2 span.required{
	    color:red;
	}
	.form-style-2 .tel-number-field{
	    width: 40px;
	    text-align: center;
	}
	.form-style-2 input.input-field{
	    width: 48%;
	    
	}
	
	.form-style-2 input.input-field, 
	.form-style-2 .tel-number-field, 
	.form-style-2 .textarea-field, 
	 .form-style-2 .select-field{
	    box-sizing: border-box;
	    -webkit-box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    border: 1px solid #C2C2C2;
	    box-shadow: 1px 1px 4px #EBEBEB;
	    -moz-box-shadow: 1px 1px 4px #EBEBEB;
	    -webkit-box-shadow: 1px 1px 4px #EBEBEB;
	    border-radius: 3px;
	    -webkit-border-radius: 3px;
	    -moz-border-radius: 3px;
	    padding: 7px;
	    outline: none;
	}
	.form-style-2 .input-field:focus, 
	.form-style-2 .tel-number-field:focus, 
	.form-style-2 .textarea-field:focus,  
	.form-style-2 .select-field:focus{
	    border: 1px solid #0C0;
	}
	.form-style-2 .textarea-field{
	    height:100px;
	    width: 55%;
	}
	.form-style-2 input[type=submit],
	.form-style-2 input[type=button]{
	    border: none;
	    padding: 8px 15px 8px 15px;
	    background: #FF8500;
	    color: #fff;
	    box-shadow: 1px 1px 4px #DADADA;
	    -moz-box-shadow: 1px 1px 4px #DADADA;
	    -webkit-box-shadow: 1px 1px 4px #DADADA;
	    border-radius: 3px;
	    -webkit-border-radius: 3px;
	    -moz-border-radius: 3px;
	}
	.form-style-2 input[type=submit]:hover,
	.form-style-2 input[type=button]:hover{
	    background: #EA7B00;
	    color: #fff;
	}
</style>
</head>
<body>
	<div class="form-style-2">
		<form action="" method="post">
			<label for="field1">
				<span>제목 <span class="required">*</span></span><input type="text" class="input-field" name="field1" value="" />
			</label>
			<label for="field2">
				<span>이메일 <span class="required">*</span></span><input type="text" class="input-field" name="field2" value="" />
			</label>
			<label>
				<span>연락처</span><input type="text" class="tel-number-field" name="tel_no_1" value="" maxlength="4" />-<input type="text" class="tel-number-field" name="tel_no_2" value="" maxlength="4"  />-<input type="text" class="tel-number-field" name="tel_no_3" value="" maxlength="10"  />
			</label>
			<label for="field2">
				<span>분실날짜</span><input type="text" class="input-field" name="field2" value="" />
			</label>
			<label for="field2">
				<span>성별</span>
				<select name="field4" class="select-field">
					<option value="General Question">수컷</option>
					<option value="Advertise">암컷</option>
				</select>
				<span>나이</span>
			</label>
			<label for="field4">
				<span>품종</span>
				<select name="field4" class="select-field">
					<option value="General Question">개</option>
					<option value="Advertise">고양이</option>
					<option value="Partnership">기타</option>
				</select>
				<input type="text" class="input-field" name="field2" value="" />
			</label>
			<label for="field2">
				<span>분실장소</span><input type="text" class="input-field" name="field2" value="" />
			</label>
			<label for="field2">
				<span>색상</span><input type="text" class="input-field" name="field2" value="" />
			</label>
			<label for="field5">
				<span>특징 <span class="required">*</span></span><textarea name="field5" class="textarea-field"></textarea>
			</label>
			<label for="field2">
				<span>신고경위</span><input type="text" class="input-field" name="field2" value="" />
			</label>
			<label for="field2">
				<span>등록번호</span><input type="text" class="input-field" name="field2" value="" />
			</label>
			<label for="field2">
				<span>RFID_CD</span><input type="text" class="input-field" name="field2" value="" />
			</label>
			<label><span>&nbsp;</span><input type="submit" value="Submit" /></label>
		</form>
	</div>
</body>
</html>