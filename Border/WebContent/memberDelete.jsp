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
<jsp:useBean id ="mb" class = "com.member.Member"></jsp:useBean>
<jsp:setProperty property ="*" name="mb"/>
<%
	MemberDAO dao  = MemberDAO.getInstance();
	dao.memberDelete(mb);
	out.println(mb.getUserid());
	response.sendRedirect("login.jsp");
%>
</body>
</html>