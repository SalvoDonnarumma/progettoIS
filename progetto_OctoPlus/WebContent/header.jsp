<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="<%=request.getContextPath()%>/style.css">
<link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
</head>
<body>
<header>
		<img src="<%=request.getContextPath()%>/img/octopus.png" class="logo">
		<span class="hfont">OctoPlus</span> 
		<div class="menu_hamburger" id="menu-icon"> 
		</div>
		<div class="icons">
			<%
			Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
			HttpSession session2 = request.getSession(false);
			if( session2 == null )
				System.out.println("Nessuna sessione attiva");
			else
				System.out.println("sessione attiva: "+session2);
			
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
				<a href="<%=request.getContextPath()%>/index.jsp"><i class='bx bx-home-heart'></i></a>
				<a href="<%=request.getContextPath()%>/login.jsp"><i class='bx bx-log-in-circle'></i></a>	<%
			} else if( isAdmin == true ){ //sezione admin
					
					if( path.contains("/store.jsp") ) { %>																					
							<form action="#" method="get" class="search-form">
    						<input type="text" name="search" placeholder="Cerca..." class="search-input">
     						<button type="submit" class="search-button"><i class='bx bx-search'></i></button>
  							</form>														
<%						}	
				%>	
					<a href="<%=request.getContextPath()%>/admin/ProductView.jsp"><i class='bx bx-library'></i></a>
					<a href="<%=request.getContextPath()%>/userprofile.jsp"><i class='bx bxs-user'></i></a>	
					<a href="<%=request.getContextPath()%>/index.jsp"><i class='bx bx-home-heart'></i></a>	
					<a href="<%=request.getContextPath()%>/Logout"><i class='bx bx-log-out-circle'></i></a>	
		
		<%		} else { //sezione utente normale 
					 if( path.contains("/store.jsp") ) { %>	
							<form action="#" method="get" class="search-form">
    							<input type="text" name="search" placeholder="Cerca..." class="search-input">
     							<button type="submit" class="search-button"><i class='bx bx-search'></i></button>
  							</form>			
<%							} %>
					<a href="<%=request.getContextPath()%>/userprofile.jsp"><i class='bx bxs-user'></i></a>	
					<a href="<%=request.getContextPath()%>/index.jsp"><i class='bx bx-home-heart'></i></a>	
					<a href="<%=request.getContextPath()%>/Logout"><i class='bx bx-log-out-circle'></i></a>	
					<%  } %>	
		<a href="<%=request.getContextPath()%>/cart.jsp"><i class='bx bx-cart' ></i></a> 
		</div>
</header>
</body>
</html>