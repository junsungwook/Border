<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여기에 제목을 입력하십시오</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function loginCheck(){
   if($("#userid").val()==""){
      alert("아이디 입력 하세요");
      return false;
   }
   if($("#pwd").val()==""){
      alert("비번 입력 하세요");
      return false;
   }
   return true;
}
function memberDel(member){
   location.href="deleteProc.jsp?userid="+member;
}
</script>
</head>
<body>
<%
String userId = (String)session.getAttribute("userId");
if(userId!=null){//세션이 있으면?
int admin= (int)session.getAttribute("admin");
	if(admin==1){%>
   <h2>회원전용 페이지</h2>
   <form action="Logout.jsp">안녕하세요 <%=userId%>님 반갑습니다.<br>
   <input type="submit" value="로그아웃">
   <input type="button" value="회원변경" onclick="location.href='memberView.jsp?userid=<%=userId%>'">
   <input type="button" value="회원탈퇴" onclick="memberDelete.jsp?userid=<%=userId%>">
   </form>
<%		 }else{ %>
	   <h2>관리자전용 페이지</h2>
	   <form action="Logout.jsp">안녕하세요 <%=userId%>님 반갑습니다.<br>
	   <input type="submit" value="로그아웃">
	   <input type="button" value="회원변경" onclick="location.href='memberView.jsp?userid=<%=userId%>'">
	   <input type="button" value="회원탈퇴" onclick="memberDelete.jsp?userid=<%=userId%>">
	   <input type="button" value="리스트보기" onclick="location.href='boardList.jsp'">
	   </form>
<% }
}else{ //세션이 없으면?
%>
<form action="loginProc.jsp" method="post" name="frm">
   <table>
      <tr>
         <td>아이디</td>
         <td><input type="text" name="userid" id="userid"></td>
      </tr>
      <tr>
         <td>암호</td>
         <td><input type="password" name="pwd" id="pwd"></td>
      </tr>
      <tr>
      <td colspan="2" align="center">
         <input type="submit" value="로그인" onclick="return loginCheck()">&nbsp;&nbsp;
         <input type="reset" value="취소">&nbsp;&nbsp;
         <input type="button" value="회원 가입" onclick="location.href='join.jsp'">
      </td>
      </tr>
   </table>
</form>
<%} %>
</body>
</html>