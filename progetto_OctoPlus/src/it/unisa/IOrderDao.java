package it.unisa;

import java.sql.SQLException; 
import java.util.Collection;
import it.model.OrderBean;
import it.model.OrderedProduct;

public interface IOrderDao {

	Collection<OrderedProduct> doRetrieveById(String order, int code) throws SQLException; 
	
	void doSave(OrderBean order) throws SQLException;

	int doSaveAll(OrderBean order, Double ptotm) throws SQLException;

	Collection<OrderBean> doRetrieveAllOrders(String order) throws SQLException;
	
	void removeOrder(int parseInt) throws SQLException;
	
	Collection<OrderBean> doRetrieveAllByKey(String email) throws SQLException;

	void removeOrderByEmail(String email) throws SQLException;
}