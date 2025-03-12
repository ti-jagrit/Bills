package com.jtim.bills.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jtim.bills.entity.Bill;
import com.jtim.bills.entity.User;

public interface BillDao extends JpaRepository<Bill, Integer>{
	public List<Bill> findByUser(User user);

}
