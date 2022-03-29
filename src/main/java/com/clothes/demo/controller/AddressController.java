package com.clothes.demo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.clothes.demo.dao.AddressDao;
import com.clothes.demo.dao.CustomerDao;
import com.clothes.demo.models.customer.Address;
import com.clothes.demo.models.customer.CustomerDetails;

@Controller
public class AddressController {
	@Autowired
	AddressDao adddao;
	@Autowired
	CustomerDao custdao;
	
//	add customer address
	@RequestMapping(path = "/fashion-factory/addAddress", method = RequestMethod.POST)
	public String addAddress(Address address,@RequestParam("customer_id") Long cust_id,HttpServletRequest request,RedirectAttributes redirAttrs) {
		HttpSession session = request.getSession();
		CustomerDetails cust = custdao.findById(cust_id).orElse(null);
		address.setCd(cust);
		adddao.save(address);
//		System.out.println("Address Entered");
		session.setAttribute("SUCCESS", "Addres Added Successfully!!");
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
//	Edit customer address
	@RequestMapping(path = "/fashion-factory/editAddress", method = RequestMethod.POST)
	public String editAddress(Address address,@RequestParam("customer_id") Long cust_id,@RequestParam("address_id") Long add_id,HttpServletRequest request,RedirectAttributes redirAttrs) {
		HttpSession session = request.getSession();
		adddao.setAddressById(address.getHouse_no(),address.getStreet(),address.getCity(),address.getDistrict(),address.getState(),address.getPincode(),add_id);
//		System.out.println("Address Edited");
		session.setAttribute("SUCCESS", "Addres Updated Successfully!!");
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
}
