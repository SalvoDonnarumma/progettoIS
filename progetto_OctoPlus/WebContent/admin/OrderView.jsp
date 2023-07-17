<!DOCTYPE html>
<%
	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
	if( (isSomeoneLogged == null) || !isSomeoneLogged ){
		response.sendRedirect(request.getContextPath()+"/login.jsp");	
		return;
	}
%>
<html lang="it">
<head>
  <title>Elenco Ordini</title>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/orderview.css">
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="<%=request.getContextPath()%>/scripts/orders.js"></script>
  <script src="<%=request.getContextPath()%>/scripts/filteredsearch.js"></script>
  <script>
		$(document).ready(function(){
			dynamicOrdersView("<%=request.getContextPath()%>/OrderServlet");
		});	
  </script> 
  <jsp:include page="../header.jsp" flush="true"/>
</head>

<body>
	<nav class="topnav">
		<div class="dropdown">
		  <label for="categoria-select">Data inizio:</label>
		  <input type="date" id="dateinit" onChange="searchAndFilterOrders()">
		  <label for="categoria-select">&nbsp&nbspData fine:</label>
		  <input type="date" id="dateend" onChange="searchAndFilterOrders()">
		</div>
	  
	  <form action="#" method="get" class="search-form">
    	  <input type="text" id="search-input" onkeyup="searchAndFilterOrders()" placeholder="Cerca ordine di un cliente via email..." class="search-input">
     	  <button type="submit" onClick="searchAndFilterOrders()" class="search-button"><i class='bx bx-search'></i></button>
  	  </form>
	</nav>
	
  <h1 style="color: #853411; text-align:left;" >Elenco Ordini</h1>
  <div class="orders-container" id="orders">   
  </div>
  <div id="bottom">
  </div>
  <br>
	<a href="admin/UserView.jsp" class="no-border-link"> Pagina visualizzazione utenti </a>
	<br>
	<a href="admin/ProductView.jsp" class="no-border-link"> Pagina visualizzazione prodotti </a>
	<br>
	<br>
</body>
</html>
