package com.jtim.bills.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jtim.bills.entity.Category;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.CategoryService;
import com.jtim.bills.service.UserService;

@RequestMapping("/admin/category")
@Controller
public class CategoryController {

	@Autowired
	private UserService userService;
	@Autowired
	private CategoryService categoryService;

	// Show all categories with the option to add a new category
	@GetMapping("/show")
	public String showCategory(Model model, Principal p) {
		User ud = userService.getUserByEmail(p.getName());
		model.addAttribute("user",ud);
		model.addAttribute("cat_list", categoryService.getAllCategories());
		model.addAttribute("category", new Category()); // Ensure empty form for adding
		return "backend/category";
	}

	// Add a new category
	@PostMapping("/add")
	public String insertCategory(@ModelAttribute Category category, RedirectAttributes redirectAttributes) {
		categoryService.addCategory(category);
		redirectAttributes.addFlashAttribute("success", "Category Added Sucessfully");
		return "redirect:/admin/category/show"; // Redirect to avoid resubmission
	}

	// Show edit page for a specific category
	@GetMapping("/edit/{cat_id}")
	public String showEditCategory(@PathVariable("cat_id") int id, Model m, Principal p) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user",ud);
		m.addAttribute("edit", true); // Indicate editing mode
		m.addAttribute("cat_list", categoryService.getAllCategories());
		m.addAttribute("edit_cat", categoryService.getCategoryById(id));
		return "backend/category";
	}

	// Update an existing category
	@PostMapping("/edit")
	public String updateCategory(@ModelAttribute Category category, RedirectAttributes redirectAttributes) {
		categoryService.updateCategory(category);

		redirectAttributes.addFlashAttribute("success", "Category Updated Sucessfully");

		return "redirect:/admin/category/show#category_data";
	}

	// Delete a category
	@PostMapping("/delete/{id}")
	public String deleteCategory(@PathVariable int id, RedirectAttributes redirectAttributes) {
		Category cat = categoryService.getCategoryById(id);
		if (cat != null) {
			categoryService.deleteCategory(cat);
			redirectAttributes.addFlashAttribute("success", "Category Deleted Sucessfully");
			return "redirect:/admin/category/show#category_data?delete=success";
		} else {
			redirectAttributes.addFlashAttribute("error", "Cannot Delete Category");
			return "redirect:/admin/category/show#category_data?delete=failed";
		}
	}
}
