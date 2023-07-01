package it.model;

public class SizesBean {
	
	
	public SizesBean() {
		super();
		this.idProdotto = 0;
		this.tagliaM = null;
		this.tagliaL = null;
		this.tagliaX = null;
		this.tagliaXXL = null;
		this.quantitaM = 0;
		this.quantitaL = 0;
		this.quantitaX = 0;
		this.quantitaXXL = 0;
	}
	
	int idProdotto;
	String tagliaM, tagliaL, tagliaX, tagliaXXL;
	int quantitaM, quantitaL, quantitaX, quantitaXXL;
	
	
	public int getIdProdotto() {
		return idProdotto;
	}
	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
	}
	public String getTagliaM() {
		return tagliaM;
	}
	public void setTagliaM(String tagliaM) {
		this.tagliaM = tagliaM;
	}
	public String getTagliaL() {
		return tagliaL;
	}
	public void setTagliaL(String tagliaL) {
		this.tagliaL = tagliaL;
	}
	public String getTagliaX() {
		return tagliaX;
	}
	public void setTagliaX(String tagliaX) {
		this.tagliaX = tagliaX;
	}
	public String getTagliaXXL() {
		return tagliaXXL;
	}
	public void setTagliaXXL(String tagliaXXL) {
		this.tagliaXXL = tagliaXXL;
	}
	public int getQuantitaM() {
		return quantitaM;
	}
	public void setQuantitaM(int quantitaM) {
		this.quantitaM = quantitaM;
	}
	public int getQuantitaL() {
		return quantitaL;
	}
	public void setQuantitaL(int quantitaL) {
		this.quantitaL = quantitaL;
	}
	public int getQuantitaX() {
		return quantitaX;
	}
	public void setQuantitaX(int quantitaX) {
		this.quantitaX = quantitaX;
	}
	public int getQuantitaXXL() {
		return quantitaXXL;
	}
	public void setQuantitaXXL(int quantitaXXL) {
		this.quantitaXXL = quantitaXXL;
	}

	
}
