package com.clothes.demo.controller;

import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.clothes.demo.bean.Mail;
import com.clothes.demo.dao.OrderDao;
import com.clothes.demo.models.customer.CustomerDetails;
import com.clothes.demo.models.orders.Order;
import com.clothes.demo.services.MailService;

@Controller
public class OrderController {
	@Autowired
	private OrderDao odao;
	@Autowired
	private MailService mailservice;
	
//	my Orders
	@RequestMapping(path = "/myOrders")
	public ModelAndView myOrders(HttpServletRequest request,RedirectAttributes redirAttrs){
		HttpSession session = request.getSession();
		CustomerDetails customer = (CustomerDetails) session.getAttribute("customer");
		
		if(null==customer) {
			session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
			ModelAndView tempmodel = new ModelAndView("redirect:/fashion-factory");
			return tempmodel;
		}
		ModelAndView mv = new ModelAndView("pages/display/myorders.jsp");
		List<Order> myorders = odao.findByCustomerSorted(customer);
		mv.addObject("myorders", myorders);
		return mv;
	}
	
//	Checkout
	@RequestMapping(path = "/checkout", method = RequestMethod.GET)
	public String checkOut(HttpServletRequest request,RedirectAttributes redirAttrs){
		HttpSession session = request.getSession();
		CustomerDetails customer = (CustomerDetails) session.getAttribute("customer");
		
		if(null==customer) {
			session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
			
			return "redirect:/fashion-factory";
		}
		return "pages/display/carddetails.jsp";
	}
	
//	Send OTP
	@GetMapping(path = "/sendOtp")
	public String sendOtp(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
		
		return "redirect:/fashion-factory";
	}
	@PostMapping(path = "/sendOtp")
	public String sendOtp(HttpServletRequest request,RedirectAttributes redirAttrs){
		HttpSession session = request.getSession();
		CustomerDetails customer = (CustomerDetails) session.getAttribute("customer");
		
		Random rnd = new Random();
	    int number = rnd.nextInt(999999);
	    // this will convert any number sequence into 6 character.
	    String otp = String.format("%06d", number);
	    
		Mail mail = new Mail();
        mail.setMailFrom("fashion-factory@gmail.com");
        mail.setMailTo(customer.getCustomer_email_id());
        mail.setMailSubject("Payment Confirmation OTP");
        mail.setMailContent("OTP :- "+otp+"\n\n valid up to 2 minutes only!!");
        mailservice.sendEmail(mail);
	    session.setAttribute("myotp", otp);
	    session.setAttribute("SUCCESS", "OTP has been sent Successfully!!");
//		String referer = request.getHeader("Referer");
		return "pages/display/sendotp.jsp";
	}
	
//	otp verification
//	@GetMapping(path = "/otpVerfication")
//	public String otpVerfication(HttpServletRequest request) {
//		HttpSession session = request.getSession();
//		session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
//		
//		return "redirect:/fashion-factory";
//	}
	@RequestMapping(path = "/otpVerfication")
	public String otpVerfication(HttpServletRequest request,RedirectAttributes redirAttrs){
		HttpSession session = request.getSession();
		
		int d1 = Integer.parseInt(request.getParameter("digit1"));
		int d2 = Integer.parseInt(request.getParameter("digit2"));
		int d3 = Integer.parseInt(request.getParameter("digit3"));
		int d4 = Integer.parseInt(request.getParameter("digit4"));
		int d5 = Integer.parseInt(request.getParameter("digit5"));
		int d6 = Integer.parseInt(request.getParameter("digit6"));
		String temp = ""+d1+d2+d3+d4+d5+d6;
		int received_otp = Integer.parseInt(temp);
		String tempotp = session.getAttribute("myotp").toString();
		int sent_otp = Integer.parseInt(tempotp);
		
		if(sent_otp == received_otp) {
			session.removeAttribute("current_order");
			session.removeAttribute("myotp");
			System.out.println("Order Placed!!");
			session.setAttribute("SUCCESS", "Your Items has been ordered Successfully!!");
			return "redirect:myOrders";
		}else {
			session.setAttribute("ERROR", "Entered OTP is Incorrect");
		}
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
}
