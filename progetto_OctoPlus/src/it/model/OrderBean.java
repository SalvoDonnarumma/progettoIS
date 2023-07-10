package it.model;

import java.util.ArrayList;
import java.util.List;

import it.unisa.IOrderDao;

public class OrderBean{
	
	public OrderBean() {
		orders = new ArrayList<OrderedProduct>();
	}

	List<OrderedProduct> orders;
	String idUtente;
	String data;
	String stato;
	Integer idOrdine;
	Double prezzototale;
	String indirizzo;

	public void addOrder(OrderedProduct product) {
		orders.add(product);
	}
	
	
	public List<OrderedProduct> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderedProduct> orders) {
		this.orders = orders;
	}

	public String getEmailUtente() {
		return idUtente;
	}

	public void setEmailUtente(String idUtente) {
		this.idUtente = idUtente;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getStato() {
		return stato;
	}

	public void setStato(String stato) {
		this.stato = stato;
	}

	public Integer getIdOrdine() {
		return idOrdine;
	}

	public void setIdOrdine(Integer idOrdine) {
		this.idOrdine = idOrdine;
	}

	public Double getPrezzototale() {
		return prezzototale;
	}


	public void setPrezzototale(Double prezzototale) {
		this.prezzototale = prezzototale;
	}


	public String getIndirizzo() {
		return indirizzo;
	}


	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}	
}
