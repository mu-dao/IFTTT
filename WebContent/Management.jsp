<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.entity.Message"%>
<%@page import="com.dao.UserDao"%>
<%@page import="java.util.Vector"%>
<%
String name="";
if(session.getAttribute("uname")!=null){
	name=session.getAttribute("uname").toString();
}

if(request.getParameter("deleteMsgId")!=null){
	UserDao.deleteMsg(request.getParameter("deleteMsgId"));
}

int cp=1, point=0, pageCount=0;
Vector<Message> allMessages= UserDao.getAllMsgSend(name);
if(request.getParameter("page")!=null)
	cp = Integer.parseInt(request.getParameter("page"));
point = (cp-1)*5;
pageCount = (int)Math.ceil((float)allMessages.size() / 5.0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="CSS/mainPage.css" rel="stylesheet" type="text/css">
<style>a{TEXT-DECORATION:none}</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Management</title>
<script>
function sendMessage(n){
	if(n==""){
		alert("Please login first！");
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

function Modify(toname, isall, title, content, id){
	sendMessage('<%=name%>');
	if(isall=="true"){
		document.myForm.toall_msg[0].checked="checked";
		document.myForm.tomember_msg.value="toAllMembers";
	}
	else{
		document.myForm.tomember_msg.value=toname;
	}
	document.myForm.tomember_msg.style.color='black'
	document.myForm.title_msg.value=title;
	document.myForm.title_msg.style.color='black'
	document.myForm.content_msg.value=content;
	document.myForm.id_msg.value=id;
}

function mouseover() {
	event.srcElement.style.backgroundColor="rgba(160,160,130,0.2)";
}

function mouseout() {
	event.srcElement.style.background="transparent"; 
}

function checkThis(n){
    if(n==""){
    	alert("Please login first！");
    	return false;
    }
    else
    	window.location.href="creatTaskAdmin.jsp";
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
	
	
	<!-- 发送消息 -->
	<div id="div_mp_m1">
		<form method="post" name="myForm" action="MsgServlet" onsubmit="return SendCheck()">
		<input type="button" id="b_message" value="Send a Message" onClick="sendMessage('<%=name %>')" style=float:left>
		<div id="div_mp_m2" style="display:none" >
			<div id="div_mp_m3">
			<div id="div_mp_sam">
			<b>Send a Message</b>
			</div>
			<br>
			<input type="text" name="id" id="id_msg" value="-1" style="display:none">
			
			To All? &nbsp;&nbsp;
			<input type="radio" name="toall" value="true" onClick="CloseToM()" id="toall_msg">&nbsp;&nbsp;Y&nbsp;&nbsp;
			<input type="radio" name="toall" value="false" onClick="OpenToM()" checked id="toall_msg">&nbsp;&nbsp;N<br>
			
			<input type="text" name="tomember" id="tomember_msg" value="toMember"  style="color:grey"
			onfocus="if(this.value==defaultValue){this.value='';this.style.color='black';}" 
   	 		onblur="if(this.value==''){this.value=defaultValue;this.style.color='grey';}"><br>
			<input type="text" name="title" id="title_msg" value="Title" style="color:grey"
			onfocus="if(this.value==defaultValue){this.value='';this.style.color='black';}" 
   	 		onblur="if(this.value==''){this.value=defaultValue;this.style.color='grey';}"><br>
   	 		<textarea name="content" style='height:150px;width:320px;resize: none;' id="content_msg"></textarea>
   	 		</div>
   	 		<div id="div_mp_m4">
   	 			<input type="submit" id="submit_msg" value="Send" class='btn'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="reset" id="reset_msg" value="Reset" onClick="OpenToM()" class='btn'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" id="cancel_msg" onClick="location.href='Management.jsp'" value="Cancel" class='btn'>
			</div>
		</div>
		</form>
	
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
					<div id="div_msg2" style=float:left onclick="Modify('<%=((Message)allMessages.get(i)).getToMember() %>', '<%=((Message)allMessages.get(i)).getIsAll() %>', '<%=((Message)allMessages.get(i)).getTitle() %>', '<%=((Message)allMessages.get(i)).getContent() %>', '<%=((Message)allMessages.get(i)).getId() %>')"
						onmouseover="mouseover()" onmouseout="mouseout()">
					Message&nbsp;No.<%=allMessages.size()-i %><br>
					Time of receipt:&nbsp;<%=((Message)allMessages.get(i)).getTime() %>&nbsp;&nbsp;&nbsp;&nbsp;
					To:&nbsp;<%=((Message)allMessages.get(i)).getToMember() %>&nbsp;&nbsp;&nbsp;&nbsp;
					<%if(((Message)allMessages.get(i)).getIsAll()=="true"){ %><b>Common Message!</b><%} %><br>
					Title:&nbsp;<%=((Message)allMessages.get(i)).getTitle() %><br>
					<%=((Message)allMessages.get(i)).getContent() %>
					</div>
					<div style=float:left id="div_del">
					<input type="button" id="bb_delete" value="Delete" onClick="DeleteMsg('<%=((Message)allMessages.get(i)).getId() %>')">
					</div>
				<%} %>
			</div>
			<%}else{ %>
			<div id="div=msg1">
				<%for(int i = point; i < point+5; i++){ %>
					<div id="div_msg2" style=float:left 
						onclick="Modify('<%=((Message)allMessages.get(i)).getToMember() %>', '<%=((Message)allMessages.get(i)).getIsAll() %>', '<%=((Message)allMessages.get(i)).getTitle() %>', '<%=((Message)allMessages.get(i)).getContent() %>', '<%=((Message)allMessages.get(i)).getId() %>')"
						onmouseover="mouseover()" onmouseout="mouseout()">
					Message&nbsp;No.<%=allMessages.size()-i %><br>
					Time of receipt:&nbsp;<%=((Message)allMessages.get(i)).getTime() %>&nbsp;&nbsp;&nbsp;&nbsp;
					To:&nbsp;<%=((Message)allMessages.get(i)).getToMember() %>&nbsp;&nbsp;&nbsp;&nbsp;
					<%if(((Message)allMessages.get(i)).getIsAll()=="true"){ %><b>Common Message!</b><%} %><br>
					Title:&nbsp;<%=((Message)allMessages.get(i)).getTitle() %><br>
					<%=((Message)allMessages.get(i)).getContent() %>
					</div>
					<div style=float:left id="div_del">
					<input type="button" id="bb_delete" value="Delete" onClick="DeleteMsg('<%=((Message)allMessages.get(i)).getId() %>')">
					</div>
				<%} %>
			</div>
			<%} %>
		
			<!-- 翻页 -->
			<div id="div_msg3">
			Page:<%=cp %>/<%=pageCount %>&nbsp;&nbsp;
			<%if(cp>1){ %>
				<a href="Management.jsp?page=<%=cp-1 %>">&lt;&lt;Previous page&nbsp;&nbsp;</a>
			<%}else{ %>
				&lt;&lt;Previous page&nbsp;&nbsp;
			<%} %>
			<%if(cp<pageCount){ %>
				<a href="Management.jsp?page=<%=cp+1 %>">Next page&gt;&gt;</a>
			<%}else{ %>
				Next page&gt;&gt;
			<%} %>
			</div>
		<%} %>
		</div>
	</div>
</body>
</html>