<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"%>
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
<link href="CSS/createTask.css" rel="stylesheet" type="text/css">
<style>a{TEXT-DECORATION:none}</style>
<script type="text/javascript">
function ThisChoose(){
	if(document.getElementById("sel_this").value=="Time"){
		clickTime();
	}
	if(document.getElementById("sel_this").value=="Weibo"){
		clickWeibo();
	}
	if(document.getElementById("sel_this").value=="163mail"){
		clickGmail();
	}
	if(document.getElementById("sel_this").value=="Monitor"){
		clickWaitWeibo();
	}
}

function ThatChoose(){
	if(document.getElementById("sel_that").value=="Weibo"){
		clickWeibo2();
	}
	if(document.getElementById("sel_that").value=="163mail"){
		clickGmail2();
	}
}

function clickTime(){
	document.getElementById("n4").style.display="inline";
	document.getElementById("n5").style.display="none";
	document.getElementById("n6").style.display="none";
	document.getElementById("nn7").style.display="none";
}

function clickWeibo(){
	document.getElementById("n5").style.display="inline";
	document.getElementById("n4").style.display="none";
	document.getElementById("n6").style.display="none";
	document.getElementById("nn7").style.display="none";
}

function clickGmail(){
	document.getElementById("n6").style.display="inline";
	document.getElementById("n4").style.display="none";
	document.getElementById("n5").style.display="none";
	document.getElementById("nn7").style.display="none";
}

function clickWaitWeibo(){
	document.getElementById("nn7").style.display="inline";
	document.getElementById("n5").style.display="inline";
	document.getElementById("text4").style.display="none";  //把微博监听内容输入删除
	document.getElementById("n6").style.display="none";
	document.getElementById("n4").style.display="none";
}

function clickWeibo2(){
	document.getElementById("n9").style.display="inline";
	document.getElementById("n10").style.display="none";
}

function clickGmail2(){
	document.getElementById("n10").style.display="inline";
	document.getElementById("n9").style.display="none";
}


function Subm(){
	if(document.getElementById("text1").value == ""){
		alert("Please enter the name of the task！");
		return false;
	}
	
	if(document.getElementById("sel_this").value=="Time"&&
			document.getElementById("text_year").value=="year"||
			document.getElementById("sel_this").value=="Weibo"&&
			document.getElementById("text_weibo").value=="Weibo"||
			document.getElementById("sel_this").value=="163mail"&&
			document.getElementById("text_163mail").value=="163mail"||
			document.getElementById("sel_this").value=="Monitor"&&			
			document.getElementById("text_wait").value=="Wait_Time"){
		alert("Please enter THIS！");
		return false;
	}
	
	if(document.getElementById("sel_that").value=="163mail"&&
			document.getElementById("text_163mail2").value=="163mail"||
			document.getElementById("sel_that").value=="Weibo"&&
			document.getElementById("text_weibo2").value=="Weibo"){
		alert("Please enter THAT！");
		return false;
	}

	if(document.getElementById("sel_this").value=="Time"){
		document.getElementById("text_weibo").value="Weibo";
		document.getElementById("text_163mail").value="163mail";
		document.getElementById("text_wait").value="Wait_Time";
	}
	if(document.getElementById("sel_this").value=="Weibo"){
		document.getElementById("text_year").value="year";
		document.getElementById("text_163mail").value="163mail";
		document.getElementById("text_wait").value="Wait_Time";
	}
	if(document.getElementById("sel_this").value=="163mail"){
		document.getElementById("text_year").value="year";
		document.getElementById("text_weibo").value="Weibo";
		document.getElementById("text_wait").value="Wait_Time";
	}
	if(document.getElementById("sel_this").value=="Monitor"){
		document.getElementById("text_weibo").value="Weibo";
		document.getElementById("text_163mail").value="163mail";
		document.getElementById("text_year").value="year";
	}
	
	if(document.getElementById("sel_that").value=="Weibo"){
		document.getElementById("text_163mail2").value="163mail";
	}
	if(document.getElementById("sel_that").value=="163mail"){
		document.getElementById("text_weibo2").value="Weibo";
	}
	return true;
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create Task</title>
</head>
<jsp:useBean id="TaskControl" scope="session" class="function.TaskControl"/>
    <jsp:setProperty property="*" name="TaskControl"/>
    
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



<form action="CreateTaskServlet" method="post" name="form22" onsubmit="return Subm()">
	<input type="text" name="username" value=<%=name %> style="display:none">
   	<p class="p1">Title of task:&nbsp;&nbsp;<input type="text" name="Name" id="text1"></p>
   	<div id="div1">IF</div>
   	<div id="div2">
   		<select id="sel_this" name ="select_this" onChange="ThisChoose()">
   			<option value="Time" selected>Time</option>
    		<option value="Weibo">Weibo</option>
    		<option value="163mail">163mail</option>
    		<option value="Monitor">Monitor</option>
   			
   		</select>
   	</div>
   	<div id="div3">THEN</div>
 	<div id="div4">
 		<select id="sel_that" name ="select_that" onChange="ThatChoose()">
    		<option value="Weibo" selected>Weibo</option>
    		<option value="163mail">163mail</option>
   		</select>
 	</div>
 	<div id="div7">
		<div id="n12" style=float:left>
	   		<input type="submit" name="Admit" id="button3" value="Admit"/>
	   	</div>
   	 	<div id="n11">
   	 		<input type="button" name="Reset" id="button4" value="Reset" onClick="window.location.href='creatTaskAdmin.jsp';"/>
   	 	</div>
	</div>
	<br>
	
 	<div id="div5">
 		<div id="n4">
	   	 	<input type="text" name="Year" id="text_year" value="year"  onfocus="if(this.value=='year'){this.value='';}" onblur="if(this.value==''){this.value='year';}"> - <input type="text" name="Mon" id="text2" value="mon"  onfocus="if(this.value=='mon'){this.value='';}" onblur="if(this.value==''){this.value='mon';}"> - <input type="text" name="Day" id="text2" value="day"  onfocus="if(this.value=='day'){this.value='';}" onblur="if(this.value==''){this.value='day';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Hour" id="text3" value="hour"  onfocus="if(this.value=='hour'){this.value='';}" onblur="if(this.value==''){this.value='hour';}"> : <input type="text" name="Min" id="text3" value="min"  onfocus="if(this.value=='min'){this.value='';}" onblur="if(this.value==''){this.value='min';}"> : <input type="text" name="Sec" id="text3" value="sec"  onfocus="if(this.value=='sec'){this.value='';}" onblur="if(this.value==''){this.value='sec';}"><br>
	   	 	<br>
	   	 </div>
	   	 <div id="n5" style="display:none">
	   	 	<input type="text" name="Weibo" id="text_weibo" value="Weibo" 
	   	  	 onfocus="if(this.value=='Weibo'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='Weibo';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Password_Of_Weibo" id="text" value="Password" 
	   	 	 onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
	   	 	 onblur="if(!value) {value=defaultValue; this.type='text';}" /><br>
	   	 	<br>
	   	 	<textarea name="SinaText" style='height:150px;width:260px;resize: none;' id="text4"></textarea>	
	   	 </div>
	   	 <div id="n6" style="display:none">
	   	 	<input type="text" name="Gmail" id="text_163mail" value="163mail" 
	   	  	 onfocus="if(this.value=='163mail'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='163mail';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Password_Of_Gmail" id="text" value="Password" 
	   	 	 onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
	   	 	 onblur="if(!value) {value=defaultValue; this.type='text';}" /><br>
	   	 	<br>
	   	 </div>
	   	 <div id="nn7" style="display:none"> 
	   	 	<input type="text" name="WaitTime" id="text_wait" value="Wait_Time" 
	   	  	 onfocus="if(this.value=='Wait_Time'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='Wait_Time';}"><br>
	   	 	 <br>
	   	 </div>
 	</div>
	
	<div id="div6">	 
		<div id="n9">
	   	 	<input type="text" name="Weibo2" id="text_weibo2" value="Weibo" 
	   	  	 onfocus="if(this.value=='Weibo'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='Weibo';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Password_Of_Weibo2" id="text" value="Password" 
	   	 	 onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
	   	 	 onblur="if(!value) {value=defaultValue; this.type='text';}" /><br>
	   	 	<br>
	   	 	<textarea name="text_of_weibo" style='height:150px;width:260px;resize: none;' id="text4"  ></textarea><br>
	   	 	<br>
	   	 </div>
	   	 <div id="n10" style="display:none">
	   	 	<input type="text" name="Gmail2" id="text_163mail2" value="163mail" 
	   	  	 onfocus="if(this.value=='163mail'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='163mail';}"><br>
	   	 	<br>
	   	 	<input type="text" name="mail_user" id="text" value="mail user account" 
	   	  	 onfocus="if(this.value=='mail user account'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='mail user account';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Password_Of_Gmail2" id="text" value="Password" 
	   	 	 onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
	   	 	 onblur="if(!value) {value=defaultValue; this.type='text';}" /><br>
	   	 	<br>
	   	 	<input type="text" name="To" id="text" value="To" 
	   	  	 onfocus="if(this.value=='To'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='To';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Theme" id="text" value="Theme" 
	   	  	 onfocus="if(this.value=='Theme'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='Theme';}"><br>
	   	 	<br>
	   	 	<textarea name="text_of_gmail" style='height:150px;width:260px;resize: none;' id="text4"></textarea><br>
	   	 	<br>
	   	 </div>
	</div>
</form>
</body>
</html>