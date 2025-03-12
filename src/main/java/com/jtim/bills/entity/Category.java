package com.jtim.bills.entity;

import java.io.Serializable;
import java.util.List;

import jakarta.validation.constraints.*;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name="category")
public class Category implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="category_id")
	private int id;
	
	@NotNull
	@Column(name="category_name", unique = true)
	private String name;
	@NotNull
	private String description;
	private int parent;
	@OneToMany(mappedBy = "category")
	private List<Product> products;
	
	public Category() {
		super();
	}

	

	public Category(int id, String name, String description, int parent, List<Product> products) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.parent = parent;
		this.products = products;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}



	public List<Product> getProducts() {
		return products;
	}



	public void setProducts(List<Product> products) {
		this.products = products;
	}

	
	
	
	
	
	

}
