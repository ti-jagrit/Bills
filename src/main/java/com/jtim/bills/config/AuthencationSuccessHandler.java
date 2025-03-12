package com.jtim.bills.config;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.jtim.bills.entity.User;
import com.jtim.bills.entity.UserRole;
import com.jtim.bills.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class AuthencationSuccessHandler implements AuthenticationSuccessHandler {
	@Autowired
	private UserService userService;
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
				Authentication authentication) throws IOException, ServletException {
	    DefaultOAuth2User oauthUser = (DefaultOAuth2User) authentication.getPrincipal();
	    String email = oauthUser.getAttribute("email");
	    String name = oauthUser.getAttribute("name");
	    String photo = oauthUser.getAttribute("picture");

	    // Create User object for new user
	    User user = new User();
	    user.setName(name);
	    user.setEmail(email);
	    user.setPhoto(photo);
	    user.setProvider("google");
	    user.setPassword(passwordEncoder.encode("password"));

	    // Check if user exists in database
	    User existingUser = userService.getUserByEmail(email);
	    if (existingUser == null) {
	        // If not, save the new user
	        UserRole userRole = new UserRole();
	        userRole.setUser(user);
	        userRole.setRole("ROLE_USER");
	        user.setUserRole(userRole);
	        user.setEnable("1");
	        userService.saveUser(user);
	    } else {
	        user = existingUser;
	    }

	   
	    response.sendRedirect("/");
	}


}
