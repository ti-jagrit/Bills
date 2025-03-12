package com.jtim.bills.service;

import com.jtim.bills.entity.Company;

public interface CompanyService {
	public void addCompany(Company company);
	public Company getCompanyById(int id);
	public void updateCompany(Company company);
	public void deleteCompany(Company company);

}
