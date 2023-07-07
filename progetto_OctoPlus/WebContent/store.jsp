<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        
<!DOCTYPE html>
<html>
<%@ page import="java.util.*, it.model.*"%>
<script src="scripts/store.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function(){
		dynamicStore("<%=request.getContextPath()%>/StoreServlet");
	});	
</script>

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
  <select id="categoria-select" onchange="searchAndFilter()">
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
 		<div class="container" id="prodotti"> 		
 		</div>		
	</section>
	<jsp:include page="footer.jsp" flush="true"/>		
</body>
</html>
