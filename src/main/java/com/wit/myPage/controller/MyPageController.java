package com.wit.myPage.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.custom.dto.CustomDTO;
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
	public String mainPage(HttpServletRequest request, HttpSession session) {
		
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");
		
		if(dtoSession == null) {
			return "redirect:/custom/login";
		} else {
			if(request.getParameter("choice") != null) {
				request.setAttribute("choice", request.getParameter("choice"));
			}
			return ".tiles/myPage/mainPage";
		}
	}
	
	// 1: 내가 주문한 내역 페이지
	@RequestMapping(value = "/orderPage", method = RequestMethod.POST)
	public String orderPage(HttpServletRequest request, HttpSession session) {	
		
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");

		request.setAttribute("lists", dao.getOrder(dtoSession.getUser_id()));
		
		return "myPage/orderPage";
	}

	// 1: 리뷰 작성 페이지
	@RequestMapping(value = "/reviewWritePage", method = RequestMethod.POST)
	public String reviewWritePage(HttpServletRequest request, MyPageDTO dto) {	

		request.setAttribute("order_code", dto.getOrder_code());
		request.setAttribute("prod_code", dto.getProd_code());
		
		return "myPage/reviewWritePage";
	}
	
	// 1: 리뷰 작성 기능
	@RequestMapping(value = "/reviewInsert", method = RequestMethod.POST)
	public String reviewInsert(HttpSession session, MyPageDTO dto) {	
		
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");
		dto.setReview_num(dao.getMaxReview_Num()+1); 
		dto.setUser_id(dtoSession.getUser_id());
		
		dao.insertReview(dto);
		dao.insertReview_Img(dto);
		
		return "redirect:/myPage/mainPage";
	}
	
	// 2: 내가 리뷰 작성한 내역 페이지
	@RequestMapping(value = "/reviewPage", method = RequestMethod.POST)
	public String reviewPage(HttpServletRequest request, HttpSession session) {	
		
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");

		request.setAttribute("lists", dao.getReview(dtoSession.getUser_id()));
		
		return "myPage/reviewPage";
	}
	
	// 2: 리뷰 삭제 기능
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.POST)
	public @ResponseBody String reviewDelete(String review_num) {	
		dao.deleteReview(review_num);
		return "";
	}
	
	// 3: 찜한 상품 등록 기능
	@RequestMapping(value = "/heartInsert", method = RequestMethod.POST)
	public @ResponseBody String heartInsert(HttpSession session, MyPageDTO dto) {	
		
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");
		dto.setUser_id(dtoSession.getUser_id());
	
		try {
			dao.insertHeart(dto);
			return "true";							// 성공
		} catch (UncategorizedSQLException ue) {
			return "over";							// 30개 초과시 에러(Trigger)
		} catch (Exception e) {
			return "false";							// 같은 상품 있을 때 외 기타 경우
		}
	}
	
	// 3: 내가 찜한 상품 목록 페이지
	@RequestMapping(value = "/heartPage", method = RequestMethod.POST)
	public String heartPage(HttpServletRequest request, HttpSession session) {	

		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");
		
		request.setAttribute("lists", dao.getHeart(dtoSession.getUser_id()));
		
		return "myPage/heartPage";
	}
	
	// 3: 찜한 상품 삭제 기능
	@RequestMapping(value = "/heartDelete", method = RequestMethod.POST)
	public @ResponseBody String heartDelete(HttpSession session, MyPageDTO dto) {	
		
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");
		dto.setUser_id(dtoSession.getUser_id());

		dao.deleteHeart(dto);
		
		return "";
	}
}
