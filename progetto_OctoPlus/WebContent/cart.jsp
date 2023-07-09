<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
 	Collection<?> products = (Collection<?>) request.getSession().getAttribute("products");
%>
<!DOCTYPE html>
<html>
<%@ page import="java.util.*,it.model.ProductBean, it.model.SizesBean, it.model.CartBean, it.unisa.DaoDataSource"%>
<head>
  <title>Carrello - OctoPlus</title>
  <link rel="stylesheet" type="text/css" href="cart.css">
  <link rel="stylesheet"
  href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="scripts/cart.js"></script>
<script>
	$(document).ready(function(){
		dynamicCart("<%=request.getContextPath()%>/CartServlet?id=<%=request.getParameter("id")%>");
	});	
</script>    
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<h2>Carrello:</h2> <br>
  <div class="container ">
    <table>
      <thead>
        <tr>
          <th>Prodotto</th>
          <th>Categoria</th>
          <th>Quantità</th>
          <th>Taglia</th>
          <th>Prezzo unitario</th>
          <th>Subtotale</th>
          <th>Elimina prodotto</th>
        </tr>
      </thead>
      <tbody id="cart">
    
      </tbody>
    </table>         

    <div class="checkout" id="checkout">
    </div>
  </div>

  <jsp:include page="footer.jsp" flush="true"/>
</body>
</html>
