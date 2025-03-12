package com.jtim.bills.serviceimpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtim.bills.dao.UserDao;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.UserService;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;

	@Override
	public void saveUser(User user) {
		// TODO Auto-generated method stub
		userDao.save(user);

	}

	@Override
	public List<User> getAllUsers() {
		// TODO Auto-generated method stub
		return userDao.findAll();
	}

	@Override
	public List<User> getAllAdmins() {
		List<User> users = userDao.findAll();
		List<User> admins = new ArrayList<>();
		for (User user : users) {
			System.out.println(user.getUserRole().getRole());
			if(user!=null && user.getUserRole().getRole().equals("ROLE_ADMIN")) {
			admins.add(user);
			}
		}
		return admins;
	}

	@Override
	public List<User> getAllCustomer() {
		List<User> users = userDao.findAll();
		List<User> customer = new ArrayList<>();
		for (User user : users) {
			if(user!=null &&user.getUserRole().getRole().equals("ROLE_USER")) {
			customer.add(user);
			}
		}
		return customer;
	}
	@Override
	public User getUserById(int id) {
		// TODO Auto-generated method stub
		return userDao.findById(id).get();
	}

	@Override
	public void updateUser(User user) {
		// TODO Auto-generated method stub
		userDao.saveAndFlush(user);

	}

	@Override
	public void deleteUser(User user) {
		// TODO Auto-generated method stub
		userDao.delete(user);

	}

	@Override
	public User getUserByEmail(String email) {
		// TODO Auto-generated method stub
		return userDao.findByEmail(email);
	}


}
