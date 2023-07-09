package it.unisa;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import it.model.CartBean;
import it.model.OrderBean;
import it.model.OrderedProduct;
import it.model.ProductBean;
import it.model.UserBean;

/**
 * Servlet implementation class OrderControl
 */
@WebServlet("/OrderControl")
public class OrderControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String isDriverManager = request.getParameter("driver");
		if(isDriverManager == null || isDriverManager.equals("")) {
			isDriverManager = "datasource";
		}
		
		IProductDao productDao = null;
		IOrderDao orderDao = null;
		if (isDriverManager.equals("drivermanager")) {
			DriverManagerConnectionPool dm = (DriverManagerConnectionPool) getServletContext()
					.getAttribute("DriverManager");
		//	productDao = new DaoDriverMan(dm);			
		} else {
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			productDao = new DaoDataSource(ds);
			orderDao = new OrderDaoDataSource(ds);
		}
		List<String> errors = new ArrayList<>();
		String action = request.getParameter("action");
		String email = request.getParameter("email");
		String indirizzo = request.getParameter("indirizzo");
		String dateTime = LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME);
		try {
			if (action != null) {
				if (action.equalsIgnoreCase("read")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("products");
					Collection <ProductBean> products = new LinkedList<ProductBean>(); //creo una lista di prodotti
					products.add(productDao.doRetrieveByKey(id)); //inserisco solo un prodotto nella lista
					/* in questo modo nella pagina di acquisto (anche se singolo) si lavora sempre con 
					 * un lista, mi permette di avere un acquisto omogoneo di uno o più prodotti*/
					request.setAttribute("products", products);
				} else if( action.equalsIgnoreCase("readAll")) {
						Collection <ProductBean> products = new LinkedList<ProductBean>(); //creo una lista di prodotti
						CartBean cart = (CartBean) request.getSession().getAttribute("cart");
						products= cart.getAllProduct();
						
						request.removeAttribute("products");
						request.setAttribute("products", products);
					
				} else if (action.equalsIgnoreCase("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					productDao.doDelete(id);
				} else if (action.equalsIgnoreCase("purchaseOne")) {
					
					int quantity = Integer.parseInt(request.getParameter("quantity"));
					String size = request.getParameter("size");
					int id = Integer.parseInt(request.getParameter("id"));
					OrderedProduct product = productDao.doRetrieveByKeyO(id);
					//controllo se posso acquistare il prodotto;
					if( size.equalsIgnoreCase("M") ) {
						if(quantity > product.getTaglie().getQuantitaM() )
							errors.add("La quantita' richiesta eccedere quella disponibile!");
					} else if ( size.equalsIgnoreCase("L") ) {
						if(quantity > product.getTaglie().getQuantitaL() )
							errors.add("La quantita' richiesta eccedere quella disponibile!");
							} else if( size.equalsIgnoreCase("XL")) {
								if ( quantity > product.getTaglie().getQuantitaXL()) 
									errors.add("La quantita' richiesta eccedere quella disponibile!");
							} else if( size.equalsIgnoreCase("XXL")) {
								if ( quantity > product.getTaglie().getQuantitaXXL()) 
									errors.add("La quantita' richiesta eccedere quella disponibile!");
							}
					RequestDispatcher dispatcherToProductPage = request.getRequestDispatcher("./product?action=read&fromStore=get&id="+product.getCode());
					if (!errors.isEmpty()) {
		            	request.setAttribute("errors", errors);
		            	dispatcherToProductPage.forward(request, response);
		            	return;
		            }
					product.setQnt(quantity);
					productDao.decreaseSize(product.getTaglie(), quantity, size, product.getCode());
					OrderBean order = new OrderBean();
					order.addOrder(product);
					order.setEmailUtente(email);
					order.setStato("IN CONSEGNA");
					order.setData(dateTime);
					order.setIndirizzo(indirizzo);

					orderDao.doSave(order);
				} else if( action.equalsIgnoreCase("purchaseAll")) {
					
				}
			}			
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		
		String fromStore = request.getParameter("fromStore");
		System.out.println(fromStore);
		
		RequestDispatcher dispatcher = null;
		
		if(  fromStore.equalsIgnoreCase("get2")) {
			dispatcher = getServletContext().getRequestDispatcher("/purchase.jsp");
		}	
		else if ( Boolean.parseBoolean(fromStore) )    
				dispatcher = getServletContext().getRequestDispatcher("/store.jsp");
         	else
         		dispatcher = getServletContext().getRequestDispatcher("/admin/ProductView.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
