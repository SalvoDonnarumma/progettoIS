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
	UserBean user = (UserBean) request.getSession().getAttribute("logged");
	System.out.println("ti sei loggato con le credenziali di: "+user.toString());
	Cart cart = (Cart) request.getAttribute("cart");
%>

<!DOCTYPE html>
<html>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.model.ProductBean, it.unisa.Cart"%>

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
</head>

<body>
	<jsp:include page="../header.jsp" flush="true"/>

	<h2>Products</h2>
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
	<div class="InsertProdotto">
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
		<input class="submit" type="submit" value="Add"><input type="reset" value="Reset">
	</form>
	</div>
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
<hr>
<br>
<h2>Insert Amministratore</h2>
	<div class="InsertAmministratore">
	<form action="AdminControl" method="post">
		<input type="hidden" name="action" value="insert"> 
		
		<label for="name">Email:</label><br> 
		<input name="email" type="email" maxlength="40" required placeholder="enter email"><br> 
		
		<label for="password">Password:</label><br> 
		<input name="password" type="password" maxlength="25" required placeholder="enter a password"><br> 
		
		<label for="cognome">Cognome:</label><br>
		<input name="cognome" type="text" value="" required placeholder="enter a surname"><br>

		<input type="submit" value="Add"><input type="reset" value="Reset">
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
	</div>
<br>
<hr>
</body>
</html>