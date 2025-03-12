package com.jtim.bills.entity;

import java.io.Serializable;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="user")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User implements Serializable{
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="user_id")
	private int id;
	
	@NotEmpty(message = "Name is Requried")
	@Size(min = 2, max=50, message = "Enter a valid Name")	
	private String name;
	
	@Column(name = "email", unique = true)
	@Email(message = "Enter a valid email")
	@NotEmpty(message = "Email is Requried")
	private String email;
	
	@Pattern(regexp = "^[0-9]{10}$", message = "Enter a valid phone Number")
	private String phone;
	
	private String address;	

	  
	private String password;
	
	private String enable;
	
	private String provider;
	
	
	private String photo;
	
	@Transient
	private MultipartFile imageFile;
	
	@OneToOne(mappedBy="user",cascade =CascadeType.ALL, fetch = FetchType.LAZY)
	private UserRole userRole;	
	
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	private List<Cart> cartList;
	
}
