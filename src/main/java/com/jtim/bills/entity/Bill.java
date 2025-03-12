package com.jtim.bills.entity;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.validation.constraints.NotNull;

@Entity
public class Bill implements Serializable {


	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "bill_id")
	private int id;
	
	@Column(name = "bill_number", unique=true)
	@NotNull(message = "bill No is Requried")
	private int billNumber;
	
	private LocalDate createdDate;
	
	private Double total;
	private Double tax;
	private Double discount;
	private Double amount;
	
	@ManyToOne
	private User user;
	
	@OneToMany(mappedBy = "bill", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<BillItem> items;
	
	private String paymentMehtod;
	private String paymentStatus;
	private String remark;
	private String createdBy;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getBillNumber() {
		return billNumber;
	}
	public void setBillNumber(int billNumber) {
		this.billNumber = billNumber;
	}
	public LocalDate getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(LocalDate createdDate) {
		this.createdDate = createdDate;
	}
	public Double getTotal() {
		return total;
	}
	public void setTotal(Double total) {
		this.total = total;
	}
	public Double getTax() {
		return tax;
	}
	public void setTax(Double tax) {
		this.tax = tax;
	}
	public Double getDiscount() {
		return discount;
	}
	public void setDiscount(Double discount) {
		this.discount = discount;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List<BillItem> getItems() {
		return items;
	}
	public void setItems(List<BillItem> items) {
		this.items = items;
	}
	public String getPaymentMehtod() {
		return paymentMehtod;
	}
	public void setPaymentMehtod(String paymentMehtod) {
		this.paymentMehtod = paymentMehtod;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	
	
	
	
	public Bill() {
		super();
	}
	
	
	
	public Bill(int billNumber, LocalDate createdDate, Double total,
			Double tax, Double discount, Double amount, User user, List<BillItem> items, String paymentMehtod,
			String paymentStatus, String remark, String createdBy) {
		super();
		this.billNumber = billNumber;
		this.createdDate = createdDate;
		this.total = total;
		this.tax = tax;
		this.discount = discount;
		this.amount = amount;
		this.user = user;
		this.items = items;
		this.paymentMehtod = paymentMehtod;
		this.paymentStatus = paymentStatus;
		this.remark = remark;
		this.createdBy = createdBy;
	}
	
	
	

}
