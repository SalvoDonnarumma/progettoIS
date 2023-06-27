package it.unisa;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.model.ProductBean;
import it.model.UserBean;


public class DaoDriverMan implements IProductDao {

	private static final String TABLE_NAME = "prodotto";
	private DriverManagerConnectionPool dmcp = null;	

	public DaoDriverMan(DriverManagerConnectionPool dmcp) {
		this.dmcp = dmcp;
		
		System.out.println("DriverManager Product Model creation....");
	}
	
	
	@Override
	public synchronized void doSave(ProductBean product) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + DaoDriverMan.TABLE_NAME
				+ " (nome, descrizione, PRICE, QUANTITY) VALUES (?, ?, ?, ?)";

		try {
			connection = dmcp.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(2, product.getCategoria());
			preparedStatement.setString(1, product.getNome());
			preparedStatement.setString(2, product.getDescrizione());
			preparedStatement.setDouble(3, product.getPrice());
			preparedStatement.setInt(4, product.getQuantity());
			preparedStatement.setString(2, product.getStats());

			preparedStatement.executeUpdate();

			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				dmcp.releaseConnection(connection);
			}
		}
	}

	@Override
	public synchronized void doSaveAdmin(UserBean admin) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + DaoDriverMan.TABLE_NAME
				+ " (email, password, cognome) VALUES (?, ?, ?, ?, ?)";

		try {
			connection = dmcp.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, admin.getEmail());
			preparedStatement.setString(2, admin.getPassword());
			preparedStatement.setString(3, admin.getCognome());

			preparedStatement.executeUpdate();

			connection.commit();
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

	@Override
	public synchronized ProductBean doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ProductBean bean = new ProductBean();

		String selectSQL = "SELECT * FROM " + DaoDriverMan.TABLE_NAME + " WHERE idProdotto = ?";

		try {
			connection = dmcp.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setCode(rs.getInt("idProdotto"));
				bean.setCategoria(rs.getString("CATEGORIA"));
				bean.setNome(rs.getString("NOME"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setPrice(rs.getDouble("PRICE"));
				bean.setQuantity(rs.getInt("QUANTITY"));
				bean.setStats(rs.getString("STATS"));
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				dmcp.releaseConnection(connection);
			}
		}
		return bean;
	}

	@Override
	public synchronized boolean doDelete(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + DaoDriverMan.TABLE_NAME + " WHERE idProdotto = ?";

		try {
			connection = dmcp.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, code);

			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				dmcp.releaseConnection(connection);
			}
		}
		return (result != 0);
	}

	@Override
	public synchronized Collection<ProductBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + DaoDriverMan.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = dmcp.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();

				bean.setCode(rs.getInt("idProdotto"));
				bean.setCategoria(rs.getString("CATEGORIA"));
				bean.setNome(rs.getString("NOME"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setPrice(rs.getDouble("PRICE"));
				bean.setQuantity(rs.getInt("QUANTITY"));
				bean.setStats(rs.getString("STATS"));
				products.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				dmcp.releaseConnection(connection);
			}
		}
		return products;
	}


	@Override
	public boolean doDeleteAdmin(int code) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}


	@Override
	public UserBean loginUserOrAdmin(String email, String password) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void doSaveUser(UserBean user) throws SQLException {
		// TODO Auto-generated method stub
		
	}
}	