package com.jtim.bills.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.jtim.bills.entity.Company;
import com.jtim.bills.service.CompanyService;

@ControllerAdvice
public class GlobalController {
		    @Autowired
	    private CompanyService companyService;

	    @ModelAttribute("company")
	    public Company getCompany() {
	        return companyService.getCompanyById(1); // Fetch company data
	    }
	}



