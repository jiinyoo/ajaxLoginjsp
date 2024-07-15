<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




<h2>인덱스 페이지 입니다.</h2>

<c:if test="${userid==null}">
<a href="member.jsp">회원 가입</a> |<a href="login.jsp"> 로그인 </a><p>
</c:if>

<c:if test="${userid!=null}">
 <a href="memberView.jsp">${name}님</a>   | <a href="logout.jsp">로그 아웃</a> 
</c:if>
    
    
    