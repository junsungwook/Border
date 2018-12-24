<%@page import="com.member.Member"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
$(function(){
	$("#btnZip").click(function(){
		window.open("zipCheckjsp.jsp","","width=500 height =500");
	})		
});
</script>
<%
	MemberDAO dao= MemberDAO.getInstance();
	String userid =request.getParameter("userid");
	Member mb = dao.memberView(userid);
%>
</head>
<body>
<form action ="updateProc.jsp" name="frm" >
이름: <input type = "text" id ="name" name ="name" value="<%=mb.getName()%>"><br>
아이디:  <input type = "text" name ="userid" id="id" value="<%=mb.getUserid()%>" readonly><br>
비밀번호:  <input type = "text" name ="pwd" value="<%=mb.getPwd()%>"><br>
이메일:  <input type = "text" name ="email" id="email" value="<%=mb.getEmail()%>"><br>
폰:  <input type = "text" name ="phone"value="<%=mb.getPhone()%>"><br>
우편번호:<input type = "text" name ="zipcode" id="zipcode" value="<%=mb.getZipcode()%>"><br>
주소:<input type = "text" name ="addr" id="addr" value="<%=mb.getAddr()%>"><input type ="button" name="btnZip" id="btnZip" value='검색'><br>
등급: <input type ="radio" value =1 name ="admin">일반회원<input type ="radio" value =2  name ="admin">관리자<br>
<input type='submit'  id="update" value='수정하기'>
<a href ="memberDelete.jsp?userid=<%=mb.getUserid()%>"><input type = "button" value="삭제"></a>
</form>
</body>
<script>
$(document).ready(function(){
	
	$('input:radio[name=admin]:input[value=' + <%=mb.getAdmin()%> + ']').attr("checked", true);
	
	$("#update").click(function(){
    	if(!$("#pwd").val().match(pw_p)){
    		alert("비밀번호는 영어,특수문자를 포함해야합니다.")
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
});

</script>
</html>