package com.wit.payment.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wit.payment.dao.PaymentDAO;
import com.wit.payment.dto.PaymentDTO;

@Controller
@RequestMapping(value = "/payment")
public class PaymentController {

	private Logger log = LoggerFactory.getLogger(PaymentController.class);
	
	@Autowired
	// @Qualifier("productDAO")
	PaymentDAO dao;
	
	@RequestMapping(value = "/checkout", method = {RequestMethod.GET, RequestMethod.POST})
	public String checkout(HttpServletRequest request, HttpSession session, String prodStr) {	
		List<Map<String, Object>> list = dao.getProdCode(prodStr);
		
		request.setAttribute("prod_list", list);
		
		return ".tiles/payment/checkout";
	}
	
	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public String payment(HttpServletRequest request, PaymentDTO dto) {	

		dao.insertOrderMain(dto);
		
		return "redirect:/category/shop.action";
	}
	
}
