package com.wit.main.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wit.category.dao.CategoryDAO;
import com.wit.category.dto.CategoryDTO;

import com.wit.main.dao.MainDAO;
import com.wit.main.dto.MainDTO;

@Controller
@RequestMapping(value = "/main")
public class MainController {

	@Autowired
	// @Qualifier("mainDAO")
	MainDAO maindao;
	
	@Autowired
	CategoryDAO categorydao;

	private Logger log = LoggerFactory.getLogger(MainController.class);

	/*
	 * @RequestMapping(value = "/main", method = {RequestMethod.GET,
	 * RequestMethod.POST}) public String main(HttpServletRequest req) {
	 * 
	 * //타일즈/내가 설정하는 jsp경로 return ".tiles/views/index"; }
	 */
	
	@RequestMapping(value = "/test", method = {RequestMethod.GET, RequestMethod.POST})
	public String test() {
		return "blog-details";
	}

	@RequestMapping(value = "/main", method = {RequestMethod.GET, RequestMethod.POST})
	public String main(HttpServletRequest req,MainDTO dto) {	

		dto.setUser_id("user");
		dto.setUser_style("CAS");

		/*HttpSession session = req.getSession();
		CustomDTO dto = (CustomDTO) session.getAttribute("customInfo");*/

		
		// 맵 객체 추가
		Map<String, Object> hMap = new HashMap<String, Object>();
		
		hMap.put("category1", "");
		hMap.put("category2", "");
		
		hMap.put("start", 1);
		hMap.put("end", 3);
		
		hMap.put("sort", "desc");
		
		hMap.put("user_id", dto.getUser_id());
		
		if(dto.getUser_id()==null || dto.getUser_id().equals("")) {
			
			List<CategoryDTO> lists = categorydao.getOrderCount(hMap);
			req.setAttribute("lists", lists);
			
		}else if(dto.getUser_id()!=null || !dto.getUser_id().equals("")) {
			
			//취향추천
			hMap.put("user_id", dto.getUser_id());
			hMap.put("user_Style", dto.getUser_style());
			
			List<MainDTO> lists = maindao.selectUserStyle(hMap);	
			req.setAttribute("lists", lists);
			
		}
		
		//조회순,리뷰순,별점순		
		List<CategoryDTO> hot_lists = categorydao.getViewOrderProductList(hMap);
		List<CategoryDTO> reCount_lists = categorydao.getReviewCountProductList(hMap);
		List<CategoryDTO> reScore_lists = categorydao.getStarRatingProductList(hMap);
		
		
		req.setAttribute("hot_lists", hot_lists);
		req.setAttribute("reCount_lists", reCount_lists);
		req.setAttribute("reScore_lists", reScore_lists);
		//req.setAttribute("getCountHeartCart", maindao.selectUserHeartCart());

		return ".tiles/main/index";


	}

}
