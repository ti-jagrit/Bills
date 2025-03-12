package com.jtim.bills.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jtim.bills.entity.Orders;
import com.jtim.bills.entity.User;

public interface OrderDao extends JpaRepository<Orders, Integer>{
	
public List<Orders> findByUser(User user);
public List<Orders> findByExpire(boolean expire);
}
