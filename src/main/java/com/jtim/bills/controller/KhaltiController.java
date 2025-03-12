package com.jtim.bills.controller;


import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.view.RedirectView;

import com.fasterxml.jackson.core.JsonProcessingException;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.UserService;

@RestController
public class KhaltiController {
	@Autowired
	private UserService userService;
	

    @PostMapping("/user/payment/khalti")
    public RedirectView initiatePayment(Principal p,@RequestParam("user_id") int id, @RequestParam double total) throws Exception, JsonProcessingException {
        String url = "https://dev.khalti.com/api/v2/epayment/initiate/";
        
        	User user=userService.getUserByEmail(p.getName());
        // Request body
        
       
        total=total*100;
        
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("return_url", "http://localhost:8080/user/payment/success/khalti");
        requestBody.put("website_url", "http://localhost:8080/user/payment/faliure/khalti");
        requestBody.put("amount", total);
        requestBody.put("purchase_order_id", user.getId());
        requestBody.put("purchase_order_name", user.getName()+" order.");

        Map<String, String> customerInfo = new HashMap<>();
        customerInfo.put("name", user.getName());
        customerInfo.put("email", user.getEmail());
        customerInfo.put("phone", user.getPhone());

        requestBody.put("customer_info", customerInfo);

        // Headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "key live_secret_key_68791341fdd94846a146f0457ff7b455");

        // HTTP entity containing headers and body
        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(requestBody, headers);

        // RestTemplate call
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, requestEntity, String.class);
        ObjectMapper objectMapper = new ObjectMapper();
        @SuppressWarnings("unchecked")
		Map<String, Object> responseMap = objectMapper.readValue(response.getBody(), Map.class);
        String aaString= (String) responseMap.get("payment_url");
        RedirectView redirectView = new RedirectView();
        redirectView.setUrl(aaString); // Set the payment URL
        return redirectView;
        
    }
}
