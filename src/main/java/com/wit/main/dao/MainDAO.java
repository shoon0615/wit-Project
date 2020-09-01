package com.wit.main.dao;

import java.util.List;
import java.util.Map;

import com.wit.main.dto.MainDTO;

public interface MainDAO {
	
	//취향추천리스트
	public List<MainDTO> selectUserStyle(Map<String,Object> hmap);

}
