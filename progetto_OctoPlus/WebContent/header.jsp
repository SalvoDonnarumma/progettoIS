<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet"
  href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
</head>
<body>
<header>
		<img src="img/octopus.png" class="logo">
		<span class="hfont">OctoPlus</span> 
		<div class="menu_hamburger" id="menu-icon"> 
		</div>
		<div class="icons">
			<%
			Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
			System.out.println("----");
			String inStore =request.getParameter("fromStore");
			System.out.println(isAdmin);
			HttpServletRequest httpServletRequest = (HttpServletRequest) request;
			String path = httpServletRequest.getServletPath();
			System.out.println(path);
			if( isAdmin == null ){ //sezione utente ospite
					if (path.contains("/store.jsp")) {%>	
						<form action="#" method="get" class="search-form">
    						<input type="text" name="search" placeholder="Cerca..." class="search-input">
     						<button type="submit" class="search-button"><i class='bx bx-search'></i></button>
  						</form>																							
<%						}
			%>	
				<a href="index.jsp"><i class='bx bx-home-heart'></i></a>
				<a href="login.jsp"><i class='bx bx-log-in-circle'></i></a>	<%
			} else if( isAdmin == true ){ //sezione admin
					
					if( path.contains("/store.jsp") ) { %>																					
							<form action="#" method="get" class="search-form">
    						<input type="text" name="search" placeholder="Cerca..." class="search-input">
     						<button type="submit" class="search-button"><i class='bx bx-search'></i></button>
  							</form>														
<%						}	
				%>	
					<a href="admin/ProductView.jsp"><i class='bx bx-library'></i></a>
					<a href="userprofile.jsp"><i class='bx bxs-user'></i></a>	
					<a href="index.jsp"><i class='bx bx-home-heart'></i></a>	
					<a href="Logout"><i class='bx bx-log-out-circle'></i></a>	
		
		<%		} else { //sezione utente normale 
					 if( path.contains("/store.jsp") ) { %>	
							<form action="#" method="get" class="search-form">
    							<input type="text" name="search" placeholder="Cerca..." class="search-input">
     							<button type="submit" class="search-button"><i class='bx bx-search'></i></button>
  							</form>			
<%							} %>
						<a href="userprofile.jsp"><i class='bx bxs-user'></i></a>	
						<a href="index.jsp"><i class='bx bx-home-heart'></i></a>
						<a href="Logout"><i class='bx bx-log-out-circle'></i></a>	
					<%  } %>	
		<a href="cart.jsp"><i class='bx bx-cart' ></i></a> 
		</div>
</header>
</body>
</html>