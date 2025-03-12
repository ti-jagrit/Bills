package com.jtim.bills.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jtim.bills.entity.User;
import com.jtim.bills.entity.UserRole;





public interface UserDao extends JpaRepository<User, Integer>{
	public User findByEmail(String email);
	public List<User> findByUserRole(UserRole userRole);

}
