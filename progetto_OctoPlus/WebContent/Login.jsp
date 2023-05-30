<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Login form</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<% 
List<String> errors = (List<String>) request.getAttribute("errors");
if (errors != null){
	for (String error: errors){ %>
		<%=error %> <br>		
	<%
	}
}
%>

<header>
		<img src="img/octopus.png" class="logo">
		<nav>
		<ul>
			<li> <a href="index.jsp"> HOME  </a> </li>
			<li> <a href="Login.jsp"> LOGIN </a> </li>
			<li> <a href="#"> CONTACT US </a> </li>
		</ul>
		</nav>
</header>
<form action="Login" method="post"> 
<fieldset>
     <legend>Login Custom</legend>
     <label for="username">Email</label>
     <input id="username" type="text" name="username" placeholder="enter email">
     <br>   
     <label for="password">Password</label>
     <input id="password" type="password" name="password" placeholder="enter password">
     <br>
     <input type="submit" value="Login"/>
     <input type="reset" value="Reset"/>
</fieldset>

<footer>
  		<div class="contact-info">
    	<h4>Contatti</h4>
    	<ul>
    	  <li>Indirizzo: Via Example 123, Città, CAP 12345</li>
    	  <li>Telefono: +39 123456789</li>
    	  <li>Email: <a href="mailto:info@example.com">info@example.com</a></li>
    	</ul>
  		</div>

  		<div class="information">
    		<h4>Informazioni</h4>
   		 <ul>
    	  <li><a href="/chi-siamo">Chi siamo</a></li>
    	  <li><a href="/termini-e-condizioni">Termini e condizioni</a></li>
    	  <li><a href="/politica-sulla-privacy">Politica sulla privacy</a></li>
    	  <li><a href="/spedizioni-e-resi">Spedizioni e resi</a></li>
      	<li><a href="/faq">FAQ</a></li>
    	</ul>
  	</div>

  	<div class="social-media">
  	  <h4>Seguici</h4>
  	  <ul>
  	    <li><a href="https://www.facebook.com/tuosito" target="_blank">Facebook</a></li>
  	    <li><a href="https://www.twitter.com/tuosito" target="_blank">Twitter</a></li>
  	    <li><a href="https://www.instagram.com/tuosito" target="_blank">Instagram</a></li>
  	    <li><a href="https://www.pinterest.com/tuosito" target="_blank">Pinterest</a></li>
  	  </ul>
  	</div>
	
	  <div class="payment-methods">
    	<h4>Metodi di pagamento</h4>
   	 <p>Accettiamo le seguenti modalità di pagamento:</p>
   	 <ul>
      	<li>Carte di credito: Visa, Mastercard, American Express</li>
      	<li>PayPal</li>
     	<li>Bonifico bancario</li>
    	</ul>
  	</div>
	</footer>
</body>
</html>
