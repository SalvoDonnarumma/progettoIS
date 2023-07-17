package it.unisa;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.sql.DataSource;

import it.model.OrderBean;
import it.model.OrderedProduct;

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
				preparedStatement.close();
			} finally {
				connection.close();
			}
		}
	}
	
	@Override
	public synchronized Collection<OrderBean> doRetrieveAllOrders(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<OrderBean> orders = new LinkedList<>();

		String selectSQL = "SELECT * FROM ordine" ;

		if (order != null && !order.equals("")) {
			selectSQL += "ORDER BY ?";
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			if (order != null && !order.equals("")) {
				preparedStatement.setString(1, order);
			}
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				OrderBean bean = new OrderBean();

				bean.setIdOrdine(rs.getInt("idOrdine"));
				bean.setEmailUtente(rs.getString("idUtente"));
				bean.setData(rs.getString("data"));
				bean.setStato(rs.getString("stato"));
				bean.setIndirizzo(rs.getString("indirizzo"));
				bean.setPrezzototale(rs.getDouble("prezzototale"));
				orders.add(bean);
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
		return orders;
	}
	
	@Override
	public synchronized Collection<OrderedProduct> doRetrieveById(String order, int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		Collection<OrderedProduct> singleorder = new LinkedList<>();

		String selectSQL = "SELECT * FROM articoloordinato WHERE idOrdine = ?" ;

		if (order != null && !order.equals("")) {
			selectSQL += "ORDER BY ?";
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);
			if (order != null && !order.equals("")) {
				preparedStatement.setString(2, order);
			}
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				OrderedProduct bean = new OrderedProduct();
				
				bean.setNome(rs.getString("nome"));
				bean.setCategoria(rs.getString("categoria"));
				bean.setPrice(rs.getDouble("prezzo"));
				bean.setQnt(rs.getInt("quantita"));

				singleorder.add(bean);
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
		return singleorder;
	}
	
	public synchronized int doSaveAll(OrderBean bean, Double ptot) throws SQLException {
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
		
		int success = 0;
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
				/* restituisco il numero di righe modificate, se è un numero > 1 vuol dire che la 
				 * query è riuscita correttamente */
				success = preparedStatement.executeUpdate();
			} finally {
				try {
						preparedStatement.close();
				} finally {
						connection.close();
				}
			}
		}
		return success;
	}
	
	@Override
	public synchronized Collection<OrderBean> doRetrieveAllByKey(String email) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		Collection<OrderBean> orders = new LinkedList<>();

		String selectSQL = "SELECT * FROM ordine WHERE idUtente = ?" ;

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, email);
			
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				OrderBean bean = new OrderBean();

				bean.setIdOrdine(rs.getInt("idOrdine"));
				bean.setEmailUtente(rs.getString("idUtente"));
				bean.setData(rs.getString("data"));
				bean.setStato(rs.getString("stato"));
				bean.setIndirizzo(rs.getString("indirizzo"));
				bean.setPrezzototale(rs.getDouble("prezzototale"));
				orders.add(bean);
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
		return orders;
	}

	@Override
	public void removeOrder(int idOrdine) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String deleteSQL = "DELETE FROM ordine WHERE idOrdine = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, idOrdine);

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
