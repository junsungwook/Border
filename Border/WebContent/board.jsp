<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<form action="boardProc.jsp" id="frm">
	<table id="blueone" >
		<tr>
			<th colspan=2><strong><a href ="boardList.jsp" ><button type="button" class="btn btn-warning">LIST</button> </a></strong></th>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="writer" id="writer"  class="form-control"></td>
		</tr>
		<tr>
			<td>제목</td>
			<td><input type="text" name="subject" id="subject" class="form-control"></td>
		</tr>
		<tr>
			<td>email</td>
			<td><input type="email" name="email" id="email" class="form-control"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea rows="10" cols="50" name="content" id="content" class="form-control"></textarea></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passwd"  id="passwd" class="form-control"></td>
		</tr>
		<tr>
			<td><input type="submit" class="btn btn-warning" value="글쓰기" id="input"></td>
			<td><input type="reset" class="btn btn-warning" name="다시쓰기"  ></td>
		</tr>
	</table>

</form>
	</div>
</body>
</html>