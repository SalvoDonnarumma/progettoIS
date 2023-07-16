package it.unisa;

import java.io.IOException; 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.model.CartBean;

/**
 * Servlet implementation class RemoveProductFromCart
 */
@WebServlet("/RemoveProductFromCart")
public class RemoveProductFromCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		CartBean cart = (CartBean) session.getAttribute("cart");
		cart.removeProduct(Integer.parseInt(request.getParameter("id")));
		request.getSession().removeAttribute("cart");
		request.getSession().setAttribute("cart", cart);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
