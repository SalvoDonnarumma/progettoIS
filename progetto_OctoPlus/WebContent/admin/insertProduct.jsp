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
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.model.ProductBean"%>

<head>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/style.css">
	<style>@charset "ISO-8859-1";
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
	background: linear-gradient(217deg, rgba(26, 82, 118, .8), rgba(26, 82, 118, 0) 70.71%),
            linear-gradient(127deg, rgba(19, 126, 166, .8), rgba(19, 126, 166, 0) 70.71%),
            linear-gradient(336deg, rgba(2, 27, 70, .8), rgba(2, 27, 70, 0) 70.71%);
}

/* Impostazioni delle tabelle */
table {
	width: 100%;
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	text-align: center;
	padding: 5px;
	border: 1px solid black;
	
}
/* Stili per il form */
form {
	width: 750px;
	margin: 0 auto;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	background-color: #f2f2f2;
	padding: 25px;
}

/* Stili per i pulsanti all'interno del form */
form input[type="submit"],
form input[type="reset"] {
	width: 100%;
	margin-top: 10px;
}

/* Stili per le sezioni del modulo */
.InsertProdotto,
.UploadPhoto,
.InsertAmministratore {
	width: 50%;
	border: 1px solid black;
	border-radius: 5px;
	padding: 20px;
	margin: 0 auto;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	background-color: #f2f2f2;
}


/* Stile per gli input del modulo */
form input[type=text],
form input[type=number],
form input[type=password],
form input[type=date],
form input[type=range],
form input[type=email],
form input[type=url],
form input[type=time],
form input[list] {
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
input[type="submit"],
input[type="reset"] {
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

input[type="submit"]:hover,
input[type="reset"]:hover {
	border-color: #2691d9;
	transition: .5s;
	color: white;
	background-color: #51b0f0;
}

/* Stili per le sezioni del modulo */
.InsertProdotto,
.UploadPhoto,
.InsertAmministratore {
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
  background-color:#91972A;
  margin: 10px 0;
}
</style>

	<title>Aggiunta prodotto</title>
</head>

<body>
	<jsp:include page="../header.jsp" flush="true"/>
	
	<h2 class="form-title">Inserisci Prodotto</h2>
	
	<form action="product?fromStore=false" method="post">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="name">Name:</label><br> 
		<input name="nome" type="text" maxlength="25" required placeholder="enter name"><br> 
		
		<label for="categoria">Categoria:</label><br> 
		<input name="categoria" type="text" maxlength="20" required placeholder="enter categoria"><br> 
		
		<label for="description">Description:</label><br>
		<textarea name="descrizione" maxlength="500" rows="10" required placeholder="enter description"></textarea><br>
		
		<label for="price">Price:</label><br> 
		<input name="price" type="number" min="0" value="0" step="any" required><br>

		<label>
		Quantit&aacute;: <br>
			Taglia M: <input style="width:5%;" name="tagliaM" type="number" min="1" ><br>
			Taglia L: <input style="width:5%;" name="tagliaL" type="number" min="1"><br>
			Taglia XL: <input style="width:5%;" name="tagliaXL" type="number" min="1"><br>
			Taglia XXL: <input style="width:5%;" name="tagliaXXL" type="number" min="1"><br>
		</label>

		<label for="Stats">Statistiche: </label><br>
		<textarea name="stats" maxlength="500" rows="10" required placeholder="enter description"></textarea><br>
		
		<br>
		<input class="submit" type="submit" value="Add"><input type="reset" value="Reset">
	</form>
	
</body>
</html>