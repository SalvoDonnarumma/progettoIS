<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
	ProductBean bean = (ProductBean) request.getAttribute("product"); 
 	SizesBean sizes = (SizesBean) bean.getTaglie();
 	boolean nondisponibile = false;
%>
<!DOCTYPE html>
<html>
<%@ page import="java.util.*,it.model.ProductBean, it.model.SizesBean, it.unisa.DaoDataSource, it.unisa.Cart"%>
<head>
<link rel="stylesheet" href="product.css">
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
		link.href=link.href.substring(0, 75);
		console.log(link.href+="&quantity=");
		console.log(link.href+=document.getElementById("quantity").value);
		console.log(link.href+="&size=");
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
					<a href="#" class="cart-btn" onClick="#"> Aggiungi al Carrello </a>
					<a id="link" onClick="addValuesToLink();" href="product?action=read&fromStore=get2&id=<%=bean.getCode()%>" class="buy-btn"> Compra adesso </a>
				</div>
			<% }%>
			<br>
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
</body>
</html>