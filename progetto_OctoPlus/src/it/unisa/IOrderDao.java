package it.unisa;

import java.sql.SQLException;
import java.util.Collection;

import it.model.CartBean;
import it.model.OrderBean;

public interface IOrderDao {

	void doSave(OrderBean order) throws SQLException;

	void doSaveAll(OrderBean order, Double ptotm) throws SQLException;

	Collection<OrderBean> doRetrieveAllOrders(String order) throws SQLException;
	
	void removeOrder(int parseInt) throws SQLException;
	
	Collection<OrderBean> doRetrieveAllByKey(String email) throws SQLException;
}
