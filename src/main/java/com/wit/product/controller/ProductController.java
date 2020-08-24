package com.wit.product.controller;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.wit.product.dao.ProductDAO;
import com.wit.product.dto.ProductDTO;

@Controller
@RequestMapping(value = "/product")
public class ProductController {
	
	@Autowired
	// @Qualifier("productDAO")
	ProductDAO dao;
	
	private Logger log = LoggerFactory.getLogger(ProductController.class);
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {		
		// log.debug("AAA");
		return "shop";
	}
	
	@RequestMapping(value = "/productDetail", method = RequestMethod.GET)
	public ModelAndView productDetail(String PROD_SUBCODE) {		

		ModelAndView mav = new ModelAndView();
		
		ProductDTO dto = dao.selectProd(PROD_SUBCODE);
		HashMap<String, Object> map = dao.selectProdScore();
		List<String> PROD_IMG = dao.selectProdImg();
		List<String> PROD_COLOR = dao.selectProdChoice("C");
		List<String> PROD_SIZE = dao.selectProdChoice("S");

		mav.addObject("dto", dto);
		mav.addObject("map", map);
		mav.addObject("PROD_IMG", PROD_IMG);
		mav.addObject("PROD_COLOR", PROD_COLOR);
		mav.addObject("PROD_SIZE", PROD_SIZE);
		
		mav.setViewName("product/productPage");
		
		return mav;
	}
	
	@RequestMapping(value = "/choiceProd", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody ProductDTO choiceProd(String PROD_SUBCODE, String PROD_COLOR, String PROD_SIZE) {

		ProductDTO dto = new ProductDTO();
		
		dto.setPROD_SUBCODE(PROD_SUBCODE);
		dto.setPROD_COLOR(PROD_COLOR);
		dto.setPROD_SIZE(PROD_SIZE);
		
		dto = dao.choiceProd(dto);

		return dto;
	}
	
	@RequestMapping(value = "/kakao", method = RequestMethod.GET)
	public String kakao() {		
		// log.debug("AAA");
		return "product/kakao";
	}

}
