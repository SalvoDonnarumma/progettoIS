package it.unisa;

import java.sql.SQLException;
import java.util.Collection;
import java.util.List;

import it.model.UserBean;

public interface IUserDao {

	void doSaveAdmin(UserBean admin) throws SQLException;

	String doSaveUser(UserBean user) throws SQLException;
	
	boolean doDeleteUser(String email) throws SQLException;

	Collection<UserBean> doRetrieveAllUsers(String order) throws SQLException;
	
	public UserBean loginUserOrAdmin(String email, String password) throws SQLException;
	
	public  Boolean comparePass(String oldPassHash, String passToBeMatch);

	boolean changePass(String pass, int idUtente) throws SQLException;
	
	public List<String> getAllEmails() throws SQLException;

	Collection<UserBean> sortByEmail(String sort) throws SQLException;
	
	Collection<UserBean> sortByName(String sort) throws SQLException;
}
