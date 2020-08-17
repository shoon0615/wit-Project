package com.wit.custom.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/custom")
public class CustomController {
	
	private Logger log = LoggerFactory.getLogger(CustomController.class);
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {		
		// log.debug("AAA");
		return "index";
	}

}
