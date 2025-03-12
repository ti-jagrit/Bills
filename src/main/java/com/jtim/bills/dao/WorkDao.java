package com.jtim.bills.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jtim.bills.entity.User;
import com.jtim.bills.entity.Work;

public interface WorkDao extends JpaRepository<Work, Integer>{
 
	public List<Work> findByCustomer(User customer);
	public List<Work> findByAssignTo(User admin);
}
