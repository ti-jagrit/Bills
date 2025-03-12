package com.jtim.bills.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtim.bills.dao.BillDao;
import com.jtim.bills.entity.Bill;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.BillService;

@Service
public class BillServiceImpl implements BillService {
	
	@Autowired
	private BillDao billDao;

	@Override
	public Bill saveBill(Bill bill) {
		// TODO Auto-generated method stub
		Bill bb=billDao.save(bill);
		
		return bb;
	}

	@Override
	public List<Bill> getAllBills() {
		// TODO Auto-generated method stub
		return billDao.findAll();
	}

	@Override
	public Bill getBillById(int id) {
		// TODO Auto-generated method stub
		return billDao.findById(id).get();
	}

	@Override
	public List<Bill> getBillByUser(User user) {
		// TODO Auto-generated method stub
		return billDao.findByUser(user);
	}

	@Override
	public void updateBill(Bill bill) {
		// TODO Auto-generated method stub
		billDao.saveAndFlush(bill);
		
	}

	@Override
	public void DeleteBill(Bill bill) {
		// TODO Auto-generated method stub
		billDao.delete(bill);
		
	}
	

}
