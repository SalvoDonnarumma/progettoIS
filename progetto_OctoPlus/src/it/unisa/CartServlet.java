package it.unisa;
import com.google.gson.*;  

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import it.model.CartBean;
import it.model.ProductBean;


@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	
	/* Aggiunta di un prodotto specifico nel carrello */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		IProductDao productDao = new DaoDataSource(ds);
		
		CartBean cart = (CartBean) session.getAttribute("cart");
		
		String id = request.getParameter("id");
		if(  id!=null && !id.equalsIgnoreCase("null") ) {
			Integer idi = Integer.parseInt(request.getParameter("id"));
				ProductBean product = null;
				try {
					product = productDao.doRetrieveByKey(idi);
				} catch (SQLException e1) {
					/*commento per riempire il blocco try-catch*/
				}

				if( cart == null ) {
					cart = new CartBean();
					session.setAttribute("cart", cart);
				}
				
				cart.addProduct(product); //aggiungo un prodotto solo se non è già presente nel carrello
				
				session.removeAttribute("cart");
				session.setAttribute("cart", cart);
		}
		
		if(cart == null) {
			cart = new CartBean();
			request.getSession().setAttribute("cart", cart);
		}
		Gson json = new Gson();
		PrintWriter out = response.getWriter();
		out.write(json.toJson(cart.getAllProduct()));		
	}	
}