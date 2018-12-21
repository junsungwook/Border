<%@page import="com.board.CommentBean"%>
<%@page import="com.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
BoardDAO dao = BoardDAO.getInstance();
String msg = request.getParameter("msg");
int bnum = Integer.parseInt(request.getParameter("num"));
CommentBean cb = new CommentBean();
cb.setBnum(bnum);
cb.setMsg(msg);
cb.setUserid("userid");
dao.commentInsert(cb);

response.sendRedirect("commentList.jsp?num="+bnum);
%>