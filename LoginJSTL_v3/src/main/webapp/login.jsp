<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 이 부분 바로 넘어가 버리는 것 해결 필요 -->
<%@ page import="login.Login" %>

<%
 Login login=new Login();
 login.login(request);   
%>




<h2>로그인</h2>
  
 <form name="login" method="post" action="loginOk.jsp">
 	<input type="text" name="userid" placeholder="아이디"><p>
 	<input type="password" name="pwd" placeholder="비밀번호" ><p>
 	<span id="result" style="font-size:8px;"></span>
 	<input type="submit" value="로그인하기">
 </form>