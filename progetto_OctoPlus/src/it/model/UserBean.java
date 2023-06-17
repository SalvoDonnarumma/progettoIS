package it.model;

import java.io.Serializable;

public class UserBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	Integer id;
	String email;
	String password;
	String nome;
	String cognome;
	String indirizzo;
	String cap;
	String metodo_pagamento;
	Boolean admin;

	public UserBean() {
		id=0;
		email="";
		password="";
		nome="";
		cognome="";
		indirizzo="";
		cap="";
		metodo_pagamento="";
		admin=false;
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

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public String getIndirizzo() {
		return indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	public String getCap() {
		return cap;
	}

	public void setCap(String cap) {
		this.cap = cap;
	}

	public String getMetodo_pagamento() {
		return metodo_pagamento;
	}

	public void setMetodo_pagamento(String metodo_pagamento) {
		this.metodo_pagamento = metodo_pagamento;
	}
	
	public void setAdmin(Boolean val) {
		this.admin=val;
	}
	
	public Boolean getAdmin() {
		return this.admin;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "UserBean [id=" + id + ", email=" + email + ", password=" + password + ", nome=" + nome + ", cognome="
				+ cognome + ", indirizzo=" + indirizzo + ", cap=" + cap + ", metodo_pagamento=" + metodo_pagamento
				+ ", admin=" + admin + "]";
	}
}
