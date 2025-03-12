package com.jtim.bills.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtim.bills.dao.ProductDao;
import com.jtim.bills.entity.Category;
import com.jtim.bills.entity.Product;
import com.jtim.bills.service.ProductService;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class ProductServiceImpl   implements ProductService{

	@Autowired
	private ProductDao productDao;
	
	
	@Override
	public void addProduct(Product product) {
		// TODO Auto-generated method stub
		productDao.save(product);
		
	}

	@Override
	public List<Product> getAllProducts() {
		// TODO Auto-generated method stub
		return productDao.findAll();
	}

	@Override
	public Product getProductById(int id) {
		// TODO Auto-generated method stub
		return productDao.findById(id).get();
	}

	@Override
	public Product getProductByName(String name) {
		// TODO Auto-generated method stub
		return productDao.findByName(name);
	}

	@Override
	public Product getProductBySlug(String slug) {
		// TODO Auto-generated method stub
		return productDao.findBySlug(slug);
	}

	@Override
	public void updateProduct(Product product) {
		// TODO Auto-generated method stub
		productDao.saveAndFlush(product);
	}

	@Override
	public void deleteProduct(Product product) {
		// TODO Auto-generated method stub
		productDao.delete(product);
		
	}
	public List<Product> getProductByCateogry(Category category){
		
		return productDao.findByCategory(category);
		
	}

}
