package com.clothes.demo.controller;


import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.clothes.demo.dao.ProductDao;
import com.clothes.demo.models.orders.OrderItem;
import com.clothes.demo.models.products.Product;
import com.clothes.demo.models.vendor.Vendor;

@Controller
public class ProductController {
	@Autowired
	ProductDao prodao;
	
	/*
	@RequestMapping(path = "/fashion-factory/addProduct", method = RequestMethod.POST)
	public String addProduct(Product product,@RequestParam("proimage") MultipartFile pimage,RedirectAttributes redirAttrs) throws IOException {
//		prodao.save(product);
		String fileName = StringUtils.cleanPath(pimage.getOriginalFilename());
		product.setProduct_image(fileName);
         
		Product savedUser = prodao.save(product);
 
        String uploadDir = "product-photos/" + savedUser.getId();
 
        FileUploadUtil.saveFile(uploadDir, fileName, pimage);
//		System.out.println(product);
		System.out.println("Product Registred");
		return "redirect:/fashion-factory";
	}
	*/
	
//	Add product
	@GetMapping(path = "/fashion-factory/addProduct")
	public String addProduct(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
		
		return "redirect:/fashion-factory";
	}
	@RequestMapping(path = "/fashion-factory/addProduct", method = RequestMethod.POST)
	public String addProduct(Product product,HttpServletRequest request,RedirectAttributes redirAttrs) throws IOException {
		System.out.println("in ADD Product");
		HttpSession session = request.getSession();
		List<Product> productcode_exists = prodao.findByProduct_code(product.getProduct_code());
		if(1==productcode_exists.size()) {
			session.setAttribute("ERROR", "Entered Product code is alredy used!!");
			String referer = request.getHeader("Referer");
			return "redirect:" + referer;
		}
		Vendor ven = (Vendor) session.getAttribute("vendor");
		System.out.println(ven);
		product.setVendor(ven);
		System.out.println(product);
		System.out.println("Product Registred");
		prodao.save(product);
		session.setAttribute("SUCCESS", "Product Added!!");
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

//	Show my all products (Vendor)
	@RequestMapping(path = "myProducts", method = RequestMethod.GET)
	public ModelAndView myProduct(HttpServletRequest request,RedirectAttributes redirAttrs) throws IOException {
		System.out.println("in MY Product");
		HttpSession session = request.getSession();
		Vendor ven = (Vendor) session.getAttribute("vendor");
		if(null==ven) {
			session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
			ModelAndView mv = new ModelAndView("redirect:/fashion-factory");
			return mv;
		}
//		System.out.println(ven);
		List<Product> all_pro = prodao.findByVendor(ven);
		System.out.println(all_pro);
		ModelAndView mv = new ModelAndView("pages/display/showMyProducts.jsp");
		mv.addObject("all_pro",all_pro);
		return mv;
	}
	
//	Edit Product Details
	@RequestMapping(path = "/fashion-factory/editProduct", method = RequestMethod.POST)
	public String editProduct(Product product,HttpServletRequest request,RedirectAttributes redirAttrs) throws IOException {
		System.out.println("Editing Product");
		Long proid = product.getId();
		HttpSession session = request.getSession();
		Product db_product = prodao.findById(proid).orElse(product);
		if(null!=db_product) {
			if(!db_product.getProduct_code().equals(product.getProduct_code())) {
				List<Product> newproductcode = prodao.findByProduct_code(product.getProduct_code());
				if(1==newproductcode.size()) {
					session.setAttribute("ERROR", "Entered Product code is alredy used!!");
					String referer = request.getHeader("Referer");
					return "redirect:" + referer;
				}
			}
		}
		
		Vendor ven = (Vendor) session.getAttribute("vendor");
//		System.out.println(ven);
//		prodao.deleteById(proid);
		String procode = product.getProduct_code();
		String proimge = product.getProduct_image();
		String proname = product.getProduct_name();
		String prodesc = product.getProduct_description();
		Double proprice = product.getProduct_price();
		String procategory = product.getProduct_category();
		
		product.setVendor(ven);
		prodao.setProductDetailsById(procode, proimge, proname, prodesc, proprice, procategory, proid);
		prodao.save(product);
		session.setAttribute("SUCCESS", "Product Details Updated Successfull");
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

//	Delete Product
	@RequestMapping(path = "/fashion-factory/deleteProduct", method = RequestMethod.POST)
	public String deleteProduct(Product product,HttpServletRequest request,RedirectAttributes redirAttrs) throws IOException {
		System.out.println("Deleting Product");
		Long pid = product.getId();
		prodao.deleteById(pid);
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
//	Showing specific category products
	@RequestMapping(path = "/showMenProducts", method = RequestMethod.GET)
	public ModelAndView showMenProducts(HttpServletRequest request,RedirectAttributes redirAttrs){
		System.out.println("Show Men Product");
		ModelAndView mv = new ModelAndView("pages/display/MenProducts.jsp");
		List<Product> all_men_products = prodao.findByProduct_category("Men");
		mv.addObject("all_men_products", all_men_products);
		return mv;
	}
	@RequestMapping(path = "/showWomenProducts", method = RequestMethod.GET)
	public ModelAndView showWomenProducts(HttpServletRequest request,RedirectAttributes redirAttrs){
		System.out.println("Show Men Product");
		ModelAndView mv = new ModelAndView("pages/display/WomenProducts.jsp");
		List<Product> all_women_products = prodao.findByProduct_category("Women");
		mv.addObject("all_women_products", all_women_products);
		return mv;
	}
	@RequestMapping(path = "/showKidsProducts", method = RequestMethod.GET)
	public ModelAndView showKidsProducts(HttpServletRequest request,RedirectAttributes redirAttrs){
		System.out.println("Show Kids Product");
		ModelAndView mv = new ModelAndView("pages/display/KidsProducts.jsp");
		List<Product> all_kids_products = prodao.findByProduct_category("Kids");
		mv.addObject("all_kids_products", all_kids_products);
		return mv;
	}
	
//	find all sold products
	@RequestMapping(path = "/soldProducts", method = RequestMethod.GET)
	public ModelAndView soldProducts(HttpServletRequest request,RedirectAttributes redirAttrs){
		System.out.println("Sold Product");
		ModelAndView mv = new ModelAndView("pages/display/SoldProducts.jsp");
		Vendor vendor = (Vendor) request.getSession().getAttribute("vendor");
		List<Product> all_sold_products = prodao.findByVendor(vendor);
		mv.addObject("all_sold_products", all_sold_products);
		return mv;
	}
}
