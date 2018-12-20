<%@page import="com.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여기에 제목을 입력하십시오</title>
</head>
<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));

BoardDAO dao = BoardDAO.getInstance();
%>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	$("#btn").click(function(){
		if($("#text").val()==""){
			alert("비밀번호를 입력하세요");
			return false;
		}
		$("#frm").submit();
	});
});
</script>
<body>
<div class="container">
<form action="deleteProc.jsp" method="post" id="frm">
	<input type="hidden" value="<%=num %>" name="num">
	<table width="500" border="1" align="center" class="table">
		<tr>
			<td>비밀번호를 입력해 주세요.</td>
		</tr>
		<tr>
			<td>비밀번호 : <input type="text" class="text" id="text" name="passwd"></td>	
		</tr>
		<tr>
			<td>
				<input type="button" value="글삭제" id="btn">
				<input type="button" value="글목록" onclick="location='boardList.jsp'">
			</td>
		</tr>
		
	</table>
</form>
</div>
</body>
</html>