<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="function.Task"%>
<%
String name="";
if(session.getAttribute("uname")!=null){
	name=session.getAttribute("uname").toString();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	Task t = new Task();
	t = (Task)session.getAttribute("selectedtask");
	int THIS = 0;
	int THAT = 0;
	String Tname=""; 
	
  	THIS = t.getTHIS_task();
  	THAT = t.getTHAT_task();
  	Tname = t.gettask_name();
  	String date = t.getDate();
  	int i=0,j=0;
  	for(i=0;i < date.length();i++)
  		if(date.charAt(i) == '-')
  			break;
  	String year = date.substring(0,i);
  	for(j=i+1;j < date.length();j++)
  		if(date.charAt(j) == '-')
  			break;
  	String mon = date.substring(i+1,j);
  	String day = date.substring(j+1,date.length());
  
  	String time = t.getTime();
  	for(i=0;i < time.length();i++)
  		if(time.charAt(i) == ':')
  			break;
  	String hour = time.substring(0,i);
  	for(j=i+1;j < time.length();j++)
  		if(time.charAt(j) == ':')
  			break;
  	String min = time.substring(i+1,j);
  	String sec = time.substring(j+1,time.length());
%>
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
	document.getElementById("n5").style.display="none";
	document.getElementById("n4").style.display="none";
	document.getElementById("nn7").style.display="none";
}
function clickWaitWeibo(){
	document.getElementById("nn7").style.display="inline";
	document.getElementById("n5").style.display="none";
	document.getElementById("n6").style.display="none";
	document.getElementById("n4").style.display="none";
}
function clickWeibo2(){
	document.getElementById("n9").style.display="inline";
	document.getElementById("n10").style.display="none";
}
function clickGmail2(){
	n10 = document.getElementById("n10").style.display="inline";
	document.getElementById("n9").style.display="none";
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
			document.getElementById("text_wait").value=="Wait_Time(mins)"){
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
		document.getElementById("text_wait").value="Wait_Time(mins)";
	}
	if(document.getElementById("sel_this").value=="Weibo"){
		document.getElementById("text_year").value="year";
		document.getElementById("text_163mail").value="163mail";
		document.getElementById("text_wait").value="Wait_Time(mins)";
	}
	if(document.getElementById("sel_this").value=="163mail"){
		document.getElementById("text_year").value="year";
		document.getElementById("text_weibo").value="Weibo";
		document.getElementById("text_wait").value="Wait_Time(mins)";
	}
	if(document.getElementById("sel_this").value=="Monitor"){
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
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>alterTask</title>
</head>
<jsp:useBean id="TaskControl" scope="session" class="function.TaskControl"/>
<jsp:setProperty property="*" name="TaskControl"/>
<body style="background-image:url(images/bg3.jpg)">
	<div id="div_mp1">
		<div style=float:left id="div_mp2">
			<p class="s1"><b>if</b>
			<a href="creatTask.jsp"><b>this</b></a>
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


<form action="CreateTaskServlet" method="post" name="form22" onsubmit="return Subm()">
  	<input type="text" name="username" value=<%=name %> style="display:none">
   	<p class="p1">Title of task:&nbsp;&nbsp;<input type="text" name="Name" id="text1" value=<%=t.gettask_name()%>></p><br>
   	<div id="div1">IF</div>
   	
   	<div id="div2">
   		<select id="sel_this" name ="select_this" onChange="ThisChoose()">
   			<option value="Time" <%= THIS==1?"selected":"" %>>Time</option>
    		<option value="Weibo" <%= THIS==3?"selected":"" %>>Weibo</option>
    		<option value="163mail" <%= THIS==2?"selected":"" %>>163mail</option>
    		<option value="Monitor" <%= THIS==4?"selected":"" %>>Monitor</option>
   		</select>
   	</div>
   	
   	<div id="div3">THAT</div>
   	
   	<div id="div4">
   		<select id="sel_that" name ="select_that" onChange="ThatChoose()">
    		<option value="Weibo" <%= THAT==2?"selected":"" %>>Weibo</option>
    		<option value="163mail" <%= THAT==1?"selected":"" %>>163mail</option>
   		</select>
   	</div>
   	
   	<div id="div7">
   		<div id="n12">
	   	 	<input type="submit" name="Admit" id="button3" value="Admit"/>
	   	 </div>
   		<div id="n11">
   	 		<input type="button" name="Reset" id="button4" value="Reset" onClick="window.location.href='creatTask.jsp';"/>
   	 	</div>
   	 </div>
   	
   	<div id="div5">
		<div id="n4" <%= THIS==1?"":"style='display:none'" %>>
			<input type="text" name="Year" id="text_year" value=<%=year %>  onfocus="if(this.value=='year'){this.value='';}" onblur="if(this.value==''){this.value='year';}"> - <input type="text" name="Mon" id="text2" value=<%=mon %>  onfocus="if(this.value=='mon'){this.value='';}" onblur="if(this.value==''){this.value='mon';}"> - <input type="text" name="Day" id="text2" value=<%=day %>  onfocus="if(this.value=='day'){this.value='';}" onblur="if(this.value==''){this.value='day';}"><br>
	   		<br>
	   		<input type="text" name="Hour" id="text2" value=<%=hour %>  onfocus="if(this.value=='hour'){this.value='';}" onblur="if(this.value==''){this.value='hour';}"> : <input type="text" name="Min" id="text2" value=<%=min %>  onfocus="if(this.value=='min'){this.value='';}" onblur="if(this.value==''){this.value='min';}"> : <input type="text" name="Sec" id="text2" value=<%=sec %>  onfocus="if(this.value=='sec'){this.value='';}" onblur="if(this.value==''){this.value='sec';}"><br>
	   		<br>
		</div>
	   	<div id="n5" <%= THIS==3?"":"style='display:none'" %>>
	   		<input type="text" name="Weibo" id="text_weibo" value=<%=t.getFrm_Sina() %>
	   	  	onfocus="if(this.value=='Weibo'){this.value='';}" 
	   	 	onblur="if(this.value==''){this.value='Weibo';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Password_Of_Weibo" id="text" value=<%=t.getFrm_PW() %> 
	   	 	onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
	   	 	onblur="if(!value) {value=defaultValue; this.type='text';}" /><br>
	   	 	<br>
	   	 	<textarea name="SinaText" style="height:150px;width:260px;resize:none;" id="text4"><%=t.getSinaText() %></textarea>
	   	 </div>
	   	 <div id="n6" <%= THIS==2?"":"style='display:none'" %>> 
	   	 	<input type="text" name="Gmail" id="text_163mail" value=<%=t.getRCV_Mail() %> 
	   	 	onfocus="if(this.value=='163mail'){this.value='';}" 
	   	 	onblur="if(this.value==''){this.value='163mail';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Password_Of_Gmail" id="text" value=<%=t.getRCV_PW() %>
	   	 	onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
	   	 	onblur="if(!value) {value=defaultValue; this.type='text';}" /><br>
	   	 	<br>
	   	 </div>
	   	 
	   	 <div id="nn7" <%= THIS==4?"":"style='display:none'" %>> 
	   	 	<input type="text" name="Weibo" id="text_weibo" value=<%=t.getFrm_Sina() %>
	   	  	onfocus="if(this.value=='Weibo'){this.value='';}" 
	   	 	onblur="if(this.value==''){this.value='Weibo';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Password_Of_Weibo" id="text" value=<%=t.getFrm_PW() %> 
	   	 	onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
	   	 	onblur="if(!value) {value=defaultValue; this.type='text';}" /><br>
	   	 	<br>
	   	 	<input type="text" name="WaitTime" id="text_wait" value=<%=t.getWaitTime() %>
	   	  	 onfocus="if(this.value=='Wait_Time(mins)'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='Wait_Time(mins)';}"><br>
	   	 	 <br>
	   	 </div>
	 </div>
	 
	 <div id="div6">
		<div id="n9" <%= THAT==2?"":"style='display:none'" %>>
	   	 	<input type="text" name="Weibo2" id="text_weibo2" value=<%=t.getTo_Sina() %> 
	   	  	 onfocus="if(this.value=='Weibo'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='Weibo';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Password_Of_Weibo2" id="text" value=<%=t.getTo_PW() %> 
	   	 	 onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
	   	 	 onblur="if(!value) {value=defaultValue; this.type='text';}" /><br>
	   	 	<br>
	   	 	<textarea name="text_of_weibo" style='height:150px;width:260px;resize: none;' id="text4"  ><%=t.getWeibo_Content()%></textarea><br>
	   	 	<br>
	   	 </div>
	   	 <div id="n10" <%= THAT==1?"":"style='display:none'" %>>
	   	 	<input type="text" name="Gmail2" id="text_163mail2" value=<%=t.getSend_Mail() %> 
	   	  	 onfocus="if(this.value=='163mail'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='163mail';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Password_Of_Gmail2" id="text" value=<%=t.getSend_PW() %> 
	   	 	 onfocus="if(this.value==defaultValue) {this.value='';this.type='password'}"
	   	 	 onblur="if(!value) {value=defaultValue; this.type='text';}" /><br>
	   	 	<br>
	   	 	<input type="text" name="To" id="text" value=<%=t.getTo_Mail() %>
	   	  	 onfocus="if(this.value=='To'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='To';}"><br>
	   	 	<br>
	   	 	<input type="text" name="Theme" id="text" value=<%=t.getSubject() %> 
	   	  	 onfocus="if(this.value=='Theme'){this.value='';}" 
	   	 	 onblur="if(this.value==''){this.value='Theme';}"><br>
	   	 	<br>
	   	 	<textarea name="text_of_gmail" style='height:150px;width:260px;resize: none;' id="text4" ><%=t.getContent() %></textarea><br>
	   	 	<br>
	   	 </div>
	 </div>
	 
</form>
</body>
</html>