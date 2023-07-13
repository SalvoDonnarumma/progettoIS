package it.unisa;
import java.io.IOException;  
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import it.model.ProductBean;
import it.model.SizesBean;
/**
 * Servlet implementation class ProductControl
 */
public class ProductControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
		
	public ProductControl() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String isDriverManager = request.getParameter("driver");
		if(isDriverManager == null || isDriverManager.equals("")) {
			isDriverManager = "datasource";
		}
		
		IProductDao productDao = null;

		if (isDriverManager.equals("drivermanager")) {
			DriverManagerConnectionPool dm = (DriverManagerConnectionPool) getServletContext()
					.getAttribute("DriverManager");
		//	productDao = new DaoDriverMan(dm);			
		} else {
			DataSource ds = (DataSource) getServletContext().getAttribute("DataSource");
			productDao = new DaoDataSource(ds);
		}
		
		String action = request.getParameter("action");	
		try {
			if (action != null) {
				if (action.equalsIgnoreCase("read")) {
					
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("product");
					request.setAttribute("product", productDao.doRetrieveByKey(id));
					
				} if (action.equalsIgnoreCase("modify"))	{
					
					String categoria = request.getParameter("categoria");
					System.out.println("Categoria: "+categoria);
					String nome = request.getParameter("nome");
					String descrizione = request.getParameter("descrizione");
					Double price = Double.parseDouble(request.getParameter("price"));
					int quantityM = Integer.parseInt(request.getParameter("tagliaM"));
					int quantityL = Integer.parseInt(request.getParameter("tagliaL"));
					int quantityXL = Integer.parseInt(request.getParameter("tagliaXL"));
					int quantityXXL = Integer.parseInt(request.getParameter("tagliaXXL"));
					String stats = request.getParameter("stats");
					ProductBean bean = new ProductBean();
					bean.setNome(nome);
					bean.setDescrizione(descrizione);
					bean.setCategoria(categoria);
					bean.setStats(stats);
					bean.setPrice(price);
					int code = Integer.parseInt(request.getParameter("id"));
					productDao.doUpdate(code, bean);
					
					SizesBean sizes = new SizesBean();			
					sizes.setQuantitaM(quantityM);
					sizes.setQuantitaL(quantityL);
					sizes.setQuantitaXL(quantityXL);
					sizes.setQuantitaXXL(quantityXXL);
					bean.setTaglie(sizes);
					productDao.doUpdateSizes(code, sizes);
				
				} else if (action.equalsIgnoreCase("delete")) {
					
						int id = Integer.parseInt(request.getParameter("id"));
						productDao.doDelete(id);
						
						} else if (action.equalsIgnoreCase("insert")) {
							String categoria = request.getParameter("categoria");
							String nome = request.getParameter("nome");
							String descrizione = request.getParameter("descrizione");
							Double price = Double.parseDouble(request.getParameter("price"));
							int quantityM = Integer.parseInt(request.getParameter("tagliaM"));
							int quantityL = Integer.parseInt(request.getParameter("tagliaL"));
							int quantityXL = Integer.parseInt(request.getParameter("tagliaXL"));
							int quantityXXL = Integer.parseInt(request.getParameter("tagliaXXL"));
							String stats = request.getParameter("stats");
							ProductBean bean = new ProductBean();
							bean.setNome(nome);
							bean.setDescrizione(descrizione);
							bean.setCategoria(categoria);
							bean.setStats(stats);
							bean.setPrice(price);
							productDao.doSave(bean);
							SizesBean sizes = new SizesBean();			
							int code = productDao.doRetrieveByName(nome);
							sizes.setQuantitaM(quantityM);
							sizes.setQuantitaL(quantityL);
							sizes.setQuantitaXL(quantityXL);
							sizes.setQuantitaXXL(quantityXXL);
							bean.setTaglie(sizes);
							productDao.setSizesByKey(code, sizes);
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
		System.out.println("Parametro fromstore: "+fromStore);
		System.out.println("Parametro action: "+action);
		RequestDispatcher dispatcher = null;
		
		if( fromStore.equalsIgnoreCase("modify"))
			dispatcher = getServletContext().getRequestDispatcher("/admin/modifyproduct.jsp");
		else if(  fromStore.equalsIgnoreCase("get")) {
			dispatcher = getServletContext().getRequestDispatcher("/singleproduct.jsp");
		}else if( fromStore.equalsIgnoreCase("get2")) {
				dispatcher = getServletContext().getRequestDispatcher("/purchase.jsp");
			   }else if ( Boolean.parseBoolean(fromStore) )    
					dispatcher = getServletContext().getRequestDispatcher("/store.jsp");
         		else {
         			dispatcher = getServletContext().getRequestDispatcher("/admin/ProductView.jsp");
        } 			
		dispatcher.forward(request, response);
	}
	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
