<!DOCTYPE html>
<html>
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
                <li><strong>Nome:</strong> [Nome]</li>
                <li><strong>Cognome:</strong> [Cognome]</li>
                <li><strong>Email:</strong> [Email]</li>
                <li><strong>Indirizzo di spedizione:</strong> [Indirizzo]</li>
                <li><strong>Numero di telefono:</strong> [Numero di telefono]</li>
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
        
        <div class="address-change">
            <h2>Modifica indirizzo di spedizione</h2>
            <p>Puoi modificare il tuo indirizzo di spedizione <a href="#">qui</a>.</p>
        </div>
        
        <div class="password-change">
            <h2>Modifica password</h2>
            <p>Se desideri cambiare la tua password, puoi farlo <a href="#">qui</a>.</p>
        </div>
        
        <div class="logout">
            <h2>Esci</h2>
            <p>Se desideri uscire dalla tua pagina utente, puoi effettuare il logout <a href="#">qui</a>.</p>
        </div>
    </div>
</body>
</html>
