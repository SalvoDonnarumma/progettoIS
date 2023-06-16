<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>OctoPlus Login</title>
<link rel="stylesheet" href="login-style.css">

<jsp:include page="header.jsp" flush="true"/>

<% 
List<String> errors = (List<String>) request.getAttribute("errors");
if (errors != null){
	for (String error: errors){ %>
		<%=error %> <br>		
	<%
	}
}
%>

<body>
<div class="center">
 <h1>OctoLogin</h1>
 	<form action="Login" method="post">
 		<div class="txt_field"> 
 			<input type= "text" name="username" required> <label>Email</label>
		</div>
		<div class="txt_field"> 
 			<input type= "password" name="password" required> <label>Password</label>
		</div>
		<div class="pass" >Forgot Password?</div>
		<input type= "submit" value="Login" >
		<div class=".singup_link"> </div>
		Not a member? <a href="#"> Signup </a>
	</form> 
</div>
</body>
</html>
