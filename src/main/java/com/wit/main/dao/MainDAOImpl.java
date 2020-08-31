package com.wit.main.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.wit.main.dto.MainDTO;

@Repository("mainDAO")
public class MainDAOImpl implements MainDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<MainDTO> selectUserStyle(String user_Id, String user_Style) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("user_Id", user_Id);
		map.put("user_Style", user_Style);
		
		List<MainDTO> lists = sqlSession.selectList("mainMapper.selectUserStyle",map);
		return lists;
	}

	
	
}
