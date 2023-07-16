function dynamicStore(url){
	$.ajax({
		url : url,
		type: 'GET',
		contentType : 'application/json; charset=utf-8'
	}).done((response) => {
		response = JSON.parse(response);
		let contenutoHTML = "";
		for(const bean of response){
			contenutoHTML += "<div class=\"box1\">";
			contenutoHTML += "</a> <h3 class=\"pname\">"+bean.name+"</h3>";
			contenutoHTML += "<a href=\"product?action=read&fromStore=get&id="+bean.code+"\">";
 			contenutoHTML += "<img src='./getPicture?id="+bean.code+"\" onerror=\"this.src='images/nophoto.png'\">";
 			contenutoHTML += "</a><h5>Categoria:</h5><h4 class=\"categoria\">"+bean.categoria+"</h4>";
 			contenutoHTML += "<h5>Costo:<h3 class=\"prezzo\">"+bean.price.toFixed(2)+"</h3>&euro;</h5>";
 			if( bean.taglie.quantitaM==0 && bean.taglie.quantitaL==0 && bean.taglie.quantitaXL==0 && bean.taglie.quantitaXXL==0)
					contenutoHTML += "<h3 style=\"color: red\"> Prodotto momentaneamente non disponibile! <h3>";
			else{
			contenutoHTML += "<div class=\"cart\">";
 			contenutoHTML += "<a href=\"cart.jsp?id="+bean.code+"\"><i class='bx bx-cart-add'></i></a> </div> </div>";
 			}
		}
		$("#prodotti").append(contenutoHTML);
		visualizeFirstXX();
	});
} 

function visualizeFirstXX(){
	let schede = document.getElementById("prodotti");
	let product = schede.querySelectorAll(".box1");
	let cont = 0;
	
	for (const bean of product) {
		cont++;
		if( cont > 16)
			bean.style.display = "none";		
	}	
}