package com.clothes.demo.controller;

import java.net.http.HttpRequest;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.clothes.demo.dao.AddressDao;
import com.clothes.demo.dao.CustomerDao;
import com.clothes.demo.dao.OrderDao;
import com.clothes.demo.dao.OrderItemDao;
import com.clothes.demo.models.customer.Address;
import com.clothes.demo.models.customer.CustomerDetails;
import com.clothes.demo.models.orders.Order;
import com.clothes.demo.models.vendor.Vendor;

@Controller
public class CustomerController {
	@Autowired
	CustomerDao cdao;
	@Autowired
	OrderDao odao;
	@Autowired
	OrderItemDao oitemdao;
	@Autowired
	AddressDao adddao;

//	add customer
	@GetMapping(path = "/fashion-factory/addCustomer")
	public String addCustomer(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");

		return "redirect:/fashion-factory";
	}

	@PostMapping(path = "/fashion-factory/addCustomer")
	public String addCustomer(CustomerDetails cd, HttpServletRequest request, RedirectAttributes redirAttrs) {
		HttpSession session = request.getSession();
		session.setAttribute("ERROR", null);
		session.setAttribute("SUCCESS", null);
		if (cd != null) {
			List<CustomerDetails> emailidexist = cdao.findBycustomer_email_id(cd.getCustomer_email_id());
			List<CustomerDetails> contactexist = cdao.findBycustomer_contact_number(cd.getCustomer_contact_number());
			if (!emailidexist.isEmpty()) {
				session.setAttribute("ERROR", "Entered Email ID is alredy used");
			} else if (!contactexist.isEmpty()) {
				session.setAttribute("ERROR", "Entered Contact Number is alredy used");
			} else {
				cdao.save(cd);
//				System.out.println(cd);
				session.setAttribute("SUCCESS", "Registration Completed!! Try to Login!!");
			}
		} else {
			session.setAttribute("ERROR", "Something Went Wrong!!");
		}
		return "redirect:/fashion-factory";
	}

//	Profile
	@RequestMapping(path = "/myProfile", method = RequestMethod.GET)
	public String mProfile(HttpServletRequest request, RedirectAttributes redirAttrs) {
		HttpSession session = request.getSession();
		CustomerDetails customer = (CustomerDetails) session.getAttribute("customer");

		if (null == customer) {
			session.setAttribute("ERROR", "You should first need to Login or SignUp!!");
			return "redirect:/fashion-factory";
		}
		return "pages/display/customerProfile.jsp";
	}

//  Edit Profile
	@RequestMapping(path = "/fashion-factory/editProfile", method = RequestMethod.POST)
	public String editProfile(CustomerDetails cd, @RequestParam("customer_id") Long cid, HttpServletRequest request,
			RedirectAttributes redirAttrs) {
		if (null != cd) {
			HttpSession session = request.getSession();
			CustomerDetails current_cust_details = (CustomerDetails) session.getAttribute("customer");
			String cname = cd.getCustomer_name();
			String image = cd.getProfile_image();
			String emailid = cd.getCustomer_email_id();
			String contact = cd.getCustomer_contact_number();
			Date dob = cd.getCustomer_dob();

			if (!current_cust_details.getCustomer_email_id().equals(cd.getCustomer_email_id())) {
				List<CustomerDetails> emailidexist = cdao.findBycustomer_email_id(cd.getCustomer_email_id());
				if (1 == emailidexist.size()) {
					if (emailidexist.get(0).getCustomer_email_id().equals(cd.getCustomer_email_id())) {
						session.setAttribute("ERROR", "Entered Email ID is alredy used");
						System.out.println("Email Exist!!");
						String referer = request.getHeader("Referer");
						return "redirect:" + referer;
					}
				}
			} else if (!current_cust_details.getCustomer_contact_number().equals(cd.getCustomer_contact_number())) {
				List<CustomerDetails> contactexist = cdao.findBycustomer_contact_number(cd.getCustomer_contact_number());
				if (1 == contactexist.size()) {
					if (contactexist.get(0).getCustomer_contact_number().equals(cd.getCustomer_contact_number())) {
						session.setAttribute("ERROR", "Entered Contact Number is alredy used");
						System.out.println("Email Exist!!");
						String referer = request.getHeader("Referer");
						return "redirect:" + referer;
					}
				}
			}

			cdao.setCustomerDetailsById(cname, image, emailid, contact, dob, cid);
			CustomerDetails customer = cdao.findById(cid).orElse(null);
			session.setAttribute("customer", customer);
			session.setAttribute("SUCCESS", "Profile Updated Successfully!!");
			System.out.println("Customer details updated successfully!!");

		}

		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

//	Delete Customer Account
	@RequestMapping(path = "/fashion-factory/deleteProfile", method = RequestMethod.POST)
	public String deleteProfile(@RequestParam("customer_email_id") String email,
			@RequestParam("password") String password, @RequestParam("customer_id") Long cid,
			HttpServletRequest request, RedirectAttributes redirAttrs) {

		HttpSession session = request.getSession();
		List<CustomerDetails> cd = cdao.findBycustomer_email_idAndcustomer_password(email, password);

		if (!cd.isEmpty()) {
			List<Order> myorders = odao.findByCustomerSorted(cd.get(0));
			if (!myorders.isEmpty()) {
				for (Order o : myorders) {
					oitemdao.deleteAllByOrder(o);
//					orderitems deleted
					odao.deleteById(o.getId());
//					order deleted
				}
			}
//				deleting address
			Address add = adddao.findBycd(cd.get(0));
			if (null != add) {
				adddao.deleteByCd(cd.get(0));
				System.out.println("Address Deleted");
			}
			cdao.deleteById(cid);

			session.removeAttribute("customer");
			session.removeAttribute("admin");
			session.removeAttribute("vendor");
			session.removeAttribute("current_order");
			session.invalidate();
			session.setAttribute("SUCCESS", "Your Account have been Deleted Successfully!!");
			return "redirect:/fashion-factory";
		} else {
			session.setAttribute("ERROR", "Something Went Wrong!! Try Again!!");
			System.out.println("Not Deleted Customer");
		}

		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
}
