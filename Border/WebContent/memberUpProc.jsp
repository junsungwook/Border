<%@page import="com.member.MemberDAO"%>
<%@page import="com.member.Member"%>
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
<jsp:useBean id ="mb" class = "com.member.Member"></jsp:useBean>
<jsp:setProperty property ="*" name="ab"/>
<% 
  	MemberDAO dao = MemberDAO.getInstance();
	dao.memberUpdate(mb);
	response.sendRedirect("list.jsp");
	%>
</body>
</html>