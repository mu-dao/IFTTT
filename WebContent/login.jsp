<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String msg=(String)request.getAttribute("error1");	
if(msg!=null){
%>
<script type="text/javascript">
alert("<%=msg%>");
</script>
<%}%>
<%
String msg2=(String)request.getAttribute("error2");	
if(msg2!=null){
%>
<script type="text/javascript">
alert("<%=msg2%>");
</script>
<%}%>
<html>
<head>
<title>Login</title>
<link href="CSS/firstPage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function login(){
	if(document.myForm.uname.value == "" || (document.myForm.uname.value == "Username" && document.myForm.uname.style.color == "grey")){
		alert("Username is empty!");
		return false;
	}
	else if(document.myForm.upass.value == "" || (document.myForm.upass.value == "Password" && document.myForm.upass.style.color == "grey")){
		alert("Password is empty!");
		return false;
	}
	else{
		return true;
	}
}
</script>
</head>
<jsp:useBean id="TaskControl" scope="session" class="function.TaskControl"/>
<jsp:setProperty property="*" name="TaskControl"/>
<body style="background-image:url(images/bg3.jpg)">
	<form method="post" name="myForm" action="LoginServlet" onsubmit="return login()">
	<div id="div_login1">
		<p class="s2"><b>Welcome to IFTTT</b>
		<div id="div_login2">
			<input type="text" name="uname" id="uname_login" value="Username" style="color:grey; text-align:center"
			onfocus="if(this.value==defaultValue) {this.value=''; this.style.color='white';}" 
   	 		onblur="if(this.value==''){this.value=defaultValue; this.style.color='grey';}"><br><br>
			<input type="text" name="upass" id="upass_login" value="Password" style="color:grey; text-align:center"
			onfocus="if(this.value==defaultValue) {this.value=''; this.type='password'; this.style.color='white';}"
   	 		onblur="if(!this.value) {this.value=defaultValue; this.type='text'; this.style.color='grey';}">
   	 	 	<p><font color=red>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${requestScope.error1}${requestScope.error2}</font></p>
   	    </div>
   	    <div id="div_login3">
   	 	 		<input type="submit" id="submit1" value="Login" class='btn'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" id="reset1" value="Reset" class='btn'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" id="back1" onClick="location.href='index.jsp'" value="Back" class='btn'>
		</div>
	</div>
</form>
</body>
</html>