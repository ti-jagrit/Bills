package com.jtim.bills.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.text.pdf.PdfStructTreeController.returnType;
import com.jtim.bills.dao.OrderDao;
import com.jtim.bills.entity.Orders;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.OrderService;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {
@Autowired
private OrderDao orderDao;
	@Override
	public Orders saveOrder(Orders order) {
		Orders od=orderDao.save(order);
		return od;
	}

	@Override
	public List<Orders> getAllOrders() {
		return orderDao .findByExpire(false);
		
	}
	@Override
	public List<Orders> getAllTheOrders() {
		return orderDao.findAll();
	}
	
	@Override
	public Orders getOrderById(int id) {
		// TODO Auto-generated method stub
		return orderDao.findById(id).get();
	}

	@Override
	public List<Orders> getOrderByUser(User user) {
		// TODO Auto-generated method stub
		return orderDao.findByUser(user);
	}

	@Override
	public void update(Orders order) {
		// TODO Auto-generated method stub
		orderDao.saveAndFlush(order);
	}

	@Override
	public void deleteOrder(Orders order) {
		// TODO Auto-generated method stub
		orderDao.delete(order);
	}

	

}
