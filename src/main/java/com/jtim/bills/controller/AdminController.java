package com.jtim.bills.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.jtim.bills.entity.User;
import com.jtim.bills.entity.UserRole;
import com.jtim.bills.service.CategoryService;
import com.jtim.bills.service.FileUploadService;
import com.jtim.bills.service.OrderService;
import com.jtim.bills.service.ProductService;
import com.jtim.bills.service.UserService;

@Controller
public class AdminController {

	@Autowired
	private UserService userService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ProductService productService;
	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private FileUploadService fileUploadService;
	@Autowired
	private OrderService orderService;

	@GetMapping("/admin")
	public String showDashboard(Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user", ud);
		m.addAttribute("categoryCount", categoryService.getAllCategories().size());
		m.addAttribute("productCount", productService.getAllProducts().size());
		m.addAttribute("userCount", userService.getAllCustomer().size());
		m.addAttribute("adminCount", userService.getAllAdmins().size());
		m.addAttribute("orderCount", orderService.getAllOrders().size());
		return ("backend/dashboard");

	}

	@GetMapping("/admin/add")
	public String showAddAdmin(Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		List<User> adminList = userService.getAllUsers();
		m.addAttribute("user", ud);
		m.addAttribute("admins", adminList);
		return ("backend/addAdmin");
	}

	@PostMapping("/admin/add")
	public String addAdmin(Principal p, @ModelAttribute User admin, RedirectAttributes redirectAttributes) {

		admin.setPassword(passwordEncoder.encode((admin.getName().toLowerCase())));
		if (fileUploadService.uploadImage(admin.getImageFile(), "user_image")) {
			String imageName = "user_image/" + admin.getImageFile().getOriginalFilename();
			admin.setPhoto(imageName);
		}
		UserRole userRole = new UserRole();
		userRole.setRole("ROLE_ADMIN");
		admin.setEnable("1");
		admin.setUserRole(userRole);
		userRole.setUser(admin);
		userService.saveUser(admin);
		redirectAttributes.addFlashAttribute("success", "Admin Added Successfully.");
		return "redirect:/admin/add";

	}

	@GetMapping("admin/edit/{id}")
	public String showAdminEdit(@PathVariable int id, Model m, Principal p) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user", ud);
		List<User> adminList = userService.getAllUsers();
		m.addAttribute("admins", adminList);
		m.addAttribute("edit", true);
		m.addAttribute("us", userService.getUserById(id));
		return "backend/addAdmin";
	}

	@PostMapping("admin/edit")
	public String adminEdit(@ModelAttribute User admin, @RequestParam("old") String op,
			RedirectAttributes redirectAttributes) {
		User uu = userService.getUserById(admin.getId());
		if (admin.getImageFile().isEmpty()) {
			admin.setPhoto(op);
		} else {
			if (fileUploadService.uploadImage(admin.getImageFile(), "user_image")) {
				String imageName = "user_image/" + admin.getImageFile().getOriginalFilename();
				admin.setPhoto(imageName);
			}
		}
		admin.setEnable("1");
		admin.setPassword(uu.getPassword());
		userService.updateUser(admin);
		return "redirect:/admin/add";
	}

	@GetMapping("/admin/profile")
	public String showAdminProfile(Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user", ud);
		return ("backend/adminProfile");

	}

	@PostMapping("/admin/changepass/{id}")
	public String changePassword(RedirectAttributes redirectAttributes, @PathVariable int id,
			@RequestParam(name = "npass") String np, @RequestParam(name = "cpass") String cp) {
		User user = userService.getUserById(id);
		if (passwordEncoder.matches(cp, user.getPassword())) {
			if (passwordEncoder.matches(np, user.getPassword())) {
				redirectAttributes.addFlashAttribute("error", "User other Passwword");
			} else {

				user.setPassword(passwordEncoder.encode(np));
				userService.saveUser(user);
				redirectAttributes.addFlashAttribute("success", "Password Changed Successfully");
			}
		} else {
			redirectAttributes.addFlashAttribute("error", "Error in password Change");
		}

		return "redirect:/admin/profile";

	}

}
