<!DOCTYPE html>
<%
	ProductBean bean = (ProductBean) request.getAttribute("product");
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	String size = (request.getParameter("size"));
 	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
 	UserBean user = (UserBean) request.getSession().getAttribute("logged");
	if( isSomeoneLogged == null ){
		response.sendRedirect("./login.jsp");	
		return;
	}
	
	
%>
<%@ page import="java.util.*,it.model.ProductBean, it.unisa.DaoDataSource, it.model.UserBean, it.unisa.Cart"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="purchase.css">
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<div class="big_container">
	<h2 style="align: center;">Da voler acquistare: </h2>
	<br>
		<div class="col-25">
	    <!--
	      <h4>Ordini:  <span class="price" style="color:black"><i class="fa fa-shopping-cart"></i> <b>4</b></span></h4>
	      <p><a href="#">Product 1</a> <span class="price">$15</span></p>
	      <p><a href="#">Product 2</a> <span class="price">$5</span></p>
	      <p><a href="#">Product 3</a> <span class="price">$8</span></p>
	      <p><a href="#">Product 4</a> <span class="price">$2</span></p>
	      <hr>
	      <p>Total <span class="price" style="color:black"><b>$30</b></span></p>
	     --> 
	     	<div class="box1">
			     <h3><%=bean.getNome()%></h3>
		 			<a href="product?action=read&fromStore=get&id=<%=bean.getCode()%>&">
		 			<img src="./getPicture?id=<%=bean.getCode()%>" onerror="this.src='./img/nophoto.png'">
		 			</a>
		 			<h4> Categoria: <%=bean.getCategoria()%> </h4>
		 			<h5> <span class="price"> Prezzo: <%=bean.getPrice()*Integer.parseInt(request.getParameter("quantity"))%></span> </h5>
		 			<h4> Taglia: <%=request.getParameter("size")%> Quantita': <%=request.getParameter("quantity")%> </h4>
		    </div>
	    </div>
	 <br>
	 <br> 	
	<h2 style="align: center;">Conferma acquisto</h2>
	<br>
	<div class="row">
	  <div class="col-75">
	    <div class="container">
	      <form action="OrderControl?fromStore=true&action=purchaseOne&id=<%=bean.getCode()%>&size=<%=size%>&quantity=<%=quantity%>" method="post">
	        <div class="row">
	          <div class="col-50">
	            <h3>Billing Address</h3>
	            <label for="fname"><i class="fa fa-user"></i> Nome completo</label>
	            <input type="text" id="fname" name="firstname" placeholder="Jonathan Joestar">
	            
	            <div class="txt_field email-field">
	            <label for="email"><i class="fa fa-envelope"></i> Email</label>
	            <input type="email" id="email" name="email" required onchange="validateFormElem(this, document.getElementById('errorEmail'), emailErrorMessage)" id="email" placeholder="killerQueen@gmail.com">
    			<span id="errorEmail" class="error-text"></span>
    			</div>
    			
	            <label for="adr"><i class="fa fa-address-card-o"></i> Indirizzo </label>
	            <input type="text" id="adr" name="indirizzo" placeholder="Via XXXXXX, YYY">
	            
	            <label for="city"><i class="fa fa-institution"></i> Citta' </label>
	            <input type="text" id="city" name="city" placeholder="Morioh Cho">
	
	            <div class="row">
	              <div class="col-50">
	                <label for="state">Stato</label>
	                <input type="text" id="state" name="state" placeholder="JJ">
	              </div>
	              <div class="col-50">
	                <label for="zip">CAP</label>
	                <input type="text" id="cap" name="cap" placeholder="10001">
	              </div>
	            </div>
	          </div>
	
	          <div class="col-50">
	            <h3>Pagamento</h3>
	            <label for="fname">Carte Accettate</label>
	            <div class="icon-container">
	              <i class="fa fa-cc-visa" style="color:navy;"></i>
	              <i class="fa fa-cc-amex" style="color:blue;"></i>
	              <i class="fa fa-cc-mastercard" style="color:red;"></i>
	              <i class="fa fa-cc-discover" style="color:orange;"></i>
	            </div>
	            <label for="cname">Nome sulla carta</label>
	            <input type="text" id="cname" name="cardname" placeholder="Giorno Giovanna">
	            <label for="ccnum">Numero di carta di credito</label>
	            <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444">
	            <label for="expmonth">Mese di scadenza</label>
	            <input type="text" id="expmonth" name="expmonth" placeholder="Settembre">
	            <div class="row">
	              <div class="col-50">
	                <label for="expyear">Anno di scadenza</label>
	                <input type="text" id="expyear" name="expyear" placeholder="2018">
	              </div>
	              <div class="col-50">
	                <label for="cvv">CVV</label>
	                <input type="text" id="cvv" name="cvv" placeholder="352">
	              </div>
	            </div>
	          </div>
	        </div>
	        <label>
	          <input type="checkbox" checked="checked" name="sameadr"> Indirizzo di spedizione uguale a quello di fatturazione
	        </label>
	        <input type="submit" value="Continue to checkout" class="btn">
	      </form>
	    </div>
	  </div>
		</div>
	</div>
</body>
</html>
