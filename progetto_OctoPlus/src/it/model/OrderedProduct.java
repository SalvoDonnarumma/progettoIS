package it.model;

public class OrderedProduct extends ProductBean {
	private static final long serialVersionUID = 981173534141524876L;
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
