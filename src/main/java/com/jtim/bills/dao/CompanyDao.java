package com.jtim.bills.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jtim.bills.entity.Company;

public interface CompanyDao extends JpaRepository<Company, Integer>{
	

}
