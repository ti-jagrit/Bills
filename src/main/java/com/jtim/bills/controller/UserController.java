package com.jtim.bills.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jtim.bills.entity.User;
import com.jtim.bills.entity.UserRole;
import com.jtim.bills.service.FileUploadService;
import com.jtim.bills.service.UserService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("admin/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	@Autowired
	private FileUploadService fileUploadService;
	
	@GetMapping("/add")
	public String showAddUser(Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user",ud);
		return("backend/addUser");
			}
	@PostMapping("/add")
	public ModelAndView addUser(Principal p, Model m,@Valid @ModelAttribute User user, BindingResult result) {
		if(result.hasErrors()) {
			ModelAndView modelAndView= new ModelAndView("backend/addUser");
			modelAndView.addObject("valid_errors", result.getAllErrors());
			return modelAndView;
		}
		
		UserRole userRole= new UserRole();
		userRole.setRole("ROLE_USER");
		user.setEnable("1");
		user.setUserRole(userRole);
		userRole.setUser(user);
		userService.saveUser(user);
		return new ModelAndView("redirect:/admin/user/add");
	}
	
	@GetMapping("/list")
	public String showUsers(Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user", ud);
		m.addAttribute("user_list",userService.getAllUsers());	
		return "backend/userList";
	}
	
	@GetMapping("/edit/{id}")
	public String showUserEdit(@PathVariable int id, Model m, Principal p) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user",ud);
				
		m.addAttribute("edit",true);
		m.addAttribute("us", userService.getUserById(id));
		return"backend/addUser";
	}
	
	@PostMapping("/edit")
	public String updateUser(@ModelAttribute User user,RedirectAttributes redirectAttributes,
			@RequestParam(name = "oldphoto") String user_photo) {
		if(user.getImageFile().isEmpty()) {
			user.setPhoto(user_photo);
		}
		else {			
			if(fileUploadService.uploadImage(user.getImageFile(), "user_image")) {
			String imageName="user_image/"+user.getImageFile().getOriginalFilename();
			user.setPhoto(imageName);
			}
		}
		user.setPassword(userService.getUserById(user.getId()).getPassword());
		user.setEnable("1");
		
		userService.updateUser(user);
		redirectAttributes.addFlashAttribute("success", "user Upadted SuccessFully");
		return "redirect:/admin/user/list#user_data";
	}
	
	

	
	
	@PostMapping("/delete/{id}")
	public String deleteUser(@PathVariable int id, RedirectAttributes redirectAttributes) {
		User user=userService.getUserById(id);
		if(user!=null) {
			userService.deleteUser(user);
			redirectAttributes.addFlashAttribute("success","User Deleted Successfully");
			return "redirect:/admin/user/list#user_data?delete=success";
			
		}
		else {
			redirectAttributes.addFlashAttribute("error","Failed to Delete User");
			return "redirect:/admin/user/list#user_data?delete=failed";
			
		}
			
	}
	
	


}
