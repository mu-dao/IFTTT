<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.dao.*" import="com.entity.*" %>
<%
String name="";
if(session.getAttribute("uname")!=null){
	name=session.getAttribute("uname").toString();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="CSS/mainPage.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reset Password</title>
<style>a{TEXT-DECORATION:none}</style>
<script>
//输入新密码后需要再次输入新密码，如果两次不一样，弹出警告
function check(){
	if(document.myForm.upass.value != document.myForm.upass2.value){
		alert("Two passwords are different！");
		return false;
	}
	else{
		return true;
	}
}

function checkInfo(n){
	if(n==""){
		alert("Please login first！");
		window.location.href="login.jsp";
	}
	else{
		window.location.href="Info.jsp";
	}
}

function checkTask(n){
	if(n==""){
		alert("Please login first！");
		window.location.href="login.jsp";
	}
	else{
		window.location.href="Info.jsp";
	}
}

function checkThis(n){
    if(n==""){
    	alert("Please login first！");
    	return false;
    }
    else
    	window.location.href="creatTask.jsp";
}
</script>
</head>
<body style="background-image:url(images/bg3.jpg)">
	<div id="div_mp1">
		<div style=float:left id="div_mp2">
			<p class="s1"><b>if</b>
			<a href="javascript:checkThis('<%=name %>');"><b>this</b></a>
			<b>then</b>
			<b>that</b></p>
		</div>		
		<div style=float:left id="div_mp6">
			<input type="button" id="b_home" value="Home" onClick="window.location.href='MainPage.jsp';">
		</div>	
		<div style=float:left id="div_mp3">
			<input type="button" id="b_task" value="Task" onClick="checkTask('<%=name %>')">
		</div>
		<div style=float:left id="div_mp4">
			<input type="button" id="b_info" value="Info" onClick="checkInfo('<%=name %>')">
		</div>
		<div style=float:left id="div_mp5">
			<input type="button" id="b_quit" value="Quit" onClick="window.location.href='quit.jsp';">
		</div>
	</div>
	<form method="post" name="myForm" action="ResetPasswordServlet" onsubmit="return check()">
	<div id="div_info1">
		<div id="div_info_rp"><p>Reset Password</p></div>
		<div id="div_rp1">
			<input type="text" name="uname" id="uname_rp" readonly value=<%=name %>>
			<input type="text" name="upass" id="upass_rp" value="Password"
			onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
   	 	 	onblur="if(!this.value) {this.value=defaultValue; this.type='text';}">
   	 	 	<font color=red>*</font>
   	 	 	<input type="text" name="upass2" id="upass2_rp" value="Repeat Password"
			onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
   	 	 	onblur="if(!this.value) {this.value=defaultValue; this.type='text';}">
			<font color=red>*</font>
		</div>
		<div id="div_rp2">
			<input type="submit" id="confirm_rp" value="Confirm" class='btn'> 
			<input type="button" id="cancel_rp" value="Cancel" onClick="window.location.href='Info.jsp';" class='btn'>
		</div>
	</div>
	</form>	
</body>
</html>