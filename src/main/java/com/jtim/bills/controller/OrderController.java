package com.jtim.bills.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.security.Principal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jtim.bills.entity.Cart;
import com.jtim.bills.entity.Company;
import com.jtim.bills.entity.Orders;
import com.jtim.bills.entity.Product;
import com.jtim.bills.entity.OrderedProduct;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.CartService;
import com.jtim.bills.service.CompanyService;
import com.jtim.bills.service.MailService;
import com.jtim.bills.service.OrderService;
import com.jtim.bills.service.ProductService;
import com.jtim.bills.service.UserService;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;

@Controller
public class OrderController {
	@Autowired
	private UserService userService;

	@Autowired
	private ProductService productService;

	@Autowired
	private OrderService orderService;

	@Autowired
	private CartService cartService;

	@Autowired
	private MailService mailService;

	@Autowired
	private CompanyService companyService;

	@GetMapping("/user/payment/success/{agent}")
	public String makeOrder(@PathVariable String agent, Principal p, Model m, RedirectAttributes redirectAttributes) {

		Orders order = new Orders();
		User user = userService.getUserByEmail(p.getName());
		double total = 0;
		order.setUser(user);
		List<Cart> carts = cartService.getCartByUser(user);
		List<OrderedProduct> orderList = new ArrayList<>();
		for (Cart cart : carts) {
			total += Integer.parseInt(cart.getProduct().getSp()) * cart.getQty();
			OrderedProduct op = new OrderedProduct();
			op.setProduct(cart.getProduct());
			op.setQty(cart.getQty());
			op.setOrder(order);
			Product pp = cart.getProduct();
			pp.setQty(pp.getQty() - cart.getQty());
			productService.updateProduct(pp);
			op.setSp(Integer.parseInt(cart.getProduct().getSp()));
			orderList.add(op);
			cartService.deleteCart(cart);
		}
		order.setOrderedProducts(orderList);
		order.setTotalAmount(total);
		order.setOrderDate(LocalDate.now());
		order.setDeliveryDate(LocalDate.now().plusDays(10));
		order.setPaymentMethod(agent);
		order.setStatus("PENDING");
		Orders or = orderService.saveOrder(order);
		m.addAttribute("order_list", or);
		m.addAttribute("user", user);
		m.addAttribute("company", companyService.getCompanyById(1));
		redirectAttributes.addFlashAttribute("success", "Order Placed Successfully");

		if (or == null) {
			redirectAttributes.addFlashAttribute("error", "Error while placing Order");
			return "redirect:/user/cart/show";
		}
		return "redirect:/user/orders";
	}



	@GetMapping("user/orders")
	public String showOrder(Principal p, Model m) {
		User user = userService.getUserByEmail(p.getName());
		List<Orders> orders = orderService.getOrderByUser(user);
		List<Orders> orderList = new ArrayList<>();
		for (Orders order : orders) {
			if (!order.getExpire()) {
				orderList.add(order);
			}
		}
		m.addAttribute("order_list",orderList);

		m.addAttribute("user", user);
		m.addAttribute("company", companyService.getCompanyById(1));
		return "frontend/order";

	}

	// for admin to approve or delete order
	@GetMapping("admin/order/list")
	public String showOrderlist(Principal p, Model m) {
		User user = userService.getUserByEmail(p.getName());
		m.addAttribute("status", "conform");
		LocalDate exp = LocalDate.now();
		List<Orders> orders = orderService.getAllOrders();
		for (Orders op : orders) {
			LocalDate date = op.getOrderDate();
			date = date.plusMonths(1);
			if (exp.isAfter(date)) {
				op.setExpire(true);
				System.out.println("updated Successsfully");
				orderService.update(op);
			}

		}

		m.addAttribute("order_list", orderService.getAllOrders());
		m.addAttribute("user", user);
		m.addAttribute("company", companyService.getCompanyById(1));
		return "backend/orderList";
	}

	@GetMapping("admin/order/neworder")
	public String showOrderNewOrderlist(Principal p, Model m) {
		User user = userService.getUserByEmail(p.getName());
		m.addAttribute("status", "pending");

		m.addAttribute("order_list", orderService.getAllOrders());
		m.addAttribute("user", user);
		m.addAttribute("company", companyService.getCompanyById(1));
		return "backend/orderList";
	}

	@GetMapping("admin/order/rejectedlist")
	public String showOrderRejectedOrderlist(Principal p, Model m) {
		User user = userService.getUserByEmail(p.getName());
		m.addAttribute("status", "rejected");
		m.addAttribute("order_list", orderService.getAllOrders());
		m.addAttribute("user", user);
		m.addAttribute("company", companyService.getCompanyById(1));
		return "backend/orderList";
	}

	@GetMapping("/admin/order/confrom/{id}")
	public String confromOrder(@PathVariable int id, Principal p, RedirectAttributes redirectAttributes) {
		Orders order = orderService.getOrderById(id);
		order.setStatus("Confrom");
		orderService.update(order);
		redirectAttributes.addFlashAttribute("success", "Order Confromed");
		String msg = " Order Conformed\n Your Order on Date: " + order.getOrderDate() + "\n Total Amount: "
				+ order.getTotalAmount() + "\nStatus: Conformed\n" + "Delivery Date: " + order.getDeliveryDate();
		String sub = "Order Confromed";
		mailService.sendMail(order.getUser().getEmail(), sub, msg);
		return "redirect:/admin/order/list";

	}

	@PostMapping("/admin/order/reject/{id}")
	public String rejectOrder(@PathVariable int id, RedirectAttributes redirectAttributes) {
		Orders order = orderService.getOrderById(id);
		List<OrderedProduct> orderedProducts = order.getOrderedProducts();
		for (OrderedProduct op : orderedProducts) {
			Product pp = op.getProduct();
			pp.setQty(pp.getQty() + op.getQty());
			productService.updateProduct(pp);
		}
		order.setStatus("Rejected");
		orderService.update(order);
		String msg = " Sorry, Your Order on Date" + order.getOrderDate() + "of Total Amount" + order.getTotalAmount()
				+ "is Reject\n";
		String sub = "Order Rejected";
		mailService.sendMail(order.getUser().getEmail(), sub, msg);
		redirectAttributes.addFlashAttribute("error", "Order Rejected");
		return "redirect:/admin/order/list";

	}

//	print order label
	@GetMapping("admin/order/print-label/{id}")
	public ResponseEntity<InputStreamResource> printLabel(@PathVariable int id)
			throws FileNotFoundException, JRException {
		Orders order = orderService.getOrderById(id);
		List<OrderedProduct> op = order.getOrderedProducts();
		int numberProduct = op.size();
		Company company = companyService.getCompanyById(1);
		String path = "classpath:label.jrxml";
		File file = ResourceUtils.getFile(path);
		JasperReport report = JasperCompileManager.compileReport(file.getAbsolutePath());
		String logo = "file:./uploads/" + company.getLogo();
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("cmpName", company.getName());
		parameters.put("cmpInfo", company.getAddress());
		parameters.put("logo", logo);
		parameters.put("product", numberProduct + "");
		parameters.put("name", order.getUser().getName());
		parameters.put("contact", order.getUser().getPhone() + " | " + order.getUser().getEmail());
		parameters.put("address", order.getUser().getAddress());
		parameters.put("orderDate", order.getUser().getAddress());
		parameters.put("weight", "");
		parameters.put("deliveryAddress", order.getUser().getAddress());

		JasperPrint jasperPrint = JasperFillManager.fillReport(report, parameters, new JREmptyDataSource());

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);

		ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(outputStream.toByteArray());

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename=" + order.getUser().getName() + "-order.pdf");

		return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_PDF)
				.body(new InputStreamResource(byteArrayInputStream));
	}
}
