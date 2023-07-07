package it.model;

import java.util.ArrayList;
import java.util.List;

public class CartBean {
	List<ProductBean> cart;
	
	public CartBean() {
		cart = new ArrayList<ProductBean>();
	}
	
	public void addProduct(ProductBean product) {
		cart.add(product);
	}
	
	public void deleteProduct(ProductBean product) {
		for(ProductBean prod : cart) {
			if(prod.getCode() == product.getCode()) {
				cart.remove(prod);
				break;
			}
		}
 	}
	
	public List<ProductBean> getAllProduct(){
		return cart;
	}
}
