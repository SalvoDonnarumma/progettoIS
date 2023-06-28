<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>OctoPlus Login</title>
<link rel="stylesheet" href="registrazione.css">
<jsp:include page="header.jsp" flush="true"/>
<script src="scripts/validate.js"></script>

<% 
List<String> errors = (List<String>) request.getAttribute("errors");
if (errors != null){
	for (String error: errors){ %>
		<%=error %>		
	<%
	}
}
%>

<body>
<div class="center">
 <h1>Benvenuto!</h1>
 
 	<form action="SignUp" method="post">
 		<div class="txt_field"> <!-- Nome -->
 			<input type="text" name="firstname" id="firstname" required pattern="^[A-Za-z]+$"
			 onchange="validateFormElem(this, document.getElementById('errorName'), nameOrLastnameErrorMessage)">
			 <span id="errorName"> </span> <label>Nome</label>
		</div>
		
		<div class="txt_field">
			<input type="text" name="lastname" id="lastname" required pattern="^[A-Za-z]+$"
			onchange="validateFormElem(this, document.getElementById('errorLastname'), nameOrLastnameErrorMessage)">
			<span id="errorLastname"></span> <label>Cognome</label>
		</div>
		
		<div class="txt_field">
			<input type="email" name="email" required 
			onchange="validateFormElem(this, document.getElementById('errorEmail'), emailErrorMessage)"	id="email">
			<span id="errorEmail"></span> <label>Email</label>
		</div>
		
		<div class="txt_field"> 
 			<input type= "password" name="password" required> <label>Password</label>
		</div>
		
		<div class="txt_field"> 
 			<input type= "password" name="conf_password" required> <label>Conferma Password</label>
		</div>
		
		<input type= "submit" value="Registrami" >
		
		Sei già registrato? 
		<a href="login.jsp"> Accedi </a>			
	</form> 		
</div>
</body>
</html>
