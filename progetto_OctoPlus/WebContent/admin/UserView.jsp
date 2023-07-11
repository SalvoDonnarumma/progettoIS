<%@page import="it.model.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	System.out.println("Benvenuto nella pagina UserView");
	Collection<?> users = (Collection<?>) request.getAttribute("users");
	request.getSession().setAttribute("fromStore", Boolean.FALSE);
	if(users == null) {
		response.sendRedirect("../AdminControl?fromStore=false");	
		return;
	}
 	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
	if( isSomeoneLogged == null ){
		response.sendRedirect("./login.jsp");	
		return;
	}
	
	UserBean user = (UserBean) request.getSession().getAttribute("logged");
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.model.ProductBean"%>

<head>
	<link rel="stylesheet" type="text/css" href="./admin/style.css">
	<style>
	body {
			background-color: #16425B;
		}

		.container {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100vh;
		}

		table {
			width: 95%;
			margin: 0 auto;
			border-collapse: collapse;
			background-color: #D9DCD6;
		}

		th, td {
			padding: 10px;
			border: 1px solid black;
		}

		img {
			width: 100px;
			height: 100px;
		}

		.UploadPhoto {
			margin: 20px auto;
			width: 90%;
			text-align: center;
		}

		.UploadPhoto form {
			display: inline-block;
			text-align: left;
		}

		.UploadPhoto .file {
			margin-top: 10px;
		}

		.UploadPhoto .submit {
			margin-top: 10px;
		}
		a.delete-link,
a.edit-link {
	display: inline-block;
	padding: 5px 8px;
	margin-right: 5px;
	background-color: #85756E;
	color: #FFFFFF;
	border-radius: 4px;
	text-decoration: none;
	transition: background-color 0.3s, color 0.3s;
}

a.delete-link:hover,
a.edit-link:hover {
	background-color: #BC2C1A;
	text-decoration: none;
	color: #FFFFFF;
}

a.delete-link, a.edit-link {
	border: none;
	outline: none;
}

a.delete-link:focus, a.edit-link:focus {
	outline: none;
}
a.no-border-link {
	display: inline-block;
	padding: 5px 8px;
	margin-right: 10px;
	background-color: transparent;
	color: #FFFFFF;
	text-decoration: none;
	transition: background-color 0.3s, color 0.3s;
}

a.no-border-link:hover {
	
	color: #BC2C1A;
	text-decoration: none;
}
.UploadPhoto form {
	display: inline-block;
	text-align: left;
	background-color: #D9DCD6;
	border-radius: 8px;
	box-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
	padding: 20px;
}

.UploadPhoto select,
.UploadPhoto option {
	padding: 5px;
	border-radius: 4px;
	border: 1px solid #ccc;
}

.UploadPhoto select {
	width: 100%;
}

.UploadPhoto .file,
.UploadPhoto .submit {
	margin-top: 10px;
}

.UploadPhoto input[type="submit"],
.UploadPhoto input[type="reset"] {
	padding: 5px 10px;
	background-color: #85756E;
	color: #FFFFFF;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.UploadPhoto input[type="submit"]:hover,
.UploadPhoto input[type="reset"]:hover {
	background-color: #BC2C1A;
}
h1 {
	font-size: 28px;
	font-weight: bold;
	color: #BC2C1A;
	
}




	</style>
<script src="scripts/validate.js"></script>
</head>

<body>
	<jsp:include page="../header.jsp" flush="true"/>

	<h1>Users</h1>
	<table border="1">
		<tr>
			<th> Email <a href="AdminControl?fromStore=false&sort=idProdotto" class="no-border-link">Sort</a></th>
			<th> Nome <a href="AdminControl?fromStore=false&sort=nome" class="no-border-link">Sort</a></th>
			<th> Cognome <a href="AdminControl?fromStore=false&sort=prezzo" class="no-border-link">Sort</a></th>
			<th> Numero telefono </th>
			<th> Admin </th>
			<th> Action </th>
		</tr>
		<%
			if (users != null && users.size() != 0) {
				Iterator<?> it = users.iterator();
				while (it.hasNext()) {
					UserBean bean = (UserBean) it.next();
		%>
		<tr>
			<td><%=bean.getEmail()%></td>
			<td><%=bean.getNome()%></td>
			<td><%=bean.getCognome()%></td>
			<% if(bean.getTelefono()== null){%>
			<td>	Non disponibile </td>
			<%} else {%>
			<td><%=bean.getTelefono()%></td>
			<%} %>
			<td><%=bean.getAdmin()%></td>
			<td><a href="AdminControl?fromStore=false&action=delete&email=<%=bean.getEmail()%>"class="no-border-link">Delete</a><br>
				</td>
		</tr>
		<%
				}
			} else {
		%>
		<tr>
			<td colspan="6">No users available</td>
		</tr>
		<%
			}
		%>
	</table>
	<br>
	<br>
		 <a href="admin/insertAmm.jsp" class="no-border-link"> Inserisci nuovo admin </a>
	<br>
	<br>
	<a href="admin/ProductView.jsp" class="no-border-link"> Pagina visualizzazione prodotti </a>
	<br>
	<br>
	
	<a href="admin/OrderView.jsp" class="no-border-link"> Pagina visualizzazione ordini </a>
	

</body>
</html>