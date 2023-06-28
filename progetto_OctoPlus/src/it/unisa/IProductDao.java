package it.unisa;

import java.sql.SQLException; 
import java.util.Collection;
import it.model.ProductBean;
import it.model.UserBean;

public interface IProductDao {
	
	public void doSave(ProductBean product) throws SQLException;

	public boolean doDelete(int code) throws SQLException;

	public ProductBean doRetrieveByKey(int code) throws SQLException;
	
	public Collection<ProductBean> doRetrieveAll(String order) throws SQLException;

	void doSaveAdmin(UserBean admin) throws SQLException;
	
	String doSaveUser(UserBean user) throws SQLException;
	
	public boolean doDeleteAdmin(int code) throws SQLException;
	
	public UserBean loginUserOrAdmin(String email, String password) throws SQLException;

	Collection<UserBean> doRetrieveAllUsers(String order) throws SQLException;
}



