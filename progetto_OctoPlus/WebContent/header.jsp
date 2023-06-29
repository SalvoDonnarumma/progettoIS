<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="style.css?ts=<?=time()?>&quot">
<link rel="stylesheet"
  href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
</head>
<body>
<header>
		<img src="img/octopus.png" class="logo">
		<span class="hfont">OctoPlus</span> 
		<div class="bx bx-menu" id="menu-icon"> </div>
		<ul class="navbar">
			<li> <a href="index.jsp"> HOME  </a> </li>
		<!-- 	<li> <a href="Login.jsp"> LOGIN </a> </li> -->
			<li> <a href="#"> CONTACT US </a> </li>
		</ul>
		<div class="icons">
			<a href="login.jsp"><i class='bx bxs-user'></i></a>
		<!--<a href="#"><i class='bx bxs-basket'></i></a>  commento perché non ho capito che cazzo è-->
			<a href="#"><i class='bx bx-cart' ></i></a> 
			
			
			<%
			Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
			System.out.println(request.getContextPath());
			String inStore =request.getParameter("fromStore");
			System.out.println(inStore);
			
			if( isAdmin == null ){ //sezione utente ospite
				%>																					
						<a href="#"><i class='bx bx-search'></i></a>				
<%		
			} else if( isAdmin == true ){ //sezione admin%> 
				<a href="admin/ProductView.jsp"><i class='bx bx-library'></i></a>
				<a href="Logout"><i class='bx bx-exit'></i></a>
<% 
					if( inStore == null );
					else if( inStore.equals("true") ) { %>																					
							<a href="#"><i class='bx bx-search'></i></a>	
								
<%			}	} else { //sezione utente normale%>
							<a href="Logout"><i class='bx bx-exit'></i></a> 
<%							
				} %>	
			
		<!--  
			<ul id="menu">
			<li> <a href="#"> <i class='bx bxs-user'></i> </a>
				<ul> 
					<li> <a href="login.jsp">ACCEDI</a> </li>
					<li> <a href="login.jsp">REGISTRAMI</a> </li>
				</ul>
			</li>		
			
			<li>
			<a href="#"><i class='bx bx-search'></i></a>
			</li>
			
			<li>
			<a href="#"><i class='bx bxs-basket'></i></a>
			</li>
			<li>
			<a href="#"><i class='bx bx-cart' ></i></a>
			</li>
			</ul>
		-->
		
			
		</div>
</header>
</body>
</html>