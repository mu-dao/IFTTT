<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.entity.User"%>
<%@page import="com.dao.UserDao"%>
<%@page import="java.util.Vector"%>
<%
String name="";
if(session.getAttribute("uname")!=null){
	name=session.getAttribute("uname").toString();
}

if(request.getParameter("Level")!=null && request.getParameter("InfoUserName")!=null){
	UserDao.updateLevel(request.getParameter("InfoUserName"), request.getParameter("Level"));
}

User user=null;
if(request.getParameter("InfoUserName")!=null){
	user=UserDao.getInfo(request.getParameter("InfoUserName"));
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
function DeleteUser(username){
	if(window.confirm("Do you really want to delete this user?"))
		window.location.href="ManageMembers.jsp?deleteUserName="+username;
}

function SetLevel(username){
	if(document.getElementById("setLevel").value=="Set Level"){
		document.getElementById("back").value="Cancel";
		document.getElementById("setLevel").value="Save";
		document.getElementById("delete").style.visibility="hidden";
		document.getElementById("level_info").removeAttribute("readonly");
		document.getElementById("level_info").style.backgroundColor="rgba(100,0,0,0.1)";
		document.getElementById("level_info").value="";
	}
	else{
		if(isNaN(document.getElementById("level_info").value))
			alert("Please enter legal level!");
		else
			window.location.href="ManageMembersInfo.jsp?InfoUserName="+username+"&Level="+document.getElementById("level_info").value;
	}
}

function Back(username){
	if(document.getElementById("back").value=="Back")
		window.location.href='ManageMembers.jsp';
	else
		window.location.href="ManageMembersInfo.jsp?InfoUserName="+username;
}
</script>
<link href="CSS/management.css" rel="stylesheet" type="text/css">
<style>a{TEXT-DECORATION:none}</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Info</title>
</head>
<body style="background-image:url(images/bg3.jpg)">
	<div id="div_mp1">
		<div style=float:left id="div_mp2">
			<p class="s1"><b>if</b>
			<a href="Management.jsp"><b>this</b></a>
			<b>then</b>
			<b>that</b></p>
		</div>
		<div id="div_lr">
			<div id="div_lr2">
				<p id="pname">Welcome&nbsp;&nbsp;<%=name %></p>
			</div>
			<div style=float:left id="div_mp6">
				<input type="button" id="b_home" value="Home" onClick="window.location.href='Management.jsp';">
			</div>
			<div style=float:left id="div_mp3">
				<input type="button" id="b_task" value="Tasks" onClick="window.location.href='taskAdmin.jsp';">
			</div>
			<div style=float:left id="div_mp4">
				<input type="button" id="b_info" value="Members" onClick="window.location.href='Management.jsp';">
			</div>
			<div style=float:left id="div_mp5">
				<input type="button" id="b_quit" value="Quit" onClick="window.location.href='quit.jsp';">
			</div>
		</div>
	</div>
	
	<div id="div_mi">
		<div id="div_info_p"><p>Personal Information</p></div>
		<div id="div_mi2" style=float:left>
			<p>Username:</p>
			<p>Sex:</p>
			<p>Birthday:</p>
			<p>Email:</p>
			<p>Phone:</p>
			<p>Money:</p>
			<p>MPoints:</p>
			<p>Level:</p>
		</div>
		<div id="div_mi3" style=float:left>
			<input type="text" name="name" id="uname_info" readonly value=<%=user.getName()%> ><br>
			<input type="radio" name="sex" value="M" <%= user.getSex().equals("M")?"checked":"" %> id="sex_info1" disabled>&nbsp;&nbsp;Male&nbsp;&nbsp;
			<input type="radio" name="sex" value="F" <%= user.getSex().equals("F")?"checked":"" %> id="sex_info2" disabled>&nbsp;&nbsp;Female<br>
			<input type="text" name="year" id="year_info" readonly value=<%=user.getYear() %>>&nbsp;--
			<input type="text" name="month" id="month_info" readonly value=<%=user.getMonth() %>>&nbsp;--
			<input type="text" name="day" id="day_info" readonly value=<%=user.getDay() %>><br>
			<input type="text" name="email" id="email_info" readonly value=<%=user.getEmail() %>><br>
			<input type="text" name="phone" id="phone_info" readonly value=<%=user.getPhone() %>><br>
			<input type="text" name="money" id="money_info" readonly value=<%=user.getMoney() %>><br>
			<input type="text" name="point" id="point_info" readonly value=<%=user.getPoint() %>><br>
			<input type="text" name="level" id="level_info" readonly value=<%=user.getLevel() %>><br>
		</div>
		<div id="div_mi4">
			<input type="button" id="setLevel" value="Set Level" onClick="SetLevel('<%=user.getName() %>')" class='btn'> 
			<input type="button" id="delete" value="Delete" onClick="DeleteUser('<%=user.getName() %>')" class='btn'>
			<input type="button" id="back" value="Back" onClick="Back('<%=user.getName() %>')" class='btn'> 
		</div>
	</div>

</body>
</html>