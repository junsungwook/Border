<%@page import="com.board.BoardBean"%>
<%@page import="com.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
table{
	text-align: center;
}
</style>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
	$.ajax({
		url:"commentList.jsp",
		type:"post",
		data:{"num":$("#num").val()},
		success:function(data){
			if(data!=null){
				data = $.parseJSON(data);
				var htmlStr="";
				htmlStr +="<table class='table table-striped table-dark'>";
				for(var i=0; i<data.length;i++){
					htmlStr +="<tr>";
					htmlStr +="<td>"+data[i].cnum+"</td>";
					htmlStr +="<td>"+data[i].userid+"</td>";
					htmlStr +="<td>"+data[i].regdate+"</td>";
					htmlStr +="<td>"+data[i].msg+"</td>";
					htmlStr +="</tr>";
				}
				htmlStr +="</table>";
				$("#result").html(htmlStr);	
			}
		},
		error:function(e){
			alert("error : "+ e);
		}
	});
	$("#commentBtn").click(function(){
		$.ajax({
			url:"commentInsert.jsp",
			type:"post",
			data:{"msg":$("#msg").val(),"num":$("#num").val()},
			success:function(data){
				data = $.parseJSON(data);
				var htmlStr="";
				htmlStr +="<table class='table table-striped table-dark'>";
				for(var i=0; i<data.length;i++){
					htmlStr +="<tr>";
					htmlStr +="<td>"+data[i].cnum+"</td>";
					htmlStr +="<td>"+data[i].userid+"</td>";
					htmlStr +="<td>"+data[i].regdate+"</td>";
					htmlStr +="<td>"+data[i].msg+"</td>";
					htmlStr +="</tr>";
				}
				htmlStr +="</table>";
				$("#result").html(htmlStr);	

			},
			error:function(e){
				alert("error : "+ e);
			}
		});
	});
});
</script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여기에 제목을 입력하십시오</title>
</head>

<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
BoardDAO dao = BoardDAO.getInstance();
BoardBean bean = dao.getBoard(num); //상세보기
int ref = bean.getRef();
int re_step = bean.getRe_step();
int re_level = bean.getRe_level();
%>
<body>
<div class="container">
<h2>글내용 보기</h2>
	<input type="hidden" name="num" id="num" value="<%=num %>">
	<table width="500" border="1" align="center" class="table">
		<tr>
			<td width="100">글번호</td>
			<td><%=bean.getNum()%></td>
			<td>조회수</td>
			<td><%=bean.getReadcount()%></td>
		</tr>
		<tr>
			<td width="100">작성자</td>
			<td><%=bean.getWriter()%></td>
			<td width="100">작성일</td>
			<td><%=bean.getReg_date()%></td>
		</tr>
		<tr>
			<td width="100">글제목</td>
			<td colspan=3><%=bean.getSubject()%></td>
		</tr>
		<tr>
			<td width="100">글내용</td>
			<td colspan=3><%=bean.getContent()%></td>
		</tr>
		<tr>
			<td colspan=4>
			<input type="button" value="글수정" onclick="location='updateForm.jsp?num=<%=bean.getNum()%>'">
			<input type="button" value="글삭제" onclick="location='deleteForm.jsp?num=<%=bean.getNum()%>'">
			<input type="button" value="답글쓰기" onclick="location='board.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
			<input type="button" value="글목록" onclick="location='boardList.jsp'">
			</td>
		</tr>
	</table>
	<br><br><br><br>
	<div align="right">
		<textarea row="5" cols="50" id="msg" class="form-control"></textarea>
		<input type="button" value="댓글쓰기" id="commentBtn" class="btn btn-default">
	</div>
	<div id="result"></div>
</div>
</body>
</html>