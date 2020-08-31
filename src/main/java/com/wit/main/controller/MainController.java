package com.wit.main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wit.custom.controller.CustomController;
import com.wit.main.dao.MainDAO;
import com.wit.main.dto.MainDTO;

@Controller
@RequestMapping(value = "/main")
public class MainController {
	
	@Autowired
	// @Qualifier("mainDAO")
	MainDAO dao;
	
	private Logger log = LoggerFactory.getLogger(CustomController.class);
	
	/*
	 * @RequestMapping(value = "/main", method = {RequestMethod.GET,
	 * RequestMethod.POST}) public String main(HttpServletRequest req) {
	 * 
	 * //타일즈/내가 설정하는 jsp경로 return ".tiles/views/index"; }
	 */
	
	@RequestMapping(value = "/main", method = {RequestMethod.GET, RequestMethod.POST})
	public String main(HttpServletRequest req,MainDTO dto) {	
		
		dto.setUser_Id("user");
		dto.setUser_Style("CAS");
		
		if(dto.getUser_Id()!=null || !dto.getUser_Id().equals("")) {
			
			List<MainDTO> lists = dao.selectUserStyle(dto.getUser_Id(), dto.getUser_Style());
			req.setAttribute("lists", lists);
			return ".tiles/views/index";
		}else {
			
		//로그인 안됐을시 별점순 정렬
		
		return ".tiles/views/index";
		
		
	}

}
	
}
