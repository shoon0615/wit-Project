package com.wit.main.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wit.custom.controller.CustomController;
import com.wit.main.dao.MainDAO;

@Controller
@RequestMapping(value = "/main")
public class MainController {
	
	@Autowired
	// @Qualifier("mainDAO")
	MainDAO dao;
	
	private Logger log = LoggerFactory.getLogger(CustomController.class);
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {		
		
		//타일즈/내가 설정하는 jsp경로
		return ".tiles/views/index";
	}

}
