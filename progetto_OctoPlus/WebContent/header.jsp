<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles//header.css">
<link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
<style>
    
    .icon {
	display: inline-black;
	margin: 2px;
	justify-content: flex-end;
}

.icon {
	color: #121212;
	font-size: 24px;
	margin-left: 15px;
	border-radius: 50%; /*rende circolare l'icona*/
  padding: 10px; /* grandezza cerchio */
  background-color: #fff;
	text-decoration: none;
}

.icon:hover{
	opacity: 0.7;
	background-color: #121212; /* Aggiungi il colore di sfondo desiderato quando ci passi sopra */
  	color: #fff; /* Cambia il colore del testo quando ci passi sopra */
}
</style>
</head>
<body>
<header>
	
	
		 <img src="<%=request.getContextPath()%>/images/octopus.png" class="logo">
	<span class="hfont">OctoPlus</span> 
		
		 <ul class="links-nav">
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
<%						}
			%>	
				<li class="item"><a href="<%=request.getContextPath()%>/index.jsp"><i class='bx bx-home-heart icon'></i></a></li>
				<li class="item"><a href="<%=request.getContextPath()%>/login.jsp"><i class='bx bx-log-in-circle icon'></i></a>	</li>
				<%
			} else if( isAdmin == true ){ //sezione admin
					
					if( path.contains("/store.jsp") ) { %>																																		
<%						}	
				%>	
					<li class="item"><a href="<%=request.getContextPath()%>/admin/OrderView.jsp"><i class='bx bx-library icon'></i></a></li>
					<li class="item"><a href="<%=request.getContextPath()%>/userprofile.jsp"><i class='bx bxs-user icon'></i></a>	</li>
					<li class="item"><a href="<%=request.getContextPath()%>/index.jsp"><i class='bx bx-home-heart icon'></i></a>	</li>
					<li class="item"><a href="<%=request.getContextPath()%>/Logout"><i class='bx bx-log-out-circle icon'></i></a>	</li>
		
		<%		} else { //sezione utente normale 
					 if( path.contains("/store.jsp") ) { %>			
<%							} %>
					<li class="item"><a href="<%=request.getContextPath()%>/userprofile.jsp"><i class='bx bxs-user icon'></i></a>	</li>
					<li class="item"><a href="<%=request.getContextPath()%>/index.jsp"><i class='bx bx-home-heart icon'></i></a>	</li>
					<li class="item"><a href="<%=request.getContextPath()%>/Logout"><i class='bx bx-log-out-circle icon'></i></a>	</li>
					<%  } %>	
	<li class="item">	<a href="<%=request.getContextPath()%>/cart.jsp"><i class='bx bx-cart icon'  ></i></a> </li>
		
		</ul>
	
		<button class="hamburger">
					<div class="bar"></div>
				</button>
		 
		 
		<nav class ="mobile-nav" aria-label="menuHamburger">
		<div class="nav-container">
			<a href="index.jsp">Home</a>
			<a href="login.jsp">Login</a>
			<a href="cart.jsp">Carrello</a>
		</div>
	</nav>
	<script>
		const menu_btn = document.querySelector('.hamburger');
		const mobile_menu = document.querySelector('.mobile-nav');
		menu_btn.addEventListener('click', function(){
			menu_btn.classList.toggle('is-active');
			mobile_menu.classList.toggle('is-active');
		});
		
		
	</script>
</header>
</body>
</html>