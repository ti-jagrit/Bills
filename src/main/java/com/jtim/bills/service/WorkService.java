package com.jtim.bills.service;

import java.util.List;

import com.jtim.bills.entity.User;
import com.jtim.bills.entity.Work;

public interface WorkService {
	public void saveWork(Work work);
	public Work getWorkById(int id);
	public List<Work> getWorkByCustomer(User user);
	public List<Work> getAllWork();
	public List<Work> getAssignedWork(User user);
	public void deleteWork(Work work);
	public void updateWork(Work work);

}
