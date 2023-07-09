package it.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

public class CartBean {
	List<ProductBean> cart;
	
	public CartBean() {
		cart = new ArrayList<ProductBean>();
	}
	
	public void removeProduct(int code) {
		Iterator<ProductBean> iterator = cart.iterator();
		while (iterator.hasNext()) {
		    ProductBean prod = iterator.next();
		    if (prod.getCode() == code) {
		        iterator.remove();
		    }
		}
	}
	
	public void addProduct(ProductBean product) {
		for(ProductBean prod : cart) {
			if(prod.getCode() == product.getCode()) {
				return;
			} 
		}
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
	
	public Collection<?> getAll() {
		Collection <ProductBean> products = new LinkedList<ProductBean>();
		for( ProductBean bean : this.cart) {
			products.add(bean);
		}
		return products;
	}
	
	public void printAll() {
		for(ProductBean prod : cart) {
			System.out.println(prod);
		}
	}
	
	public List<ProductBean> getAllProduct(){
		return cart;
	}
}
