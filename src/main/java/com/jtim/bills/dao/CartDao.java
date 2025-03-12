package com.jtim.bills.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jtim.bills.entity.Cart;
import com.jtim.bills.entity.User;

public interface CartDao extends JpaRepository<Cart, Integer>{
	public List<Cart> findByUser(User user);

}
