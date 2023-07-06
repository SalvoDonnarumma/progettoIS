package it.unisa;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

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
       
    public OrderControl() {
        super();
        // TODO Auto-generated constructor stub
    }

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
				}
			}			
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		String sort = request.getParameter("sort");

		try {
			request.removeAttribute("products");
			request.setAttribute("products", productDao.doRetrieveAll(sort));
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		String fromStore = request.getParameter("fromStore");
		System.out.println(fromStore);
		
		RequestDispatcher dispatcher = null;
		
		if(  fromStore.equalsIgnoreCase("get")) {
			dispatcher = getServletContext().getRequestDispatcher("/singleproduct.jsp");
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
