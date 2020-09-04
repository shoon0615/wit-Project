package com.wit.main.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wit.main.dto.MainDTO;

public interface MainDAO {
	
	//취향추천리스트
	public List<MainDTO> selectUserStyle(Map<String,Object> hmap);
	
	//메인헤더부분 고객의 찜,카트 카운트
	public HashMap<String, Object> selectUserHeartCart(String user_id);

}
