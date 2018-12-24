<%@page import="com.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
   request.setCharacterEncoding("utf-8");
%>
<body>
<jsp:useBean id ="mb" class = "com.member.Member"></jsp:useBean>
<jsp:setProperty property ="*" name="mb"/>
<%
	MemberDAO dao  = MemberDAO.getInstance();
	dao.memberInsert(mb);
	out.println(mb.getUserid());
%>
<form action = "list1.jsp">
<input type = 'submit' onclick='view()'value='전체보기'>
</form>
</body>
</html>