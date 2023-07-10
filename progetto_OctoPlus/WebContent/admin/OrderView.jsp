<!DOCTYPE html>
<%
 	Boolean isSomeoneLogged = (Boolean) request.getSession().getAttribute("isAdmin");
	if( isSomeoneLogged == null ){
		response.sendRedirect("../login.jsp");	
		return;
	}
%>
<html>
<head>
  <title>Elenco Ordini</title>
  <link rel="stylesheet" type="text/css" href="./orderview.css">
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="../scripts/orders.js"></script>
  <script>
		$(document).ready(function(){
			dynamicOrdersView("<%=request.getContextPath()%>/OrderServlet");
		});	
  </script> 
  <jsp:include page="../header.jsp" flush="true"/>
</head>


<body>
  <h1>Elenco Ordini</h1>
  <div class="orders-container" id="orders">   
  </div>
  <div id="bottom">
  </div>
</body>
</html>
