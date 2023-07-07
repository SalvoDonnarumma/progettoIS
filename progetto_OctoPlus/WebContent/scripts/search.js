function searchAndFilter() {
  let input, filter, schede, product;
  input = document.getElementById("search-input");
  filter = input.value.toUpperCase();
  schede = document.getElementById("categoria-select");
  product = schede.querySelectorAll(".scheda");

  
  const categoriaSelect = document.getElementById("categoria-select");
  const selectedCategory = categoriaSelect.value;

  for (const item of product) {
    let a = item.querySelector(".pname");
    let textValue = a.textContent || a.innerText;
    const prodottoCategoria = item.dataset.categoria;
    const prodottoGenere = item.dataset.genere;

    const nameMatches = textValue.toUpperCase().indexOf(filter) > -1;
    const categoryMatches = selectedCategories.length === 0 || selectedCategories.includes(prodottoCategoria);
    const genreMatches = selectedGenres.length === 0 || selectedGenres.includes(prodottoGenere);
    const categoryMatchesSelected = selectedCategory === "" || selectedCategory === prodottoCategoria;

    if (filter && (selectedCategories.length > 0 || selectedGenres.length > 0 || selectedCategory !== "")) {
      // Se è presente una ricerca per nome e/o filtri attivi, considera solo i prodotti che corrispondono a tutti i criteri
      if (nameMatches && categoryMatches && genreMatches && categoryMatchesSelected) {
        item.style.display = "";
      } else {
        item.style.display = "none";
      }
    } else if (filter || selectedCategory !== "") {
      // Se è presente solo una ricerca per nome o una categoria selezionata, considera solo i prodotti che corrispondono a uno dei criteri
      if ((nameMatches && categoryMatches && genreMatches) || categoryMatchesSelected) {
        item.style.display = "";
      } else {
        item.style.display = "none";
      }
    } else if (selectedCategories.length > 0 || selectedGenres.length > 0) {
      // Se ci sono solo filtri attivi, considera solo i prodotti che corrispondono ai filtri
      if (categoryMatches && genreMatches) {
        item.style.display = "";
      } else {
        item.style.display = "none";
      }
    } else {
      // Se non ci sono né ricerca né filtri attivi, mostra tutti i prodotti
      item.style.display = "";
    }
  }
}
