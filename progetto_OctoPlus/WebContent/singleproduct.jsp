<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
 	ProductBean bean = (ProductBean) request.getAttribute("product");
	
 	SizesBean sizes = (SizesBean) bean.getTaglie();
 	Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
 	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
 	boolean nondisponibile = false;
%>
<!DOCTYPE html>
<html>
<%@ page import="java.util.*,it.model.ProductBean, it.model.SizesBean, it.unisa.DaoDataSource"%>
<head>
<link rel="stylesheet" href="./product.css">
<title>Visualizzazione prodotto</title>
<script> 
	function getSizeValue(){
		var selectedValue = document.getElementById("size").value;
		console.log(selectedValue);	
		return selectedValue;
	}
	function getQuantityValue(){
		var selectedValue = document.getElementById("quantity").value;
		console.log(selectedValue);	
		return selectedValue;
	}
	
	function addValuesToLink(){
		var link = document.getElementById("link");	
		link.href=link.href.substring(0, 80);
		console.log(link.href+="&qnt0=");
		console.log(link.href+=document.getElementById("quantity").value);
		console.log(link.href+="&sz0=");
		console.log(link.href+=document.getElementById("size").value);
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<div class="flex-box">
		<div class="left">
			<div class="img">
				<img src="./getPicture?id=<%=bean.getCode()%>" onerror="this.src='./img/nophoto.png'" style=" width: 450px;">
			</div>
		</div>
		<div class="right">
			<div class="url"> Home > Store > Product </div>
			<div class="pname"> <%=bean.getNome()%> </div>
			<br>
			<h2> <%=bean.getCategoria()%> </h2>
			<br>
			<div class="price"> $<%=bean.getPrice()%> </div> 
			<% if( (sizes.getQuantitaM() == 0 && sizes.getQuantitaM() == 0 && sizes.getQuantitaXL() == 0 && sizes.getQuantitaXXL() == 0) || sizes == null) {
				nondisponibile = true;%>
				<p style="color: red"> Prodotto momentaneamente non disponibile! </p>
			<% } else {%>
			Seleziona taglia:
			<select id="size" onChange="getSizeValue();">	
				<% if( sizes.getQuantitaM() > 0 ){ %>
					<option value="M"> M </option>
				<%} %>	
				<% if( sizes.getQuantitaL() >0 ){ %>
					<option value="L"> L </option>
				<%} %>	
				<% if( sizes.getQuantitaXL()>0 ){ %>
					<option value="XL"> XL </option>
				<%} %>	
				<% if( sizes.getQuantitaXXL()>0 ){ %>
					<option value="XXL"> XXL </option>
				<%} }%>	
			</select>
			<br>
			<br>
			<% if( nondisponibile ){ %>
				<p style="color: red"> Acquisto momentaneamente non disponibile! </p>
			<%} else { %>	
				<div class="quantiy">	
					<p> Quantita': 
					<input id="quantity" type="number" min="1" max="100" value="1" onChange="getQuantityValue()">
					</p>
				</div>
				<br>
				<div class="btn-box">
					<a href="cart.jsp?id=<%=bean.getCode()%>" class="cart-btn"> Aggiungi al Carrello </a>
					<a id="link" onClick="addValuesToLink();" href="OrderControl?action=read&fromStore=get2&id=<%=bean.getCode()%>" class="buy-btn"> Compra adesso </a>
				<%	
					if( isAdmin == null );
					else if( isAdmin == true ){ %>
						<a href="product?action=read&fromStore=modify&id=<%=bean.getCode()%>" class="modify-btn" onClick="functionAlert()"> Modifica </a>
				<%	}	%>	
				</div>
			<% }%>
			<br>
			
			<h3 style="color: red;">
			<%
				List<String> errors = (List<String>) request.getAttribute("errors");
				if (errors != null){
					for (String error: errors){ %>
						<%=error %> <br>		
					<%
					}
				}
			%>
			</h3>
			<div>
			<h3> Dettagli prodotto</h3>
			<p align="left">
			<%=bean.getDescrizione()%>		
			</p>
			<h3> Statistiche </h3>
			<p align="right">
			<%=bean.getStats()%>
			</p>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<jsp:include page="footer.jsp" flush="true"/>
	<% if( errors != null)
			errors.clear();
	%>	
</body>
</html>