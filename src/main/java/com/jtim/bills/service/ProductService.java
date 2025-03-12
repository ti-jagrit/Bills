package com.jtim.bills.service;

import java.util.List;

import com.jtim.bills.entity.Category;
import com.jtim.bills.entity.Product;

public interface ProductService {
	public void addProduct(Product product);
	public List<Product> getAllProducts();
	public Product getProductById(int id);
	public Product getProductByName(String name);
	public Product getProductBySlug(String slug);
	public void updateProduct(Product product);
	public void deleteProduct(Product product);
	public List<Product> getProductByCateogry(Category category);

}
