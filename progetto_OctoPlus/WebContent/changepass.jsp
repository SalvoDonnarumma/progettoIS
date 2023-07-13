<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
//quando una persona si logga salvo i suoi dati nella sessione, in questo modo posso prelevarli con l'operazione duale
	UserBean bean = (UserBean) request.getSession().getAttribute("logged"); 
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
   	*{
   		background-color: linear-gradient(217deg, rgba(26, 82, 118, .8), rgba(26, 82, 118, 0) 70.71%),
              linear-gradient(127deg, rgba(19, 126, 166, .8), rgba(19, 126, 166, 0) 70.71%),
              linear-gradient(336deg, rgba(2, 27, 70, .8), rgba(2, 27, 70, 0) 70.71%);
   	}
    
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		function checkPassLength(){
			var pass = document.getElementById("newpassword");
			if( pass.value.length < 12){
				$("#errorPass").empty();
				$("#errorPass").append("la password deve essere lunga almeno 12 caratteri!");
			} else {
				$("#errorPass").empty();
			}
			
			if(  pass.value.length == 0 )
				$("#errorPass").empty();
		}
		
		function alertLength(){
			var pass = document.getElementById("newpassword");
			if( pass.value.length < 12)
				alert("La password deve essere lunga almeno 12 caratteri!");
		}
	</script>
</head>
<body>
  <jsp:include page="./header.jsp" flush="true"/>
  <br>
  <br>
  <div class="container">
    <h2>Cambio password</h2>
    <!-- la servlet si chiama UserControl ma è mappata con /AdminControl -->
    <form action="AdminControl?fromStore=cgpass&action=cgpass&id=<%=bean.getEmail()%>" method="post">
      <label for="currentPassword">Password attuale</label>
      <input name="currentPassword" type="password" id="currentPassword" required>
      
      <label for="newPassword">Nuova password</label>
      <input name="newPassword" onChange="checkPassLength()"  id="newpassword" type="password" required>
      <span style="color:red;" id="errorPass"></span>
      
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
     
      <button type="submit" onClick="alertLength()" >Cambia password</button>
    </form>
  </div>
</body>
</html>
