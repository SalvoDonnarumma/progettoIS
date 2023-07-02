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

import com.mysql.cj.jdbc.result.ResultSetMetaData;

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
				+ " (CATEGORIA, NOME, DESCRIZIONE, PRICE, QUANTITY, STATS) VALUES (?, ?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, product.getCategoria());
			preparedStatement.setString(2, product.getNome());
			preparedStatement.setString(3, product.getDescrizione());
			preparedStatement.setDouble(4, product.getPrice());
			preparedStatement.setInt(5, product.getQuantity());
			preparedStatement.setString(6, product.getStats());
			
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
	public synchronized void doSaveAdmin(UserBean admin) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String insertSQL = "INSERT INTO utente (email, password, cognome, admin) VALUES (?, ?, ?, ?)";
		
		admin.setPassword(toHash(admin.getPassword())); //occorre memorizzare direttamente l'hash della pass nel db
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, admin.getEmail());
			preparedStatement.setString(2, admin.getPassword());
			preparedStatement.setString(3, admin.getCognome());
			preparedStatement.setBoolean(4, true);

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
	public synchronized String doSaveUser(UserBean user) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String insertSQL = "INSERT INTO utente (email, password, nome, cognome, admin) VALUES (?, ?, ?, ?, ?)";
		
		user.setPassword(toHash(user.getPassword()));
		try {
			connection = ds.getConnection();
			
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, user.getEmail());
			preparedStatement.setString(2, user.getPassword());
			preparedStatement.setString(3, user.getNome());
			preparedStatement.setString(4, user.getCognome());
			preparedStatement.setBoolean(5, false);
		
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
		
		return user.getEmail();
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
				taglie.setQuantitaXXL(rs.getInt("taglieXXL"));
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
				bean.setQuantity(rs.getInt("QUANTITY"));
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
				bean.setQuantity(rs.getInt("QUANTITY"));
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
	
	@Override
	public synchronized Collection<UserBean> doRetrieveAllUsers(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<UserBean> users = new LinkedList<UserBean>();

		String selectSQL = "SELECT * FROM utente" ;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				UserBean bean = new UserBean();

				bean.setId(rs.getInt("idutente"));
				bean.setEmail(rs.getString("email"));
				bean.setNome(rs.getString("nome"));
				bean.setCognome(rs.getString("cognome"));
				bean.setPassword(rs.getString("password"));
				bean.setIndirizzo(rs.getString("indirizzo"));
				bean.setMetodo_pagamento(rs.getString("metodo_pagamento"));
				bean.setAdmin(rs.getBoolean("admin"));
				users.add(bean);
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
		return users;
	}
	
	public synchronized UserBean loginUserOrAdmin(String email, String password) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String selectSQLUser = "SELECT * FROM utente";

		String hashPassword = toHash(password);
		String emailToBeMatch = null;
		String hashPasswordToBeMatch = null;
		
		UserBean user = new UserBean();
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQLUser);
			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				emailToBeMatch = rs.getString("email"); //prelevo tutte le email dal db
				hashPasswordToBeMatch = rs.getString("password"); //prelevo tutte le password dal db
				
				
				if(emailToBeMatch.equals(email) && hashPasswordToBeMatch.equals(hashPassword)) {
					System.out.println(" ***** "+hashPasswordToBeMatch+"--"+hashPassword+"\n");
					boolean admin = rs.getBoolean("admin"); 
					if(admin) {
						user.setId(rs.getInt("idutente"));
						user.setEmail(rs.getString("email"));
						user.setPassword(rs.getString("password"));
						user.setCognome(rs.getString("cognome"));
						user.setAdmin(rs.getBoolean("admin"));
					} else {
						user.setId(rs.getInt("idutente"));
						user.setEmail(rs.getString("email"));
						user.setPassword(rs.getString("password"));
						user.setCognome(rs.getString("cognome"));
						user.setNome(rs.getString("nome"));
						user.setIndirizzo(rs.getString("indirizzo"));
						user.setCap(rs.getString("cap"));
						user.setAdmin(rs.getBoolean("admin"));
					}
					System.out.println(user);
					return user;
				}
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
		
		return null;
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
	
	private String toHash(String password) {
        String hashString = null;
        try {
            java.security.MessageDigest digest = java.security.MessageDigest.getInstance("SHA-512");
            byte[] hash = digest.digest(password.getBytes(StandardCharsets.UTF_8));
            hashString = "";
            for (int i = 0; i < hash.length; i++) {
                hashString += Integer.toHexString( 
                                  (hash[i] & 0xFF) | 0x100 
                              ).toLowerCase().substring(1,3);
            }
        } catch (java.security.NoSuchAlgorithmException e) {
            System.out.println(e);
        }
        return hashString;
    }
	
	@Override
	public boolean doDeleteUser(String email) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		String deleteSQL = "DELETE FROM utente WHERE email = ?";
		int result = 0;
		
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setString(1, email);

			result = preparedStatement.executeUpdate();
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
		return (result != 0);
		
	}
}