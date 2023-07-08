package it.unisa;
import com.google.gson.*; 

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import it.model.CartBean;
import it.model.ProductBean;
import it.model.UserBean;


@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L; 
 
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		IProductDao productDao = new DaoDataSource(ds);
		
		CartBean cart = (CartBean) session.getAttribute("cart");
		
		System.out.println("Il mio id e':"+request.getParameter("id"));
		String id = request.getParameter("id");
		
		if(  id!=null && !id.equalsIgnoreCase("null") ) {
			Integer id_i = Integer.parseInt(request.getParameter("id"));
				ProductBean product = null;
				try {
					product = productDao.doRetrieveByKey(id_i);
				} catch (SQLException e1) {
				}

				if( cart == null ) {
					cart = new CartBean();
					session.setAttribute("cart", cart);
				}
				
				cart.addProduct(product); //aggiungo un prodotto solo se non è già presente nel carrello
				cart.printAll();
				
				session.removeAttribute("cart");
				session.setAttribute("cart", cart);
		}
		
		System.out.println("Carrello: "+cart);
		
		if(cart == null) {
			cart = new CartBean();
			request.getSession().setAttribute("cart", cart);
		}
		Gson json = new Gson();
	
		PrintWriter out = response.getWriter();
		out.write(json.toJson(cart.getAllProduct()));		
	}	
}