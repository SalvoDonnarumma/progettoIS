package it.unisa;

import java.sql.SQLException;

import it.model.CartBean;
import it.model.OrderBean;

public interface IOrderDao {

	void doSave(OrderBean order) throws SQLException;

	void doSaveAll(OrderBean order, Double ptotm) throws SQLException;
}
