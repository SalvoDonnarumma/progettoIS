package it.unisa;

import java.io.IOException; 
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.google.gson.*;

import it.model.ProductBean;

/**
 * Servlet implementation class StoreServlet
 */
@WebServlet("/StoreServlet")
public class StoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection connection = null;
		Gson json = new Gson();
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		IProductDao productDao = new DaoDataSource(ds);
		Collection<ProductBean> products = null; 
		try {
			products = productDao.doRetrieveAll(null);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		PrintWriter out = response.getWriter();
		out.write(json.toJson(products));
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
