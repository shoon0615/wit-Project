package com.wit.category.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wit.category.dao.CategoryDAO;
import com.wit.category.dto.CategoryDTO;
import com.wit.util.MyUtil;

@Controller
@RequestMapping(value = "/category")
public class CategoryController {

	private Logger log = LoggerFactory.getLogger(CategoryController.class);

	@Autowired
	@Qualifier("categoryDAO")
	CategoryDAO dao;

	@Autowired
	MyUtil myUtil;

	@RequestMapping(value = "/shop", method = RequestMethod.GET)
	public String shop(HttpServletRequest request, CategoryDTO dto) throws Exception {
		
		// 테스트 에러 방지로 임시 제작, 완성시 삭제
		if(dto.getProd_category1() == null) {
			dto.setProd_category1("");
			dto.setProd_category2("");
		}
		
		request.setAttribute("category1_list", dao.getCategory(""));
		request.setAttribute("category1", dto.getProd_category1());
		request.setAttribute("category2", dto.getProd_category2());		
		request.setAttribute("pagePrice", dao.getProductPrice(dto));
		
		return ".tiles/category/shop";
	}
	
	@RequestMapping(value = "/category2", method = RequestMethod.POST)
	public String category2(HttpServletRequest request) throws Exception {
		String code_form = request.getParameter("code_form");
	
		request.setAttribute("category2_list", dao.getCategory(code_form));

		return "category/category2";
	}

	@RequestMapping(value = "/productList", method = RequestMethod.POST)
	public String productList(HttpServletRequest request,
			@RequestParam(value="sizeArray[]") List<String> sizeArray) throws Exception {

		// 리스트 생성
		List<CategoryDTO> list = null;
		// 절대 경로 생성
		String cp = request.getContextPath();
		// 맵 객체 추가
		Map<String, Object> hMap = new HashMap<String, Object>();
		// 넘어오는값
		String type = request.getParameter("searchType");		// 상품 리스트(all/가격/조회수/리뷰/별점)
		String pageNum = request.getParameter("pageNum");		// 페이지 넘버
		String category1 = request.getParameter("category1");	// 카테고리 대분류
		String category2 = request.getParameter("category2");	// 카테고리 중분류
		String sort = request.getParameter("searchSort");		// 정렬 타입(asc/desc)
		int minAmount = Integer.parseInt(request.getParameter("minAmount"));	// 금액바 최소 금액
		int maxAmount = Integer.parseInt(request.getParameter("maxAmount"));	// 금액바 최대 금액

		// 카테고리 및 금액 추가
		hMap.put("category1", category1);
		hMap.put("category2", category2);
		hMap.put("minAmount", minAmount);
		hMap.put("maxAmount", maxAmount);

		// 페이지 번호의 onclick 데이터로 인한 추가
		hMap.put("type", type);
		hMap.put("sort_data", sort);
		
		// 정렬 타입 추가
		if(sort == null || sort.equals("0")) {
			hMap.put("sort", "asc");
		} else {
			hMap.put("sort", "desc");
		}

		// 사이즈 배열 추가
		//체크한 사이즈를 예를 들어 220,250 의 모양으로 만들어 SQL 조건문 중 IN 안에 넣음
		Iterator<String> iter = sizeArray.iterator();
        String size = "";
        while(iter.hasNext()){
        	size += "'";
            size += (String)iter.next()+"',";
        }
        size = size.replaceAll(",$", "");

        if(size.equals("'0'")) {
        	hMap.put("size", "'%%'");
        	hMap.put("sizeChk", "like");
        } else {
        	hMap.put("size", size);
        	hMap.put("sizeChk", "in");
        }
        
		// 페이지 넘버 추가
		int currentPage = 1;
		if (pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		} else {
			pageNum = "1"; // 처음 페이지값
		}
		int dataCount = dao.getProductCount(hMap);
		int numPerPage = 2;// 페이지에 보여주는 게시물수
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		if (currentPage > totalPage) {
			currentPage = totalPage;
		}
		// 한 페이지의 첫과 끝 게시물 번호
		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;
		hMap.put("start", start);
		hMap.put("end", end);
		/*	
		 * 
		 * 
		 * // 전달할 url과 path String 
		 * articleUrl = cp + "/productDetail.action?pageNum=" +
		 * currentPage; if (!param.equals("")) articleUrl = articleUrl + "&" + param;
		 * 
		 * 
		 * String imagePath = "/gyp/sfiles/product"; // 이미지 경로
		 */
	
		// 상품 리스트 호출
		if (type.equals("priceSort")) {
			list = dao.getPriceProductList(hMap);
		} else if (type.equals("viewSort")) {
			list = dao.getViewOrderProductList(hMap);
		} else if (type.equals("reviewSort")) {
			list = dao.getReviewCountProductList(hMap);
		} else if (type.equals("starSort")) {
			list = dao.getStarRatingProductList(hMap);
		} else {
			list = dao.getAllProductList(hMap);
		}

		String searchUrl = "shop.action";
		String pageIndexList = myUtil.categoryPageIndexList(currentPage, totalPage, searchUrl, hMap);

		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("dataCount", dataCount);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("pageIndexList", pageIndexList);
		request.setAttribute("category1", category1);
		request.setAttribute("category2", category2);
		// request.setAttribute("imagePath", imagePath);
		// request.setAttribute("articleUrl", articleUrl);
		
		return "category/productList";
	}

	@RequestMapping(value = "/categorySize", method = RequestMethod.POST)
	public String categorySize(HttpServletRequest request) throws Exception {

		String category1 = request.getParameter("category1");
		
		request.setAttribute("category1", category1);
		request.setAttribute("categorySize", dao.getCategorySize(category1));

		return "category/categorySize";
	}
	
	@RequestMapping(value = "/categoryPrice", method = RequestMethod.POST)
	public @ResponseBody Map<String, Integer> categoryPrice(CategoryDTO dto) {
		Map<String, Integer> map = dao.getProductPrice(dto);

		return map;
	}
	
}
