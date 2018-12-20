<%@page import="com.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String passwd = request.getParameter("passwd");
BoardDAO dao  = BoardDAO.getInstance();
boolean resp = dao.delBoard(num,passwd);
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