package com.jtim.bills.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jtim.bills.entity.User;
import com.jtim.bills.entity.Work;
import com.jtim.bills.service.UserService;
import com.jtim.bills.service.WorkService;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("admin/work/")
public class WorkController {
	@Autowired
	private UserService userService;
	@Autowired
	private WorkService workService;

	@GetMapping("create")
	public String showWorkAdd(Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		List<User> customer = userService.getAllUsers();
		m.addAttribute("customer_list", customer);
		m.addAttribute("user", ud);
		return "backend/createWork";
	}

	@PostMapping("/add")
	public String addWork(@ModelAttribute Work work, RedirectAttributes redirectAttributes, Principal p) {
		work.setOrderDate(LocalDate.now());
		work.setTotal(work.getPrice() * work.getQty());
		work.setUpdatedBy(userService.getUserByEmail(p.getName()));
		workService.saveWork(work);
		redirectAttributes.addFlashAttribute("success", "Task Create Successfully");
		return "redirect:/admin/work/view";

	}

	@GetMapping("/view")
	public String showWork(Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		List<Work> work_List = workService.getAllWork();
		m.addAttribute("work_List", work_List);
		m.addAttribute("user", ud);
		List<User> admins = userService.getAllAdmins();
		m.addAttribute("admins", admins);
		return "backend/showWork";
	}

	@GetMapping("mywork")
	public String showAssignWorks(Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user", ud);
		m.addAttribute("assign_works",workService.getAssignedWork(ud));
		return "backend/assignedWork";

	}

	@GetMapping("/details/{id}")
	public String showWorkDetails(@PathVariable int id, Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		Work work = workService.getWorkById(id);
		m.addAttribute("work", work);
		m.addAttribute("user", ud);
		return "backend/showWorkDetails";
	}

	@GetMapping("customer/{id}")
	public String showCustomerWork(@PathVariable int id, Model m) {
		User customer = userService.getUserById(id);
		List<Work> works = workService.getWorkByCustomer(customer);
		m.addAttribute("cus_work", works);
		m.addAttribute("customer", customer);

		return "backend/customerWork";
	}

	@PostMapping("assign")
	public String assignAdmin(@RequestParam("workId") int id, @RequestParam("assignTo") int admin,
			@RequestParam("deadline") int dea, RedirectAttributes redirectAttributes) {
		Work work = workService.getWorkById(id);
		work.setAssignTo(userService.getUserById(admin));
		work.setDeadline(dea);
		workService.updateWork(work);
		redirectAttributes.addFlashAttribute("Sucess", "Work Assign Successfully");
		return "redirect:/admin/work/view";

	}

}
