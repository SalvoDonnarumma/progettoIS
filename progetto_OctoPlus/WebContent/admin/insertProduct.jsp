<%
	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
	if( (isSomeoneLogged == null) || !isSomeoneLogged ){
		response.sendRedirect(request.getContextPath()+"/login.jsp");	
		return;
	}
%>
<%@page import="it.model.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="it">
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.model.ProductBean"%>

<head>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.css">
	<title> Inserimento nuovo prodotto </title>
<style>
@charset "ISO-8859-1";

/* Impostazioni dei link */
a {
	color: blue;
	font-weight: bold;
	text-decoration: none;
}

a:visited {
	color: blue;
}

a:hover {
	color: red;
}

a:active {
	color: blue;
}

/* Impostazioni del corpo della pagina */
body {
	background: linear-gradient(217deg, rgba(26, 82, 118, .8),
		rgba(26, 82, 118, 0) 70.71%),
		linear-gradient(127deg, rgba(19, 126, 166, .8), rgba(19, 126, 166, 0)
		70.71%), linear-gradient(336deg, rgba(2, 27, 70, .8),
		rgba(2, 27, 70, 0) 70.71%);
}

/* Stili per il form */
form {
	width: 40%;
	margin: 0 auto;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	background-color: #daf0ef;
	padding: 25px;
	text-align: center;
}

/* Stili per le sezioni del modulo */
.InsertProdotto, .UploadPhoto, .InsertAmministratore {
	width: 50%;
	border: 1px solid black;
	border-radius: 5px;
	padding: 20px;
	margin: 0 auto;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	background-color: #f2f2f2;
}

/* Stile per gli input del modulo */
form input[type=text], form input[type=number], form input[type=password],
	form input[type=date], form input[type=range], form input[type=email],
	form input[type=url], form input[type=time], form input[list] {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	background-color: #f5f5f5;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin-bottom: 10px;
	margin-right: 30px;
}

form textarea {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	background-color: #f5f5f5;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin-bottom: 10px;
	resize: vertical; /*fa solo su e giù*/
	margin-right: 30px;
}

/* Stile per i pulsanti di invio e reset */
input[type="submit"], input[type="reset"] {
	width: 50%;
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

input[type="submit"]:hover, input[type="reset"]:hover {
	border-color: #2691d9;
	transition: .5s;
	color: white;
	background-color: #51b0f0;
	width: 60%;
}

/* Stili per le sezioni del modulo */
.InsertProdotto, .UploadPhoto, .InsertAmministratore {
	width: 50%;
	border: 1px solid black;
	padding: 20px;
	margin: 0 auto;
}
/* Stili per il titolo del form */
.form-title {
	font-size: 28px;
	font-weight: bold;
	color: #000;
	margin-bottom: 20px;
	text-align: left;
	text-transform: uppercase;
}

/* Stili per la linea decorativa sotto il titolo */
.form-title::after {
	content: "";
	display: block;
	width: 100px;
	height: 3px;
	background-color: #853411;
	margin: 10px 0;
}

@media ( max-width : 800px) {
	form {
	width: 90%;
	margin: 0 auto;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	background-color: #daf0ef;
	padding: 25px;
}
}
</style>

<title>Aggiunta prodotto</title>
</head>

<body>
	<jsp:include page="../header.jsp" flush="true"/>
	
	<h2 class="form-title">Inserisci Prodotto</h2>
	
	<form action="<%=request.getContextPath()%>/product?fromStore=false" method="post">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="name">Name:</label><br> 
		<input name="nome" type="text" maxlength="25" required placeholder="enter name"><br> 
		
		<label for="categoria">Categoria:</label><br> 
		<select style="width:25%;" name="categoria" id="categoria-select" onchange="searchAndFilter()">
						    <option value="Coltelli">Coltelli</option>
						    <option value="Erogatori">Erogatori</option>
						    <option value="Guanti">Guanti</option>
						    <option value="Maschere">Maschere</option>
						    <option value="Mute">Mute</option>
						    <option value="Pinne">Pinne</option>
						    <option value="Torce">Torce</option>
		</select>
		<br>
		<label for="description">Description:</label><br>
		<textarea name="descrizione" maxlength="500" rows="10" required placeholder="enter description"></textarea><br>
		
		<label for="price">Price:</label><br> 
		<input name="price" style="width:20%;" type="number" min="0" value="0" step="any" required><br>

		<label>
		Quantit&aacute;: <br>
			Taglia M: <input style="width:15%;" name="tagliaM" type="number" min="0" ><br>
			Taglia L: <input style="width:15%;" name="tagliaL" type="number" min="0"><br>
			Taglia XL: <input style="width:15%;" name="tagliaXL" type="number" min="0"><br>
			Taglia XXL: <input style="width:15%;" name="tagliaXXL" type="number" min="0"><br>
		</label>

		<label for="Stats">Statistiche: </label><br>
		<textarea name="stats" maxlength="500" rows="10" required placeholder="enter description"></textarea><br>
		
		<br>
		<input class="submit" type="submit" value="Add"><br><input type="reset" value="Reset">
	</form>
	
</body>
</html>