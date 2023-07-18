<%@page import="it.model.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
	if( (isSomeoneLogged == null) || !isSomeoneLogged ){
		response.sendRedirect(request.getContextPath()+"/login.jsp");	
		return;
	}
	System.out.println("Benvenuto nella pagina UserView");
	Collection<?> users = (Collection<?>) request.getAttribute("users");
	request.getSession().setAttribute("fromStore", Boolean.FALSE);
	if(users == null) {
		response.sendRedirect(request.getContextPath()+"/AdminControl?fromStore=false");	
		return;
	}
	UserBean user = (UserBean) request.getSession().getAttribute("logged");
%>

<!DOCTYPE html>
<html lang="it">
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.model.ProductBean"%>

<head>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/productviewstyle.css">
	<title> Lista Utenti </title>
<script src="scripts/validate.js"></script>
<script type="text/javascript">
	function confirmAlert(){
		alert("Eliminazione utente in corso...");
	}
</script>
</head>

<body>
	<jsp:include page="../header.jsp" flush="true"/>

	<br>
	<br>
		 <a href="admin/insertAmm.jsp" class="no-border-link"> Inserisci nuovo admin </a>
	<br>
	<br>
	<a href="admin/ProductView.jsp" class="no-border-link"> Pagina visualizzazione prodotti </a>
	<br>
	<br>
	
	<a href="admin/OrderView.jsp" class="no-border-link"> Pagina visualizzazione ordini </a>
	<h1 style="color: #853411;" >Elenco Utenti</h1>
	<table border="1" title="Tabella utenti">
	<caption>Tabella utenti</caption>
		<tr>
			<th> Email <a href="AdminControl?fromStore=false&sort=email" class="no-border-link">Sort</a></th>
			<th> Nome</th>
			<th> Cognome <a href="AdminControl?fromStore=false&sort=cognome" class="no-border-link">Sort</a></th>
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
			<td><a onClick="confirmAlert();" href="AdminControl?fromStore=false&action=delete&email=<%=bean.getEmail()%>"class="no-border-link">Delete</a><br>
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
</body>
</html>