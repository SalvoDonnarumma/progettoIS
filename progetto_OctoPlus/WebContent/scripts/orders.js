function dynamicOrdersView(url){
	$.ajax({
		url : url,
		type: 'GET',
		contentType : 'application/json; charset=utf-8'
	}).done((response) => {
		response = JSON.parse(response);
		var contenutoHTML = "";
		var contenutoHTML2 = "";

		if( response.length == 0 ){
			contenutoHTML +=  "<span>Nessun ordine disponibile</span>";
		} else {
			 for(const bean of response){
				 	contenutoHTML += "<div class=\"order-card\">";
					contenutoHTML +=     "<h2 id=\"idOrdine\"> Ordine:#"+bean.idOrdine+"</h2>";
					contenutoHTML +=     "<p>Cliente:<div class=\"email\">"+bean.idUtente+"</div></p>";
					contenutoHTML +=     "<p>Data:<div class=\"data\">"+bean.data+"</div></p>";
					contenutoHTML +=     "<p>Stato:"+bean.stato+"</p>";
					contenutoHTML +=     "<p>Stato:"+bean.indirizzo+"</p>";
					contenutoHTML +=     "<p>Totale:"+bean.prezzototale.toFixed(2)+"&euro;</p>";
					contenutoHTML +=     "<p>Metodo di pagamento: Carta di credito</p>";
					contenutoHTML += "	<p> <button id='" + bean.idOrdine + "' onclick=eliminaRiga(this)> Per rimuovere l'ordine clicca qui!</button>";
					contenutoHTML += "</div>";
		      }

			  contenutoHTML2 += "<span>";
			  contenutoHTML2 +=	"<br> Vuoi vedere la pagina della visualizzazione prodotti?";  
			  contenutoHTML2 +=	"<a href=\"./ProductView.jsp\"> Clicca qui! </a>";
			  contenutoHTML2 += "</span>";

			  contenutoHTML2 += "<span>";
			  contenutoHTML2 +=   "Vuoi vedere la pagina della visualizzazione utenti?";
			  contenutoHTML2 +=   "<a href=\"./UserView.jsp\"> Clicca qui! </a>";
			  contenutoHTML2 += "</span>";
		} 
		$("#orders").empty();
		$("#orders").append(contenutoHTML);
		$("#bottom").empty();
		$("#bottom").append(contenutoHTML2);
	});
} 

function dynamicOrdersUser(url){
	$.ajax({
		url : url,
		type: 'GET',
		contentType : 'application/json; charset=utf-8'
	}).done((response) => {
		response = JSON.parse(response);
		var contenutoHTML = "";
		
		contenutoHTML += "<h2>I tuoi ordini</h2>";
        contenutoHTML += "<table>";
            		
		if( response.length == 0 ){
			contenutoHTML +=  "<span>Nessun ordine disponibile</span>";
		} else {
				for(const bean of response){
                	contenutoHTML += "<tr>";
                    contenutoHTML += "<th>Numero ordine</th>";
                    contenutoHTML += "<th>Data</th>";
                    contenutoHTML += "<th>Stato</th>";
                    contenutoHTML += "<th>Totale</th>";
                    contenutoHTML += "<th>Visualizza dettagli prodotti</th>";
               		contenutoHTML += "</tr>";
                	contenutoHTML += "<tr>";
                    contenutoHTML += "<td>[#"+bean.idOrdine+"]</td>";
                    contenutoHTML += "<td>["+bean.data+"]</td>";
                    contenutoHTML += "<td>["+bean.stato+"]</td>";
                    contenutoHTML += "<td>["+bean.prezzototale.toFixed(2)+"&euro;]</td>";
                    contenutoHTML += "<td> <a href=\"./productlist.jsp?id="+bean.idOrdine+"\"> Dettagli prodotti </a> </td>";
                	contenutoHTML += "</tr>";
		      }			
		      contenutoHTML += "</table>";
		} 
		$("#orders").empty();
		$("#orders").append(contenutoHTML);
	});
} 

function eliminaRiga(button) {
  let row = button.parentNode.parentNode;
  let idOrdine = button.getAttribute("id");
  var pathArray = window.location.pathname.split('/');
  var contextPath = '/' + pathArray[1];
  var url = contextPath + "/RemoveOrderServlet";
  console.log(idOrdine);
  $.ajax({
    url: url,
    type: 'POST',
    data:  { idOrdine: idOrdine },
    success: function(response) {
      row.parentNode.removeChild(row);
	  dynamicOrdersView(contextPath+"/OrderServlet");
    },
    error: function(xhr, status, error) {
      console.error(error);
    }
  });
}
