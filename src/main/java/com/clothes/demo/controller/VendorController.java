package com.clothes.demo.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.clothes.demo.dao.BillingAddressDao;
import com.clothes.demo.dao.VendorDao;
import com.clothes.demo.models.customer.CustomerDetails;
import com.clothes.demo.models.vendor.BillingAddress;
import com.clothes.demo.models.vendor.Vendor;

@Controller
public class VendorController {
	@Autowired
	VendorDao vendao;
	@Autowired
	BillingAddressDao billdao;

//	add Vendor
	@RequestMapping(path = "/fashion-factory/addVendor", method = RequestMethod.POST)
	public String addCustomer(Vendor vd, BillingAddress billadd, HttpServletRequest request,
			RedirectAttributes redirAttrs) {
		HttpSession session = request.getSession();
		if (vd != null && billadd != null) {
			List<Vendor> emailidexist = vendao.findByvendor_email_id(vd.getVendor_email_id());
			List<Vendor> contactexist = vendao.findByvendor_contact_number(vd.getVendor_contact_number());
			if (!emailidexist.isEmpty()) {
				session.setAttribute("ERROR", "Entered Email ID is alredy used");
			} else if (!contactexist.isEmpty()) {
				session.setAttribute("ERROR", "Entered Contact Number is alredy used");
			} else {
				vd.setBilling_address(billadd);
				billdao.save(billadd);
				vendao.save(vd);
				session.setAttribute("SUCCESS", "Registration Completed!! Try to Login!!");
			}
//			System.out.println(billadd);
//			System.out.println(vd);
//			System.out.println("Vendor Registred!!");
		} else {
			session.setAttribute("ERROR", "Something Went Wrong!!");
		}
		return "redirect:/fashion-factory";
	}

//	Profile
	@RequestMapping(path = "/myVendorProfile", method = RequestMethod.GET)
	public String mProfile(HttpServletRequest request, RedirectAttributes redirAttrs) {
		return "pages/display/vendorProfile.jsp";
	}

//  Edit Profile
	@RequestMapping(path = "/fashion-factory/editVendorProfile", method = RequestMethod.POST)
	public String editVendorProfile(Vendor v, @RequestParam("vendor_id") Long vid, HttpServletRequest request,
			RedirectAttributes redirAttrs) {
		HttpSession session = request.getSession();
		if (null != v) {

			Vendor old_vendor_details = (Vendor) session.getAttribute("vendor");
			if (!old_vendor_details.getVendor_email_id().equals(v.getVendor_email_id())) {
				List<Vendor> emailidexist = vendao.findByvendor_email_id(v.getVendor_email_id());
				if (1 == emailidexist.size()) {
					if (emailidexist.get(0).getVendor_email_id().equals(v.getVendor_email_id())) {
						session.setAttribute("ERROR", "Entered Email ID is alredy used");
						System.out.println("Email Exist!!");
						String referer = request.getHeader("Referer");
						return "redirect:" + referer;
					}
				}
			} else if (!old_vendor_details.getVendor_contact_number().equals(v.getVendor_contact_number())) {
				List<Vendor> contactexists = vendao.findByvendor_contact_number(v.getVendor_contact_number());
				if (1 == contactexists.size()) {
					if (contactexists.get(0).getVendor_contact_number().equals(v.getVendor_contact_number())) {
						session.setAttribute("ERROR", "Entered Contact Number is alredy used");
						System.out.println("Email Exist!!");
						String referer = request.getHeader("Referer");
						return "redirect:" + referer;
					}
				}
			}
			String vname = v.getVendor_name();
			String shopname = v.getVendor_shop_name();
			String simage = v.getImage();
			String email = v.getVendor_email_id();
			String contact = v.getVendor_contact_number();

			vendao.setVendorById(simage, contact, email, vname, shopname, vid);
			Vendor vendor = vendao.findById(vid).orElse(v);
			session.setAttribute("vendor", vendor);
			session.setAttribute("SUCCESS", "Profile Updated Successfull");
			System.out.println("Vendor updated successfully!!");

		} else {
			session.setAttribute("ERROR", "Something Went Wrong!! Try Again!!");
			return "redirect:fashion-factory";
		}

		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

//	Edit Billing Address
	@RequestMapping(path = "/fashion-factory/editBillingAddress", method = RequestMethod.POST)
	public String editBillingAddress(BillingAddress baddress, @RequestParam("aid") Long aid,
			@RequestParam("vendor_id") Long vid, HttpServletRequest request, RedirectAttributes redirAttrs) {
		if (null != baddress) {
			String hno = baddress.getHouse_no();
			String street = baddress.getStreet();
			String city = baddress.getCity();
			String district = baddress.getDistrict();
			String state = baddress.getState();
			String pincord = baddress.getPincode();

			billdao.setBillingAdressById(hno, street, city, district, state, pincord, aid);
			Vendor vendor = vendao.findById(vid).orElse(null);
			HttpSession session = request.getSession();
			session.setAttribute("vendor", vendor);
			session.setAttribute("SUCCESS", "Billing Address Updated Successfull");
			System.out.println("Billing Address Updated successfully!!");
		}

		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}

//	All vendors
	@RequestMapping(path = "/allSellers", method = RequestMethod.GET)
	public ModelAndView viewAllSellers(HttpServletRequest request, RedirectAttributes redirAttrs) {

		List<Vendor> all_vendors = vendao.findAll();
		ModelAndView mv = new ModelAndView("pages/display/AllSellers.jsp");
		mv.addObject("all_vendors", all_vendors);
		return mv;
	}
}
