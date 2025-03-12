package com.jtim.bills.service;

import java.util.List;

import com.jtim.bills.entity.Category;

public interface CategoryService {
	public void addCategory(Category category);
	public List<Category> getAllCategories();
	public Category getCategoryById(int id);
	public Category getCategoryByName(String name);
	public List<Category> getCategoryByParent(int parentId);
	public void updateCategory(Category category);
	public void deleteCategory(Category category);


}
