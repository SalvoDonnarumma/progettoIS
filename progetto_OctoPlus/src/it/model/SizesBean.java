package it.model;

public class SizesBean {
	
	
	public SizesBean() {
		super();
		this.idProdotto = 0;
		this.quantitaM = 0;
		this.quantitaL = 0;
		this.quantitaXL = 0;
		this.quantitaXXL = 0;
	}
	
	int idProdotto;
	int quantitaM, quantitaL, quantitaXL, quantitaXXL;
	public int getIdProdotto() {
		return idProdotto;
	}
	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
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
	public int getQuantitaXL() {
		return quantitaXL;
	}
	public void setQuantitaXL(int quantitaXL) {
		this.quantitaXL = quantitaXL;
	}
	public int getQuantitaXXL() {
		return quantitaXXL;
	}
	public void setQuantitaXXL(int quantitaXXL) {
		this.quantitaXXL = quantitaXXL;
	}
	@Override
	public String toString() {
		return "taglia M=" + quantitaM + "  taglia L=" + quantitaL
				+ " taglia X=" + quantitaXL + " taglia XXL=" + quantitaXXL;
	}
	
}
