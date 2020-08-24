package com.wit.category.controller;

import java.net.URLEncoder;
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
	public String shop(HttpServletRequest request) throws Exception {

		return "shop";
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
		String pageNum = request.getParameter("pageNum");
		String type = request.getParameter("searchType");// 정렬 타입(all/가격↑↓/조회수↑↓/리뷰↑↓/별점↑↓)
		String category1 = request.getParameter("category1");
		String category2 = request.getParameter("category2");
		
		String param = "";
		param = "category1=" + category1;
		param += "&category2=" + category2;
		param += "&type=" + type;
		
		hMap.put("category1", category1);
		hMap.put("category2", category2);
		
		//체크한 사이즈를 예를 들어 220,250 의 모양으로 만들어 SQL 조건문 중 IN 안에 넣음
		Iterator<String> iter = sizeArray.iterator();
        String size = null;
        while(iter.hasNext()==true){
            size += (String)iter.next()+",";
        }
        size = size.replaceAll(",$", "");
		System.out.print(size);
        
		// 페이징
		int currentPage = 1;
		if (pageNum != null) {
			currentPage = Integer.parseInt(pageNum);
		} else {
			pageNum = "1"; // 처음 페이지값
		}
		int dataCount = dao.getProductCount(hMap);
		int numPerPage = 9;// 페이지에 보여주는 게시물수
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		if (currentPage > totalPage) {
			currentPage = totalPage;
		}
		// 한 페이지의 첫과 끝 게시물 번호
		int start = (currentPage - 1) * numPerPage + 1;
		int end = currentPage * numPerPage;
		hMap.put("start", start);
		hMap.put("end", end);
		
		String searchUrl = "shop.action?" + param;
		String pageIndexList = myUtil.categoryPageIndexList(currentPage, totalPage, searchUrl,type);

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
		if (type.equals("가격↑")) {
			list = dao.getExpensiveProductList(hMap);
		} else if (type.equals("가격↓")) {
			list = dao.getCheapProductList(hMap);
		} else if (type.equals("조회수↑")) {
			list = dao.getHighViewOrderProductList(hMap);
		} else if (type.equals("조회수↓")) {
			list = dao.getLowViewOrderProductList(hMap);
		} else if (type.equals("리뷰↑")) {
			list = dao.getManyReviewCountProductList(hMap);
		} else if (type.equals("리뷰↓")) {
			list = dao.getLittleReviewCountProductList(hMap);
		} else if (type.equals("별점↑")) {
			list = dao.getHighStarRatingProductList(hMap);
		} else if (type.equals("별점↓")) {
			list = dao.getLowStarRatingProductList(hMap);
		} else if (type.equals("all")) {
			list = dao.getAllProductList(hMap);
		}

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

		return "productList";
	}

	@RequestMapping(value = "/categorySize", method = RequestMethod.POST)
	public String categorySize(HttpServletRequest request) throws Exception {

		String category1 = request.getParameter("category1");
		
		request.setAttribute("category1", category1);

		return "categorySize";
	}
	
}
