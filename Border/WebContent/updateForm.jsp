<%@page import="com.board.BoardBean"%>
<%@page import="com.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
BoardDAO dao = BoardDAO.getInstance();
BoardBean bean = dao.getBoard(num); //상세보기

%>
</head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<style>  
body{
	padding : 30px;
}
	body { background: #fff; }
	#blueone {
	  border-collapse: collapse;
	}  
	#blueone th {
	  padding: 10px;
	  color: #168;
	  border-bottom: 3px solid #FACC2E;
	  text-align: left;
	}
	#blueone td {
	  color: #669;
	  padding: 10px;
	  border-bottom: 1px solid #ddd;
	}
	#blueone tr:hover td {
	  color: #004;
	}
</style>
<body>
<div class="container">
<form action="updateProc.jsp" method="post">
<input type = "hidden" name = "num" value="<%=bean.getNum() %>">
<input type = "hidden" name = "ref" value="<%=bean.getRef() %>">
<input type = "hidden" name = "re_step" value="<%=bean.getRe_step() %>">
<input type = "hidden" name = "re_level" value="<%=bean.getRe_level() %>">
	<table id="blueone" >
		<tr>
			<th colspan=2><strong><a href ="boardList.jsp" ><button type="button" class="btn btn-warning">LIST</button> </a></strong></th>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="writer" id="writer"  class="form-control" value="<%=bean.getWriter()%>"></td>
		</tr>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" name="subject" id="subject" value="<%=bean.getSubject()%>" class="form-control">
			</td>
		</tr>
		<tr>
			<td>email</td>
			<td><input type="text" name="email" id="email" class="form-control" value="<%=bean.getEmail()%>"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea rows="10" cols="50" name="content" id="content" class="form-control"><%=bean.getContent()%></textarea></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passwd"  id="passwd" class="form-control"></td>
		</tr>
		<tr>
			<td><input type="submit" class="btn btn-warning" value="글수정" id="input"></td>
			<td><input type="reset" class="btn btn-warning" name="다시쓰기"  ></td>
		</tr>
	</table>

</form>
	</div>
</body>
</html>