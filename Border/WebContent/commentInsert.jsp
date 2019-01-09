<%@page import="com.member.Member"%>
<%@page import="com.board.CommentBean"%>
<%@page import="com.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String msg = request.getParameter("msg");
int bnum = Integer.parseInt(request.getParameter("num"));
Member mb = (Member)session.getAttribute("mb");
String userid = (String)session.getAttribute("userId");
if(userid==null){
	out.println("1");
}else{
	BoardDAO dao = BoardDAO.getInstance();
	CommentBean cb = new CommentBean();
	cb.setBnum(bnum);
	cb.setMsg(msg);
	cb.setUserid(userid);
	dao.commentInsert(cb);
	response.sendRedirect("commentList.jsp?num="+bnum);
}
%>