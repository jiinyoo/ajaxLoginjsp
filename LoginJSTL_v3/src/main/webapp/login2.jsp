<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 이 부분 바로 넘어가 버리는 것 해결 필요 -->
<script>

function idpwdcheck(){
		var userid=document.login.userid.value;
		var pwd=document.login.pwd.value;
		
	    var chk=new XMLHttpRequest();
		chk.open("get","loginCheck.jsp?userid="+userid+"&pwd="+pwd);
		chk.send();
		chk.onload=function()
		{
			
			var cnt=chk.responseText.trim();
			if(cnt==1){
				return true;
			}else{
				document.getElementById("result").innerText="해당하는 계정 정보가 없습니다.";
				return false;
				
			}	
		}
	
}
    
</script>       


<h2>로그인</h2>
    
 <form name="login" method="post" action="loginOk.jsp" onsubmit="return idpwdcheck()">
 	<input type="text" name="userid" placeholder="아이디"><p>
 	<input type="password" name="pwd" placeholder="비밀번호" ><p>
 	<span id="result" style="font-size:8px;"></span>
 	<input type="submit" value="로그인하기">
 </form>