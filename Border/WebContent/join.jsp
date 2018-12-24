<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
var emailPattern =/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
var pw_p= /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
$(document).ready(function(){
    $("#pw1").keyup(function(){
        $("#pw2").val("");
        $("div").remove();
        return false;
    });
    $("#pw2").keyup(function() {
        if ($("#pw1").val() != "") {
            if ($("#pw1").val() != $("#pw2").val()) {
                $("div").remove();
             	   $("span").append("<div style='color:red'>비밀번호 틀림</div>");
             	   return false;
            } else {
                $("div").remove();
            	    $("span").append("<div style='color:green'>비밀번호 맞음</div>");
             }
        }
    });
    $("#btnIn").click(function(){
    	if(!$("#pw1").val().match(pw_p)){
    		alert("비밀번호는 영어,특수문자를 포함해야합니다.")
    		return false;
    	}
        if ($("#pw1").val() != $("#pw2").val()) {
          	alert("비밀번호 맞지않음");
        	return false;
        }
        if($("#name").val()==""){
        	alert("이름입력"); 
        	return false;
        }
        if($("#id").val()==""){
        	alert("아이디입력"); 
        	return false;
        }
        if(!$("#email").val().match(emailPattern)){
        	alert("이메일 형식이 아닙니다.");
        	return false;
        }
         	$("#frm").submit();
         });
    $("#idcheck").click(function(){
    	url="idProc.jsp"
    	window.open(url,"confirm","width=500 height=150");
    });
});
$(function(){
	$("#btnZip").click(function(){
		window.open("zipCheckjsp.jsp","","width=500 height =500");
	})	
});
</script>
<body>
<h1>회원가입</h1>
<form name ="frm" id="frm" action ="joinProc.jsp">
<input type ="hidden" name="userid" id="id1">
<table>
	<tr>
		<td> 이름:</td>
		<td><input type ="text" name="name" id="name"> * </td>
	</tr>
	<tr>
		<td> ID:</td>
		<td><input type ="text" disabled  id="id"> * </td>
		<td><input type ="button" id="idcheck" value ="중복체크"></td>
	</tr>
	<tr>
		<td> PASSWORD:</td>
		<td><input type ="password" id ="pw1" name="pwd"> * (영문,특수기호포함)</td>
	</tr>
	<tr>
		<td> 암호확인:</td>
		<td><input type ="password"  id ="pw2"> * </td>
		<td><span></span></td>
	</tr>
	<tr>
		<td> E-MAIL:</td>
		<td><input type ="text" name= "email" id="email">  </td>
	</tr>
	<tr>
		<td> PHONE:</td>
		<td><input type ="text" name="phone"></td>
	</tr>
	<tr>
		<td>우편번호:</td>
		<td><input type ="text" name="zipcode" id= "zipcode"></td>
	</tr>
	<tr>
		<td> 주소:</td>
		<td><input type ="text" name="addr" id="addr"></td>
		<td><input type ="button" name="btnZip" id="btnZip" value='검색'></td>
	</tr>
	<tr>
		<td> 등급:</td>
		<td><input type ="radio" value =1  name ="admin">일반회원<input type ="radio" value =2  name ="admin">관리자</td>
	</tr>
	<tr>
		<td></td>
		<td><input type ="button" id ="btnIn" value ="확인"><input type ="button" value ="취소"></td>
	</tr>
</table>
</form>
</body>
</html>