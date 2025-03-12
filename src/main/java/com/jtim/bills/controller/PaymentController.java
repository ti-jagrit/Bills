package com.jtim.bills.controller;

import java.security.Principal;
import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.jtim.bills.PaymentDto;
import com.jtim.bills.entity.Cart;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.PaymentService;
import com.jtim.bills.service.UserService;

@Controller
public class PaymentController {
	@Autowired
	private UserService userService;
	@Autowired
	private PaymentService paymentService;

	@GetMapping("/user/payment/esewa")
	public String payViaEsewa(Principal p, Model m) {
		User user = userService.getUserByEmail(p.getName());
		List<Cart> carts = user.getCartList();
		PaymentDto payment = new PaymentDto();
		double amount = 0;
		for (Cart cart : carts) {
			amount += Double.parseDouble((cart.getProduct().getSp())) * cart.getQty();
		}
		payment.setAmount(amount);
		payment.setPsc(100);
		payment.setPdc(100);
		payment.setTaxAmount(100);
		payment.setTotalAmount(Math.ceil(amount + 100 + 100 + 100));
		payment.setProductCode("EPAYTEST");
		payment.setTransactionUUID(UUID.randomUUID() + "-0C81");
		payment.setSignedField("total_amount,transaction_uuid,product_code");
		String msg = "total_amount=" + payment.getTotalAmount() + ",transaction_uuid=" + payment.getTransactionUUID()
				+ ",product_code=" + payment.getProductCode();
		payment.setSignature(paymentService.generateEsewaSignature("8gBm/:&EnhH.1/q", msg));
		payment.setSuccessUrl("http://localhost:8080/user/payment/success/esewa");
		payment.setFailureUrl("http://localhost:8080/user/payment/faliure/esewa");
		m.addAttribute("user", user);
		m.addAttribute("payment", payment);
		m.addAttribute("test", msg);
		return "frontend/esewa";

	}
	@GetMapping("/user/payment/khalti")
	public String payViaKhalti(Principal p, Model m) {
		User user = userService.getUserByEmail(p.getName());
		List<Cart> carts = user.getCartList();
		PaymentDto payment = new PaymentDto();
		double amount = 0;
		for (Cart cart : carts) {
			amount += Double.parseDouble((cart.getProduct().getSp())) * cart.getQty();
		}
		payment.setAmount(amount);
		payment.setPsc(100);
		payment.setPdc(100);
		payment.setTaxAmount(100);
		payment.setTotalAmount(Math.ceil(amount + 100 + 100 + 100));
		
		m.addAttribute("user", user);
		m.addAttribute("payment", payment);
		
		return "frontend/khalti";

	}

}
