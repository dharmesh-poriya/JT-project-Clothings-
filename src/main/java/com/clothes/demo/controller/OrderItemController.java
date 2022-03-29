package com.clothes.demo.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.clothes.demo.dao.AddressDao;
import com.clothes.demo.dao.OrderDao;
import com.clothes.demo.dao.OrderItemDao;
import com.clothes.demo.dao.ProductDao;
import com.clothes.demo.models.authenticate.Admin;
import com.clothes.demo.models.customer.Address;
import com.clothes.demo.models.customer.CustomerDetails;
import com.clothes.demo.models.orders.Order;
import com.clothes.demo.models.orders.OrderItem;
import com.clothes.demo.models.products.Product;
import com.clothes.demo.models.vendor.Vendor;

@Controller
public class OrderItemController {
	@Autowired
	private OrderItemDao oitemdao;
	@Autowired
	private OrderDao odao;
	@Autowired
	ProductDao prodao;
	@Autowired
	AddressDao adddao;

//	Add product
	@GetMapping(path = "/fashion-factory/addToCart")
	public String addProduct(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");

		return "redirect:/fashion-factory";
	}
	@PostMapping(path = "/fashion-factory/addToCart")
	public String addProduct(@RequestParam("product_id") Long proid, @RequestParam("quentity") int quentity,
			HttpServletRequest request, RedirectAttributes redirAttrs) throws IOException {
		System.out.println("in ADDTOCART");
		HttpSession session = request.getSession();
		CustomerDetails customer = (CustomerDetails) session.getAttribute("customer");
		Vendor vendor = (Vendor) session.getAttribute("vendor");
		Admin admin = (Admin) session.getAttribute("admin");
		//		if customer not logged in and try to go this url
		if(null!=vendor || null!=admin) {
			session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
			String referer = request.getHeader("Referer");
			return "redirect:" + referer;
		}else if(null==customer) {
			session.setAttribute("ERROR", "You should first need to Login or SignUp!!");
			String referer = request.getHeader("Referer");
			return "redirect:" + referer;
		}
		
		Order current_order = (Order) session.getAttribute("current_order");
		long millis = System.currentTimeMillis();
		if (null == current_order) {
			Order newOrder = new Order();
			newOrder.setOrder_date(new java.sql.Date(millis));
			newOrder.setOrder_time(new java.sql.Time(millis));
			newOrder.setCustomer(customer);

			Order savedOrder = odao.save(newOrder);
			session.setAttribute("current_order", savedOrder);
			current_order = (Order) session.getAttribute("current_order");
		}

		OrderItem myitem = new OrderItem();
		Product myproduct = prodao.findById(proid).orElse(null);
		List<OrderItem> itemexist = oitemdao.findByOrder_idAndProduct_id(current_order, myproduct);
		Long solditems = myproduct.getSold_quantity();
		solditems += quentity;
		if (itemexist.isEmpty()) {
			myitem.setItem_price(myproduct.getProduct_price());
			myitem.setQuentity(quentity);
			myitem.setOrder_item_date((Date) new java.sql.Date(millis));
			myitem.setOrder_item_time((Time) new java.sql.Time(millis));
			myitem.setProduct(myproduct);
			myitem.setOrder(current_order);
		} else {
			myitem = itemexist.get(0);
			session.setAttribute("SUCCESS", quentity+" Added in to the cart");
			quentity += myitem.getQuentity();
			System.out.println(quentity);
			oitemdao.setOrderItemByQuentity(quentity, myitem.getId());
		}
		oitemdao.save(myitem);
		prodao.setSold_QuantityById(solditems, proid);
//		temporary printing data
		System.out.println("Item added to cart");
//		System.out.println(myitem);
//		System.out.println(myproduct);
		
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
//	showing carts items
	@RequestMapping(path = "/myCarts", method = RequestMethod.GET)
	public ModelAndView myCarts(HttpServletRequest request,RedirectAttributes redirAttrs){
		System.out.println("In My Carts");
		HttpSession session = request.getSession();
		CustomerDetails customer = (CustomerDetails) session.getAttribute("customer");
//		if customer not logged in and try to go this url
		if(null==customer) {
			session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
			ModelAndView tempmodel = new ModelAndView("redirect:/fashion-factory");
			return tempmodel;
		}
		
		ModelAndView mv = new ModelAndView("pages/display/mycarts.jsp");
		
		Order current_order = (Order) session.getAttribute("current_order");
		if(null != customer) {
			Address customeradd = adddao.findBycd(customer);
			mv.addObject("customer_address", customeradd);
		}
		List<OrderItem> carts = oitemdao.findAllByOrder_id(current_order);
		mv.addObject("carts", carts);
		
		return mv;
	}
	
//	Edit purchased Quantity
	@GetMapping(path = "/fashion-factory/editCartQuentity")
	public String editCartQuentity(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
		
		return "redirect:/fashion-factory";
	}
	@PostMapping(path = "/fashion-factory/editCartQuentity")
	public String editCartQuentity(@RequestParam("id") Long id,@RequestParam("quantity") int quentity,HttpServletRequest request,RedirectAttributes redirAttrs){
		OrderItem current_q = oitemdao.findById(id).orElse(null);
		HttpSession session = request.getSession();
		CustomerDetails customer = (CustomerDetails) session.getAttribute("customer");
//		if customer not logged in and try to go this url
		if(null==customer) {
			session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
			String referer = request.getHeader("Referer");
			return "redirect:" + referer;
		}
		int q = current_q.getQuentity();
		if(q>quentity) {
			Long que = (long) (q-quentity);
			que = current_q.getProduct().getSold_quantity()-que;
			prodao.setSold_QuantityById(que, current_q.getProduct().getId());
		}else if(q<quentity) {
			Long que = (long) (quentity-q);
			que += current_q.getProduct().getSold_quantity();
			prodao.setSold_QuantityById(que, current_q.getProduct().getId());
		}
		oitemdao.setOrderItemByQuentity(quentity, id);
		session.setAttribute("SUCCESS", "Quantity Updated Successfully!!");
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
//	Delete purchased Items
	@GetMapping(path = "/fashion-factory/deleteCartQuentity")
	public String deleteCartQuentity(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
		
		return "redirect:/fashion-factory";
	}
	@PostMapping(path = "/fashion-factory/deleteCartQuentity")
	public String deleteCartQuentity(@RequestParam("id") Long id,HttpServletRequest request,RedirectAttributes redirAttrs){
		HttpSession session = request.getSession();
		OrderItem current_q = oitemdao.findById(id).orElse(null);
		Long que = current_q.getProduct().getSold_quantity()-current_q.getQuentity();
		prodao.setSold_QuantityById(que, current_q.getProduct().getId());
		oitemdao.deleteById(id);
		session.setAttribute("SUCCESS", "Item Deleted Successfully!!");
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
//	view specific order items according to order
	@GetMapping(path = "/orderedItems")
	public String orderedItems(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("ERROR", "You should first need to Login or SignUp as Customer!!");
		
		return "redirect:/fashion-factory";
	}
	@PostMapping(path = "/orderedItems")
	public ModelAndView orderedItems(@RequestParam("id") Long id,HttpServletRequest request,RedirectAttributes redirAttrs){
		ModelAndView mv = new ModelAndView("pages/display/ordereditems.jsp");
		Order order = odao.findById(id).orElse(null);
		List<OrderItem> ordered_items = oitemdao.findAllByOrder_id(order);
		mv.addObject("ordered_items", ordered_items);
		return mv;
	}
	

}
