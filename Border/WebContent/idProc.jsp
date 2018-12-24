<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function sendIt(){
	$.ajax({
		type:"post",
		url:"idcheckProc.jsp?userid="+$("#userid").val(),
		success: function(data){
			if(data.trim()=="ok"){
				alert("쓸수있는 아이디입니다.");
				$(opener.document).find("#id").val($("#userid").val());
				$(opener.document).find("#id1").val($("#userid").val());
				self.close();
				}else{alert("쓸수없는 아이디입니다!");}
		},
		error:function(e){
			alert(e);
		},
	});
}
</script>
<body>

<input type="text" id="userid">
<input type ="button"onclick="sendIt()" value="중복확인">

</body>
</html>