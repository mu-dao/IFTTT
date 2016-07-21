<%@page import="com.sun.corba.se.impl.orbutil.closure.Constant"%>
<%@page import="com.entity.Message"%>
<%@page import="com.dao.UserDao"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String name="";
if(session.getAttribute("uname")!=null){
	name=session.getAttribute("uname").toString();
}

if(request.getParameter("deleteMsgId")!=null){
	UserDao.deleteMsg(request.getParameter("deleteMsgId"));
}

int cp=1, point=0, pageCount=0;
Vector<Message> allMessages= UserDao.getAllMsg(name);
if(request.getParameter("page")!=null)
	cp = Integer.parseInt(request.getParameter("page"));
point = (cp-1)*5;
pageCount = (int)Math.ceil((float)allMessages.size() / 5.0);
%>

<html>
<head>
<link href="CSS/mainPage.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MainPage</title>
<style>a{TEXT-DECORATION:none}</style>
<script>
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

function sendMessage(n){
	if(n==""){
		alert("Please login first！");
		//window.location.href="MainPage.jsp";
	}
	else{
		document.getElementById("div_msg").style.display="none";
		document.getElementById("div_mp_m2").style.display="block";
		document.getElementById("b_message").style.display="none";
	}
}

function CloseToM(){
	document.getElementById("tomember_msg").value="toAllMember";
	document.getElementById("tomember_msg").disabled=true;
}

function OpenToM(){
	document.getElementById("tomember_msg").value="toMember";
	document.getElementById("tomember_msg").removeAttribute("disabled");
}

function SendCheck(){
	if(document.myForm.tomember_msg.value=="toMember"){
		alert("Please enter the toMember!");
		return false;
	}
	else if(document.myForm.title_msg.value=="Title"){
		alert("Please enter the title!");
		return false;
	}
	else{
		return true;
	}
}

function mouseover() {
	event.srcElement.style.backgroundColor="rgba(160,160,130,0.2)";
}

function mouseout() {
	event.srcElement.style.background="transparent"; 
}

function DeleteMsg(id){
	if(window.confirm("Do you really want to delete this message?"))
		window.location.href="MainPage.jsp?deleteMsgId="+id;
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
	
	 
	<div id="div_mp_m1">
		<!--
		<form method="post" name="myForm" action="MsgServlet" onsubmit="return SendCheck()">
		<input type="button" id="b_message" value="Send a Message" onClick="sendMessage('<%=name %>')" style=float:left>
		<div id="div_mp_m2" style="display:none" >
			<div id="div_mp_m3">
			<div id="div_mp_sam">
			<b>Send a Message</b>
			</div>
			<br>
			<input type="radio" name="toall" value="true" onClick="CloseToM()" id="toall_msg" style="display:none">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="radio" name="toall" value="false" onClick="OpenToM()" checked id="toall_msg" style="display:none">&nbsp;&nbsp;<br>
			
			<input type="text" name="tomember" id="tomember_msg" value="Admin" readonly><br>
			<input type="text" name="title" id="title_msg" value="Title" style="color:grey"
			onfocus="if(this.value==defaultValue){this.value='';this.style.color='black';}" 
   	 		onblur="if(this.value==''){this.value=defaultValue;this.style.color='grey';}"><br>
   	 		<textarea name="content" style='height:150px;width:320px;resize: none;' id="content_msg"></textarea>
   	 		</div>
   	 		<div id="div_mp_m4">
   	 			<input type="submit" id="submit_msg" value="Send" class='btn'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" id="reset_msg" value="Reset" onClick="OpenToM()" class='btn'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" id="cancel_msg" onClick="location.href='MainPage.jsp'" value="Cancel" class='btn'>
			</div>
		</div>
		</form>
		 -->
		<!-- 消息查看 -->
		<div id="div_msg">
		<%if(name!=""){
			if(allMessages.size()==0){ %>
				<div id="div_msg2">
					No Message!
				</div>
			<%} if(allMessages.size()-point <= 5){ %>
			<div id="div_msg1">
				<%for(int i = point; i < allMessages.size(); i++){ %>
					<div style=float:left id="div_msg2" 
						onmouseover="mouseover()" onmouseout="mouseout()">
					Message&nbsp;No.<%=allMessages.size()-i %><br>
					Time of receipt:&nbsp;<%=((Message)allMessages.get(i)).getTime() %>&nbsp;&nbsp;&nbsp;&nbsp;
					From:&nbsp;<%=((Message)allMessages.get(i)).getFromMember() %>&nbsp;&nbsp;&nbsp;&nbsp;
					<%if(((Message)allMessages.get(i)).getIsAll()=="true"){ %><b>Common Message!</b><%} %><br>
					Title:&nbsp;<%=((Message)allMessages.get(i)).getTitle() %><br>
					<%=((Message)allMessages.get(i)).getContent() %>
					</div>
					<div id="div_del" style=float:left>
					<input type="button" id="bb_delete" value="Delete" onClick="DeleteMsg('<%=((Message)allMessages.get(i)).getId() %>')"
					<%=((Message)allMessages.get(i)).getIsAll()=="true"?"style='display:none'":"" %>>
					</div>
				<%} %>
			</div>
			<%}else{ %>
			<div id="div=msg1">
				<%for(int i = point; i < point+5; i++){ %>
					<div style=float:left id="div_msg2"
						onmouseover="mouseover()" onmouseout="mouseout()">
					Message&nbsp;No.<%=allMessages.size()-i %><br>
					Time of receipt:&nbsp;<%=((Message)allMessages.get(i)).getTime() %>&nbsp;&nbsp;&nbsp;&nbsp;
					From:&nbsp;<%=((Message)allMessages.get(i)).getFromMember() %>&nbsp;&nbsp;&nbsp;&nbsp;
					<%if(((Message)allMessages.get(i)).getIsAll()=="true"){ %><b>Common Message!</b><%} %><br>
					Title:&nbsp;<%=((Message)allMessages.get(i)).getTitle() %><br>
					<%=((Message)allMessages.get(i)).getContent() %>
					</div>
					<div id="div_del" style=float:left>
					<input type="button" id="bb_delete" value="Delete" onClick="DeleteMsg('<%=((Message)allMessages.get(i)).getId() %>')"
					<%=((Message)allMessages.get(i)).getIsAll()=="true"?"style='display:none'":"" %>>
					</div>
				<%} %>
			</div>
			<%} %>
		
			<!-- 翻页 -->
			<div id="div_msg3">
			Page:<%=cp %>/<%=pageCount %>&nbsp;&nbsp;
			<%if(cp>1){ %>
				<a href="MainPage.jsp?page=<%=cp-1 %>">&lt;&lt;Previous page&nbsp;&nbsp;</a>
			<%}else{ %>
				&lt;&lt;Previous page&nbsp;&nbsp;
			<%} %>
			<%if(cp<pageCount){ %>
				<a href="MainPage.jsp?page=<%=cp+1 %>">Next page&gt;&gt;</a>
			<%}else{ %>
				Next page&gt;&gt;
			<%} %>
			</div>
		<%} %>
		</div>	
	</div>
</body>
</html>