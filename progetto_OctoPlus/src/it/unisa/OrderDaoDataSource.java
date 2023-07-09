package it.unisa;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import it.model.CartBean;
import it.model.OrderBean;
import it.model.OrderedProduct;
import it.model.ProductBean;
import it.model.UserBean;

public class OrderDaoDataSource implements IOrderDao{
	private DataSource ds = null;

	public OrderDaoDataSource(DataSource ds) {
		this.ds = ds;
		System.out.println("DataSource Product Model creation....");
	}
	
	public int getLastCode() throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String getLast = "SELECT * from ordine order by idOrdine DESC LIMIT 1";
		int idOrdine = 0;
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(getLast);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) { 
				idOrdine = rs.getInt("idOrdine");
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}	
		return idOrdine;
	}
	
	public synchronized void doSave(OrderBean bean) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String insertSQL1 = "INSERT INTO ordine (idUtente, data, stato, indirizzo) VALUES (?, ?, ?, ?)";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL1);
			preparedStatement.setString(1, bean.getEmailUtente());
			preparedStatement.setString(2, bean.getData());
			preparedStatement.setString(3, bean.getStato());
			preparedStatement.setString(4, bean.getIndirizzo());
			
			preparedStatement.executeUpdate();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		
		int idOrdine = this.getLastCode(); //prelevo dal db il codice dell'ordine appena inserito
		
		double totalprice = 0;
		String insertSQL2  = "INSERT INTO articoloordinato (idOrdine, idProdotto, nome, categoria, prezzo, quantita) VALUES (?, ?, ?, ?, ?, ?)";
		List<OrderedProduct> orderedProducts = bean.getOrders();
		for( OrderedProduct product : orderedProducts) {
			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(insertSQL2);
				preparedStatement.setInt(1, idOrdine);
				preparedStatement.setInt(2, product.getCode());
				preparedStatement.setString(3, product.getNome());
				preparedStatement.setString(4, product.getCategoria());
				preparedStatement.setDouble(5, product.getPrice());
				preparedStatement.setInt(6, product.getQnt());
				preparedStatement.executeUpdate();
			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					if (connection != null)
						connection.close();
				}
			}
			totalprice = totalprice + product.getPrice()*product.getQnt();
		}
		bean.setPrezzototale(totalprice);
		System.out.println("Costo totale ordine "+idOrdine+" :"+totalprice);
		
		String insertSQL3 = "UPDATE ordine SET prezzototale=? WHERE idOrdine=?";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL3);
			preparedStatement.setDouble(1, totalprice);	
			preparedStatement.setInt(2, idOrdine);
			preparedStatement.executeUpdate();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	}
	
	public synchronized void doSaveAll(OrderBean bean, Double ptot) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		/* inserimento dell'ordine nel db */
		String insertSQL1 = "INSERT INTO ordine (idUtente, data, stato, indirizzo, prezzototale) VALUES (?, ?, ?, ?, ?)";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL1);
			preparedStatement.setString(1, bean.getEmailUtente());
			preparedStatement.setString(2, bean.getData());
			preparedStatement.setString(3, bean.getStato());
			preparedStatement.setString(4, bean.getIndirizzo());
			preparedStatement.setDouble(5, ptot);
			
			preparedStatement.executeUpdate();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		
		int idOrdine = this.getLastCode(); //prelevo dal db il codice dell'ordine appena inserito
		
		String insertSQL2  = "INSERT INTO articoloordinato (idOrdine, idProdotto, nome, categoria, prezzo, quantita) VALUES (?, ?, ?, ?, ?, ?)";
		List<OrderedProduct> orderedProducts = bean.getOrders();
		for( OrderedProduct product : orderedProducts) {
			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(insertSQL2);
				preparedStatement.setInt(1, idOrdine);
				preparedStatement.setInt(2, product.getCode());
				preparedStatement.setString(3, product.getNome());
				preparedStatement.setString(4, product.getCategoria());
				preparedStatement.setDouble(5, product.getPrice());
				preparedStatement.setInt(6, product.getQnt());
				preparedStatement.executeUpdate();
			} finally {
				try {
					if (preparedStatement != null)
						preparedStatement.close();
				} finally {
					if (connection != null)
						connection.close();
				}
			}
		}
	}
}
