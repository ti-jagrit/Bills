package com.jtim.bills.config;


import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;




@Configuration
public class SecurityConfigurationAuth {
	@Autowired
	private DataSource dataSource;

	@Autowired
	private PasswordEncoder passwordEncoder;
	@Autowired
	private AuthencationSuccessHandler authencationSuccessHandler;

	@Bean
	SecurityFilterChain securityFilerChain(HttpSecurity http) throws Exception {
		http.authorizeHttpRequests(authorize -> authorize.requestMatchers("/admin/**").hasRole("ADMIN")
				.requestMatchers("/user/**").hasRole("USER"))
				.authorizeHttpRequests(
						authorize -> authorize.requestMatchers("/**").permitAll().anyRequest().authenticated())
				.formLogin(login -> login.loginPage("/userlogin").loginProcessingUrl("/login")
						.usernameParameter("email").passwordParameter("password")
						.defaultSuccessUrl("/loginsuccess", true).failureUrl("/loginfailed").permitAll())

				.logout(logout -> logout.logoutUrl("/logout").logoutSuccessUrl("/").permitAll()
						.invalidateHttpSession(true));
		http.csrf( customizer -> customizer.disable()); 
		http.oauth2Login(oauth->{
			oauth.loginPage("/userlogin");
			oauth.successHandler(authencationSuccessHandler);
			
		});
		
		return http.build();
	}

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.jdbcAuthentication().passwordEncoder(passwordEncoder) // Ensure this is a valid password encoder bean
				.dataSource(dataSource) // Inject the DataSource
				.usersByUsernameQuery("SELECT email, password, enable FROM user WHERE email = ?")
				.authoritiesByUsernameQuery("SELECT u.email, r.role " + "FROM user AS u "
						+ "JOIN user_role AS r ON u.user_id = r.user_id " + "WHERE u.email = ?");
	}

}
