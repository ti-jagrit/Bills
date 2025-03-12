package com.jtim.bills.service;

import java.util.List;

import com.jtim.bills.entity.Orders;
import com.jtim.bills.entity.User;

public interface OrderService {
	public Orders saveOrder(Orders order);
	public List<Orders> getAllOrders();
	public List<Orders> getAllTheOrders();
	public Orders getOrderById(int id);
	public List<Orders> getOrderByUser(User user);
	public void update(Orders order);
	public void deleteOrder(Orders order);
	

}
