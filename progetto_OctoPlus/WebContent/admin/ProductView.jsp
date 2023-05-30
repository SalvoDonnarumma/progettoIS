<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	if(products == null) {
		response.sendRedirect("../product");	
		return;
	}
	ProductBean product = (ProductBean) request.getAttribute("product");
	
	Cart cart = (Cart) request.getAttribute("cart");
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.unisa.ProductBean, it.unisa.Cart"%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<title>Storage DS/BF</title>
	<link rel="stylesheet" href="Productstyle.css">
</head>

<body>
	<header>
		<img src="img/octopus.png" class="logo">
		<nav>
		<ul>
			<li> <a href="#"> HOME  </a> </li>
			<li> <a href="Login.jsp"> LOGIN </a> </li>
			<li> <a href="#"> CONTACT US </a> </li>
		</ul>
		</nav>
	</header>

	<h2>Products</h2>
	<a href="product">List</a>
	<table border="1">
		<tr>
			<th>IdProdotto <a href="product?sort=idProdotto">Sort</a></th>
			<th>Categoria<a href="product?sort=categoria">Sort</a></th>
			<th>Nome <a href="product?sort=nome">Sort</a></th>
			<th>Prezzo <a href="product?sort=prezzo">Sort</a></th>
			<th>Descrizione</th>
			<th>Foto</th>
			<th>Statistiche</th>
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
			<td><a href="product?driver=drivermanager&action=delete&id=<%=bean.getCode()%>">Delete</a><br>
				<a href="product?driver=drivermanager&action=read&id=<%=bean.getCode()%>">Details</a><br>
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
	
	<h2>Details</h2>
	<%
		if (product != null) {
	%>
	<table border="1">
		<tr>
			<th>Code</th>
			<th>Name</th>
			<th>Description</th>
			<th>Price</th>
			<th>Quantity</th>
		</tr>
		<tr>
			<td><%=product.getCode()%></td>
			<td><%=product.getNome()%></td>
			<td><%=product.getDescrizione()%></td>
			<td><%=product.getPrice()%></td>
			<td><%=product.getQuantity()%></td>
		</tr>
	</table>
	<%
		}
	%>
	<h2>Insert Prodotto</h2>
	<form action="product" method="post">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="name">Name:</label><br> 
		<input name="nome" type="text" maxlength="25" required placeholder="enter name"><br> 
		
		<label for="categoria">Categoria:</label><br> 
		<input name="categoria" type="text" maxlength="20" required placeholder="enter categoria"><br> 
		
		<label for="description">Description:</label><br>
		<textarea name="descrizione" maxlength="500" rows="10" required placeholder="enter description"></textarea><br>
		
		<label for="price">Price:</label><br> 
		<input name="price" type="number" min="0" value="0" step="any" required><br>

		<label for="quantity">Quantity:</label><br> 
		<input name="quantity" type="number" min="1" value="1" required><br>

		<label for="Stats">Statistiche: </label><br>
		<textarea name="stats" maxlength="500" rows="10" required placeholder="enter description"></textarea><br>
		
		<br>
		<center><input type="submit" value="Add"><input type="reset" value="Reset"></center>
	</form>
<br>
<hr>
<br>
<h3>Upload photo:</h3>
<form action="UpdatePhoto" enctype="multipart/form-data" method="post">
	Name-surname:
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
	<input type="submit" value="Upload"><input type="reset">
</form>
<br>
<hr>
<br>
	<h2>Insert Amministratore</h2>
	<form action="AdminControl" method="post">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="name">Email:</label><br> 
		<input name="email" type="email" maxlength="40" required placeholder="enter email"><br> 
		
		<label for="password">Password:</label><br> 
		<input name="password" type="password" maxlength="25" required placeholder="enter a password"><br> 
		
		<label for="Foto">Foto profilo:</label><br> 
		<input class="file" type="file" name="adminPhoto" value="" maxlength="255">
		<br>
		<label for="cognome">Cognome:</label>
		<input name="cognome" type="text" value="" required placeholder="enter a surname"><br>

		<center> <input type="submit" value="Add"><input type="reset" value="Reset"> </center>
	</form>
	
	<% if(cart != null) { %>
		<h2>Cart</h2>
		<table border="1">
		<tr>
			<th>Name</th>
			<th>Action</th>
		</tr>
		<% List<ProductBean> prodcart = cart.getProducts(); 	
		   for(ProductBean beancart: prodcart) {
		%>
		<tr>
			<td><%=beancart.getNome()%></td>
			<td><a href="product?action=deleteC&id=<%=beancart.getCode()%>">Delete from cart</a></td>
		</tr>
		<%} %>
	</table>		
	<% } %>	
<br>
<hr>
</body>
</html>