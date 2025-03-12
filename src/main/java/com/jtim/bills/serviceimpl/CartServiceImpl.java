package com.jtim.bills.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtim.bills.dao.CartDao;
import com.jtim.bills.entity.Cart;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.CartService;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class CartServiceImpl implements CartService {

	@Autowired
	private CartDao cartDao;

	@Override
	public void saveCart(Cart cart) {
		cartDao.save(cart);

	}

	@Override
	public Cart getCartById(int id) {
		// TODO Auto-generated method stub
		return cartDao.findById(id).get();
	}

	@Override
	public List<Cart> getCartByUser(User user) {
		// TODO Auto-generated method stub
		return cartDao.findByUser(user);
	}

	@Override
	public void updateCart(Cart cart) {
		cartDao.saveAndFlush(cart);

	}

	@Override
	public void deleteCart(Cart cart) {
		cartDao.delete(cart);

	}

	@Override
	public void deleteUserCart(User user) {
		List<Cart> carts= cartDao.findByUser(user);
		for (Cart cart : carts) {
			cartDao.delete(cart);
			
		}

	}

}
