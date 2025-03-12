package com.jtim.bills.service;

public interface PaymentService {
	public String generateEsewaSignature(String secrect, String message);

}
