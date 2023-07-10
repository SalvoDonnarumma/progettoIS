<!DOCTYPE html>
<html lang="en">
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
    <form>
      <label for="currentPassword">Password attuale</label>
      <input type="password" id="currentPassword" required>
      
      <label for="newPassword">Nuova password</label>
      <input type="password" id="newPassword" required>
      
      <label for="confirmPassword">Conferma nuova password</label>
      <input type="password" id="confirmPassword" required>
      
      <button type="submit">Cambia password</button>
    </form>
  </div>
</body>
</html>
