 <%
	UserBean bean = (UserBean) request.getSession().getAttribute("logged"); //quando una persona si logga salvo i suoi dati nella sessione
 	Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
	if( bean == null ){
		response.sendRedirect("./login.jsp");		
		return;
	}
%>
<!DOCTYPE html>
<html lang="it">
<%@ page import="java.util.*,it.model.ProductBean, it.model.SizesBean, it.unisa.DaoDataSource, it.model.UserBean"%>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Lista Acquisti</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/listproduct.css">
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="scripts/dynamicproducts.js"></script>
  <script>
	$(document).ready(function(){
		dynamicOrderView("<%=request.getContextPath()%>/getListProductByID?id=<%=request.getParameter("id")%>");
	});	
  </script> 
</head>
<body>
  <jsp:include page="header.jsp" flush="true"/>
  <br>
  <br>
  <div id="container_products" class="container_products">
  </div>
  <br>
  <div class="center">
  	<div class="links">
 
    <a class="redirect" href="<%=request.getContextPath()%>/userprofile.jsp">Torna al profilo</a>
  
    <a  class="redirect" href="store.jsp" class="modify-btn">Torna al catalogo</a>
  
</div>
  </div>
  <br>
  <br>
  <jsp:include page="footer.jsp" flush="true"/>
</body>
</html>
