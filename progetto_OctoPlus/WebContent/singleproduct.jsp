<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
	ProductBean bean = (ProductBean) request.getAttribute("product"); 		
%>
<!DOCTYPE html>
<html>
<%@ page import="java.util.*,it.model.ProductBean, it.unisa.DaoDataSource, it.unisa.Cart"%>
<head>
<link rel="stylesheet" href="product.css">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="header.jsp" flush="true"/>

<script> 
	function getSelectedValue(){
		var selectedValue = document.getElementById("selectDaVerificare").value;
		console.log(selectedValue);	
	}
	
	function getQuantityValue(){
		var selectedValue = document.getElementById("quantity").value;
		console.log(selectedValue);		
	}
</script>
</head>
<body>
	<div class="flex-box">
		<div class="left">
			<div class="img">
				<img src="./getPicture?id=<%=bean.getCode()%>" onerror="this.src='./img/nophoto.png'">
			</div>
		</div>
		<div class="right">
			<div class="url"> Home > Store > Product </div>
			<div class="pname"> <%=bean.getNome()%> </div>
			<br>
			<h2> <%=bean.getCategoria()%> </h2>
			<br>
			<div class="price"> $<%=bean.getPrice()%> </div>
			Seleziona taglia: <select id="selectDaVerificare" onChange="getSelectedValue();">
				<option value="M"> M </option>
				<option value="L"> L </option>
				<option value="XL"> XL </option>
				<option value="XXL"> XXL </option>
			</select>
			<div class="quantiy">
				<p> Quantità: 
				<input id="quantity" type="number" min="1" max="100" value="1" onChange="getQuantityValue()">
				</p>
			</div>
			<div class="btn-box">
				<button class="cart-btn" onClick="#"> Aggiungi al Carrello </button>
				<button class="buy-btn"> Compra adesso </button>
			</div>
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
	<jsp:include page="footer.jsp" flush="true"/>	
</body>
</html>