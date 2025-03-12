package com.jtim.bills.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jtim.bills.entity.Category;
import com.jtim.bills.entity.Company;
import com.jtim.bills.entity.Product;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.CategoryService;
import com.jtim.bills.service.CompanyService;
import com.jtim.bills.service.FileUploadService;
import com.jtim.bills.service.ProductService;
import com.jtim.bills.service.UserService;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
@RequestMapping("admin/product")
public class ProductController {

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ProductService productService;

	@Autowired
	private FileUploadService fileUploadService;
	@Autowired
	private UserService userService;
	@Autowired
	private CompanyService companyService;

	@GetMapping("/add")
	public String showAddProduct(Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user", ud);
		m.addAttribute("cat_list", categoryService.getAllCategories());
		return "backend/addProduct";
	}

	@PostMapping("/add")
	public String AddProduct(Principal p, Model m, @ModelAttribute Product product, RedirectAttributes redirectAttributes) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user",ud);

		if (fileUploadService.uploadImage(product.getImageFile(),"product_image")) {
			String image = "product_image/" + product.getImageFile().getOriginalFilename();
			product.setImage(image);
			product.setAddedDate(LocalDate.now());

			if(product.getSlug()==null) {
				String slug = product.getName() + "-" + product.getAddedDate();
				product.setSlug(slug);
				}
			redirectAttributes.addFlashAttribute("success","Product Added Successfullt");

			productService.addProduct(product);
			return "redirect:/admin/product/list";
		}
		redirectAttributes.addFlashAttribute("error","Error in Product Addtion.");

		return "redirect:/admin/product/add";
	}

	@GetMapping("/list")
	public String showProduct(Principal p, Model m) {
		User ud = userService.getUserByEmail(p.getName());
		m.addAttribute("user",ud);
		m.addAttribute("cat_list", categoryService.getAllCategories());
		m.addAttribute("products_list", productService.getAllProducts());
		return "backend/listProduct";

	}

	@GetMapping("/edit/{product_id}")

	public String editProduct(@PathVariable("product_id") int id, Model model, Principal p) {
		User ud = userService.getUserByEmail(p.getName());
		model.addAttribute("user",ud);
		model.addAttribute("edit", true);
		model.addAttribute("cat_list", categoryService.getAllCategories());
		model.addAttribute("pro", productService.getProductById(id));
		model.addAttribute("product_list", productService.getAllProducts());
		return "backend/addProduct";

	}

	@PostMapping("/update")
	public String updateProduct(@ModelAttribute Product product, @RequestParam("pevImage") String pevImg, RedirectAttributes redirectAttributes) {

		if (product.getImageFile().isEmpty()) {
			product.setImage(pevImg);
		} else {
			if (fileUploadService.uploadImage(product.getImageFile(),"product_image")) {
				String image = "product_image/" + product.getImageFile().getOriginalFilename();
				product.setImage(image);
				
			}
			
		}
		product.setAddedDate(product.getAddedDate());
		if(product.getSlug()==null) {
		String slug = product.getName() + "-" + product.getAddedDate();
		product.setSlug(slug);
		}
		productService.updateProduct(product);
		redirectAttributes.addFlashAttribute("success","Product Updated Successfully");

		return "redirect:/admin/product/list";
	}

	@PostMapping("/delete/{product_id}")
	public String deleteProduct(@PathVariable int product_id, RedirectAttributes redirectAttributes) {
		Product product = productService.getProductById(product_id);
		if (product != null) {
			productService.deleteProduct(product);
			redirectAttributes.addFlashAttribute("success","Product Deleted Successfully.");
			return "redirect:/admin/product/list#product_data?delete=success";
		} else {
			redirectAttributes.addFlashAttribute("error","Error in  Deleting Product.");
			return "redirect:/admin/product/list#product_data?delete=failed";
		}
	}
	
//	@GetMapping("/print-report")
//	public void printReport(Principal p) throws JRException, FileNotFoundException {
//		
//		List<Product> products=productService.getAllProducts();
//		User user=userService.getUserByEmail(p.getName());
//		String path="classpath:report.jrxml";
//		
//		File file=ResourceUtils.getFile(path);
//		
//		JasperReport report=JasperCompileManager.compileReport(file.getAbsolutePath());
//		
//		JRBeanCollectionDataSource dataset=new JRBeanCollectionDataSource(products);
//		Map<String, Object> parameters=new HashMap<>();
//		parameters.put("createBy",user.getName());
//		parameters.put("stockData",dataset);
//		
//		JasperPrint  jasperPrint=JasperFillManager.fillReport(report,parameters, new JREmptyDataSource());
//		JasperExportManager.exportReportToPdfFile(jasperPrint, "C:\\Users\\jtima\\Downloads\\stock.pdf");
//		
//		
//	}
	
	@GetMapping("/print-report")
	public ResponseEntity<InputStreamResource> jasperBill() throws Exception {
		
		Company company = companyService.getCompanyById(1);
		String path = "classpath:stock.jrxml";
		File file = ResourceUtils.getFile(path);
		List<Product> products=productService.getAllProducts();
		JasperReport report = JasperCompileManager.compileReport(file.getAbsolutePath());
		List<Map<String, Object>> product = new ArrayList<>();
		int i = 1;
		for (Product p : products) {
			Map<String, Object> productData = new HashMap<>();
			productData.put("sn", i++);
			productData.put("product", p.getName());
			productData.put("sp", p.getSp());
			productData.put("qty", p.getQty());
			productData.put("total",Double.parseDouble(p.getSp())*p.getQty());
			product.add(productData);
		}
		
//		for pie chart to view number of product based on category
		List<Category> categories=categoryService.getAllCategories();
		List<Map<String, Object>> productCat = new ArrayList<>();

		for (Category category : categories) {
			Map<String, Object> catMap=new HashMap<>();
			List<Product> catProdcutsList=productService.getProductByCateogry(category);
			catMap.put("categoryName",category.getName());
			catMap.put("productQty",catProdcutsList.size());
			productCat.add(catMap);		
		}
		JRBeanCollectionDataSource chartDataSource = new JRBeanCollectionDataSource(productCat);
		JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(product);

		String logo = "file:./uploads/" + company.getLogo();
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("name", company.getName());
		parameters.put("info", company.getAddress()+" | "+company.getEmail());
		parameters.put("image", logo);
		parameters.put("stock", dataSource);
		parameters.put("chart", chartDataSource);
		JasperPrint jasperPrint = JasperFillManager.fillReport(report, parameters, new JREmptyDataSource());

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);

		ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(outputStream.toByteArray());

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename="+company.getName()+"-stock.pdf");

		return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_PDF)
				.body(new InputStreamResource(byteArrayInputStream));
	}
	
	

}
