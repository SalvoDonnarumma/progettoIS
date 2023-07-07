let openShopping = document.querySelector('.box1');
let closeShopping = document.querySelector('.closeShopping');
let list = document.querySelector('.list');
let listCard = document.querySelector('.listCard');
let total = document.querySelector('.total');
let quantity = document.querySelector('.quantity');

openShopping.addEventListener('click', ()=>{
	body.classList.add('active');
})
closeShopping.addEventListener('click', ()=>{
	body.classList.remove('active');
})
