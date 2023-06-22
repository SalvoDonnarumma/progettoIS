<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>OCTOPLUS</title>
	<link rel="stylesheet" type="text/css" href="store.css?ts=<%= System.currentTimeMillis() %>">	
	<link rel="stylesheet"
  href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
</head>
<body>
	<!-- header start -->
	<jsp:include page="header.jsp" flush="true"/>
 	
 	
 	<!-- shop start -->
 	
 <!-- 	<section class="shop" id="shop">
  <div class="container">
    <% for (int i = 1; i <= 7; i++) { %>
    <div class="box1">
      <img src="img/nophoto.png">
      <h4>I'm a product</h4>
      <h5>$15.50</h5>
      <div class="cart">
        <a href="#"><i class='bx bx-cart-add'></i></a>
      </div>
    </div>
    <% } %>
  </div>
-->
 	
 	
 	<section class="shop" id="shop">
 		<div class="container">
 			<div class="box1">
 			<a href="#">    <!-- si collegherà alla pagina di visualizzazione dettagliata -->
 				<img src="img/nophoto.png">
 					</a>
 				<h4>Product 1</h4>
 				<h5>$15.50</h5>
 				<div class="cart">
 					<a href="#"><i class='bx bx-cart-add'></i></a>
 				</div>
 			
 			</div>
 		
 			<div class="box1">
 				<a href="#">
 				<img src="img/nophoto.png">
 					</a>
 				<h4>Product 2</h4>
 				<h5>$19.99</h5>
 				<div class="cart">
 					<a href="#"><i class='bx bx-cart-add'></i></a>
 				</div>
 			</div>
 			
 			<div class="box1">
 				<a href="#">
 				<img src="img/nophoto.png">
 					</a>
 				<h4>Product 3</h4>
 				<h5>$12.99</h5>
 				<div class="cart">
 					<a href="#"><i class='bx bx-cart-add'></i></a>
 				</div>
 			</div>
 			
 			<div class="box1">
 				<img src="img/nophoto.png">
 				<h4>Product 4</h4>
 				<h5>$24.99</h5>
 				<div class="cart">
 					<a href="#"><i class='bx bx-cart-add'></i></a>
 				</div>
 			</div>
 			
 			<div class="box1">
 				<img src="img/nophoto.png">
 				<h4>Product 5</h4>
 				<h5>$9.99</h5>
 				<div class="cart">
 					<a href="#"><i class='bx bx-cart-add'></i></a>
 				</div>
 			</div>
 			
 			<div class="box1">
 				<img src="img/nophoto.png">
 				<h4>Product 6</h4>
 				<h5>$17.99</h5>
 				<div class="cart">
 					<a href="#"><i class='bx bx-cart-add'></i></a>
 				</div>
 			</div>
 			
 			<div class="box1">
 				<img src="img/nophoto.png">
 				<h4>Product 7</h4>
 				<h5>$14.99</h5>
 				<div class="cart">
 					<a href="#"><i class='bx bx-cart-add'></i></a>
 				</div>
 			</div>
 		  </div>		

	</section>
	
	<jsp:include page="footer.jsp" flush="true"/>		
</body>
</html>
