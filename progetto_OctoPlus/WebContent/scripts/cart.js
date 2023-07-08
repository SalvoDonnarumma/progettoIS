function dynamicCart(url){
	$.ajax({
		url : url,
		type: 'GET',
		contentType : 'application/json; charset=utf-8'
	}).done((response) => {
		response = JSON.parse(response);
		let contenutoHTML = "";
		
		if( response.length == 0 ){
			contenutoHTML +=  "<tr>";
			contenutoHTML +=  "<td colspan=\"6\">No products available</td>";
			contenutoHTML +=  "</tr>";
		} else {
				for(const bean of response){
				  	contenutoHTML += "<tr>";
		          	contenutoHTML += "<td>"+ bean.name;
		          	contenutoHTML += "<img style=\"width: 150px\" src='./getPicture?id="+bean.code+"\" onerror=\"this.src='img/nophoto.png'\">"+"</td>";
		          	contenutoHTML += "<td>"+ bean.categoria +"</td>";
		          	contenutoHTML += "<td> <input type=number min=1 max=\"10\" class=quantita onchange=totaleParziale() value=\"1\"> </td>";
		          	contenutoHTML += "<td> <select id=\"size\">";	
				  	contenutoHTML += "<option value=\"M\"> M </option>";
				  	contenutoHTML += "<option value=\"L\"> L </option>";
				  	contenutoHTML += "<option value=\"XL\"> XL </option>";
				  	contenutoHTML += "<option value=\"XXL\"> XXL </option>";
				  	contenutoHTML += "</select>";
		          	contenutoHTML += "<td>"+"<p class=price>"+bean.price.toFixed(2)+"</p>"+"</td>";
		          	contenutoHTML += "<td class=totProd>"+"</td>";
		          	contenutoHTML += "<td> <button data-isbn='" + bean.code + "'onclick=eliminaRiga(this)><i  class='bx bx-trash'></i></button>";
		         	contenutoHTML += "</tr>"; 
		      }
		    		contenutoHTML += "<tr>";
      			 	contenutoHTML += "<th colspan=\"6\">";
       				contenutoHTML += "</th>;"
      	  			contenutoHTML += "<th>";
       		        contenutoHTML += "<div id=\"cassa\" s>";
	 		        contenutoHTML += "<h5>TOTALE</h5>";
	 			    contenutoHTML += "<div class=\"totale\">";
	 				contenutoHTML += "<h6> Prodotti: </h6>";
	 				contenutoHTML += "<p class=\"tot\">&#8364 totale</p>";
	 				contenutoHTML += "</div>";
					contenutoHTML += "</div>"; 
       				contenutoHTML += "</th>";
     			  	contenutoHTML += "</tr>";
		} 
		$("#cart").append(contenutoHTML);
		totaleParziale(); 
	});
} 


function totaleParziale(){
	let product, elem1, elem2, costo, quantita, totParz, tot = 0;
		
	product = document.getElementById("cart");
	elem2 = product.getElementsByClassName('quantita');
	var elementi = document.querySelectorAll('p.price');
	console.log(elementi);
	
	for(let i = 0; i < elementi.length; i++){
		totParz = 0;
		
		var elementoDesiderato = elementi[i]; 
		var valore = elementoDesiderato.textContent.trim();
    	console.log(valore);
    	costo = parseFloat(valore);
		quantita = parseInt(elem2[i].value)
		console.log(elem2[i].value);
		totParz += costo * quantita;
		tot += totParz;
		
		product.getElementsByClassName("totProd")[i].innerHTML = "&#8364 " + totParz.toFixed(2); 
	}
	
	let cassa;
	
	cassa = document.getElementById("cassa");
	cassa.getElementsByClassName("tot")[0].innerHTML = "&#8364 " + tot.toFixed(2);
	if(tot == 0) 
		spedizione = 0;	
}

function eliminaRiga(button) {
  let row = button.parentNode.parentNode;
  let idProdotto = button.getAttribute("data-isbn");
  var pathArray = window.location.pathname.split('/');
  var contextPath = '/' + pathArray[1];
  var url = contextPath + "/RimuoviProdotto";

  $.ajax({
    url: url,
    type: 'POST',
    data: {isbn: idProdotto },
    success: function(response) {
      // Rimuovi la riga del prodotto dal carrello nell'interfaccia utente
      row.parentNode.removeChild(row);

	  dynamicCart(contextPath+"/CartServlet");
      // Aggiorna i totali
      totaleParziale();
    },
    error: function(xhr, status, error) {
      console.error(error);
    }
  });
}
