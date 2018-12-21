<%@page import="com.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id ="b" class = "com.board.BoardBean"></jsp:useBean>
<jsp:setProperty property ="*" name="b"/>
<%
BoardDAO dao  = BoardDAO.getInstance();
boolean resp = dao.updateBoard(b);
if(resp==false){
%>
<script>
 alert("비번오류");
 history.back();
</script>
<%	
}
else{
	response.sendRedirect("boardList.jsp");
}
 %>