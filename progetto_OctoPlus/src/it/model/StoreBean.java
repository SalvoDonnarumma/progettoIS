package it.model;

import java.util.ArrayList;
import java.util.List;

public class StoreBean {
	List<OrderBean> allorders;
	
	public StoreBean() {
		allorders = new ArrayList<OrderBean>();
	}

	public List<OrderBean> getAllorders() {
		return allorders;
	}

	public void setAllorders(List<OrderBean> allorders) {
		this.allorders = allorders;
	}
	
}
