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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.wit.cart.dto.CartDTO;
import com.wit.custom.dto.CustomDTO;
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
	public ModelAndView productDetail(HttpServletRequest request, String PROD_SUBCODE) {		
		PROD_SUBCODE = PROD_SUBCODE.toUpperCase();
		ModelAndView mav = new ModelAndView();

		ProductDTO dto = dao.selectProd(PROD_SUBCODE);
		HashMap<String, Object> map = dao.selectProdScore(PROD_SUBCODE);
		List<String> PROD_IMG = dao.selectProdImg(PROD_SUBCODE);
		List<String> PROD_COLOR = dao.selectProdChoice("C", PROD_SUBCODE);
		List<String> PROD_SIZE = dao.selectProdChoice("S", PROD_SUBCODE);

		mav.addObject("dto", dto);
		mav.addObject("map", map);
		mav.addObject("PROD_IMG", PROD_IMG);		
		mav.addObject("PROD_COLOR", PROD_COLOR);
		mav.addObject("PROD_SIZE", PROD_SIZE);

		// 받은 PROD_SUBCODE가 없을 경우 이전 주소로 롤백함
		if(dto == null) {
			mav.setViewName("redirect:" + request.getHeader("referer").substring(request.getHeader("referer").indexOf("/wit")+4).replace(".action", ""));
		} else {
			mav.setViewName(".tiles/product/productPage");
		}

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
	public @ResponseBody List<String> selectBag(HttpSession session, String PROD_SUBCODE, 
			@RequestParam(value="PROD_INFO[]") List<String> PROD_INFO) {		

		CustomDTO cdto = (CustomDTO)session.getAttribute("customInfo");	
		@SuppressWarnings("unchecked")
		List<CartDTO> lcdto = (List<CartDTO>)session.getAttribute("cart_lists");
		List<String> lists = new ArrayList<String>();
		
		if(cdto != null) {
			lists = dao.selectBag(cdto.getUser_id(), PROD_SUBCODE, PROD_INFO);
		} else if(lcdto != null) {
			lists = dao.selectBag(PROD_SUBCODE, PROD_INFO, lcdto);
		}
		
		return lists;
	}

	@RequestMapping(value = "/insertBag", method = RequestMethod.POST)
	public @ResponseBody String insertBag(HttpSession session, String PROD_SUBCODE, 
			@RequestParam(value="PROD_INFO[]") List<String> PROD_INFO) {		

		CustomDTO cdto = (CustomDTO)session.getAttribute("customInfo");		
		@SuppressWarnings("unchecked")
		List<CartDTO> lcdto = (List<CartDTO>)session.getAttribute("cart_lists");
		
		if(cdto != null) {
			dao.insertBag(cdto.getUser_id(), PROD_SUBCODE, PROD_INFO);
		} else {
			session.setAttribute("cart_lists", dao.insertBag(PROD_SUBCODE, PROD_INFO, lcdto));
		}
		return "";
	}

	//����
	@RequestMapping(value = "/review", method = RequestMethod.POST)
	public String review(HttpServletRequest req,String PROD_SUBCODE,String sort,String mode,String pageNum) {

		String user_form = "NORMAL";

		List<reviewDTO> review_lists = new ArrayList<reviewDTO>();

		int currentPage = 1; 
		if(pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		}
		int numPerPage = 2; 
		int reviewCnt = dao.selectCountReview(PROD_SUBCODE); //��ü���� ī��Ʈ
		int start = 1;
		int end = numPerPage * Integer.parseInt(pageNum);

		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("prod_subcode", PROD_SUBCODE);
		hMap.put("start", start);
		hMap.put("end", end);
		hMap.put("sort", sort);
		hMap.put("user_form", user_form);

		if(mode == null || mode.equals("")){ //�ʱ⸮�� (����: �ֽż�/ üũ�ڽ� üũx)

			review_lists =  dao.selectProductReview(hMap);	

		}else if(mode.equals("photoReview")) { //���丮�丸

			review_lists =  dao.selectPhotoReview(hMap);
			reviewCnt = dao.selectCountPhotoReview(PROD_SUBCODE); //���丮�� ī��Ʈ

		}else if(mode.equals("myFormReview")) { //�� ü���� ���丸

			hMap.put("user_form", user_form);
			review_lists =  dao.selectUserFormReview(hMap);	
			reviewCnt = dao.selectCountFormReview(hMap); //ü���� ī��Ʈ

		}else if(mode.equals("all")){ //���� + ü���� ����

			hMap.put("user_form", user_form);
			review_lists =  dao.selectAllChkReview(hMap);
			reviewCnt = dao.selectCountAllChkReview(hMap); // ü�� + ���丮�� ī��Ʈ

		}

		int totalPage = myUtil.getPageCount(numPerPage, reviewCnt); //��Ż������ī��Ʈ
		if(currentPage > totalPage) currentPage = totalPage;	


		System.out.println("totalPage: " + totalPage);
		System.out.println("currentPage: " + currentPage);
		log.debug("pageNum: " + pageNum);
		log.debug("mode: " + mode);
		log.debug("PROD_SUBCODE: " + PROD_SUBCODE + "user_form: " + user_form);

		//�����̹���
		for(int i=0; i<review_lists.size(); i++) { 
			review_lists.get(i).setReview_img(dao.selectReviewImg(review_lists.get(i).getReview_num()));
		}
		req.setAttribute("review_lists", review_lists);
		req.setAttribute("reviewCnt", reviewCnt);
		req.setAttribute("pageNum", currentPage);
		req.setAttribute("totalPage", totalPage);

		return "product/review";
	}

	//�Ű�
	@RequestMapping(value = "/report", method = RequestMethod.POST)
	public String report(HttpServletRequest req) {

		String user_id = "user";
		int review_num = Integer.parseInt(req.getParameter("review_num"));
		Map<String, Object> hMap = new HashMap<String, Object>();
		
		//�Ű� insert
		hMap.put("review_num", review_num);
		hMap.put("user_id", user_id);
		dao.insertReport(hMap);

		dao.deleteReview(); //�Ű� 3�������� �������
		dao.deleteReport(); //�Ű� ���̺����� ����

		return "product/review";
	}

}
