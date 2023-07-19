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
	
		DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
		productDao = new DaoDataSource(ds);
		orderDao = new OrderDaoDataSource(ds);
		
		List<String> errors = new ArrayList<>();
		String action = request.getParameter("action");
		System.out.println("action: "+action);
		UserBean bean = (UserBean) request.getSession().getAttribute("logged");
		if( bean == null ){
			response.sendRedirect("./login.jsp");		
			return;
		}
		String email = bean.getEmail();
		String indirizzo = request.getParameter("indirizzo");
		String dateTime = LocalDateTime.now().format(DateTimeFormatter.ISO_DATE_TIME);
		try {
			if (action != null) {
				if (action.equalsIgnoreCase("read")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("products");
					Collection <ProductBean> products = new LinkedList<>(); //creo una lista di prodotti
					products.add(productDao.doRetrieveByKey(id)); //inserisco solo un prodotto nella lista
					/* in questo modo nella pagina di acquisto (anche se singolo) si lavora sempre con 
					 * un lista, mi permette di avere un acquisto omogoneo di uno o più prodotti*/
					request.setAttribute("products", products);
				} else if( action.equalsIgnoreCase("readAll")) {
						Collection <ProductBean> products; //creo una lista di prodotti
						CartBean cart = (CartBean) request.getSession().getAttribute("cart");
						products= cart.getAllProduct();
						request.removeAttribute("products");
						request.setAttribute("products", products);
				} else if( action.equalsIgnoreCase("viewAll")) {
						Collection <OrderBean> orders; //creo una lista di ordini
						orders = orderDao.doRetrieveAllOrders(null);
						request.removeAttribute("orders");
						request.setAttribute("orders",orders);
				} else if (action.equalsIgnoreCase("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					productDao.doDelete(id);
				} else if (action.equalsIgnoreCase("purchaseOne")) {
					
					int quantity = Integer.parseInt(request.getParameter("qnt"));
					String size = request.getParameter("sz");
					int id = Integer.parseInt(request.getParameter("id"));
					OrderedProduct product = productDao.doRetrieveByKeyO(id);
					//controllo se posso acquistare il prodotto;
					String error = "La quantita' richiesta eccedere quella disponibile!";
					if( size.equalsIgnoreCase("M") ) {
						if(quantity > product.getTaglie().getQuantitaM() )
							errors.add(error);
					} else if ( size.equalsIgnoreCase("L") ) {
						if(quantity > product.getTaglie().getQuantitaL() )
							errors.add(error);
							} else if( size.equalsIgnoreCase("XL")) {
								if ( quantity > product.getTaglie().getQuantitaXL()) 
									errors.add(error);
							} else if( size.equalsIgnoreCase("XXL")) {
								if ( quantity > product.getTaglie().getQuantitaXXL()) 
									errors.add(error);
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
					
					/* svuoto il carrello */
					CartBean newcart = new CartBean();
					request.getSession().removeAttribute("cart");
					request.getSession().setAttribute("cart", newcart);
				} else if( action.equalsIgnoreCase("purchaseAll")) { 
					CartBean cart = (CartBean) request.getSession().getAttribute("cart");
					
					/* prendo le taglie dei singoli prodotti messi nel carrello */
					@SuppressWarnings("unchecked")
					List<String>sizes = (List<String>) request.getSession().getAttribute("sizes");
					
					/* prendo le quantità dei singoli prodotti messi nel carrello */
					@SuppressWarnings("unchecked")
					List<Integer>qnts = (List<Integer>) request.getSession().getAttribute("qnts");
					
					/* devo controllare se ogni prodotto è disponibile per l'acquisto
					 * sulla quantità e taglia richiesta */
					OrderedProduct prodondb = null;
					ProductBean p = null;
					String error = "La quantita' richiesta di un prodotto presente nel carrello eccedere quella disponibile!";
					for(int i=0; i<cart.getSize(); i++) {
						p = cart.getProduct(i);
						prodondb = productDao.doRetrieveByKeyO(p.getCode());

						if( sizes.get(i).equalsIgnoreCase("M") ) {
							if(qnts.get(i) > prodondb.getTaglie().getQuantitaM() )
								errors.add(error);
						} else if ( sizes.get(i).equalsIgnoreCase("L") ) {
							if( qnts.get(i) > prodondb.getTaglie().getQuantitaL() )
								errors.add(error);
								} else if( sizes.get(i).equalsIgnoreCase("XL") ) {
									if ( qnts.get(i) > prodondb.getTaglie().getQuantitaXL() ) 
										errors.add(error);
								} else if( sizes.get(i).equalsIgnoreCase("XXL") ) {
									if ( qnts.get(i) > prodondb.getTaglie().getQuantitaXXL() ) 
										errors.add(error);
								}
						if(!errors.isEmpty())
							break;
					}
					/*Se qualche prodotto non è disponibiile all'acquisto, rimando alla pagina del primo prodotto 
					 * non disponibile invitando l'utente a modificare la quantità del prodotto desiderato della 
					 * taglia desiderata: potrà acquistarlo singolarmente o eventualmente entrare nel carrello
					 * e modificare la quantità da acquistare */
					RequestDispatcher dispatcherToProductPage = request.getRequestDispatcher("./product?action=read&fromStore=get&id="+prodondb.getCode());
					if (!errors.isEmpty()) {
		            	request.setAttribute("errors", errors);
		            	dispatcherToProductPage.forward(request, response);
		            	return;
		            }
					
					System.out.println("Tutti i prodotti idonei all'acquisto");
					OrderBean order = new OrderBean();
					
					for(int i = 0; i<cart.getSize(); i++) {
						p = cart.getProduct(i);
						prodondb = productDao.doRetrieveByKeyO(p.getCode());
						/* salvo il prodotto insieme alla quantità con cui
						 * lo si vuol comprare, quantità che verrà salvata nel db */
						prodondb.setQnt(qnts.get(i));
						/* decremento le quantità di determinate taglie dei prodotti acquistati */
						productDao.decreaseSize(prodondb.getTaglie(), qnts.get(i), sizes.get(i), prodondb.getCode());
						/* aggiungo tutti i prodotti nella lista dell'ordine */
						order.addOrder(prodondb);
					}
					
					order.setEmailUtente(email);
					order.setStato("IN CONSEGNA");
					order.setData(dateTime);
					order.setIndirizzo(indirizzo);
					Double ptot = Double.parseDouble(request.getParameter("tot"));
					orderDao.doSaveAll(order, ptot);
		
					/* svuoto il carrello */
					CartBean newcart = new CartBean();
					request.getSession().removeAttribute("cart");
					request.getSession().setAttribute("cart", newcart);
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
		} else if ( Boolean.parseBoolean(fromStore) )    
					dispatcher = getServletContext().getRequestDispatcher("/store.jsp");
         		else
         			dispatcher = getServletContext().getRequestDispatcher("/admin/ProductView.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
