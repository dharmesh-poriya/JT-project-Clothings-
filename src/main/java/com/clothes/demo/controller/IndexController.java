package com.clothes.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.clothes.demo.dao.ProductDao;
import com.clothes.demo.models.products.Product;

@Controller
public class IndexController {
	
	@Autowired
	ProductDao prodao;
	
//	@RequestMapping(path="/",method=RequestMethod.POST) write like this or
//	@PostMapping(path="/")
	@RequestMapping(path="/fashion-factory")
	public ModelAndView index(RedirectAttributes redirAttrs) {
		List<Product> menpro = prodao.findByProduct_category("Men");
		List<Product> womenpro = prodao.findByProduct_category("Women");
		List<Product> kidspro = prodao.findByProduct_category("Kids");
		
		ModelAndView mv = new ModelAndView("index.jsp");
		mv.addObject("menproduct", menpro);
		mv.addObject("womenproduct", womenpro);
		mv.addObject("kidsproduct", kidspro);
		redirAttrs.addFlashAttribute("success", "Everything went just fine.");
		return mv;
	}
}
