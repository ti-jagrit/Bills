package com.jtim.bills.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.jtim.bills.entity.Company;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.CompanyService;
import com.jtim.bills.service.FileUploadService;
import com.jtim.bills.service.UserService;

@Controller
@RequestMapping("/admin/company")
public class CompanyController {
	@Autowired
	private CompanyService companyService;
	@Autowired
	private UserService userService;
	@Autowired
	private FileUploadService fileUploadService;

	@GetMapping("/add")
	public String showAddCompany(Principal p, Model model) {
		User user = userService.getUserByEmail(p.getName());

		Company company = companyService.getCompanyById(1);
		if (company == null) {
			company = new Company();
			company.setName("Company Name Pvt. Ltd.");
			company.setLogo("image/user.png");
			company.setPan("1012/0000");
			company.setAddress("Kathmandu Nepal");
			company.setEmail("Example");
			company.setPhone("9841000000");
			company.setWebsite("company.com.np");
			company.setRegNo("2071/072");
			companyService.addCompany(company);
		}
		model.addAttribute("company", company);

		model.addAttribute("user", user);

		return "backend/addComapny";
	}

	@PostMapping("/add")
	public String AddCompany(@ModelAttribute Company company, @RequestParam String oldImage,
			RedirectAttributes redirectAttributes) {
		System.out.println("image: "+oldImage);
		if (company.getLogoImage().isEmpty()) {
			company.setLogo(oldImage);
		} else {
			if (fileUploadService.uploadImage(company.getLogoImage(), "company")) {
				String img = "company/" + company.getLogoImage().getOriginalFilename();
				company.setLogo(img);
			}
		}
		companyService.updateCompany(company);
		redirectAttributes.addFlashAttribute("success", "Compnay Details Updated Successfully");

		return "redirect:/admin/company/add";
	}

}
