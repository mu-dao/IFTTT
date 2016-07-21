<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
session.removeAttribute("uname"); 
session.invalidate(); %>
<script>alert('Log out...');window.location.href='index.jsp'</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quit</title>
</head>
<body>

</body>
</html>