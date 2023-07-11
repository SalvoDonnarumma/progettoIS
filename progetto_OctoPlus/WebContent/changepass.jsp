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
<html lang="en">
<%@ page import="java.util.*,it.model.ProductBean, it.model.SizesBean, it.unisa.DaoDataSource, it.model.UserBean"%>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cambio password</title>
  <style>
    /* Stili di base */
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f2f2f2;
    }
    
    .container {
      margin: 0 auto;
      padding: 50px;
      background-color: #fff;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
      border-radius: 4px;
      top: 50%;
  	  left: 50%;
	  max-width: 400px;
    }
    
    h2 {
      text-align: center;
    }
    
    label {
      display: block;
      margin-bottom: 5px;
    }
    
    input[type="password"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    
    button {
      width: 100%;
      padding: 10px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }
    
    /* Stili responsive */
    @media (max-width: 600px) {
      .container {
        max-width: 100%;
        margin: 10px;
        box-shadow: none;
        border-radius: 0;
      }
    }
  </style>
</head>
<body>
  <jsp:include page="./header.jsp" flush="true"/>
  <br>
  <br>
  <div class="container">
    <h2>Cambio password</h2>
    <form action="AdminControl?fromStore=cgpass&action=cgpass&id=<%=bean.getEmail()%>" method="post">
      <label for="currentPassword">Password attuale</label>
      <input name="currentPassword" type="password" id="currentPassword" required>
      
      <label for="newPassword">Nuova password</label>
      <input name="newPassword" type="password" required>
      
      <label for="confirmPassword">Conferma nuova password</label>
      <input name="confirmPassword" type="password" required>
      
      <%
     	 List<String> errors = (List<String>) request.getAttribute("errors");
			if (errors != null){
				for (String error: errors){ %>
				<label style="color: red">	<%=error %> </label>
				<br>		
			<%
			}
		}
      %>
     
      <button type="submit">Cambia password</button>
    </form>
  </div>
</body>
</html>
