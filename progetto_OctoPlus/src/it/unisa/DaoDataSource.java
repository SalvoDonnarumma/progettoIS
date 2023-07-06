package it.unisa;

import java.io.IOException;  
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.sql.DataSource;

import it.model.OrderedProduct;
import it.model.ProductBean;
import it.model.SizesBean;
import it.model.UserBean;

public class DaoDataSource implements IProductDao {
	
	private static final String TABLE_NAME = "prodotto";
	private DataSource ds = null;

	public DaoDataSource(DataSource ds) {
		this.ds = ds;
		
		System.out.println("DataSource Product Model creation....");
	}
	
	@Override
	public synchronized void doSave(ProductBean product) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + DaoDataSource.TABLE_NAME
				+ " (CATEGORIA, NOME, DESCRIZIONE, PRICE, STATS) VALUES (?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, product.getCategoria());
			preparedStatement.setString(2, product.getNome());
			preparedStatement.setString(3, product.getDescrizione());
			preparedStatement.setDouble(4, product.getPrice());
			preparedStatement.setString(5, product.getStats());
			
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
	
	@Override
	public synchronized void doUpdate(int code, ProductBean product) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String update = "UPDATE " + DaoDataSource.TABLE_NAME
				+ " SET CATEGORIA=?, NOME=?, DESCRIZIONE=?, PRICE=?, STATS=? WHERE idProdotto=?";		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(update);
			preparedStatement.setString(1, product.getCategoria());
			preparedStatement.setString(2, product.getNome());
			preparedStatement.setString(3, product.getDescrizione());
			preparedStatement.setDouble(4, product.getPrice());
			preparedStatement.setString(5, product.getStats());
			preparedStatement.setInt(6, code);
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
	
	@Override
	public synchronized void doUpdateSizes(int code,SizesBean sizes) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String update = "UPDATE taglie SET tagliaM=?, tagliaL=?, tagliaXL=?, tagliaXXL=? WHERE idProdotto=?";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(update);
			preparedStatement.setInt(1, sizes.getQuantitaM());
			preparedStatement.setInt(2, sizes.getQuantitaL());
			preparedStatement.setInt(3, sizes.getQuantitaXL());
			preparedStatement.setInt(4, sizes.getQuantitaXXL());
			preparedStatement.setInt(5, code);
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

	@Override
	public void decreaseSize(SizesBean sizes, int qnt, String size, int code) throws SQLException{
			Connection connection = null;
			PreparedStatement preparedStatement = null;
			String update = null;
			if( size.equalsIgnoreCase("M") ) {
				update = "UPDATE taglie SET tagliaM=tagliaM-? WHERE idProdotto=?";
			} else if( size.equalsIgnoreCase("L")) {
					update = "UPDATE taglie SET tagliaL=tagliaL-? WHERE idProdotto=?";
					}
				else if( size.equalsIgnoreCase("XL")) {
						update = "UPDATE taglie SET tagliaXL=tagliaXL-? WHERE idProdotto=?";
					}
					else if( size.equalsIgnoreCase("XXL")) {
						update = "UPDATE taglie SET tagliaXXL=tagliaXXL-? WHERE idProdotto=?";	
			}
			
			try {
				connection = ds.getConnection();
				preparedStatement = connection.prepareStatement(update);
				preparedStatement.setInt(1, qnt);
				preparedStatement.setInt(2, code);
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
	
	@Override
	public synchronized SizesBean getSizesByKey(int code) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		SizesBean taglie = new SizesBean();
		String selectSQL = "SELECT * FROM taglie WHERE idProdotto= ?";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) { 
				taglie.setIdProdotto(rs.getInt("idProdotto"));
				taglie.setQuantitaM(rs.getInt("tagliaM"));
				taglie.setQuantitaL(rs.getInt("tagliaL"));
				taglie.setQuantitaXL(rs.getInt("tagliaXL"));
				taglie.setQuantitaXXL(rs.getInt("tagliaXXL"));
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
		return taglie;
	}
	
	@Override
	public synchronized void setSizesByKey(int code,SizesBean taglie) throws SQLException{
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		String query = "INSERT INTO taglie (idProdotto, tagliaM, tagliaL, tagliaXL, tagliaXXL) VALUES (?,?,?,?,?)";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, code);
			preparedStatement.setInt(2, taglie.getQuantitaM());
			preparedStatement.setInt(3, taglie.getQuantitaL());
			preparedStatement.setInt(4, taglie.getQuantitaXL());
			preparedStatement.setInt(5, taglie.getQuantitaXXL());
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
	
	
	@Override
	public synchronized ProductBean doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		ProductBean bean = new ProductBean();

		String query = "SELECT * FROM " + DaoDataSource.TABLE_NAME + " WHERE idProdotto= ?";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, code);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) { 
				bean.setCode(rs.getInt("IDPRODOTTO"));
				bean.setCategoria(rs.getString("CATEGORIA"));
				bean.setNome(rs.getString("NOME"));
				bean.setDescrizione(rs.getString("DESCRIZIONE"));
				bean.setPrice(rs.getDouble("PRICE"));
				bean.setStats(rs.getString("STATS"));
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
		
		SizesBean taglie = this.getSizesByKey(code);
		bean.setTaglie(taglie);
		return bean;
	}
	
	@Override
	public synchronized OrderedProduct doRetrieveByKeyO(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		OrderedProduct bean = new OrderedProduct();

		String query = "SELECT * FROM " + DaoDataSource.TABLE_NAME + " WHERE idProdotto= ?";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setInt(1, code);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) { 
				bean.setCode(rs.getInt("IDPRODOTTO"));
				bean.setCategoria(rs.getString("CATEGORIA"));
				bean.setNome(rs.getString("NOME"));
				bean.setDescrizione(rs.getString("DESCRIZIONE"));
				bean.setPrice(rs.getDouble("PRICE"));
				bean.setStats(rs.getString("STATS"));
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
		
		SizesBean taglie = this.getSizesByKey(code);
		bean.setTaglie(taglie);
		return bean;
	}
	
	@Override
	public int doRetrieveByName(String nome) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ProductBean bean = new ProductBean();

		String query = "SELECT * FROM " + DaoDataSource.TABLE_NAME + " WHERE nome= ?";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(query);
			preparedStatement.setString(1, nome);
			ResultSet rs = preparedStatement.executeQuery();
			while (rs.next()) { 
				bean.setCode(rs.getInt("IDPRODOTTO"));
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
		return bean.getCode();
	}

	@Override
	public synchronized boolean doDelete(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + DaoDataSource.TABLE_NAME + " WHERE idProdotto = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, code);

			result = preparedStatement.executeUpdate();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return (result != 0);
	}

	
	
	@Override
	public synchronized Collection<ProductBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<ProductBean> products = new LinkedList<ProductBean>();

		String selectSQL = "SELECT * FROM " + DaoDataSource.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ProductBean bean = new ProductBean();
				int code = rs.getInt("idProdotto");
				bean.setCode(code);
				bean.setCategoria(rs.getString("CATEGORIA"));
				bean.setNome(rs.getString("NOME"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setPrice(rs.getDouble("PRICE"));
				bean.setStats(rs.getString("STATS"));
				SizesBean taglie = this.getSizesByKey(code);
				bean.setTaglie(taglie);
				products.add(bean);
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
		return products;
	}
	
	

	public synchronized static void updatePhoto(String idA, InputStream photo) 
			throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = 	DriverManagerConnectionPool.getConnection();
			stmt = con.prepareStatement("UPDATE prodotto SET photo = ? WHERE idProdotto = ?");
			try {
				stmt.setBinaryStream(1, photo, photo.available());
				stmt.setString(2, idA);	
				stmt.executeUpdate();
				con.commit();
			} catch (IOException e) {
				System.out.println(e);
			}
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				System.out.println(sqlException);
			} finally {
				if (con != null)
					DriverManagerConnectionPool.releaseConnection(con);
			}
		}
	}
	
	public synchronized static byte[] load(String id) throws SQLException {

		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		byte[] bt = null;

		try {
			connection = DriverManagerConnectionPool.getConnection();
			String sql = "SELECT photo FROM prodotto WHERE idProdotto = ?";
			stmt = connection.prepareStatement(sql);
			
			stmt.setString(1, id);
			rs = stmt.executeQuery();

			if (rs.next()) {
				bt = rs.getBytes("photo");
			}

		} catch (SQLException sqlException) {
			System.out.println(sqlException);
		} 
			finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				System.out.println(sqlException);
			} finally {
				if (connection != null) 
					DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
		return bt;
	}
}