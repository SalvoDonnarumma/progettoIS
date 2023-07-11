<%@page import="it.model.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	request.getSession().setAttribute("fromStore", Boolean.FALSE);
	if(products == null) {
		response.sendRedirect("../product?fromStore=false");	
		return;
	}
	ProductBean product = (ProductBean) request.getAttribute("product");
 	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
	if( isSomeoneLogged == null ){
		response.sendRedirect("../login.jsp");		
		return;
	}
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.model.ProductBean"%>

<head>
	<link rel="stylesheet" type="text/css" href="./admin/productviewstyle.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>
	<jsp:include page="../header.jsp" flush="true"/>

	<h2>Products</h2>
	<table border="1">
		<tr>
			<th>IdProdotto <a href="product?fromStore=false&sort=idProdotto">Sort</a></th>
			<th>Categoria<a href="product?fromStore=false&sort=categoria">Sort</a></th>
			<th>Nome <a href="product?fromStore=false&sort=nome">Sort</a></th>
			<th>Prezzo <a href="product?&sort=prezzo">Sort</a></th>
			<th>Descrizione</th>
			<th>Foto</th>
			<th>Statistiche</th>
			<th>Taglie Disponibili</th>
			<th>Action</th>
		</tr>
		<%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
		%>
		<tr>
			<td><%=bean.getCode()%></td>
			<td><%=bean.getCategoria()%></td>
			<td><%=bean.getNome()%></td>
			<td><%=bean.getPrice()%></td>
			<td><%=bean.getDescrizione()%></td>
			<td> <img src="./getPicture?id=<%=bean.getCode()%>" onerror="this.src='./img/nophoto.png'" style="width:100px;height:100px"> </td>
			<td><%=bean.getStats()%></td>
			<td><p> <%=bean.getTaglie()%> </p> </td>
			<td><a href="product?fromStore=false&action=delete&id=<%=bean.getCode()%>">Cancella</a><br>
				<a href="product?action=read&fromStore=modify&id=<%=bean.getCode()%>">Modifica</a> <br>
				</td>
		</tr>
		<%
				}
			} else {
		%>
		<tr>
			<td colspan="6">No products available</td>
		</tr>
		<%
			}
		%>
	</table>
	
	<%
		if (product != null) {
	%>
	<table border="1">
		<tr>
			<th>Code</th>
			<th>Name</th>
			<th>Description</th>
			<th>Price</th>
		</tr>
		<tr>
			<td><%=product.getCode()%></td>
			<td><%=product.getNome()%></td>
			<td><%=product.getDescrizione()%></td>
			<td><%=product.getPrice()%></td>
		</tr>
	</table>
	<%
		}
	%>
	<h3>Vuoi inserire un nuovo prodotto?</h3> <a href="./admin/insertProduct.jsp"> Clicca qui </a>
	
<br>
<hr>
<br>
<h2>Upload photo:</h2>
	<div class="UploadPhoto">
<form action="UpdatePhoto" enctype="multipart/form-data" method="post">
	Nome file caricato:
	<select name="id">
<%
	if(products != null && products.size() > 0) {
		Iterator<?> it = products.iterator(); 
		while(it.hasNext()) {
			ProductBean item = (ProductBean)it.next();
%>	
		<option value="<%=item.getCode()%>"> cod: <%=item.getCode()%> nome: <%=item.getNome()%></option>
<%
		}
	}	
%>		
	</select>
	<br>
	<input class="file" type="file" name="talkPhoto" value="" maxlength="255">	
	<br>		
	<input type="submit" class="submit" value="Upload">      <input type="reset">
	<br>
</form>
	</div>

	<br>
	<br>
	Vuoi vedere la pagina della visualizzazione utenti?
	<a href="admin/UserView.jsp"> Clicca qui! </a>
	<br>
	<br>
	Vuoi vedere la pagina della visualizzazione ordini?
	<a href="admin/OrderView.jsp"> Clicca qui! </a>
<br>
</body>
</html>