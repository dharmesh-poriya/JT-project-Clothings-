package com.clothes.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.clothes.demo.ClothingsApplication;
import com.clothes.demo.bean.Mail;
import com.clothes.demo.dao.AdminDao;
import com.clothes.demo.dao.CustomerDao;
import com.clothes.demo.dao.OrderDao;
import com.clothes.demo.dao.OrderItemDao;
import com.clothes.demo.dao.ProductDao;
import com.clothes.demo.dao.VendorDao;
import com.clothes.demo.models.authenticate.Admin;
import com.clothes.demo.models.customer.CustomerDetails;
import com.clothes.demo.models.orders.Order;
import com.clothes.demo.models.orders.OrderItem;
import com.clothes.demo.models.vendor.Vendor;
import com.clothes.demo.services.MailService;

@Controller
public class AuthenticationController {
	@Autowired
	CustomerDao cdao;
	@Autowired
	AdminDao addao;
	@Autowired
	VendorDao vendao;
	@Autowired
	OrderDao odao;
	@Autowired
	OrderItemDao oitemdao;
	@Autowired
	ProductDao prodao;
	@Autowired
	MailService mailservice;

	@RequestMapping(path = "/fashion-factory/doLogin", method = RequestMethod.POST)
	public String doLogin(@RequestParam("email") String email, @RequestParam("password") String password,
			HttpServletRequest request, RedirectAttributes redirAttrs) {
		List<CustomerDetails> cd = cdao.findBycustomer_email_idAndcustomer_password(email, password);
		List<Admin> ad = addao.findByadmin_email_idAndadmin_password(email, password);
		List<Vendor> vd = vendao.findByvendor_email_idAndvendor_password(email, password);

		HttpSession session = request.getSession();
		session.setAttribute("customer", null);
		session.setAttribute("admin", null);
		session.setAttribute("vendor", null);
		session.setAttribute("ERROR", null);
		session.setAttribute("SUCCESS", null);
		
		if (!cd.isEmpty()) {
			System.out.println("Customer Logged In!!");
			System.out.println(cd.get(0));
			session.setAttribute("customer", cd.get(0));
			session.setAttribute("SUCCESS", "Login Successfull!!");
//			Mail mail = new Mail();
//	        mail.setMailFrom("d.poriya05@gmail.com");
//	        mail.setMailTo(email);
//	        mail.setMailSubject("Login Attempt");
//	        mail.setMailContent("Login Successfull!!");
//	        mailservice.sendEmail(mail);
		} else if (!ad.isEmpty()) {
			System.out.println("Admin Logged In!!");
			System.out.println(ad.get(0));
			session.setAttribute("admin", ad.get(0));
			session.setAttribute("SUCCESS", "Admin Login Successfull");
		} else if (!vd.isEmpty()) {
			System.out.println("Vendor Logged In!!");
			System.out.println();
			session.setAttribute("vendor", vd.get(0));
			session.setAttribute("SUCCESS", "Login Successfull");
		} else {
			System.out.println("Invalid Credentials");
			session.setAttribute("ERROR", "Invalid Credentials");
			return "redirect:/fashion-factory";
		}
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

//	Logout
	@RequestMapping(path = "fashion-factory/doLogout", method = RequestMethod.GET)
	public String doLogout(HttpServletRequest request, RedirectAttributes redirAttrs) {
		HttpSession session = request.getSession();
		session.setAttribute("customer", null);
		session.setAttribute("admin", null);
		session.setAttribute("vendor", null);
		session.removeAttribute("customer");
		session.removeAttribute("admin");
		session.removeAttribute("vendor");

//		Clearing Current Carts 
		Order current_order = (Order) session.getAttribute("current_order");
		if (null != current_order) {
			List<OrderItem> currentcartitems = oitemdao.findAllByOrder_id(current_order);
			for (OrderItem oi : currentcartitems) {
				Long soldq = oi.getProduct().getSold_quantity() - oi.getQuentity();
				prodao.setSold_QuantityById(soldq, current_order.getId());
				oitemdao.deleteById(oi.getId());
			}
			odao.deleteById(current_order.getId());
		}
		session.removeAttribute("current_order");
		session.invalidate();
		System.out.println("Logout!!");
		return "redirect:/fashion-factory";
	}

}
