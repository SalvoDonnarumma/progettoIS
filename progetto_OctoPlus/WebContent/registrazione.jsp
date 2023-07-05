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
 			<input type= "password" name="conf_password" required
 			onchange="validateFormElem(this, document.getElementById('errorPass'), wrongconfirmPassErrorMessage)"> <label>Conferma Password</label>
 			<span id="errorPass"></span>
		</div>
		<span id="errorPhone0"></span>
		
		<div id="phones" class="txt_field">
					<input type="tel" name="phone"
						id="phone0" required
						pattern="^([0-9]{3}-[0-9]{7})$"
						onchange="validateFormElem(this, document.getElementById('errorPhone0'), phoneErrorMessage)">
				<label>Numero telefono [###-#######]</label>
				<br>
				<span id="errorPhone0"></span>
		</div>
		
		<input type= "submit" value="Registrami" >
		
		Sei già registrato? 
		<a href="login.jsp">  <b> Accedi </b> </a>			
	</form> 		
</div>
</body>
</html>
