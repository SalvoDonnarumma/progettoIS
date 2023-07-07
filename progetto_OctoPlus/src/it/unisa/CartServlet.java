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
import java.util.HashMap;
import java.util.Map;

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
		Connection connection = null;
		HttpSession session = request.getSession();
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		try {
			connection = ds.getConnection();
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		CartBean carrello = (CartBean) session.getAttribute("cart");
		String isbn = request.getParameter("isbn");
		UserBean user = (UserBean) session.getAttribute("user");
		RequestDispatcher dispatcher = null;
		Gson json = new Gson();
		PrintWriter out = response.getWriter();

		if(isbn == null) {
			HashMap<String , String> hashMap = new HashMap<>();
			hashMap.put("url", "carrello.jsp");
			out.write(json.toJson(hashMap));
			return;
		}
		try {
			connection = ds.getConnection();
			if (user == null) 
				response.sendRedirect("login.jsp");
			else {
				String query = "SELECT * FROM prodotti WHERE isbn = ?";
				PreparedStatement ps = connection.prepareStatement(query);
				ps.setString(1, isbn);
				ResultSet rs = ps.executeQuery();

				if (rs.next()) {
					String nome = rs.getString("nome");
					String descrizione = rs.getString("descrizione");
					String img = rs.getString("immagine_prod");
					String genere = rs.getString("genere_nome");
					String categoria = rs.getString("categoria_nome");
					int quantita = rs.getInt("quantita");
					double prezzo = rs.getDouble("prezzo");
					ProductBean prodotto = new ProductBean();

					int flag = 0;
					for (ProductBean p : carrello.getAllProduct()) {
						if (prodotto.getNome().equals(p.getNome()))
							flag = 1;
					}

					if (flag == 0) {
						carrello.addProduct(prodotto);;
						session.setAttribute("cart", carrello);
					}
				}
				rs.close();
				out.write(json.toJson(carrello.getAllProduct()));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}	
}