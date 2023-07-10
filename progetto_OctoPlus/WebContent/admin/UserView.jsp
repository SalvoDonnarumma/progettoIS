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

	<h2>Users</h2>
	<table border="1">
		<tr>
			<th> Email <a href="AdminControl?fromStore=false&sort=idProdotto">Sort</a></th>
			<th> Nome <a href="AdminControl?fromStore=false&sort=nome">Sort</a></th>
			<th> Cognome <a href="AdminControl?fromStore=false&sort=prezzo">Sort</a></th>
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
			<td><a href="AdminControl?fromStore=false&action=delete&email=<%=bean.getEmail()%>">Delete</a><br>
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
		<h3>Vuoi inserire un nuovo admin? <a href="insertAmm.jsp"> Clicca qui </a></h3>
	<br>
	<br>
	Vuoi vedere la pagina della visualizzazione prodotti?
	<a href="admin/ProductView.jsp"> Clicca qui! </a>
	<br>
	<br>
	Vuoi vedere la pagina della visualizzazione ordini?
	<a href="#"> Clicca qui! </a>
	

</body>
</html>