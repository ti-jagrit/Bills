package com.jtim.bills.serviceimpl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jtim.bills.dao.CompanyDao;
import com.jtim.bills.entity.Company;
import com.jtim.bills.service.CompanyService;

@Service
public class CompanyServiceImpl implements CompanyService {
	@Autowired
	private CompanyDao companyDao;

	@Override
	public void addCompany(Company company) {
		companyDao.save(company);

	}

	@Override
	public void updateCompany(Company company) {
		companyDao.saveAndFlush(company);
	}

	@Override
	public void deleteCompany(Company company) {
		companyDao.delete(company);
	}

	@Override
	public Company getCompanyById(int id) {
	    Optional<Company> company = companyDao.findById(id);
	    return company.orElse(null);
	}

}
