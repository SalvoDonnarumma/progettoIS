package it.model;

public class OrderedProduct extends ProductBean {
	public OrderedProduct() {
		super();
		qnt=0;
	}
	int qnt;
	
	public int getQnt() {
		return qnt;
	}
	public void setQnt(int qnt) {
		this.qnt = qnt;
	}
}
