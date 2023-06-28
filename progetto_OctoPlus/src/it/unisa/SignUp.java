package it.unisa;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import it.model.UserBean;

/**
 * Servlet implementation class SignUp
 */
@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String isDriverManager = request.getParameter("driver");
		if(isDriverManager == null || isDriverManager.equals("")) {
			isDriverManager = "datasource";
		}
		
		IProductDao productDao = null;

		if (isDriverManager.equals("drivermanager")) {
			DriverManagerConnectionPool dm = (DriverManagerConnectionPool) getServletContext()
					.getAttribute("DriverManager");
		//	productDao = new DaoDriverMan(dm);			
		} else {
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			productDao = new DaoDataSource(ds);
		}
	
		String username = request.getParameter("email");
		String name = request.getParameter("firstname");
		String surname = request.getParameter("lastname");
		String password = request.getParameter("password");
		String conf_password = request.getParameter("conf_password");
		
		List<String> errors = new ArrayList<>();
        if ( !password.equals(conf_password) ) {  //controllo se password e conferma password sono uguali
        	request.setAttribute("errors", errors);
        	RequestDispatcher dispatcherToLoginPage = request.getRequestDispatcher("login.jsp");
        	dispatcherToLoginPage.forward(request, response);
        	return;
        }
		
		UserBean user= new UserBean();
		try {
			user.setEmail(username);
			user.setPassword(password);
			user.setNome(username);
			user.setCognome(surname);
			
			productDao.doSaveUser(user);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.getSession().setAttribute("isAdmin", Boolean.FALSE); //inserisco il token nella sessione
		request.getSession().setAttribute("logged", user);
		response.sendRedirect("store.jsp");	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
