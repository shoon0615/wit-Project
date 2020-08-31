package com.wit.main.dao;

import java.util.List;

import com.wit.main.dto.MainDTO;

public interface MainDAO {
	
	public List<MainDTO> selectUserStyle(String user_Id,String user_Style);

}
