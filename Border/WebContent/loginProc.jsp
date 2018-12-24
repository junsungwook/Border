<%@page import="com.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여기에 제목을 입력하십시오</title>
</head>
<%
request.setCharacterEncoding("utf-8");
String userid = request.getParameter("userid");
String pwd = request.getParameter("pwd");
MemberDAO dao = MemberDAO.getInstance();
int result = dao.userCheck(userid,pwd);
if(result==1){
	int admin = dao.AdminCheck(userid);
	if(admin==1){
	   session.setAttribute("userId", userid);
	   response.sendRedirect("login.jsp");
	   session.setAttribute("admin",admin);
   }
   else if(admin==2){
	   session.setAttribute("userId", userid);
	   session.setAttribute("admin",admin);
	   response.sendRedirect("login.jsp");

   }
}
else if(result==0){
   %>
   <script>
      alert("비밀번호가 맞지 않습니다");
      location.href="login.jsp";
   </script>
   <%
}
else if(result==-1){
   %>
   <script>
      alert("회원이 아닙니다");
      location.href="login.jsp";
   </script>
   <%
}
%>