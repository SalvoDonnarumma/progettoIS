package it.model;

import java.io.InputStream;
import java.io.Serializable;

public class ProductBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	int code;
	String name;
	String description;
	String categoria;
	Double price;
	String stats;
	SizesBean taglie;

	public ProductBean() {
		code = -1;
		name = "";
		description = "";
		taglie = new SizesBean();
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

	@Override
	public String toString() {
		return "ProductBean [code=" + code + ", name=" + name + ", description=" + description + ", categoria="
				+ categoria + ", price=" + price + ", stats=" + stats + ", taglie=" + taglie;
	}


	public String getStats() {
		return stats;
	}


	public void setStats(String stats2) {
		this.stats = stats2;
	}


	public SizesBean getTaglie() {
		return taglie;
	}


	public void setTaglie(SizesBean taglie) {
		this.taglie = taglie;
	}
}
