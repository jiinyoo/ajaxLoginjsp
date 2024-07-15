<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login.Login" %>

<%
 Login login=new Login();
 login.memberView(request,session,response);
%>

<h2>회원 정보</h2>

<div>아이디 : ${mdto.userid}</div>
<div>이름 : ${mdto.name}</div>
<div>이메일 : ${mdto.email}</div>
<div>전화번호 : ${mdto.phone}</div>
<div>최초가입일 : ${mdto.writeday}</div>