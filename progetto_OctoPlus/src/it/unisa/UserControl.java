package it.unisa;

import java.io.IOException; 
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import it.model.UserBean;

/**
 * Servlet implementation class AdminControl
 */
@WebServlet("/AdminControl")
public class UserControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isDriverManager = request.getParameter("driver");
		if(isDriverManager == null || isDriverManager.equals("")) {
			isDriverManager = "datasource";
		}
		
		IProductDao adminDao = null;

		if (isDriverManager.equals("drivermanager")) {
			DriverManagerConnectionPool dm = (DriverManagerConnectionPool) getServletContext()
					.getAttribute("DriverManager");
		//	adminDao = new DaoDriverMan(dm);			
		} else {
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			adminDao = new DaoDataSource(ds);
		}
		
		String action = request.getParameter("action");

		try {
			if (action != null) {
				if (action.equalsIgnoreCase("read")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("product");
					request.setAttribute("product", adminDao.doRetrieveByKey(id));
				} else if (action.equalsIgnoreCase("delete")) {
					String email = request.getParameter("email");
					System.out.println("email da cancellare: "+email);
					adminDao.doDeleteUser(email);
				} else if (action.equalsIgnoreCase("insert")) {
					
					String email = request.getParameter("email");
					String password = request.getParameter("password");
					String cognome = request.getParameter("cognome");
					
					UserBean bean = new UserBean();
					bean.setEmail(email);
					bean.setPassword(password);
					bean.setCognome(cognome);
					adminDao.doSaveAdmin(bean);
				}
			}			
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		String sort = request.getParameter("sort");
		
		try {
			request.removeAttribute("users");
			request.setAttribute("users", adminDao.doRetrieveAllUsers(sort));
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		String fromStore = request.getParameter("fromStore");
		
		RequestDispatcher dispatcher = null;
		
		if(  fromStore.equalsIgnoreCase("get")) {
			dispatcher = getServletContext().getRequestDispatcher("/singleproduct.jsp");
		}	
		else if ( Boolean.parseBoolean(fromStore) )    
				dispatcher = getServletContext().getRequestDispatcher("/store.jsp");
         	else
         		dispatcher = getServletContext().getRequestDispatcher("/admin/UserView.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
