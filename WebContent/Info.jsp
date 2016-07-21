<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="com.dao.*" import="com.entity.*" %>
<%
String name="";
if(session.getAttribute("uname")!=null){
	name=session.getAttribute("uname").toString();
}
User user = UserDao.getInfo(name);
String hsex = user.getSex();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script> 
function MClick(){ 
	if(document.infoForm.modify.value=="Modify"){
		document.infoForm.sex_info1.removeAttribute("disabled");
		document.infoForm.sex_info2.removeAttribute("disabled");
		document.infoForm.year_info.removeAttribute("readonly");
		document.infoForm.month_info.removeAttribute("readonly");
		document.infoForm.day_info.removeAttribute("readonly");
		document.infoForm.email_info.removeAttribute("readonly");
		document.infoForm.phone_info.removeAttribute("readonly");
		
		document.infoForm.uname_info.style.border="1px solid red";
		document.infoForm.money_info.style.border="1px solid red";
		document.infoForm.point_info.style.border="1px solid red";
		document.infoForm.level_info.style.border="1px solid red";
		
		document.infoForm.resetpass.style.visibility="hidden";
		
		document.infoForm.recharge.value="Cancel";
		document.infoForm.modify.value="Save";
		return false;
	}
	else{
		if(document.infoForm.email_info.value == ""){
			alert("E-mail is empty！");
			return false;
		}
		else{
			document.infoForm.year_info.readonly=true;
			document.infoForm.month_info.readonly=true;
			document.infoForm.day_info.readonly=true;
			document.infoForm.email_info.readonly=true;
			document.infoForm.phone_info.readonly=true;
			document.infoForm.modify.value="Modify";
			infoForm.submit();
			document.infoForm.sex_info1.disabled=true;
			document.infoForm.sex_info2.disabled=true;
		}
	}
} 

function RechargeClick(){
	if(document.infoForm.recharge.value=="Recharge"){
		document.infoForm.plus.style.visibility="visible";
		document.infoForm.recharge_info.style.visibility="visible";
		document.infoForm.confirm.style.visibility="visible";
		document.infoForm.cancel.style.visibility="visible";
	
		document.infoForm.modify.style.visibility="hidden";
		document.infoForm.resetpass.style.visibility="hidden";
		document.infoForm.recharge.style.visibility="hidden";
	}
	else{
		window.location.href="Info.jsp";
	}
}

function ConfirmClick(){
	if(document.infoForm.recharge_info.value=="")
		alert("Please enter the recharge number！");
	else if(isNaN(document.infoForm.recharge_info.value))
		alert("Please enter the legal recharge number！");
	else
		infoForm.submit();
}

function CancelClick(){
	document.infoForm.plus.style.visibility="hidden";
	document.infoForm.recharge_info.style.visibility="hidden";
	document.infoForm.confirm.style.visibility="hidden";
	document.infoForm.cancel.style.visibility="hidden";
	
	document.infoForm.modify.style.visibility="visible";
	document.infoForm.resetpass.style.visibility="visible";
	document.infoForm.recharge.style.visibility="visible";
}

function checkInfo(n){
	if(n==""){
		alert("Please login first！");
		//window.location.href="login.jsp";
	}
	else{
		window.location.href="Info.jsp";
	}
}

function checkTask(n){
	if(n==""){
		alert("Please login first！");
		//window.location.href="login.jsp";
	}
	else{
		window.location.href="task2.jsp";
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
<link href="CSS/mainPage.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Info</title>
<style>a{TEXT-DECORATION:none}</style>
</head>
<body style="background-image:url(images/bg3.jpg)">
<form method="post" name="infoForm" action="ModifyInfoServlet">
	<div id="div_mp1">
		<div style=float:left id="div_mp2">
			<p class="s1"><b>if</b>
			<a href="javascript:checkThis('<%=name %>');"><b>this</b></a>
			<b>then</b>
			<b>that</b></p>
		</div>
		<div id="div_lr">
			<div id="div_lr2">
			<%if(name!=""){ %>
				<p id="pname">Welcome&nbsp;&nbsp;<%=name %></p>
			<%}else{ %>
				<input type="button" id="b_login" value="Login" onClick="window.location.href='login.jsp';">&nbsp;&nbsp;
				<input type="button" id="b_register" value="Register" onClick="window.location.href='register.jsp';">
			<%} %>
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
	</div>
	
	<div id="div_info1">
		<div id="div_info_p"><p>Personal Information</p></div>
		<div id="div_info2" style=float:left>
			<p>Username:</p>
			<p>Sex:</p>
			<p>Birthday:</p>
			<p>Email:</p>
			<p>Phone:</p>
			<p>Money:</p>
			<p>MPoints:</p>
			<p>Level:</p>
		</div>
		<div id="div_info3" style=float:left>
			<input type="text" name="name" id="uname_info" readonly value=<%=user.getName()%> ><br>
			<input type="radio" name="sex" value="M" <%= hsex.equals("M")?"checked":"" %> id="sex_info1" disabled>&nbsp;&nbsp;Male&nbsp;&nbsp;
			<input type="radio" name="sex" value="F" <%= hsex.equals("F")?"checked":"" %> id="sex_info2" disabled>&nbsp;&nbsp;Female<br>
			<input type="text" name="year" id="year_info" readonly value=<%=user.getYear() %>>&nbsp;--
			<input type="text" name="month" id="month_info" readonly value=<%=user.getMonth() %>>&nbsp;--
			<input type="text" name="day" id="day_info" readonly value=<%=user.getDay() %>><br>
			<input type="text" name="email" id="email_info" readonly value=<%=user.getEmail() %>><br>
			<input type="text" name="phone" id="phone_info" readonly value=<%=user.getPhone() %>><br>
			<input type="text" name="money" id="money_info" readonly value=<%=user.getMoney() %>>
			
			<input type="text" id="plus" value="+" readonly style="visibility:hidden">&nbsp;
			<input type="text" name="rechargeMoney" id="recharge_info" style="visibility:hidden">
			<br>
			
			<input type="text" name="point" id="point_info" readonly value=<%=user.getPoint() %>>
			<input type="button" id="confirm" value="Confirm" onClick="ConfirmClick()" style="visibility:hidden" class='btn'>
			<input type="button" id="cancel" value="Cancel" onClick="CancelClick()" style="visibility:hidden" class='btn'>
			<br>
			<input type="text" name="level" id="level_info" readonly value=<%=user.getLevel() %>><br>
		</div>
		<div id="div_info4">
			<input type="button" id="modify" value="Modify" onClick="MClick()" class='btn'> 
			<input type="button" id="resetpass" value="ResetPassword" onClick="window.location.href='resetPassword.jsp';" class='btn'>
			<input type="button" id="recharge" value="Recharge" onClick="RechargeClick()" class='btn'> 
		</div>
	</div>
	</form>
</body>
</html>