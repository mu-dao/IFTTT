<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>IFTTT page</title>
<link href="CSS/firstPage.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
function login(){
	window.location.href="login.jsp";
}
function register(){
	window.location.href="register.jsp";
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>a{TEXT-DECORATION:none}</style>
</head>
<body style="background-image:url(images/bg3.jpg)">
	<div id="div1">
		<div id="div3">
		<a href="MainPage.jsp" target="under"><b><i>IFTTT</i></b></a><br>
		</div>
		<div id="div2">
			<input type="button" onClick="login()" value="LOGIN" id="button_login"/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" onClick="register()" value="REGISTER" id="button_register"/>
		</div>
	</div>
</body>
</html>