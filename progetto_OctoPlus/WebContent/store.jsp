<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	Collection<?> products = (Collection<?>) request.getAttribute("products");
	UserBean user = (UserBean) request.getSession().getAttribute("logged");
	if( user != null )
		System.out.println("Ti sei loggato come: "+user);
	else
		System.out.println("Ti sei loggato come utente ospite");
	
	if(products == null) {
		response.sendRedirect("./product?fromStore=true");
		return;
	}
	ProductBean product = (ProductBean) request.getAttribute("product");
	
	Cart cart = (Cart) request.getAttribute("cart");
%>     
<!DOCTYPE html>
<html>
<%@ page import="java.util.*,it.model.ProductBean,it.model.UserBean, it.model.SizesBean, it.unisa.Cart"%>
<head>
<meta charset="ISO-8859-1">
	<title>OCTOPLUS</title>
	<link rel="stylesheet" type="text/css" href="./store.css">	
	<link rel="stylesheet"
  href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
</head>
<body>
	<!-- header start -->
	<jsp:include page="header.jsp" flush="true"/>
 	
 	<nav class="topnav">
  <div class="dropdown">
    <label for="categoria-select">Categoria:</label>
    <select id="categoria-select">
      <option value="">Tutte</option>
      <option value="coltelli">Coltelli</option>
      <option value="erogatori">Erogatori</option>
      <option value="guanti">Guanti</option>
      <option value="maschere">Maschere</option>
      <option value="mute">Mute</option>
      <option value="pinne">Pinne</option>
      <option value="torce">Torce</option>
    </select>
  </div>

  <div class="dropdown">
    <label for="prezzo-select">Prezzo:</label>
    <select id="prezzo-select">
      <option value="">Tutti</option>
      <option value="0-25">0-25</option>
      <option value="25-50">25-50</option>
      <option value="50-100">50-100</option>
      <option value="100-150">100-150</option>
      <option value="150-200">150-200</option>
      <option value="200-300">200-300</option>
      <option value="300+">300+</option>
    </select>
  </div>
</nav>



 	<!-- shop start -->
 	<section class="shop" id="shop">
 		<div class="container"> 		
 			<%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
					SizesBean sizes = (SizesBean) bean.getTaglie();
		%>
 			<div class="box1">
 			
 				<h3><%=bean.getNome()%></h3>
 				<a href="product?action=read&fromStore=get&id=<%=bean.getCode()%>">
 				<img src="./getPicture?id=<%=bean.getCode()%>" onerror="this.src='./img/nophoto.png'">
 					</a>
 				<h4> Categoria: <%=bean.getCategoria()%> </h4>
 				<h5> Costo: <%=bean.getPrice()%> &euro; </h5>
 			<% if( (sizes.getQuantitaM() == 0 && sizes.getQuantitaM() == 0 && sizes.getQuantitaXL() == 0 && sizes.getQuantitaXXL() == 0) || sizes == null){ %>
				<p style="color: red"> Prodotto Esaurito! </p>
			<% } else {%>
				<div class="cart">
 					<a href="#"><i class='bx bx-cart-add'></i></a>
 				</div>
				<%}%>	
 			</div>	
 		<%
				}
			} 
 		%>
 		</div>		
	</section>
	<script>// Funzione per gestire il cambio selezione delle opzioni->non funziona, rimuove tutti i prodotti
	function handleSelectChange() {
		  var categoriaSelect = document.getElementById('categoria');
		  var prezzoSelect = document.getElementById('prezzo');
		  
		  var categoriaValue = categoriaSelect.value;
		  var prezzoValue = prezzoSelect.value;

		  console.log('Categoria selezionata:', categoriaValue);
		  console.log('Prezzo selezionato:', prezzoValue);

		
		  updateResults(categoriaValue, prezzoValue);
		}

		
		var categoriaSelect = document.getElementById('categoria-select');
		categoriaSelect.addEventListener('change', handleSelectChange);

		var prezzoSelect = document.getElementById('prezzo-select');
		prezzoSelect.addEventListener('change', handleSelectChange);

	
		function updateResults(categoria, prezzo) {
		  
		  var prodotti = document.getElementsByClassName('box1');
		  for (var i = 0; i < prodotti.length; i++) {
		    var prodotto = prodotti[i];
		    var categoriaProdotto = prodotto.getAttribute('categoria');
		    var prezzoProdotto = prodotto.getAttribute('prezzo');

		    if ((categoria === '' || categoria === categoriaProdotto) &&
		        (prezzo === '' || prezzo === prezzoProdotto)) {
		      prodotto.style.display = 'block';
		    } else {
		      prodotto.style.display = 'none';
		    }
		  }
		}
</script>
	<jsp:include page="footer.jsp" flush="true"/>		
</body>
</html>
