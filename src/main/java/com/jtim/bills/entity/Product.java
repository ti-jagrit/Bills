package com.jtim.bills.entity;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "product")
public class Product implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="product_id")
	private int id;
	
	@Column(name = "name")
	private String name;
	
	@ManyToOne
	@JoinColumn(name="category_id")
	private Category category;
	private String sp;
	private String cp;
	private int qty;
	@Column(name="slug", unique=true)
	private String slug;
	private String description;
	private String image;
	@Transient
	private MultipartFile imageFile;
	private LocalDate addedDate;
	
	@OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<Cart> cartList = new ArrayList<>();
	
	public Product() {
		super();
	}


	public Product(int id, String name, Category category, String sp, String cp, int qty, String slug,
			String description, String image,LocalDate addedDate, MultipartFile imageFile, List<Cart> cartList) {
		super();
		this.id = id;
		this.name = name;
		this.category = category;
		this.sp = sp;
		this.cp = cp;
		this.qty = qty;
		this.slug = slug;
		this.description = description;
		this.image = image;
		this.addedDate=addedDate;
		this.imageFile=imageFile;
		this.cartList=cartList;
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


	public Category getCategory() {
		return category;
	}


	public void setCategory(Category category) {
		this.category = category;
	}


	public String getSp() {
		return sp;
	}


	public void setSp(String sp) {
		this.sp = sp;
	}


	public String getCp() {
		return cp;
	}


	public void setCp(String cp) {
		this.cp = cp;
	}


	public int getQty() {
		return qty;
	}
	


	public void setQty(int qty) {
		this.qty = qty;
	}


	public String getSlug() {
		return slug;
	}


	public void setSlug(String slug) {
		this.slug = slug;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	public LocalDate getAddedDate() {
		return addedDate;
	}


	public void setAddedDate(LocalDate addedDate) {
		this.addedDate = addedDate;
	}


	public MultipartFile getImageFile() {
		return imageFile;
	}


	public void setImageFile(MultipartFile imageFile) {
		this.imageFile = imageFile;
	}


	public List<Cart> getCartList() {
		return cartList;
	}


	public void setCartList(List<Cart> cartList) {
		this.cartList = cartList;
	}
	
	
	
	
	
	
	

}
