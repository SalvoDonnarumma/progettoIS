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
					contenutoHTML +=     "<h2 id=\"idOrdine\"> Ordine:"+bean.idOrdine+"#</h2>";
					contenutoHTML +=     "<p>Cliente:"+bean.idUtente+"</p>";
					contenutoHTML +=     "<p>Data:"+bean.data+"</p>";
					contenutoHTML +=     "<p>Stato:"+bean.stato+"</p>";
					contenutoHTML +=     "<p>Stato:"+bean.indirizzo+"</p>";
					contenutoHTML +=     "<p>Totale:"+bean.prezzototale+"&euro;</p>";
					contenutoHTML +=     "<p>Metodo di pagamento: Carta di credito</p>";
					contenutoHTML += "	<p> <button id='" + bean.idOrdine + "' onclick=eliminaRiga(this)> Per rimuovere l'ordine clicca qui!</button>";
					contenutoHTML +=  "</div>";
		      }
		    
			  contenutoHTML2 += "<span>";
			  contenutoHTML2 +=	"<br> Vuoi vedere la pagina della visualizzazione prodotti?";  
			  contenutoHTML2 +=	"<a href=\"./ProductView.jsp\"> Clicca qui! </a>";
			  contenutoHTML2 += "</span>";
			  
			  contenutoHTML2 += "<span>";
			  contenutoHTML2 +=   "Vuoi vedere la pagina della visualizzazione ordini?";
			  contenutoHTML2 +=   "<a href=\"./UserView.jsp\"> Clicca qui! </a>";
			  contenutoHTML2 += "</span>";
		} 
		$("#orders").empty();
		$("#orders").append(contenutoHTML);
		$("#bottom").empty();
		$("#bottom").append(contenutoHTML2);
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
