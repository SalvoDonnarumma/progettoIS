<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
	UserBean bean = (UserBean) request.getSession().getAttribute("logged"); //quando una persona si logga salvo i suoi dati nella sessione
 	Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
	if( bean == null ){
		response.sendRedirect("./login.jsp");		
		return;
	}
%>
<!DOCTYPE html>
<html>
<%@ page import="java.util.*,it.model.ProductBean, it.model.SizesBean, it.unisa.DaoDataSource, it.model.UserBean"%>
<head>
    <title>Pagina Utente</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/styles/profile.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<script src="<%=request.getContextPath()%>/scripts/orders.js"></script>
  	<script>
		$(document).ready(function(){
			dynamicOrdersUser("<%=request.getContextPath()%>/OrderServlet?idUtente=<%=bean.getEmail()%>");
		});	
  </script> 
</head>
<body>
	<jsp:include page="./header.jsp" flush="true"/>
	<br>
  	<br>
    <div class="container_orders">
        <h1 class="title" >Area personale</h1>
        
        <div class="user-info">
            <h1>Informazioni personali</h1>
            <ul>
                <li><strong>Nome:</strong> <%=bean.getNome() %></li>
                <li><strong>Cognome:</strong> <%=bean.getCognome() %></li>
                <li><strong>Email:</strong> <%=bean.getEmail() %></li>
                <li><strong>Numero di telefono:</strong> <%=bean.getTelefono() %></li>
            </ul>
        </div>
          
        <div class="orders" id="orders">   
        </div>
        
     
        
        <div class="logout">
           
            <p> <a href="Logout" class="no-border-link">Logout</a>.</p>
        </div>
         <div class="password-change">
            
            <p> <a href="./changepass.jsp" class="no-border-link">Cambia password</a></p>
        </div>
    </div>
    
    <br>
  	<br>
	<jsp:include page="footer.jsp" flush="true"/>
</body>
</html>
