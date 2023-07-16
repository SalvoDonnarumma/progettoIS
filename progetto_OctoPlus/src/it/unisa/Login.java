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

@WebServlet("/Login")
public class Login extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			String isDriverManager = request.getParameter("driver");
			if(isDriverManager == null || isDriverManager.equals("")) {
				isDriverManager = "datasource";
			}
			
			IUserDao userDao = null;
	
			
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			userDao = new UserDaoDataSource(ds);
			
			String username = request.getParameter("email");
			String password = request.getParameter("password");
			List<String> errors = new ArrayList<>();
        	RequestDispatcher dispatcherToLoginPage = request.getRequestDispatcher("login.jsp");

			
			if(username == null || username.trim().isEmpty()) {
				errors.add("Il campo username non può essere vuoto!");
			}
            if(password == null || password.trim().isEmpty()) {
            	errors.add("Il campo password non può essere vuoto!");
			}
            if (!errors.isEmpty()) {
            	request.setAttribute("errors", errors);
            	dispatcherToLoginPage.forward(request, response);
            	return;
            }
			
			UserBean match=null;
			try {
				match=userDao.loginUserOrAdmin(username, password);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			if(match==null) {
				errors.add("Username o password non validi!");
				request.setAttribute("errors", errors);
				dispatcherToLoginPage.forward(request, response);
			} else if( match.getAdmin() ) { //sono state usate credenziali di admin
				request.getSession().setAttribute("isAdmin", Boolean.TRUE); //inserisco il token nella sessione
				request.getSession().setAttribute("logged", match);
				response.sendRedirect("store.jsp");			
			} else if( !match.getAdmin() && match!=null ) { //sono state usate credenziali di un utente
				request.getSession().setAttribute("isAdmin", Boolean.FALSE); //inserisco il token nella sessione
				request.getSession().setAttribute("logged", match);
				response.sendRedirect("store.jsp");
			}
			
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	
	private static final long serialVersionUID = 1L;


}
