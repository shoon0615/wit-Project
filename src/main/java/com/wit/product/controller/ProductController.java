package com.wit.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.wit.product.dao.ProductDAO;
import com.wit.product.dto.ProductDTO;
import com.wit.product.dto.reviewDTO;
import com.wit.util.MyUtil;

@Controller
@RequestMapping(value = "/product")
public class ProductController {

	@Autowired
	// @Qualifier("productDAO")
	ProductDAO dao;

	@Autowired
	MyUtil myUtil;

	private Logger log = LoggerFactory.getLogger(ProductController.class);

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {		
		// log.debug("AAA");
		return "product/index";
	}

	@RequestMapping(value = "/productDetail", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView productDetail(String PROD_SUBCODE,String sort) {		

		String user_form = "NORMAL";

		ModelAndView mav = new ModelAndView();

		ProductDTO dto = dao.selectProd(PROD_SUBCODE);
		HashMap<String, Object> map = dao.selectProdScore();
		List<String> PROD_IMG = dao.selectProdImg(PROD_SUBCODE);
		List<String> PROD_COLOR = dao.selectProdChoice("C", PROD_SUBCODE);
		List<String> PROD_SIZE = dao.selectProdChoice("S", PROD_SUBCODE);



		mav.addObject("dto", dto);
		mav.addObject("map", map);
		mav.addObject("PROD_IMG", PROD_IMG);
		mav.addObject("PROD_COLOR", PROD_COLOR);
		mav.addObject("PROD_SIZE", PROD_SIZE);

		mav.setViewName(".tiles/product/productPage");

		return mav;
	}

	@RequestMapping(value = "/choiceProd", method = RequestMethod.POST)
	public @ResponseBody ProductDTO choiceProd(String PROD_SUBCODE, String PROD_COLOR, String PROD_SIZE) {

		ProductDTO dto = new ProductDTO();

		dto.setPROD_SUBCODE(PROD_SUBCODE);
		dto.setPROD_COLOR(PROD_COLOR);
		dto.setPROD_SIZE(PROD_SIZE);

		dto = dao.choiceProd(dto);

		return dto;
	}

	@RequestMapping(value = "/selectBag", method = RequestMethod.POST)
	public @ResponseBody List<String> selectBag(HttpServletRequest req,
			String PROD_SUBCODE, 
			@RequestParam(value="PROD_INFO[]") List<String> PROD_INFO) {		

		HttpSession session = req.getSession();

		List<String> lists = dao.selectBag("user", PROD_SUBCODE, PROD_INFO);

		return lists;
	}

	@RequestMapping(value = "/insertBag", method = RequestMethod.POST)
	public @ResponseBody String insertBag(HttpServletRequest req,
			String PROD_SUBCODE, 
			@RequestParam(value="PROD_INFO[]") List<String> PROD_INFO) {		

		HttpSession session = req.getSession();

		dao.insertBag("user", PROD_SUBCODE, PROD_INFO);

		return "";
	}

	@RequestMapping(value = "/shopcart", method = RequestMethod.GET)
	public String shopcart() {		

		return "shop-cart";
	}

	@RequestMapping(value = "/kakao", method = RequestMethod.GET)
	public String kakao() {		
		// log.debug("AAA");
		return "product/kakao";
	}

	//리뷰
	@RequestMapping(value = "/review", method = RequestMethod.POST)
	public String review(HttpServletRequest req,String PROD_SUBCODE,String sort,String mode,String pageNum) {

		String user_form = "NORMAL";
		
		List<reviewDTO> review_lists = new ArrayList<reviewDTO>();
		
		int currentPage = 1; 
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		int numPerPage = 2; 
		int reviewCnt = dao.selectCountReview(PROD_SUBCODE); //전체리뷰 카운트
		int start = (currentPage - 1) * numPerPage + 1; //3
		int end = currentPage * numPerPage; //4

		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("prod_subcode", PROD_SUBCODE);
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("sort", sort);
		hMap.put("user_form", user_form);

		if(mode == null || mode.equals("")){ //초기리뷰 (정렬: 최신순/ 체크박스 체크x)

			review_lists =  dao.selectProductReview(hMap);	

		}else if(mode.equals("photoReview")) { //포토리뷰만

			review_lists =  dao.selectPhotoReview(hMap);
			reviewCnt = dao.selectCountPhotoReview(PROD_SUBCODE); //포토리뷰 카운트

		}else if(mode.equals("myFormReview")) { //내 체형별 리뷰만

			hMap.put("user_form", user_form);
			review_lists =  dao.selectUserFormReview(hMap);	
			reviewCnt = dao.selectCountFormReview(hMap); //체형별 카운트

		}else if(mode.equals("all")){ //포토 + 체형별 리뷰

			hMap.put("user_form", user_form);
			review_lists =  dao.selectAllChkReview(hMap);
			reviewCnt = dao.selectCountAllChkReview(hMap); // 체형 + 포토리뷰 카운트

		}

		int totalPage = myUtil.getPageCount(numPerPage, reviewCnt); //토탈페이지카운트

		if(currentPage > totalPage) currentPage = totalPage;

		System.out.println("totalPage: " + totalPage);
		System.out.println("currentPage: " + currentPage);
		log.debug(pageNum);
		log.debug(mode);
		log.debug("PROD_SUBCODE: " + PROD_SUBCODE + "user_form: " + user_form);

		for(int i=0; i<review_lists.size(); i++) { //리뷰이미지
			review_lists.get(i).setReview_img(dao.selectReviewImg(review_lists.get(i).getReview_num()));
		}

		req.setAttribute("review_lists", review_lists);
		req.setAttribute("reviewCnt", reviewCnt);
		req.setAttribute("pageNum", pageNum);
		req.setAttribute("totalPage", totalPage);

		return "product/review";
	}

}
