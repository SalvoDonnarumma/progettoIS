<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
 	Collection<?> products = (Collection<?>) request.getSession().getAttribute("products");
%>
<!DOCTYPE html>
<html>
<%@ page import="java.util.*,it.model.ProductBean, it.model.SizesBean, it.model.CartBean, it.unisa.DaoDataSource, it.unisa.Cart"%>
<head>
  <title>Carrello - OctoPlus</title>
  <link rel="stylesheet" type="text/css" href="cart.css">
 <script src="./Script/dynamicCode.js"></script>
<script>
	document.addEventListener("DOMContentLoaded", dynamicCart("<%=request.getContextPath()%>/CartServlet?isbn=<%=request.getParameter("isbn")%>"));
</script>
<script>
	function updateSubtotal(input) {
		  var quantity = parseInt(input.value);
		  var price = 10; 
	
		  var subtotal = quantity * price;
	
		  var subtotalCell = input.parentNode.nextElementSibling;
		  subtotalCell.textContent = '$' + subtotal.toFixed(2);
		}
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
          <th>Quantità</th>
          <th>Taglia</th>
          <th>Prezzo unitario</th>
          <th>Subtotale</th>
          <th>Azioni</th>
        </tr>
      </thead>
      <tbody>
      <%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
					SizesBean sizes = bean.getTaglie();
		%>
        <!-- Ciclo per ogni prodotto nel carrello -->
        <tr>
          <td><%= bean.getNome() %> </td>
          <td> <input type="number" value="1" min="1" max="10" /> </td>
          <td> <select id="size" onChange="getSizeValue();">	
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
				<%} %>	
			</select> <td>
          <td> <%= bean.getPrice() %> </td>
          <td>Subtotale</td>
          <td>
            <button>Modifica</button>
            <button>Rimuovi</button>
          </td>
        </tr>
        <!-- Fine del ciclo -->
        <% 		}
			} else {
		%>
		<tr>
			<td colspan="6">No products available</td>
		</tr>
		<%
			}
		%>
        
      </tbody>
      <tfoot>
        <tr>
          <td colspan="4"></td>
          <td>Totale</td>
          <td>Totale carrello</td>
        </tr>
      </tfoot>
    </table>

    <div class="checkout">
      <button>Procedi al pagamento</button>
    </div>
  </div>

  <jsp:include page="footer.jsp" flush="true"/>
</body>
</html>
