function searchAndFilter(){
  let input, filter, schede, product;
  input = document.getElementById("search-input");
  filter = input.value.toUpperCase();
  schede = document.getElementById("prodotti");
  product = schede.querySelectorAll(".box1");
    
  const selectedCategoria = document.getElementById("categoria-select").value;
  const selectedPrice = document.getElementById("prezzo-select").value;
	
  for (const bean of product) {
	  
    let textValue = bean.querySelector(".pname").textContent.trim();
    const prodottoCategoria = bean.querySelector(".categoria").textContent.trim();
    const prodottoPrezzo = parseFloat(bean.querySelector(".prezzo").textContent.trim());
	
	var minprezzo = 0;
	var maxprezzo = 0;
	
	if( selectedPrice != null ){
		var rangeprezzi = selectedPrice.split('-');
		console.log(rangeprezzi);
		minprezzo = parseFloat(rangeprezzi[0]);
		maxprezzo = parseFloat(rangeprezzi[1]);
	}
	
	console.log(minprezzo);
	console.log(maxprezzo);
	
    const nameMatches = textValue.toUpperCase().indexOf(filter) > -1;
    const categoryMatches = selectedCategoria.length === 0 || selectedCategoria.includes(prodottoCategoria);
    const priceMatches = (prodottoPrezzo >= minprezzo && prodottoPrezzo <= maxprezzo);
	console.log(priceMatches);
	
	
    if (filter && (selectedCategoria.length > 0 || selectedPrice.length > 0)) {
      // Se è presente una ricerca per nome e filtri attivi, considera solo i prodotti che corrispondono a entrambi
      if (textValue && categoryMatches && prodottoPrezzo >= minprezzo && prodottoPrezzo <= maxprezzo) {
        bean.style.display = "";
      } else {
        bean.style.display = "none";
      }
    } else if (filter) {
      // Se è presente solo una ricerca per nome, considera solo i prodotti che corrispondono al nome
      if (nameMatches) {
        bean.style.display = "";
      } else {
        bean.style.display = "none";
      }
      // Se sono presenti solo i filtri attivi, calcolo i 4 casi possibile: 
    } else if(selectedCategoria.length > 0 && selectedPrice.length > 0){ //categorie e prezzi attivi
		if (categoryMatches && priceMatches) {
       		 bean.style.display = "";
      } else { 
        	 bean.style.display = "none";
      }
	} else if (selectedCategoria.length > 0 && !(selectedPrice.length>0) ) { //solo categoria attivi
      		if (categoryMatches) {
        		bean.style.display = "";
      		} else {
        		bean.style.display = "none";
      		}
    }  else if( selectedPrice.length > 0 && !(selectedCategoria.length>0) ) { //solo prezzo attivi
		   if (priceMatches){
        		bean.style.display = "";
      		} else {
        		bean.style.display = "none";
      		}
    }  else { // Se non ci sono né ricerca né filtri attivi, mostra tutti i prodotti
       bean.style.display = "";
    }
  }
}