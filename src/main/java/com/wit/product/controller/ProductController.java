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
import org.springframework.stereotype.
Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.wit.product.dao.ProductDAO;
import com.wit.product.dto.CartDTO;
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

		List<String> lists = dao.selectBag("users", PROD_SUBCODE, PROD_INFO);

		return lists;
	}

	@RequestMapping(value = "/insertBag", method = RequestMethod.POST)
	public @ResponseBody String insertBag(HttpServletRequest req,
			String PROD_SUBCODE, 
			@RequestParam(value="PROD_INFO[]") List<String> PROD_INFO) {		

		HttpSession session = req.getSession();

		dao.insertBag("users", PROD_SUBCODE, PROD_INFO);

		return "";
	}
	
	@RequestMapping(value = "/shopcart", method = {RequestMethod.GET})
	public String shopcart(HttpServletRequest req) {
	
		return ".tiles/product/shop-cart";
	}

	@RequestMapping(value = "/shopcart_ok", method = {RequestMethod.POST})
	public String shopcart_ok(HttpServletRequest req) {
		
		String user_id = "users";
		List<CartDTO> lists = dao.selectCart(user_id);
		int total_amount = dao.selectTotalAmount(user_id);
		req.setAttribute("lists", lists);
		req.setAttribute("total_amount", total_amount);
		
		return "/product/cartDetail";
	}
	
	@RequestMapping(value = "/updateCart", method = RequestMethod.POST)
	public @ResponseBody int updateCart(HttpServletRequest req,String prod_code) {
		
		String user_id = "users";
		int cart_qty = Integer.parseInt(req.getParameter("cart_qty"));
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("cart_qty", cart_qty);
		hMap.put("prod_code", prod_code);
		dao.updateCart(hMap);
		
		int total_amount = dao.selectTotalAmount(user_id);
		
		return total_amount;
	}
	
	@RequestMapping(value = "/deleteCart", method = RequestMethod.POST)
	public String deleteCart(HttpServletRequest req,String prod_code) {
		
		System.out.println(prod_code);
		
		String[] prod_code_arr = null;
		String user_id = "users";
		Map<String, Object> hMap = new HashMap<String, Object>();
		
		prod_code = prod_code.substring(0, prod_code.length()-1);
		prod_code_arr = prod_code.split(",");
		
		for(int i=0; i<prod_code_arr.length; i++) {
			
			hMap.put("user_id", user_id);
			hMap.put("prod_code", prod_code_arr[i]);
			
			System.out.println(prod_code_arr[i]);
			dao.deleteCart(hMap);
		}
		
		List<CartDTO> lists = dao.selectCart(user_id);
		
		req.setAttribute("lists", lists);
		
		return "product/cartDetail";
	}

	@RequestMapping(value = "/kakao", method = RequestMethod.GET)
	public String kakao() {		
		// log.debug("AAA");
		return "product/kakao";
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

		String user_id = "users";
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
	
	//�Ű�
		@RequestMapping(value = "cartOptionChange", method = RequestMethod.GET)
		public String cartOptionChange(HttpServletRequest req) {

			return "product/cartOptionModal";
		}

}
