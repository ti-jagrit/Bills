package com.jtim.bills.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.jtim.bills.entity.Product;
import com.jtim.bills.entity.User;
import com.jtim.bills.entity.UserRole;
import com.jtim.bills.service.CompanyService;
import com.jtim.bills.service.FileUploadService;
import com.jtim.bills.service.ProductService;
import com.jtim.bills.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
public class HomeController {
	@Autowired
	private UserService userService;
	@Autowired
	private ProductService productService;
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private FileUploadService fileUploadService;
	@Autowired
	private CompanyService companyService;

	@GetMapping({ "/home", "/" })
	public String showHome(Principal p, Model m) {
		
		if (p != null) {
			System.out.println(p.getName());
			User ud = userService.getUserByEmail(p.getName());
			m.addAttribute("user", ud);
		}
		m.addAttribute("company",companyService.getCompanyById(1));
		return "frontend/home";
	}
	
	@GetMapping("/home/{em}")
	public String showHomeEmail(@PathVariable String em,Model m) {
			User ud = userService.getUserByEmail(em);
			m.addAttribute("user", ud);
		
		m.addAttribute("company",companyService.getCompanyById(1));
		return "frontend/home";
	}

	@GetMapping("/register")
	public String showRegister(Model m) {
		m.addAttribute("company",companyService.getCompanyById(1));
		return "register";
	}

	@GetMapping("/about")
	public String showAbout(Principal p, Model m) {
		if (p != null) {
			User ud = userService.getUserByEmail(p.getName());
			m.addAttribute("user", ud);
		}
		m.addAttribute("company",companyService.getCompanyById(1));
		return "frontend/about";
	}

	@GetMapping("/userlogin")
	public String showUseLogin(Model m) {
		m.addAttribute("company",companyService.getCompanyById(1));
		return "login";
	}

	@GetMapping("/loginsuccess")
	public String showDashboard(Principal p, Model m, RedirectAttributes redirectAttributes, HttpServletRequest request) {
	    String referer =(String) request.getSession().getAttribute("previousUrl");
	    System.out.println("Referer Url :"+referer);

	    if (p != null) {
	        User ud = userService.getUserByEmail(p.getName());
	        m.addAttribute("user", ud.getName());
	        m.addAttribute("company", companyService.getCompanyById(1));
	        
	        String role = ud.getUserRole().getRole();

	        if ("ROLE_ADMIN".equals(role)) {
	            if (referer != null && referer.contains("admin")) {
	            	System.out.println("ROle Admin: "+referer);
	                return "redirect:" + referer;
	            }
	            return "redirect:/admin";
	        }

	        if ("ROLE_USER".equals(role)) {
	            if (referer != null && !referer.contains("admin")) {
	            	System.out.println("ROle User: "+referer);
	                return "redirect:" + referer;
	                
	            }
	            return "redirect:/home";
	        }

	        redirectAttributes.addFlashAttribute("error", "Invalid role detected");
	    } else {
	        redirectAttributes.addFlashAttribute("error", "User is not authenticated");
	    }

	    return "redirect:/userlogin";
	}


	@GetMapping("/loginfailed")
	public String showLoginFailed(RedirectAttributes redirectAttributes, Model m) {
		redirectAttributes.addFlashAttribute("error", "Email or Password Incorrect");
		m.addAttribute("company",companyService.getCompanyById(1));
		return "redirect:/userlogin";
	}

	@PostMapping("/register")
	public String userStore(@Valid @ModelAttribute User user, BindingResult bindingResult, Model m,
			RedirectAttributes redirectAttributes) {
		if (bindingResult.hasErrors()) {
			m.addAttribute("errors", bindingResult.getAllErrors());
		
			return "register";
			
		}
		
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		if (fileUploadService.uploadImage(user.getImageFile(), "user_image")) {
			String imageName = "user_image/" + user.getImageFile().getOriginalFilename();
			user.setPhoto(imageName);
		}
		UserRole userRole = new UserRole();
		userRole.setRole("ROLE_USER");
		user.setEnable("1");
		user.setUserRole(userRole);
		userRole.setUser(user);
		userService.saveUser(user);
		redirectAttributes.addFlashAttribute("success", "User Register Successfully");
		return "redirect:/userlogin";
	}

	@GetMapping("/product")
	public String showProducts(Model m, Principal p) {
		if (p != null) {
			User ud = userService.getUserByEmail(p.getName());
			m.addAttribute("user", ud);
		}
		m.addAttribute("company",companyService.getCompanyById(1));
		m.addAttribute("product_list", productService.getAllProducts());
		return ("frontend/product");

	}

	@GetMapping("/user/userprofile")
	public String showUserProfile(Model m, Principal p) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user", ud);
		m.addAttribute("company",companyService.getCompanyById(1));
		return ("frontend/userProfile");

	}

	// to show product deatails
	@GetMapping("/product/show/{id}")
	public String showProducDetails(@PathVariable int id, Model m, Principal p) {
		if (p != null) {
			User ud = userService.getUserByEmail(p.getName());
			m.addAttribute("user", ud);
		}
		m.addAttribute("company",companyService.getCompanyById(1));

		Product product = productService.getProductById(id);
		m.addAttribute("product", product);
		return "frontend/productDetails";
	}

	@PostMapping("/user/deleteprofile/{id}")
	public String deleteUserAccount(@PathVariable int id, RedirectAttributes redirectAttributes, Principal p, Model m) {
		User user = userService.getUserById(id);
		if (user != null) {
			m.addAttribute("company",companyService.getCompanyById(1));
			userService.deleteUser(user);
			redirectAttributes.addFlashAttribute("success", "Your Account is deleted Successfully");
			return "redirect:/";
		} else {
			if (p != null) {
				User ud = userService.getUserByEmail(p.getName());
				m.addAttribute("user", ud);
			}
			m.addAttribute("company",companyService.getCompanyById(1));
			redirectAttributes.addFlashAttribute("error", "Error in Account Deletion");
			return "redirect:/user/userprofile";
		}
	}

	@PostMapping("/user/changepass/{id}")
	public String changePassword(RedirectAttributes redirectAttributes, @PathVariable int id,
			@RequestParam(name = "npass") String np, @RequestParam(name = "cpass") String cp) {
		User user = userService.getUserById(id);
		
		if (passwordEncoder.matches(cp, user.getPassword())) {

			if (passwordEncoder.matches(np, user.getPassword())) {
				redirectAttributes.addFlashAttribute("error", "Use Other Password");
			} else {
				user.setPassword(passwordEncoder.encode(np));
				userService.saveUser(user);
				redirectAttributes.addFlashAttribute("success", "Password Changed Successfully");
			}
		} else {
			redirectAttributes.addFlashAttribute("error", "eroor");
		}

		return "redirect:/user/userprofile";

	}

	@GetMapping("/user/editprofile/{id}")
	public String showEditProfile(Principal p, Model m) {
		User user = userService.getUserByEmail(p.getName());
		m.addAttribute("user", user);
		m.addAttribute("company",companyService.getCompanyById(1));
		return "frontend/editprofile";
	}

	@PostMapping("/user/editprofile")
	public String updateUser(@Valid @ModelAttribute User user, Principal p, BindingResult bindingResult, Model m,
			RedirectAttributes redirectAttributes, @RequestParam(name = "oldphoto") String user_photo) {
		if (bindingResult.hasErrors()) {
			m.addAttribute("errors", bindingResult.getAllErrors());
			return "frontend/editprofile";
		}
		m.addAttribute("company",companyService.getCompanyById(1));
		if (user.getImageFile().isEmpty()) {
			user.setPhoto(user_photo);
		} else {
			if (fileUploadService.uploadImage(user.getImageFile(), "user_image")) {
				String imageName = "user_image/" + user.getImageFile().getOriginalFilename();
				user.setPhoto(imageName);
			}
		}
		user.setPassword(userService.getUserById(user.getId()).getPassword());
		user.setEnable("1");

		userService.updateUser(user);
		redirectAttributes.addFlashAttribute("success", "Profile Updated Successfully");
		return "redirect:/user/userprofile";

	}

}
