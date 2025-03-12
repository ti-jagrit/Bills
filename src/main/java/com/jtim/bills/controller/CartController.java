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

import com.jtim.bills.entity.Cart;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.CartService;
import com.jtim.bills.service.CompanyService;
import com.jtim.bills.service.ProductService;
import com.jtim.bills.service.UserService;

@RequestMapping("/user/cart")
@Controller
public class CartController {
	@Autowired
	private ProductService productService;
	@Autowired 
	private UserService userService;
	@Autowired
	private CartService cartService;
	@Autowired
	private CompanyService companyService;
	
	
	
	
//	user/cart/add/${product.id}
	@GetMapping("/add/{id}")
	public String addCart(Principal p, @PathVariable int id, RedirectAttributes redirectAttributes, Model m) {
		Cart cart= new Cart();
		User ud=userService.getUserByEmail(p.getName());
		List<Cart> cc=cartService.getCartByUser(ud);
		boolean avv=false;
		int acid=0;
		m.addAttribute("user",ud);
		for (Cart test : cc) {
			if(test.getProduct()==productService.getProductById(id)) {
				acid=test.getId();
				
				avv=true;
			}
			
		}
		if (avv && acid!=0) {
			
			cart=cartService.getCartById(acid);
			cart.setQty(cart.getQty()+1);
			cartService.updateCart(cart);
			m.addAttribute("company",companyService.getCompanyById(1));
		}
		else {
		
		cart.setProduct(productService.getProductById(id));
		cart.setQty(1);
		cart.setAddedDate(LocalDate.now());
		cart.setUser(userService.getUserByEmail(p.getName()));
		cartService.saveCart(cart);
		}
		redirectAttributes.addFlashAttribute("success","product Added to Cart");
		return "redirect:/product";
	}
	
	@GetMapping("/show")
	public String showCart(Model m, Principal p) {
		User user=userService.getUserByEmail(p.getName());
		m.addAttribute("user",user);
		m.addAttribute("cart_list", cartService.getCartByUser(user));
		m.addAttribute("company",companyService.getCompanyById(1));
		return"frontend/Cart";
	}
	@PostMapping("/update/{id}")
	public String updateCart(@PathVariable int id, @ModelAttribute Cart cart, RedirectAttributes redirectAttributes) {
		Cart c=cartService.getCartById(id);
		int qty = c.getProduct().getQty();
		if(cart.getQty()<=qty) {
		cartService.updateCart(cart);
		redirectAttributes.addFlashAttribute("success", "Cart Updated Sucessfully");
		}
		else {
			redirectAttributes.addFlashAttribute("error", "Quantity Out of stock");
		}
		return"redirect:/user/cart/show";
	}
	
	@GetMapping("/delete/{id}")
	public String deleteCart(@PathVariable int id, RedirectAttributes redirectAttributes) {
		Cart cart= cartService.getCartById(id);
		cartService.deleteCart(cart);
		redirectAttributes.addFlashAttribute("success", "Cart Item Deleted!");
		
		return"redirect:/user/cart/show";
	}
	

}
