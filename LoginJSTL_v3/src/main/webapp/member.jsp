<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>

var validChk=0;
 function UCheck()
{
	var userid=document.member.userid.value;
	

	
	if(userid.length>=4)
	{
		
		var chk=new XMLHttpRequest();
		chk.open("get","useridCheck.jsp?userid="+userid);
		chk.send();
		chk.onload=function()
		{
			
			var cnt=chk.responseText.trim();
			if(cnt==1){
				alert("아이디가 이미 존재합니다.");
				validChk=0;
			}else{
				alert("사용할 수 있는 아이디입니다.");
				validChk=1;
			}	
		}
		 document.getElementById("idmsg").innerText="";
	}else{
		
		document.getElementById("idmsg").innerText="아이디는 4자 이상입니다."
		document.getElementById("idmsg").style.color="red";
		validChk=0
		
		
	}
} 
 
 
 
function Echeck()
{
	var email=document.member.email.value;
	var chk=new XMLHttpRequest();
	chk.open("get","emailCheck.jsp?email="+email);
	chk.send();
	chk.onload=function()
	{
		var emailtext=chk.responseText.trim();
		if(emailtext==1)
		{
			alert("같은 이메일 주소가 이미 있습니다.");
			validChk=1;
		}else{
			validChk=0;
		}
		
	}
	
	
	
	
	
}
 
 
 

 
 
function pwdlen()
{
	var plen=document.member.pwd1.value.length;
	if(plen<8){
		document.getElementById("pwd1").innerText="비밀번호는 8자 이상입니다.";
		document.getElementById("pwd1").style.color="red";
		validChk=0;
	}else{
		document.getElementById("pwd1").innerText="";
		validChk=1;
	}
	
	
}
 
 
 

function pwdEqual()
{
	var pwd1=document.member.pwd1.value;
	var pwd2=document.member.pwd2.value;
	
	
	if(pwd2 !=""){
		
	if(pwd1==pwd2){
		document.getElementById("pwd2").innerText="";
		validChk=1;
		
	}else{
		document.getElementById("pwd2").innerText="비밀번호 확인이 일치하지 않습니다."
		document.getElementById("pwd2").style.color="red";
		validChk=0;
	}
	
	}

}



function phoneval()
{
	
	var phonelen=document.member.phone.value.length;
	if(phonelen!=11){
		document.getElementById("phone").innerText="11자리 숫자만 입력하세요";
		validChk=0;
		
	}else{
		document.getElementById("phone").innerText="";
		validChk=1;
	}
	
}




function send()
{
	if(validChk==0){
		return false;
	}else{
		
		return true;
	}	
	
}

 </script>

<form name="member" method="post" action="memberOk.jsp" onsubmit="return send()">
	<h2>회원 가입</h2>
	<input type="text" name="userid" placeholder="아이디" onblur="UCheck()" required>
	<span id="idmsg" style="font-size:8px;"></span><p>
	<!-- id도 check -->
	<input type="text" name="name" placeholder="이름" required ><p>
	<input type="password" name="pwd1"	placeholder="비밀번호"  minlength="8" maxlength="16" onkeyup="pwdEqual(); pwdlen();" required >
	<span id="pwd1" style="font-size:8px;"></span>
	<p>
	<input type="password" name="pwd2"	placeholder="비밀번호 검토" onkeyup="pwdEqual()" minlength="8" maxlength="16" required>
	<span id="pwd2" style="font-size:8px;"></span><p>
	<input type="email" name="email" placeholder="이메일" onblur="Echeck()"><p>
	<input type="text" name="phone" placeholder="전화번호"  onkeyup="phoneval()" minlength="11" maxlength="11">
	<span id="phone" style="font-size:8px; color:blue;"></span><p>
	<input type="submit" value="회원가입">
</form>