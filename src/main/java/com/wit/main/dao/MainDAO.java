package com.wit.main.dao;

import java.util.List;
import java.util.Map;

import com.wit.main.dto.MainDTO;

public interface MainDAO {
	
	//������õ����Ʈ
	public List<MainDTO> selectUserStyle(Map<String,Object> hmap);

}
