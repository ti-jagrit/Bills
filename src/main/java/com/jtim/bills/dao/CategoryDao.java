package com.jtim.bills.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jtim.bills.entity.Category;

@Repository
public interface CategoryDao extends JpaRepository<Category, Integer> {
	//auto generated method for save, findaAl, findById, update, delete
	
	public Category findByName(String name);
	public List<Category> findByParent(int parent);

}
