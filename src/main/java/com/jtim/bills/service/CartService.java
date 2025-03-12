package com.jtim.bills.service;

import java.util.List;

import com.jtim.bills.entity.Cart;
import com.jtim.bills.entity.User;

public interface CartService {
	public void saveCart(Cart cart);
	public Cart getCartById(int id);
	public List<Cart> getCartByUser(User user);
	public void updateCart(Cart cart);
	public void deleteCart(Cart cart);
	public void deleteUserCart(User user);
	
	

}
