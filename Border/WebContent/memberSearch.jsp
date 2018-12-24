<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.member.Member"%>
<%@page import="com.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
	String selsch = request.getParameter("selsch");
	String textsch = request.getParameter("textsch");
	Member mb = new Member();
	MemberDAO dao  = MemberDAO.getInstance();
	ArrayList<Member> arr = dao.memberSearch(selsch, textsch);
	JSONArray jarr= new JSONArray();
	String admin="";
	for(Member m:arr){
		JSONObject obj = new JSONObject();
		obj.put("name",m.getName());
		obj.put("userid",m.getUserid());
		obj.put("pwd",m.getPwd());
		obj.put("email",m.getEmail());
		obj.put("phone",m.getPhone());
		obj.put("zipcode",m.getZipcode());
		obj.put("addr",m.getAddr());
		if(m.getAdmin()==1){admin="일반회원";}else{admin="관리자";}
		obj.put("admin",admin);
		jarr.add(obj);
	}
	out.println(jarr.toString());
%>

