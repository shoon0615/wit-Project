package com.wit.product.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/product")
public class ProductController {
	
	private Logger log = LoggerFactory.getLogger(ProductController.class);
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {		
		// log.debug("AAA");
		return "index";
	}

}
