package com.wit.myPage.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.wit.myPage.dao.MyPageDAO;
import com.wit.myPage.dto.MyPageDTO;

@Controller
@RequestMapping(value = "/myPage")
public class MyPageController {

private Logger log = LoggerFactory.getLogger(MyPageController.class);
	
	@Autowired
	// @Qualifier("myPageDAO")
	MyPageDAO dao;
	
	// 메인 페이지
	@RequestMapping(value = "/mainPage", method = {RequestMethod.GET, RequestMethod.POST})
	public String mainPage(HttpServletRequest request) {
		
		return ".tiles/myPage/mainPage";
	}
	
	// 1: 내가 주문한 내역 페이지
	@RequestMapping(value = "/orderPage", method = RequestMethod.POST)
	public String orderPage(HttpServletRequest request) {	
		String user_id = "users";	
		request.setAttribute("lists", dao.getOrder(user_id));
		
		return "myPage/orderPage";
	}

	// 1: 리뷰 작성 페이지
	@RequestMapping(value = "/reviewWritePage", method = RequestMethod.POST)
	public String reviewWritePage(HttpServletRequest request, MyPageDTO dto) {	
		String user_id = "users";	
		request.setAttribute("order_code", dto.getOrder_code());
		request.setAttribute("prod_code", dto.getProd_code());
		
		return "myPage/reviewWritePage";
	}
	
	// 1: 리뷰 작성 기능
	@RequestMapping(value = "/reviewInsert", method = RequestMethod.POST)
	public String reviewInsert(MyPageDTO dto) {	

		dto.setReview_num(dao.getMaxReview_Num()+1); 
		dto.setUser_id("users");
		dao.insertReview(dto);
		dao.insertReview_Img(dto);
		
		return "redirect:/myPage/mainPage";
	}
	
	// 2: 내가 리뷰 작성한 내역 페이지
	@RequestMapping(value = "/reviewPage", method = RequestMethod.POST)
	public String reviewPage(HttpServletRequest request) {	
		String user_id = "users";	
		request.setAttribute("lists", dao.getReview(user_id));
		
		return "myPage/reviewPage";
	}
	
	// 2: 리뷰 삭제 기능
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.POST)
	public @ResponseBody String reviewDelete(String review_num) {	
		dao.deleteReview(review_num);
		return "";
	}
	
	// 3: 내가 찜한 상품 목록 페이지
	@RequestMapping(value = "/heartPage", method = RequestMethod.POST)
	public String heartPage(HttpServletRequest request) {	
		String user_id = "users";	
		request.setAttribute("lists", dao.getHeart(user_id));
		
		return "myPage/heartPage";
	}
	
	// 3: 찜한 상품 삭제 기능
	@RequestMapping(value = "/heartDelete", method = RequestMethod.POST)
	public @ResponseBody String heartDelete(MyPageDTO dto) {	
		dto.setUser_id("users");
		dao.deleteHeart(dto);
		return "";
	}
}
