package com.jtim.bills.controller;

import java.io.File;
import java.security.Principal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.*;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.jtim.bills.entity.Bill;
import com.jtim.bills.entity.BillItem;
import com.jtim.bills.entity.Company;
import com.jtim.bills.entity.Product;
import com.jtim.bills.entity.User;
import com.jtim.bills.service.BillService;
import com.jtim.bills.service.CategoryService;
import com.jtim.bills.service.CompanyService;
import com.jtim.bills.service.ProductService;
import com.jtim.bills.service.UserService;

import jakarta.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.core.io.InputStreamResource;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

@Controller
@RequestMapping("/admin/bill/")
public class BillController {
	@Autowired
	private UserService userService;
	@Autowired
	private ProductService productService;
	@Autowired
	private CategoryService categoryService;

	@Autowired
	private BillService billService;

	@Autowired
	private CompanyService companyService;

	@GetMapping("/create")
	public String createBill(Principal p, Model m) {
		User user = userService.getUserByEmail(p.getName());
		m.addAttribute("user", user);
		m.addAttribute("customer_list", userService.getAllUsers());
		m.addAttribute("product_list", productService.getAllProducts());
		m.addAttribute("category_list", categoryService.getAllCategories());
		List<Bill> bills= billService.getAllBills();
		int no=0;
		for (Bill bill : bills) {
			no=bill.getBillNumber();
		}
		m.addAttribute("pev_no",++no);
		
		return "backend/createBill";
	}

	@GetMapping("/list")
	public String ListBill(Principal p, Model m) {
		User user = userService.getUserByEmail(p.getName());
		m.addAttribute("user", user);
		m.addAttribute("product_list", productService.getAllProducts());
		m.addAttribute("category_list", categoryService.getAllCategories());
		m.addAttribute("bill_list", billService.getAllBills());
		return "backend/listBills";
	}

	@PostMapping("/create-bill")
	public String saveBill(@RequestParam int customerId, @RequestParam("productId[]") int[] pid,
			@RequestParam("bill_no") int billNo, @RequestParam("quantity[]") int[] qty, @RequestParam("tax") String tax,
			@RequestParam("discount") String discount, Model model, Principal p,
			RedirectAttributes redirectAttributes) {

		User user = userService.getUserById(customerId);
		Bill bill = new Bill();
		bill.setUser(user);
		bill.setCreatedDate(LocalDate.now());
		bill.setCreatedBy(userService.getUserByEmail(p.getName()).getName());
		bill.setPaymentMehtod("Cash");
		bill.setRemark("bill");
		bill.setBillNumber(billNo);

		

		List<BillItem> billItems = new ArrayList<>();
		double totalSum = 0.00;
		for (int i = 0; i < pid.length; i++) {
			int productId = pid[i];
			int quantity = qty[i];
			Product product = productService.getProductById(productId);

			BillItem item = new BillItem();
			item.setProduct(product);
			item.setQty(quantity);
			item.setSp(Double.parseDouble(product.getSp()));
			item.setTotal(quantity * item.getSp());
			item.setBill(bill);
			product.setQty(product.getQty() - item.getQty());
			productService.updateProduct(product);

			// Add to list
			billItems.add(item);
			totalSum += item.getTotal();

		}
		if (discount != null) {
			double dis= Double.parseDouble(discount)*totalSum/100;
			bill.setDiscount(dis);
			
		} else {
			bill.setDiscount(0.00);
		}
		if (tax != null) {
			double calcTax= 13*totalSum/100;
			bill.setTax(calcTax);
		} else {
			bill.setTax(0.00);
		}
		bill.setItems(billItems);
		bill.setAmount(totalSum);
		double totalbill = totalSum - bill.getDiscount();
		
		totalbill = totalbill + bill.getTax();
		
		bill.setTotal(totalbill);

		Bill savedBill = billService.saveBill(bill);
		if (savedBill != null) {
			redirectAttributes.addFlashAttribute("success", "Bill created successfully!");
			return "redirect:/admin/bill/list";
		} else {
			redirectAttributes.addFlashAttribute("error", "Error in bill creation.");
			return "redirect:/admin/bill/create";
		}

	}

	@GetMapping("/billdetail/{id}")
	public String showBillDetails(@PathVariable int id, Model m, Principal p) {
		User user = userService.getUserByEmail(p.getName());
		m.addAttribute("user", user);
		Bill bill = billService.getBillById(id);

		m.addAttribute("bill", bill);
		return "backend/billDetails";
	}

	@GetMapping("/printbill/{id}")
	public void printBill(@PathVariable int id, HttpServletResponse response) throws Exception {
		Bill bill = billService.getBillById(id);
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition", "inline; filename=bill_" + bill.getUser().getName() + ".pdf");

		// Create document with A5 size
		Document document = new Document(PageSize.A5, 36, 36, 36, 36); // Custom margins
		PdfWriter.getInstance(document, response.getOutputStream());
		document.open();

		// Title Section
		Font titleFont = FontFactory.getFont(FontFactory.TIMES_BOLD, 16);
		Font subTitleFont = FontFactory.getFont(FontFactory.TIMES, 12);
		Paragraph title = new Paragraph("Printo Hub Trade Link Pvt. Ltd.", titleFont);
		title.setAlignment(Element.ALIGN_CENTER);
		document.add(title);

		Paragraph address = new Paragraph("Bagbazar-28, Kathmandu | Contact: 9851000000", subTitleFont);
		address.setAlignment(Element.ALIGN_CENTER);
		document.add(address);

		document.add(Chunk.NEWLINE);

		Paragraph billInfo = new Paragraph();
		billInfo.setFont(subTitleFont);

		Paragraph leftAligned = new Paragraph("Bill No: " + bill.getBillNumber(), subTitleFont);
		leftAligned.setAlignment(Element.ALIGN_LEFT);
		document.add(leftAligned);

		// Adding Created Date on the right
		Paragraph rightAligned = new Paragraph("Date: " + bill.getCreatedDate().toString(), subTitleFont);
		rightAligned.setAlignment(Element.ALIGN_RIGHT);
		document.add(rightAligned);

		// Adding Name and Address in separate lines
		billInfo.add(new Chunk("\nName: " + bill.getUser().getName(), subTitleFont));
		billInfo.add(new Chunk("\nAddress: " + bill.getUser().getAddress(), subTitleFont));

		// Add the paragraph to the document
		document.add(billInfo);
		document.add(Chunk.NEWLINE);

		// Table for Items
		PdfPTable itemTable = new PdfPTable(5);
		itemTable.setWidthPercentage(100);
		itemTable.setWidths(new float[] { 1, 4, 2, 2, 3 });

		// Add table headers
		itemTable.addCell(createHeaderCell("S.N."));
		itemTable.addCell(createHeaderCell("Product Name"));
		itemTable.addCell(createHeaderCell("Quantity"));
		itemTable.addCell(createHeaderCell("Unit"));
		itemTable.addCell(createHeaderCell("Total Price"));

		// Add items to table
		int i = 1;
		for (BillItem item : bill.getItems()) {
			itemTable.addCell(createCell(String.valueOf(i++), Element.ALIGN_CENTER));
			itemTable.addCell(createCell(item.getProduct().getName(), Element.ALIGN_LEFT));
			itemTable.addCell(createCell(String.valueOf(item.getQty()), Element.ALIGN_CENTER));
			itemTable.addCell(createCell("Rs." + item.getSp(), Element.ALIGN_RIGHT));
			itemTable.addCell(createCell("Rs." + item.getTotal(), Element.ALIGN_RIGHT));
		}

		// Add Subtotal and Total in table
		itemTable.addCell(createCell("", Element.ALIGN_CENTER, 3)); // Empty cells
		itemTable.addCell(createCell("Sub Total", Element.ALIGN_RIGHT));
		itemTable.addCell(createCell("Rs." + bill.getAmount(), Element.ALIGN_RIGHT));

		itemTable.addCell(createCell("", Element.ALIGN_CENTER, 3));
		itemTable.addCell(createCell("Discount", Element.ALIGN_RIGHT));
		if (bill.getDiscount() != null) {
			itemTable.addCell(createCell("Rs." + bill.getDiscount(), Element.ALIGN_RIGHT));

		} else {
			itemTable.addCell(createCell("Rs. 0", Element.ALIGN_RIGHT));
		}

		if (bill.getTax() != null) {

			itemTable.addCell(createCell("", Element.ALIGN_CENTER, 3));
			itemTable.addCell(createCell("Tax", Element.ALIGN_RIGHT));
			itemTable.addCell(createCell("Rs." + bill.getTax(), Element.ALIGN_RIGHT));
		}

		itemTable.addCell(createCell("", Element.ALIGN_CENTER, 3));
		itemTable.addCell(createCell("Total", Element.ALIGN_RIGHT));
		itemTable.addCell(createCell("Rs." + bill.getTotal(), Element.ALIGN_RIGHT));

		document.add(itemTable);

		// Add Signature Section
		document.add(Chunk.NEWLINE);
		Paragraph signature = new Paragraph("\n ___________________\nAuthorized Signature", subTitleFont);
		signature.setAlignment(Element.ALIGN_RIGHT);
		document.add(signature);

		document.close();
	}

	// Helper methods to create table cells
	private PdfPCell createCell(String content, int alignment) {
		return createCell(content, alignment, FontFactory.getFont(FontFactory.TIMES, 12));
	}

	private PdfPCell createCell(String content, int alignment, Font font) {
		PdfPCell cell = new PdfPCell(new Phrase(content, font));
		cell.setHorizontalAlignment(alignment);
		cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
		cell.setBorderWidth(0.5f);
		return cell;
	}

	private PdfPCell createCell(String content, int alignment, int colspan) {
		PdfPCell cell = createCell(content, alignment);
		cell.setColspan(colspan);
		return cell;
	}

	private PdfPCell createHeaderCell(String content) {
		PdfPCell cell = createCell(content, Element.ALIGN_CENTER, FontFactory.getFont(FontFactory.TIMES_BOLD, 12));
		return cell;
	}

	@GetMapping("/jasper/{id}")
	public ResponseEntity<InputStreamResource> jasperBill(@PathVariable int id) throws Exception {
		Bill bill = billService.getBillById(id);
		Company company = companyService.getCompanyById(1);
		String path = "classpath:bill.jrxml";
		File file = ResourceUtils.getFile(path);

		JasperReport report = JasperCompileManager.compileReport(file.getAbsolutePath());

		List<Map<String, Object>> itemList = new ArrayList<>();
		int i = 1;
		for (BillItem item : bill.getItems()) {
			Map<String, Object> itemData = new HashMap<>();
			itemData.put("sn", i++);
			itemData.put("items", item.getProduct().getName());
			itemData.put("qty", item.getQty());
			itemData.put("rate", item.getSp());
			itemList.add(itemData);
		}
		JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(itemList);

		String logo = "file:./uploads/" + company.getLogo();
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("company", company.getName());
		parameters.put("comAdd", company.getAddress());
		parameters.put("comInfo", company.getEmail());
		parameters.put("billNo", bill.getBillNumber());
		parameters.put("name", bill.getUser().getName());
		parameters.put("reg", "VAT: " + company.getPan());
		parameters.put("address", bill.getUser().getAddress());
		parameters.put("logo", logo);
		parameters.put("BIll", dataSource);
		JasperPrint jasperPrint = JasperFillManager.fillReport(report, parameters, new JREmptyDataSource());

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);

		ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(outputStream.toByteArray());

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename="+bill.getUser().getName()+"-bill.pdf");

		return ResponseEntity.ok().headers(headers).contentType(MediaType.APPLICATION_PDF)
				.body(new InputStreamResource(byteArrayInputStream));
	}

}
