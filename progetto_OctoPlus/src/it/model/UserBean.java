package it.model;

import java.io.Serializable;

public class UserBean implements Serializable {

	private static final long serialVersionUID = 1L;
	
	Integer id;
	String email;
	String password;
	String nome;
	String cognome;
	String telefono;
	Boolean admin;

	public UserBean() {
		id=0;
		email="";
		password="";
		nome="";
		cognome="";
		telefono="";
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

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	@Override
	public String toString() {
		return "UserBean [id=" + id + ", email=" + email + " nome=" + nome + ", cognome="
				+ cognome + ", telefono=" + telefono + ", admin=" + admin + "]";
	}

}
