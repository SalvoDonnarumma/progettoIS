package it.unisa;

import java.io.InputStream;
import java.io.Serializable;

public class ProductBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	int code;
	String name;
	String description;
	String categoria;
	Double price;
	InputStream photo;
	InputStream stats;
	//discutere questione taglie
	int quantity;

	public ProductBean() {
		code = -1;
		name = "";
		description = "";
		quantity = 0;
	}

	
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	
	public String getCategoria() {
		return this.categoria;
	}
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getNome() {
		return name;
	}

	public void setNome(String name) {
		this.name = name;
	}

	public String getDescrizione() {
		return description;
	}

	public void setDescrizione(String description) {
		this.description = description;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return name + " (" + code + "), " + price + " " + quantity + ". " + description;
	}


	public InputStream getPhoto() {
		return photo;
	}


	public void setPhoto(InputStream photo) {
		this.photo = photo;
	}


	public InputStream getStats() {
		return stats;
	}


	public void setStats(InputStream stats) {
		this.stats = stats;
	}

}
