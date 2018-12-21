<%@page import="com.board.BoardBean"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부산 IT교육 센터 게시판</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style>  
   body { background: #fff; padding : 30px;}
   #blueone {
     
   }  
   #blueone thead{
     padding: 10px;
     text-align: left;
     border-bottom: 2px solid blue;
   }

</style>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function () {
   $("#searchIt").click(function(){
      if(search.word.value==""){
         alert("검색어를 넣어라");
         search.word.focus();
         return;
      }
         search.submit();
   });
});

</script>
</head>
<body>
<div class="container">
<%
   BoardDAO dao  = BoardDAO.getInstance();
   int pageSize=5;
   String pageNum=request.getParameter("pageNum");
   if(pageNum==null){
	   pageNum="1";
   }
   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage-1)*pageSize+1;
   int endRow = currentPage*pageSize;
   String word="";
   String field="";
   if(request.getParameter("word")!=null){
      word=request.getParameter("word");
      field=request.getParameter("field");
   }
   ArrayList<BoardBean> arr = dao.boardList(field,word,startRow,endRow);
   //여기서 사이즈 재는 놈을 불러서 밑에 번호 버튼의 크기나 이러저런거 지정할 준비한다
   int count = dao.size(field,word);
   int number=count-(currentPage-1)*pageSize;
%>

<table id="blueone" class="table table-hover table-striped table-dark">
	<thead class="thead-light">  
	   <tr>
	      <th scope="col">번호</th>
	      <th scope="col">제목</th>
	      <th scope="col">작성자</th>
	      <th scope="col">작성일</th>
	      <th scope="col">조회</th>
	      <th scope="col">ip</th>
	   </tr>
	</thead>
   <% 
    for(int i =0; i <arr.size(); i ++){
   %>
       <tbody>
          <tr>
	             <th scope="row"><%=number--%></th>
	             <td>
	             	<%
	             		int wid=0;
	             		if(arr.get(i).getRe_level()>0){
	             			wid=7*(arr.get(i).getRe_level());
	             	%>
	             		<img src="images/level.gif" width="<%=wid %>" height="16">
	             		<img src="images/re.gif">
	             	<%
	             		}else{
	             	%>
	             	<img src="images/level.gif" width="<%=wid %>" height="16">
	             	<%
	             		}
	             	%>
	             	<a href="boardView.jsp?num=<%=arr.get(i).getNum()%>"><%=arr.get(i).getSubject()%></a>
	             </td>
	             <td><%=arr.get(i).getWriter() %></td>
	             <td><%=arr.get(i).getReg_date() %></td>
	             <td><%=arr.get(i).getReadcount() %></td>
	             <td><%=arr.get(i).getIp() %></td>
          </tr>
      </tbody>
       <%
    }
      %>
</table>
<%
   if(count>0){//53
      //총페이지수
      int pageCount = count/pageSize+(count%pageSize==0?0:1);
      int pageBlock = 3;//[이전] 4|5|6 [다음]
      
      int startPage=(int) ((currentPage-1)/pageBlock)*pageBlock+1;
      int endPage=startPage +pageBlock-1;
      if(endPage >pageCount){
         endPage=pageCount;
      }//12
      // 이전출력부분
      if(startPage>pageBlock){
         %><a href="boardList.jsp?pageNum=<%=startPage%>&field=<%=field%>&word=<%=word%>">[이전]</a><% 
      }
      //페이지 수 출력부분
      for(int i =startPage; i<=endPage; i++){
         if(i==currentPage){
            %>[<%=i%>]<%
         }else{
         %>[<a href ="boardList.jsp?pageNum=<%=i%>&field=<%=field%>&word=<%=word%>"><%=i%></a>]<% 
      }
         //다음 출력부분
         if(endPage<pageCount){
            %><a href="boardList.jsp?pageNum=<%=startPage+pageBlock%>&field=<%=field%>&word=<%=word%>">[다음]</a><%
         }
      }
   }
%>
<br><br>
<form name="search" action="boardList.jsp">
	<div class="col-xs-2">
	   <select id="field" class="form-control" name="field">
	      <option value="subject"> 제목
	      <option value="writer"> 작성자
	   </select>
	</div>
	<div class="col-xs-3">
	   <input type='text' id='word' name='word' size='10' class="form-control" placeholder="검색어입력">
	</div>
	   <input type='button' class="btn btn-default" value="검색" id='searchIt'>
</form>
</div>
</body>
</html>