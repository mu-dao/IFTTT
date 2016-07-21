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

if(request.getParameter("deleteUserName")!=null){
	UserDao.deleteUser(request.getParameter("deleteUserName"));
}
		
int cp=1, point=0, pageCount=0;
Vector<User> allUsers= UserDao.getAllUser();
if(request.getParameter("page")!=null)
	cp = Integer.parseInt(request.getParameter("page"));
point = (cp-1)*20;
pageCount = (int)Math.ceil((float)allUsers.size() / 20.0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="CSS/management.css" rel="stylesheet" type="text/css">
<style>a{TEXT-DECORATION:none}</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Members Management</title>
<script>
function mouseover() {
	if(event.srcElement.tagName=="TD")
		event.srcElement.parentElement.style.backgroundColor="rgba(160,160,130,0.6)";
	else{
		event.srcElement.parentElement.parentElement.style.backgroundColor="rgba(160,160,130,0.6)";
	}
}

function mouseout() {
	if(event.srcElement.tagName=="TD")
		event.srcElement.parentElement.style.background="transparent"; 
	else{
		event.srcElement.parentElement.parentElement.style.background="transparent"; 
	}
}

function DeleteUser(username){
	if(window.confirm("Do you really want to delete this user?"))
		window.location.href="ManageMembers.jsp?deleteUserName="+username;
}

function showInfo(username){
	window.location.href="ManageMembersInfo.jsp?InfoUserName="+username;
}

function checkThis(n){
    if(n==""){
    	alert("Please login first！");
    	return false;
    }
    else
    	window.location.href="creatTaskAdmin.jsp";
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
				<input type="button" id="b_info" value="Members" onClick="window.location.href='ManageMembers.jsp';">
			</div>
			<div style=float:left id="div_mp5">
				<input type="button" id="b_quit" value="Quit" onClick="window.location.href='quit.jsp';">
			</div>
		</div>
	</div>
	
	<!-- 用户信息 -->
	<div id="div_mb">
		<div id="div_mb2">
		<table id="table1" >
			<tr id="tr1">
			<td style="width:50px">&nbsp;&nbsp;No.</td>
			<td style="width:110px">UserName</td>
			<td style="width:160px">E-mail</td>
			<td style="width:100px">Money</td>
			<td style="width:80px">Points</td>
			<td style="width:80px">Level</td>
			<td style="width:80px">Operation</td>
			</tr> 
			<%if(name!=""){
				if(allUsers.size()-point <= 20){
					for(int i = point; i < allUsers.size(); i++){ %>
						<tr onmouseover="mouseover()" onmouseout="mouseout()">
						<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')">&nbsp;&nbsp;<%=i+1 %></td>
						<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')"><%=((User)allUsers.get(i)).getName() %></td>
						<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')"><%=((User)allUsers.get(i)).getEmail() %></td>
						<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')"><%=((User)allUsers.get(i)).getMoney() %></td>
						<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')"><%=((User)allUsers.get(i)).getPoint() %></td>
						<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')"><%=((User)allUsers.get(i)).getLevel() %></td>
						<td><input type="button" id="b_delete" value="Delete" onClick="DeleteUser('<%=((User)allUsers.get(i)).getName() %>')"></td>
						</tr>
				<%}}else{
					for(int i = point; i < point+20; i++){%>
					<tr onmouseover="mouseover()" onmouseout="mouseout()">
					<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')">&nbsp;&nbsp;<%=i+1 %></td>
					<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')"><%=((User)allUsers.get(i)).getName() %></td>
					<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')"><%=((User)allUsers.get(i)).getEmail() %></td>
					<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')"><%=((User)allUsers.get(i)).getMoney() %></td>
					<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')"><%=((User)allUsers.get(i)).getPoint() %></td>
					<td onclick="showInfo('<%=((User)allUsers.get(i)).getName() %>')"><%=((User)allUsers.get(i)).getLevel() %></td>
					<td><input type="button" id="b_delete" value="Delete" onClick="DeleteUser('<%=((User)allUsers.get(i)).getName() %>')"></td>
					</tr>
				<%}} %>
		</table>
		</div>

		<!-- 翻页 -->
		<div id="div_mb3">
			Page:<%=cp %>/<%=pageCount %>&nbsp;&nbsp;
			<%if(cp>1){ %>
				<a href="ManageMembers.jsp?page=<%=cp-1 %>">&lt;&lt;Previous page&nbsp;&nbsp;</a>
			<%}else{ %>
				&lt;&lt;Previous page&nbsp;&nbsp;
			<%} %>
			<%if(cp<pageCount){ %>
				<a href="ManageMembers.jsp?page=<%=cp+1 %>">Next page&gt;&gt;</a>
			<%}else{ %>
				Next page&gt;&gt;
			<%} %>
		</div>
		<%} %>
	</div>
</body>
</html>