package com.jtim.bills.entity;

import java.io.Serializable;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;


@Entity
public class Work implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "work_id")
	private int id;

	private String name;
	private String detail;
	private String size;
	private int qty;

	@ManyToOne
	@JoinColumn(name = "customer_id")
	private User customer;

	@Column(name = "order_date")
	private LocalDate orderDate;

	@Column(name = "deliver_date")
	private LocalDate deliverDate;

	@Column(name = "ready_date")
	private LocalDate readyDate;

	private int deadline;
	private String remark;
	private String delivery;
	@Column(name = "delivery_cost")
	private double deliveryCost;

	private double price;
	private double total;
	private double payment;

	private String status;
	@ManyToOne
	private User assignTo;
	
	@ManyToOne
	private User updatedBy;

	
	
	public Work() {
		super();
	}



	public Work(String name, String detail, String size, int qty, User customer, LocalDate orderDate,
			LocalDate deliverDate, LocalDate readyDate, int deadline, String remark, String delivery,
			double deliveryCost, double price, double total, double payment, String status, User assignTo,
			User updatedBy) {
		super();
		this.name = name;
		this.detail = detail;
		this.size = size;
		this.qty = qty;
		this.customer = customer;
		this.orderDate = orderDate;
		this.deliverDate = deliverDate;
		this.readyDate = readyDate;
		this.deadline = deadline;
		this.remark = remark;
		this.delivery = delivery;
		this.deliveryCost = deliveryCost;
		this.price = price;
		this.total = total;
		this.payment = payment;
		this.status = status;
		this.assignTo = assignTo;
		this.updatedBy = updatedBy;
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



	public String getDetail() {
		return detail;
	}



	public void setDetail(String detail) {
		this.detail = detail;
	}



	public String getSize() {
		return size;
	}



	public void setSize(String size) {
		this.size = size;
	}



	public int getQty() {
		return qty;
	}



	public void setQty(int qty) {
		this.qty = qty;
	}



	public User getCustomer() {
		return customer;
	}



	public void setCustomer(User customer) {
		this.customer = customer;
	}



	public LocalDate getOrderDate() {
		return orderDate;
	}



	public void setOrderDate(LocalDate orderDate) {
		this.orderDate = orderDate;
	}



	public LocalDate getDeliverDate() {
		return deliverDate;
	}



	public void setDeliverDate(LocalDate deliverDate) {
		this.deliverDate = deliverDate;
	}



	public LocalDate getReadyDate() {
		return readyDate;
	}



	public void setReadyDate(LocalDate readyDate) {
		this.readyDate = readyDate;
	}



	public int getDeadline() {
		return deadline;
	}



	public void setDeadline(int deadline) {
		this.deadline = deadline;
	}



	public String getRemark() {
		return remark;
	}



	public void setRemark(String remark) {
		this.remark = remark;
	}



	public String getDelivery() {
		return delivery;
	}



	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}



	public double getDeliveryCost() {
		return deliveryCost;
	}



	public void setDeliveryCost(double deliveryCost) {
		this.deliveryCost = deliveryCost;
	}



	public double getPrice() {
		return price;
	}



	public void setPrice(double price) {
		this.price = price;
	}



	public double getTotal() {
		return total;
	}



	public void setTotal(double total) {
		this.total = total;
	}



	public double getPayment() {
		return payment;
	}



	public void setPayment(double payment) {
		this.payment = payment;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public User getAssignTo() {
		return assignTo;
	}



	public void setAssignTo(User assignTo) {
		this.assignTo = assignTo;
	}



	public User getUpdatedBy() {
		return updatedBy;
	}



	public void setUpdatedBy(User updatedBy) {
		this.updatedBy = updatedBy;
	}
	
	
	
	
	
	
	

	

}
