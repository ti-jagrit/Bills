package com.jtim.bills.service;

import java.util.List;

import com.jtim.bills.entity.Bill;
import com.jtim.bills.entity.User;

public interface BillService {
	public Bill saveBill(Bill bill);
	public List<Bill> getAllBills();
	public Bill getBillById(int id);
	public List<Bill> getBillByUser(User user);
	public void updateBill(Bill bill);
	public void DeleteBill(Bill bill);
}
