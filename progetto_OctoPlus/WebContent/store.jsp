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
<%@ page import="java.util.*,it.model.ProductBean,it.model.UserBean, it.unisa.Cart"%>
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
 	<section class="shop" id="shop">
 		<div class="container"> 		
 			<%
			if (products != null && products.size() != 0) {
				Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProductBean bean = (ProductBean) it.next();
		%>
 			<div class="box1">
 			
 				<h3><%=bean.getNome()%></h3>
 			<a href="product?action=read&fromStore=get&id=<%=bean.getCode()%>">
 				<img src="./getPicture?id=<%=bean.getCode()%>" onerror="this.src='./img/nophoto.png'">
 					</a>
 				<h4> Categoria: <%=bean.getCategoria()%> </h4>
 				<h5><%=bean.getPrice()%></h5>
 				<div class="cart">
 					<a href="#"><i class='bx bx-cart-add'></i></a>
 				</div>
 			</div>	
 		<%
				}
			} 
 		%>

 		</div>		
	</section>
	<jsp:include page="footer.jsp" flush="true"/>		
</body>
</html>
