package it.unisa;

import java.io.Serializable;

public class AdminBean implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	String email;
	String password;
	String cognome;

	public AdminBean() {
		email="";
		password="";
		cognome="";
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}
}
