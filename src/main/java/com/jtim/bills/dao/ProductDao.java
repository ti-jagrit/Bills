package com.jtim.bills.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jtim.bills.entity.Category;
import com.jtim.bills.entity.Product;



public interface ProductDao extends JpaRepository<Product, Integer> {
	public Product findByName(String name);
	public Product findBySlug(String slug);
	public List<Product> findByCategory(Category category);

}
