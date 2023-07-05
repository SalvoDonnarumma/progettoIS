<%
	ProductBean bean = (ProductBean) request.getAttribute("product"); 
 	SizesBean sizes = (SizesBean) bean.getTaglie();
 	Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
 	System.out.println(bean);
 	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
	if( isSomeoneLogged == null ){
		response.sendRedirect("./login.jsp");	
		return;
	}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<%@ page import="java.util.*,it.model.ProductBean, it.model.SizesBean, it.unisa.DaoDataSource, it.unisa.Cart"%>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./admin/modifyproduct.css">
</head>
<body>
	<jsp:include page="../header.jsp" flush="true"/>
	<div class="big_container">
	<br>
		<div class="col-25">  
	     	<div class="box1">
	     	<h3 style="color: grey;">Vecchio Prodotto:</h3> <br>
	     	
	     	<img src="./getPicture?id=<%=bean.getCode()%>" onerror="this.src='./img/nophoto.png'" style="width:30%">
	     	
			<p class="name">Nome: <%=bean.getNome()%> </p> 
			
			<p class="categoria">Categoria:<%=bean.getCategoria()%> </p>  <br> 
			
			<p class="description">Descrizione: <%=bean.getDescrizione()%> <p><br>
			
			<p>Prezzo: <%=bean.getPrice()%> &euro; </p> <br>
	
			<p>Quantit&aacute; taglie M disponibili: <%=bean.getTaglie().getQuantitaM()%> </p><br>
	
			<p>Quantit&aacute; taglie L disponibili: <%=bean.getTaglie().getQuantitaL()%></p><br>
			
			<p>Quantit&aacute; taglie XL disponibili: <%=bean.getTaglie().getQuantitaXL()%></p><br>
			
			<p>Quantit&aacute; taglie XLL disponibili:<%=bean.getTaglie().getQuantitaXXL()%></p><br>
	
			<p>Statistiche:  <%= bean.getStats()%> <br>
		 			
		 	</div>
	    </div>
	 <br>
	 <br> 	
	<br>
		<div class="row">
		  <div class="col-75"> 
	    	<div class="container">
	    	<h2 style="color: red;"> Modifiche al prodotto: </h2> <br>
	      	<form action="product?fromStore=false" method="post">
				<input type="hidden" name="action" value="insert"> 
			
				<h4>
					<label> Nome prodotto: 
						<input name="nome" type="text" maxlength="25" required placeholder="enter name" value=<%=bean.getNome()%>><br> 
					</label>
				</h4>
				
				<h4>
					<label>
					Seleziona categoria: 
					<select style="width:10%;">
					    <option value="1">COLTELLI</option>
				    	<option value="2">EROGATORI</option>
				    	<option value="3">GUANTI</option>
				    	<option value="4">MASCHERE</option>
				    	<option value="5">MUTE</option>
				    	<option value="6">PINNE</option>
				    	<option value="7">TORCE</option>
 					</select>
 					</label>
				</h4>
				<br>
				
				<h4>
					<label>
						Descrizione: <br>
						<textarea  style="width:40%;" cols="100" name="descrizione" maxlength="1000" rows="10" required>
						<%=bean.getDescrizione()%>
						</textarea><br>
					</label>
				</h4>
				
				<h4>
					<label>
						Prezzo: 
						<input style="width:5%;" name="price" type="number" min="0" value="0" step="any" value=<%=bean.getPrice()%>  required>&euro;
					</label>
				</h4>
				
				<br>
				<h4>
					<label>
						Quantit&aacute;: <br>
						<h5>
						Taglia M: <input style="width:5%;" name="quantity" type="number" min="1" value=<%=bean.getTaglie().getQuantitaM()%> ><br>
						Taglia L: <input style="width:5%;" name="quantity" type="number" min="1" value=<%=bean.getTaglie().getQuantitaL()%>><br>
						Taglia XL: <input style="width:5%;" name="quantity" type="number" min="1" value=<%=bean.getTaglie().getQuantitaXL()%>><br>
						Taglia XXL: <input style="width:5%;" name="quantity" type="number" min="1" value=<%=bean.getTaglie().getQuantitaXXL()%>><br>
						</h5>
					</label>
				</h4>
				

				<h4>
					<label>
						Statistiche: <br>
						<textarea  style="width:40%;" cols="100" name="descrizione" maxlength="1000" rows="10" required placeholder="enter description">
						<%= bean.getStats() %>
						</textarea><br>
					</label>
				</h4>
				<br>
				<br>
				<div class="buttons">
				<input class="submitButton" type="submit" value="Add"><input class="resetButton" type="reset" value="Reset">
				</div>
			</form>
	    	</div>
	  	</div>
		</div>
	</div>
</body>
</html>