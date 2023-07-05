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
			System.out.println(inStore);
			
			if( isAdmin == null ){ //sezione utente ospite
				if( inStore == null);
				else if (inStore.equals("true") && inStore != null) {%>	
						<form action="#" method="get" class="search-form">
    						<input type="text" name="search" placeholder="Cerca..." class="search-input">
     						<button type="submit" class="search-button"><i class='bx bx-search'></i></button>
  						</form>																							
<%						}
			%>	
				<a href="login.jsp"><i class='bx bxs-user'></i></a>	<%
			} else if( isAdmin == true ){ //sezione admin
					if( inStore == null );
					else if( inStore.equals("true") ) { %>																					
							<form action="#" method="get" class="search-form">
    						<input type="text" name="search" placeholder="Cerca..." class="search-input">
     						<button type="submit" class="search-button"><i class='bx bx-search'></i></button>
  							</form>														
<%						}	
				%>	<a href="admin/ProductView.jsp"><i class='bx bx-library'></i></a>
					<a href="login.jsp"><i class='bx bxs-user'></i></a>		
					<a href="Logout"><i class='bx bx-exit'></i></a>	
				<%	
			} else { //sezione utente normale 
						 if( inStore == null);
						 else if( inStore.equals("true")) {%>	
							<form action="#" method="get" class="search-form">
    						<input type="text" name="search" placeholder="Cerca..." class="search-input">
     						<button type="submit" class="search-button"><i class='bx bx-search'></i></button>
  							</form>			
<%							} %>
						<a href="login.jsp"><i class='bx bxs-user'></i></a>	
						<a href="Logout"><i class='bx bx-exit'></i></a>	
					<%  } %>	
		<a href="#"><i class='bx bx-cart' ></i></a> 
		</div>
</header>
</body>
</html>