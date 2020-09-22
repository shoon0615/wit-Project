package com.wit.myPage.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wit.myPage.dao.MyPageDAO;

@Controller
@RequestMapping(value = "/myPage")
public class MyPageController {

private Logger log = LoggerFactory.getLogger(MyPageController.class);
	
	@Autowired
	// @Qualifier("myPageDAO")
	MyPageDAO dao;
	
	@RequestMapping(value = "/mainPage", method = {RequestMethod.GET, RequestMethod.POST})
	public String mainPage(HttpServletRequest request) {
		
		return ".tiles/myPage/mainPage";
	}
	
	@RequestMapping(value = "/orderPage", method = RequestMethod.POST)
	public String orderPage(HttpServletRequest request) {	
		String user_id = "users";	
		request.setAttribute("lists", dao.getOrder(user_id));
		
		return "myPage/orderPage";
	}
	
	@RequestMapping(value = "/reviewPage", method = RequestMethod.POST)
	public String reviewPage(HttpServletRequest request) {	
		String user_id = "users";	
		request.setAttribute("lists", dao.getReview(user_id));
		
		return "myPage/reviewPage";
	}
	
	@RequestMapping(value = "/heartPage", method = RequestMethod.POST)
	public String heartPage(HttpServletRequest request) {	
		String user_id = "users";	
		request.setAttribute("lists", dao.getHeart(user_id));
		
		return "myPage/heartPage";
	}
}
