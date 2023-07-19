package it.unisa;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.sql.DataSource;

@WebListener
public class MainContext implements ServletContextListener {

	public void contextInitialized(ServletContextEvent sce) {
		ServletContext context = sce.getServletContext();

		DataSource ds = null;
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/storageprogetto");

		} catch (NamingException e) {
			/*commento per riempire il try-catch*/
		}		

		context.setAttribute("DataSource", ds);	
	}

	public void contextDestroyed(ServletContextEvent sce) {
		ServletContext context = sce.getServletContext();
		
		DataSource ds = (DataSource) context.getAttribute("DataSource");
		System.out.println("DataSource deletion...."+ds.toString());
		
		DriverManagerConnectionPool dm = (DriverManagerConnectionPool) context.getAttribute("DriverManager");
		System.out.println("DriverManager deletion...."+dm.toString());		
	}
}
