<!DOCTYPE html>
<%
 	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
	if( isSomeoneLogged == null ){
		response.sendRedirect("../login.jsp");	
		return;
	}
%>
<html>
<head>
  <title>Elenco Ordini</title>
  <link rel="stylesheet" type="text/css" href="./orderview.css">
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="../scripts/orders.js"></script>
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
		  <label for="categoria-select">Categoria:</label>
		  <select id="categoria-select" onchange="searchAndFilter()">
		    <option value="">Tutte</option>
		    <option value="Coltelli">Coltelli</option>
		    <option value="Erogatori">Erogatori</option>
		    <option value="Guanti">Guanti</option>
		    <option value="Maschere">Maschere</option>
		    <option value="Mute">Mute</option>
		    <option value="Pinne">Pinne</option>
		    <option value="Torce">Torce</option>
		  </select>
		</div>
	  
	  <form action="#" method="get" class="search-form">
    			<input type="text" id="search-input" onkeyup="searchAndFilter()" placeholder="Cerca..." class="search-input">
     			<button type="submit" onClick="searchAndFilter()" class="search-button"><i class='bx bx-search'></i></button>
  	  </form>
	</nav>
	
  <h1>Elenco Ordini</h1>
  <div class="orders-container" id="orders">   
  </div>
  <div id="bottom">
  </div>
</body>
</html>
