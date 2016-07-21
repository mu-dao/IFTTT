<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String msg=(String)request.getAttribute("error1");	
if(msg!=null){
%>
<script type="text/javascript">
alert("<%=msg%>");
</script>
<%}%>
<head>
<link href="CSS/firstPage.css" rel="stylesheet" type="text/css">
<title>Register</title>
<script type="text/javascript">
function regCheck(){
	if(document.myForm.uname.value == "" || document.myForm.uname.value == "Username"){
		alert("UserName is empty！");
		return false;
	}
	else if( document.myForm.upass.value == "" || document.myForm.upass.value == "Password"){
		alert("Password is empty！");
		return false;
	}
	else if(document.myForm.upass2.value == "" || document.myForm.upass2.value == "Repeat Password"){
		alert("Password is empty！");
		return false;
	}
	else if(document.myForm.upass.value != document.myForm.upass2.value){
		alert("Two passwords are different！");
		return false;
	}
	else if(document.myForm.email.value == "" || document.myForm.email.value == "E-mail"){
		alert("E-mail is empty！");
		return false;
	}
	else{
		return true;
	}
}
</script>
</head>
<body style="background-image:url(images/bg3.jpg)">
	<form method="post" name="myForm" action="RegisterServlet" onsubmit="return regCheck()">
	<div id="div_reg1">
		<p class="s3"><b>Welcome to IFTTT</b>
		<div id="div_reg2">
			<input type="text" name="uname" id="uname_reg" value="Username" style="text-align:center"
			onfocus="if(this.value==defaultValue){this.value='';}" 
   	 		onblur="if(this.value==''){this.value=defaultValue;}">
   	 		<font color=red>*</font><font color=red>&nbsp;${requestScope.error1}</font><br><br>
			<input type="text" name="upass" id="upass_reg" value="Password" style="text-align:center"
			onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
   	 	 	onblur="if(!this.value) {this.value=defaultValue; this.type='text';}">
   	 	 	<font color=red>*</font><br><br>
   	 	 	<input type="text" name="upass2" id="upass2_reg" value="Repeat Password" style="text-align:center"
			onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
   	 	 	onblur="if(!this.value) {this.value=defaultValue; this.type='text';}">
   	 	 	<font color=red>*</font><br><br>
   	 	 	<input type="text" name="year" id="year_reg" value="YYYY" style="text-align:center"
			onfocus="if(this.value==defaultValue){this.value='';}" 
   	 		onblur="if(this.value==''){this.value=defaultValue;}">&nbsp;--
   	 		<input type="text" name="month" id="month_reg" value="MM" style="text-align:center"
			onfocus="if(this.value==defaultValue){this.value='';}" 
   	 		onblur="if(this.value==''){this.value=defaultValue;}">&nbsp;--
   	 		<input type="text" name="day" id="day_reg" value="DD" style="text-align:center"
			onfocus="if(this.value==defaultValue){this.value='';}" 
   	 		onblur="if(this.value==''){this.value=defaultValue;}">
   	 		<br><br>&nbsp;&nbsp;&nbsp;&nbsp;
   	 	 	<input type="radio" name="sex" value="M" id="sex_reg">&nbsp;&nbsp;Male&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="sex" value="F" id="sex_reg">&nbsp;&nbsp;Female
   	 	 	<br><br>
   	 	 	<input type="text" name="email" id="email_reg" value="E-mail" style="text-align:center"
			onfocus="if(this.value==defaultValue){this.value='';}" 
   	 		onblur="if(this.value==''){this.value=defaultValue;}">
   	 		<font color=red>*</font><br><br>
   	 	 	<input type="text" name="phone" id="phone_reg" value="Phone" style="text-align:center"
			onfocus="if(this.value==defaultValue){this.value='';}" 
   	 		onblur="if(this.value==''){this.value=defaultValue;}">
   	 	 </div>
   	 	 	<div id="div_reg3">
   	 	 		<input type="submit" id="submit2" value="Register" class='btn'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" id="reset2" value="Reset" class='btn'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" id="back2" onClick="location.href='index.jsp'" value="Back" class='btn'>
		</div>
	</div>
	</form>
</body>
</html>
















