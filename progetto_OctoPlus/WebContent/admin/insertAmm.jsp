<%@page import="it.model.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.model.ProductBean"%>

<head>
	
	<style>
	a:link {
		color: blue;
		font-weight: bold;
	}

/* visited link */
	a:visited {
		color: blue;
		font-weight: bold;
	}

/* mouse over link */
	a:hover {
		color: red;
		font-weight: bold;
	}

	a:active {
		color: blue;
		font-weight: bold;
	}
	
	body{
		background: 
			linear-gradient(217deg, rgba(26, 82, 118, .8), rgba(26, 82, 118, 0) 70.71%),
            linear-gradient(127deg, rgba(19, 126, 166, .8), rgba(19, 126, 166, 0) 70.71%),
            linear-gradient(336deg, rgba(2, 27, 70, .8), rgba(2, 27, 70, 0) 70.71%);
	}
	
	table {
		width: 100%;
	}

	table, th, td {
		text-align: center;
		border: 1px solid black;
		border-collapse: collapse;
	}

	th, td {
		padding: 5px;
	}

	label {
		font-weight: bold;
	}

	form input[type=text], form input[type=number], form input[type=password],
	form input[type=date], form input[type=range], form input[type=email],
	form input[type=url], form input[type=time], form input[list] {
		width: 500px;
		font-size: 1em;
	}

	textarea {
		width: 500px;
		height: 60px;
		font-size: 1em;
	}
	
	input[type="submit"]{
		  width: 15%;
		  height: 25%;
		  border: 1px solid;
		  background: #2691d9;
		  border-radius: 10px;
		  font-size: 18px;
		  color: #e9f4fb;
		  font-weight: 700;
		  cursor: pointer;
		  outline: none;
		  position: relative;
		}
	input[type="submit"]:hover{
		  border-color: #2691d9;
		  transition: .5s;
		  color: white;
		  background-color: #51b0f0; 
		}
		
	input[type="reset"]{
		  width: 15%;
		  height: 25%;
		  border: 1px solid;
		  background: #2691d9;
		  border-radius: 10px;
		  font-size: 18px;
		  color: #e9f4fb;
		  font-weight: 700;
		  cursor: pointer;
		  outline: none;
		  position:relative;
		}
	input[type="reset"]:hover{
		  border-color: #2691d9;
		  transition: .5s;
		  text-align: center;
		  color: white;
		  background-color: #51b0f0; 
		}	
		
	.InsertProdotto{
		width: 50%;
  		border: 1px solid black;
  		padding: 20px;
  		margin-left: auto;
 		margin-right: auto;
	}	
	
	.UploadPhoto{
		width: 50%;
  		border: 1px solid black;
  		padding: 20px;
  		margin-left: auto;
 		margin-right: auto;
	}
	
	.InsertAmministratore{
		width: 50%;
  		border: 1px solid black;
  		padding: 20px;
  		margin-left: auto;
 		margin-right: auto;
 		padding: auto;
	}
}
	</style>
<script src="scripts/validate.js"></script>
</head>

<body>
	<jsp:include page="../header.jsp" flush="true"/>

	
	<h2>Insert Amministratore</h2>
	<div class="InsertAmministratore">
	<form action="AdminControl?fromStore=false" method="post">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="name">Email </label>
		<input name="email" type="email" maxlength="40" required placeholder="enter email"><br> 
		
		<label for="cognome">Cognome </label>
		<input name="cognome" type="text" value="" required placeholder="enter a surname"><br>
		
		<div class="txt_field"> 
			<label>Password</label>
 			<input type= "password" name="password" required placeholder="enter a password"> 
		</div>
		
		<div id="phones" class="txt_field">
			<label>Numero telefono</label>
					<input type="tel" name="phone"
						id="phone0" required
						pattern="^([0-9]{3}-[0-9]{7})$"
						onchange="validateFormElem(this, document.getElementById('errorPhone0'), phoneErrorMessage)"
						placeholder="[###-#######]">
				<br>
				<span id="errorPhone0"></span>
		</div>

		<input type="submit" value="Add"><input type="reset" value="Reset">
	</form>
	</div>
	
</body>
</html>