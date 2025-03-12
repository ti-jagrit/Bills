package com.jtim.bills.service;

import java.util.List;

import com.jtim.bills.entity.User;

public interface UserService {
	public void saveUser(User user);
	public List<User> getAllUsers();
	public List<User> getAllAdmins();
	public List<User> getAllCustomer();
	public User getUserById(int id);
	public User getUserByEmail(String email);
	public void updateUser(User user);
	public void deleteUser(User user);

}
