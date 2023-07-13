<!DOCTYPE html>
<%
	Collection <?> products = (Collection<?>) request.getAttribute("products");
	ProductBean bean = null;
	String size = null;
	Integer quantity = null;
	List<String>sizes = new ArrayList<>();
	List<Integer>qnts = new ArrayList<>();
 	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
 	UserBean user = (UserBean) request.getSession().getAttribute("logged");
	if( isSomeoneLogged == null ){
		response.sendRedirect("./login.jsp");	
		return;
	}	
%>
<%@ page import="java.util.*,it.model.ProductBean, it.unisa.DaoDataSource, it.model.UserBean"%>
<html>
<head>
<title> Acquisto-OctoPlus </title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/purchase.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="scripts/validate.js"></script>
<script type="text/javascript">
	function checkCAPLength(){
		var pass = document.getElementById("cap");
		if( pass.value.length != 5){
			$("#errorCAP").empty();
			$("#errorCAP").append("<style=\"color: red;\">Questo campo deve contenere 5 caratteri</style>");
		} else 
			$("#errorCAP").empty();
		if(  pass.value.length == 0 )
			$("#errorCAP").empty();
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true"/>
	<div class="big_container">
	<h2 style="align: center;">Da voler acquistare: </h2>
	<br>
	<div class="col-25">
	    <%if( products.size()>1) {
	    	int i = 0;
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					sizes.add((request.getParameter("sz"+i))); /*mi servirà nella servlet per verificare se 
					l'acquisto di ogni prodotto nel carrello è possbile effettuarlo opppure no*/
					qnts.add(Integer.parseInt(request.getParameter("qnt"+i)));
					bean = (ProductBean) it.next(); %>
			<div class="box1">		
			     	<h3><%=bean.getNome()%></h3>
		 			<a href="product?action=read&fromStore=get&id=<%=bean.getCode()%>&">
		 			<img src="./getPicture?id=<%=bean.getCode()%>" onerror="this.src='./img/nophoto.png'">
		 			</a>
		 			<h4> Categoria: <%=bean.getCategoria()%> </h4>
		 			<h4> Taglia: <%=request.getParameter("sz"+i)%> Quantita': <%=request.getParameter("qnt"+i)%> </h4>
			</div>
	  <% 	i++;	}	
			request.getSession().removeAttribute("sizes");
			request.getSession().setAttribute("sizes", sizes);
			request.getSession().removeAttribute("qnts");
			request.getSession().setAttribute("qnts", qnts);
			} %>
	    <%} else {	
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					bean = (ProductBean) it.next(); %>
			<div class="box1">		
			     	<h3><%=bean.getNome()%></h3>
		 			<a href="product?action=read&fromStore=get&id=<%=bean.getCode()%>&">
		 			<img src="./getPicture?id=<%=bean.getCode()%>" onerror="this.src='./img/nophoto.png'">
		 			</a>
		 			<h4> Categoria: <%=bean.getCategoria()%> </h4>
		 			<h5> <span class="price"> Prezzo: <%=bean.getPrice()*Integer.parseInt(request.getParameter("qnt0"))%></span> </h5>
		 			<h4> Taglia: <%=request.getParameter("sz0")%> Quantita': <%=request.getParameter("qnt0")%> </h4>
			</div>
	  <% 		} 
		   } 
	     } %>
	</div>
	<h3> Prezzo dell'ordine: <%= request.getParameter("tot")%>&euro; </h3>	   
	 <br>
	 <br> 	
	<h2 style="align: center;">Conferma acquisto</h2>
	<br>
	<div class="row">
	  <div class="col-75">
	    <div class="container">
		<%if( products.size()>1) {%>
	    	 <form action="OrderControl?fromStore=true&action=purchaseAll&tot=<%= request.getParameter("tot")%>" method="post">
	    	 <div class="row">
	          <div class="col-50">
	            <h3>Billing Address</h3>
	            <label for="fname"><i class="fa fa-user"></i> Nome completo</label>
	            <input type="text" id="firstname" name="firstname" placeholder="Jonathan Joestar" required pattern="[A-Za-zÀ-ÿ\s]+"
	            onkeyup="validateFormElem(this, document.getElementById('errorName'), nameOrLastnameErrorMessage)">
			 	<span id="errorName"> </span>
	            
	            <div class="txt_field email-field">
	            <label for="email"><i class="fa fa-envelope"></i> Email</label>
	            <input type="email" id="email" name="email" required onchange="validateFormElem(this, document.getElementById('errorEmail'), emailErrorMessage)" 
	            id="email" placeholder="killerQueen@gmail.com">
    			<span id="errorEmail" class="error-text"></span>
    			</div>
    			
	            <label for="adr"><i class="fa fa-address-card-o"></i> Indirizzo </label>
	            <input type="text" id="adr" name="indirizzo" placeholder="Via XXXXXX, YYY" required pattern="^Via .+, \d+$"
	            onchange="validateFormElem(this, document.getElementById('errorAdr'), formatErrorMessage)" >
	            <span id="errorAdr" class="error-text"></span>
	            
	            <label for="city"><i class="fa fa-institution"></i> Citta' </label>
	            <input type="text" id="city" name="city" placeholder="Morioh Cho" required pattern="[A-Za-zÀ-ÿ\s]+"
	            onkeyup="validateFormElem(this, document.getElementById('errorCity'), nameOrLastnameErrorMessage)">
			 	<span id="errorCity"> </span>
				
	            <div class="row">
	              <div class="col-50">
	                <label for="state">Stato</label>
	                <input type="text" id="state" name="state" placeholder="JJ" required pattern="^[A-Za-z]+$"
	           		 onkeyup="validateFormElem(this, document.getElementById('errorState'), nameOrLastnameErrorMessage)">
			 		<span id="errorState"> </span>
	              </div>
	              <div class="col-50">
	                <label for="zip">CAP</label>
	                <input type="text" id="cap" name="cap" placeholder="10001" required pattern="\d{5}"
	                required onChange="checkCAPLength()" onkeyup="validateFormElem(this, document.getElementById('errorCAP'), formatErrorMessage)">
			 		<span id="errorCAP"> </span>
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
	            <input type="text" id="cname" name="cardname" placeholder="Giorno Giovanna" required pattern="[A-Za-zÀ-ÿ\s]+"
	            onkeyup="validateFormElem(this, document.getElementById('errorNameC'), nameOrLastnameErrorMessage)">
			 	<span id="errorNameC"> </span>
	            <label for="ccnum">Numero di carta di credito</label>
	            <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444" required
	            pattern="\d{4}-\d{4}-\d{4}-\d{4}" onChange="validateFormElem(this, document.getElementById('errorNumberC'), formatErrorMessage)">
			 	<span id="errorNumberC"> </span>
	            <label for="expmonth">Mese di scadenza</label>
	            <input type="text" id="expmonth" name="expmonth" placeholder="Settembre"  required
	            pattern="[A-Za-z]+" onChange="validateFormElem(this, document.getElementById('errorMonthC'), nameOrLastnameErrorMessage)">
			 	<span id="errorMonthC"> </span>
	            <div class="row">
	              <div class="col-50">
	                <label for="expyear">Anno di scadenza</label>
	                <input type="text" id="expyear" name="expyear" placeholder="2018" required pattern="\d{4}"
	                onChange="validateFormElem(this, document.getElementById('errorEXPC'), formatErrorMessagge)">
			 		<span id="errorEXPC"> </span>
	              </div>
	              <div class="col-50">
	                <label for="cvv">CVV</label>
	                <input type="text" id="cvv" name="cvv" placeholder="352" required pattern="\d{3}"
	                onChange="validateFormElem(this, document.getElementById('errorCVV'), formatErrorMessagge)">
			 		<span id="errorCVV"> </span>
	              </div>
	            </div>
	          </div>
	        </div>
	        <label>
	          <input type="checkbox" checked="checked" name="sameadr"> Indirizzo di spedizione uguale a quello di fatturazione
	        </label>
	        <input type="submit" value="Continue to checkout" class="btn">
	      </form>
	    <%} else { %>
	    	<form action="OrderControl?fromStore=true&action=purchaseOne&id=<%=bean.getCode()%>&sz=<%=request.getParameter("sz0")%>&qnt=<%=request.getParameter("qnt0")%>" method="post">
	    	<div class="row">
	          <div class="col-50">
	            <h3>Billing Address</h3>
	            <label for="fname"><i class="fa fa-user"></i> Nome completo</label>
	            <input type="text" id="firstname" name="firstname" placeholder="Jonathan Joestar" required pattern="[A-Za-zÀ-ÿ\s]+"
	            onkeyup="validateFormElem(this, document.getElementById('errorName'), nameOrLastnameErrorMessage)">
			 	<span id="errorName"> </span>
	            
	            <div class="txt_field email-field">
	            <label for="email"><i class="fa fa-envelope"></i> Email</label>
	            <input type="email" id="email" name="email" required onchange="validateFormElem(this, document.getElementById('errorEmail'), emailErrorMessage)" 
	            id="email" placeholder="killerQueen@gmail.com">
    			<span id="errorEmail" class="error-text"></span>
    			</div>
    			
	            <label for="adr"><i class="fa fa-address-card-o"></i> Indirizzo </label>
	            <input type="text" id="adr" name="indirizzo" placeholder="Via XXXXXX, YYY" required pattern="^Via .+, \d+$"
	            onchange="validateFormElem(this, document.getElementById('errorAdr'), formatErrorMessage)" >
	            <span id="errorAdr" class="error-text"></span>
	            
	            <label for="city"><i class="fa fa-institution"></i> Citta' </label>
	            <input type="text" id="city" name="city" placeholder="Morioh Cho" required pattern="[A-Za-zÀ-ÿ\s]+"
	            onkeyup="validateFormElem(this, document.getElementById('errorCity'), nameOrLastnameErrorMessage)">
			 	<span id="errorCity"> </span>
				
	            <div class="row">
	              <div class="col-50">
	                <label for="state">Stato</label>
	                <input type="text" id="state" name="state" placeholder="JJ" required pattern="^[A-Za-z]+$"
	           		 onkeyup="validateFormElem(this, document.getElementById('errorState'), nameOrLastnameErrorMessage)">
			 		<span id="errorState"> </span>
	              </div>
	              <div class="col-50">
	                <label for="zip">CAP</label>
	                <input type="text" id="cap" name="cap" placeholder="10001" required pattern="\d{5}"
	                required onChange="checkCAPLength()" onkeyup="validateFormElem(this, document.getElementById('errorCAP'), formatErrorMessage)">
			 		<span id="errorCAP"> </span>
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
	            <input type="text" id="cname" name="cardname" placeholder="Giorno Giovanna" required pattern="[A-Za-zÀ-ÿ\s]+"
	            onkeyup="validateFormElem(this, document.getElementById('errorNameC'), nameOrLastnameErrorMessage)">
			 	<span id="errorNameC"> </span>
	            <label for="ccnum">Numero di carta di credito</label>
	            <input type="text" id="ccnum" name="cardnumber" placeholder="1111-2222-3333-4444" required
	            pattern="\d{4}-\d{4}-\d{4}-\d{4}" onChange="validateFormElem(this, document.getElementById('errorNumberC'), formatErrorMessage)">
			 	<span id="errorNumberC"> </span>
	            <label for="expmonth">Mese di scadenza</label>
	            <input type="text" id="expmonth" name="expmonth" placeholder="Settembre"  required
	            pattern="[A-Za-z]+" onChange="validateFormElem(this, document.getElementById('errorMonthC'), nameOrLastnameErrorMessage)">
			 	<span id="errorMonthC"> </span>
	            <div class="row">
	              <div class="col-50">
	                <label for="expyear">Anno di scadenza</label>
	                <input type="text" id="expyear" name="expyear" placeholder="2018" required pattern="\d{4}"
	                onChange="validateFormElem(this, document.getElementById('errorEXPC'), formatErrorMessagge)">
			 		<span id="errorEXPC"> </span>
	              </div>
	              <div class="col-50">
	                <label for="cvv">CVV</label>
	                <input type="text" id="cvv" name="cvv" placeholder="352" required pattern="\d{3}"
	                onChange="validateFormElem(this, document.getElementById('errorCVV'), formatErrorMessagge)">
			 		<span id="errorCVV"> </span>
	              </div>
	            </div>
	          </div>
	        </div>
	        <label>
	          <input type="checkbox" checked="checked" name="sameadr"> Indirizzo di spedizione uguale a quello di fatturazione
	        </label>
	        <input type="submit" value="Continue to checkout" class="btn">
	      </form>
	    <%       }%>  
	        
	    </div>
	  </div>
		</div>
	</div>
</body>
</html>
