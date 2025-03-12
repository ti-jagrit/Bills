package com.jtim.bills.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtim.bills.dao.WorkDao;
import com.jtim.bills.entity.User;
import com.jtim.bills.entity.Work;
import com.jtim.bills.service.WorkService;

@Service
public class WorkServiceImpl implements WorkService {

	@Autowired
	private WorkDao workDao;

	@Override
	public void saveWork(Work work) {
		workDao.save(work);
	}

	@Override
	public Work getWorkById(int id) {
		return workDao.findById(id).get();
	}
	@Override
	public List<Work> getAssignedWork(User user) {
		// TODO Auto-generated method stub
		return workDao.findByAssignTo(user);
	}

	@Override
	public List<Work> getWorkByCustomer(User user) {

		return workDao.findByCustomer(user);
	}

	@Override
	public List<Work> getAllWork() {
		return workDao.findAll();
	}

	@Override
	public void deleteWork(Work work) {
		workDao.delete(work);

	}

	@Override
	public void updateWork(Work work) {
		workDao.saveAndFlush(work);

	}

	

}
