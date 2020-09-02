package com.wit.main.controller;

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
	 * //Ÿ����/���� �����ϴ� jsp��� return ".tiles/views/index"; }
	 */

	@RequestMapping(value = "/main", method = {RequestMethod.GET, RequestMethod.POST})
	public String main(HttpServletRequest req,MainDTO dto) {	

		dto.setUser_Id("user");
		dto.setUser_Style("CAS");

		/*HttpSession session = req.getSession();
		CustomDTO dto = (CustomDTO) session.getAttribute("customInfo");*/

		// ����Ʈ ��ü �߰�
		List<MainDTO> lists = new ArrayList<MainDTO>();
		
		// �� ��ü �߰�
		Map<String, Object> hMap = new HashMap<String, Object>();
		
		hMap.put("category1", "");
		hMap.put("category2", "");
		
		hMap.put("start", 1);
		hMap.put("end", 3);
		
		hMap.put("sort", "desc");
		
		if(dto.getUser_Id()!=null || !dto.getUser_Id().equals("")) {
			
			//������õ
			hMap.put("user_Id", dto.getUser_Id());
			hMap.put("user_Style", dto.getUser_Style());
			
			lists = maindao.selectUserStyle(hMap);	
			
		} else {
			
			//��ȸ��
			//�ֹ�������
		}
			
		req.setAttribute("lists", lists);
		
		//��ȸ��,�����,������		
		List<CategoryDTO> hot_lists = categorydao.getViewOrderProductList(hMap);
		List<CategoryDTO> reCount_lists = categorydao.getReviewCountProductList(hMap);
		List<CategoryDTO> reScore_lists = categorydao.getStarRatingProductList(hMap);

		req.setAttribute("hot_lists", hot_lists);
		req.setAttribute("reCount_lists", reCount_lists);
		req.setAttribute("reScore_lists", reScore_lists);

		return ".tiles/main/index";



	}

}
