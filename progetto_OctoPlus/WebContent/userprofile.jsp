<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%
	UserBean bean = (UserBean) request.getSession().getAttribute("logged"); //quando una persona si logga salvo i suoi dati nella sessione
 	Boolean isAdmin = (Boolean) request.getSession().getAttribute("isAdmin");
%>
<!DOCTYPE html>
<html>
<%@ page import="java.util.*,it.model.ProductBean, it.model.SizesBean, it.unisa.DaoDataSource, it.model.UserBean, it.unisa.Cart"%>
<head>
    <title>Pagina Utente</title>
    <link rel="stylesheet" type="text/css" href="profile.css">
</head>
<body>
	<jsp:include page="./header.jsp" flush="true"/>
    <div class="container">
        <h1>Area personale</h1>
        
        <div class="user-info">
            <h2>Informazioni personali</h2>
            <ul>
                <li><strong>Nome:</strong> <%=bean.getNome() %></li>
                <li><strong>Cognome:</strong> <%=bean.getCognome() %></li>
                <li><strong>Email:</strong> <%=bean.getEmail() %></li>
                <li><strong>Numero di telefono:</strong> <%=bean.getTelefono() %></li>
            </ul>
        </div>
        
        <div class="orders">
            <h2>I tuoi ordini</h2>
            <table>
                <tr>
                    <th>Numero ordine</th>
                    <th>Data</th>
                    <th>Stato</th>
                    <th>Totale</th>
                </tr>
                <tr>
                    <td>[Numero ordine]</td>
                    <td>[Data ordine]</td>
                    <td>[Stato ordine]</td>
                    <td>[Totale ordine]</td>
                </tr>
                <tr>
                    <td>[Numero ordine]</td>
                    <td>[Data ordine]</td>
                    <td>[Stato ordine]</td>
                    <td>[Totale ordine]</td>
                </tr>
                <tr>
                    <td>[Numero ordine]</td>
                    <td>[Data ordine]</td>
                    <td>[Stato ordine]</td>
                    <td>[Totale ordine]</td>
                </tr>
            </table>
        </div>
        
        <div class="password-change">
            <h2>Modifica password</h2>
            <p>Se desideri cambiare la tua password, puoi farlo <a href="#">qui</a>.</p>
        </div>
        
        <div class="logout">
            <h2>Esci</h2>
            <p>Se desideri uscire dalla tua pagina utente, puoi effettuare il logout <a href="Logout">qui</a>.</p>
        </div>
    </div>
</body>
</html>
