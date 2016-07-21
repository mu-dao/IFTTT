<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.dao.*" import="com.entity.*"
    import="java.util.*" 
	import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String name="";
if(session.getAttribute("uname")!=null){
	name=session.getAttribute("uname").toString();
}
User user = UserDao.getInfo(name);
%>
<%
String msg=(String)request.getAttribute("error_running");	
if(msg!=null){
%>
<script type="text/javascript">
alert("<%=msg%>");
</script>
<%}%>
<%
String msg3=(String)request.getAttribute("error_stop");	
if(msg3!=null){
%>
<script type="text/javascript">
alert("<%=msg3%>");
</script>
<%}%>
<%
String msg2=(String)request.getAttribute("error");	
if(msg2!=null){
%>
<script type="text/javascript">
alert("<%=msg2%>");
</script>
<%}%>
<%
String msg4=(String)request.getAttribute("error_finish");	
if(msg4!=null){
%>
<script type="text/javascript">
alert("<%=msg4%>");
</script>
<%}%>
<head>
<link href="CSS/mainPage.css" rel="stylesheet" type="text/css">
<link href="CSS/task2.css" rel="stylesheet" type="text/css">
<style>a{TEXT-DECORATION:none}</style>
<script>
function getcontent(i){
  var info_select = document.getElementById("select_description"); //?right?
  var info_text = document.getElementById("info_text"); //?
  info_text.value =info_select.options[i].value;
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="CSS/task2.css" rel="stylesheet" type="text/css">
<title>task</title>

<%//读取数据库中的内容，创建任务的相应数组 ,学习如何把任务信息放在select框中
  	  //String A=session.getAttribute("nn").toString();
	  //name="ha";
  	  Class.forName("org.gjt.mm.mysql.Driver").newInstance(); 
	  Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/IFTTT","root","123456");  
	  Statement  stmt=connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	  String sql = "SELECT * FROM TASK";
	  ResultSet rst = stmt.executeQuery(sql);
	  ArrayList<String> TaskInfo = new ArrayList<String>();
	  ArrayList<String> Accomplish = new ArrayList<String>();
	  ArrayList<String> Running = new ArrayList<String>();
	  ArrayList<String> TaskName = new ArrayList<String>();
	  ArrayList<String> TaskId = new ArrayList<String>();
	  /*TaskName.add("1");
	  TaskName.add("2");
	  TaskId.add("0");
	  TaskId.add("1");
	  TaskInfo.add("taskinfo 0");
	  TaskInfo.add("1　2");*/
	  
	  String task_info = "";
	  String acc = "";
	  String run = "";
	  String task_name = "";
	  String task_id = "";
	  while(rst.next()){
	  	//task_info = rst.getString(2) + '\t' +"----"+'\t' + rst.getString(26);
	  	String state="";
	  	if(rst.getString(4).equals("1"))
	  		state="Running";
	  	else if(rst.getString(4).equals("2"))
	  		state="Stopped";
	  	else if(rst.getString(4).equals("3"))
	  		state="Over";
	  	task_info = rst.getString(2) + "&#13;User:" + rst.getString(3)+"&#13;&#13;"+ rst.getString(23) + "&#13;&#13;" + state;
	  	TaskInfo.add(task_info);
	  	task_name=rst.getString(2);
	  	TaskName.add(task_name);
	  	task_id=rst.getString(1);
	  	TaskId.add(task_id);
	  	/*if(rst.getString(23).equals("1")){   //不是23
	  		acc = rst.getString(2) + '\t' +"----"+'\t' + rst.getString(26);
	  		Accomplish.add(acc);
	  	}
	  	else if(rst.getString(4).equals("1")){
	  		run = rst.getString(2) + '\t' +"----"+'\t' + rst.getString(26);
	  		Running.add(run);
	  	}*/
	  }
	  
  	%>
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
	
<form method="post" name="taskForm" action="TaskServlet">
	<div id="div_task">
	<div id="task_list" style=float:left>  
		<p class="p1">task list</p>
		<select id="select_list" name ="select_list" onChange="getcontent(this.selectedIndex)" size=5>
		<%for(int i = 0;i<TaskName.size();i++){ %>
			<option value=<%=TaskId.get(i) %>> <%=TaskName.get(i) %> </option>
		<%} %>
		</select>
	</div>

	<div id="task_description" style=float:left>
		<p class="p1">task description</p>
		<select id="select_description" onchange="" style="display:none" size=10>
		<%for(int i = 0;i<TaskName.size();i++){ %>
			<option value=<%=TaskInfo.get(i) %>> <%=TaskId.get(i) %> </option>
		<%} %>
		</select>
		<textarea id="info_text"> </textarea>
	</div>
	</div>
	<div id="div_b0">
		<div style=float:left id="div_b1">
			<input type="button" id="b_new" value="NEW" onClick="window.location.href='creatTask.jsp';">
		</div>

		<div style=float:left id="div_b5">
			<input type="submit" id="b_delete" value="DELETE" name="delete">
		</div>
	</div>	
</form>
</body>
</html>