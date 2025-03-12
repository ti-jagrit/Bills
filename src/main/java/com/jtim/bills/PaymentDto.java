package com.jtim.bills;

public class PaymentDto {
	private double amount;
	private double taxAmount;
	private double psc;
	private double pdc;
	private double totalAmount;
	private String transactionUUID;
	private String productCode;
	private String signedField;
	private String signature;
	private String successUrl;
	private String failureUrl;
	
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public double getTaxAmount() {
		return taxAmount;
	}
	public void setTaxAmount(double taxAmount) {
		this.taxAmount = taxAmount;
	}
	public double getPsc() {
		return psc;
	}
	public void setPsc(double psc) {
		this.psc = psc;
	}
	public double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getTransactionUUID() {
		return transactionUUID;
	}
	public void setTransactionUUID(String transactionUUID) {
		this.transactionUUID = transactionUUID;
	}
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public String getSignedField() {
		return signedField;
	}
	public void setSignedField(String signedField) {
		this.signedField = signedField;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getSuccessUrl() {
		return successUrl;
	}
	public void setSuccessUrl(String successUrl) {
		this.successUrl = successUrl;
	}
	public String getFailureUrl() {
		return failureUrl;
	}
	public void setFailureUrl(String failureUrl) {
		this.failureUrl = failureUrl;
	}
	public double getPdc() {
		return pdc;
	}
	public void setPdc(double pdc) {
		this.pdc = pdc;
	}
	public PaymentDto() {
		super();
	}
	public PaymentDto(double amount, double taxAmount, double psc, double totalAmount, String transactionUUID,
			String productCode, String signedField, String signature, String successUrl, String failureUrl, Double pdc) {
		super();
		this.amount = amount;
		this.taxAmount = taxAmount;
		this.psc = psc;
		this.totalAmount = totalAmount;
		this.transactionUUID = transactionUUID;
		this.productCode = productCode;
		this.signedField = signedField;
		this.signature = signature;
		this.successUrl = successUrl;
		this.failureUrl = failureUrl;
		this.pdc=psc;
	}
	
	
	
	
	

}
