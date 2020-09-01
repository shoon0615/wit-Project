package com.wit.main.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.main.dto.MainDTO;

@Repository("mainDAO")
public class MainDAOImpl implements MainDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	//취향추천리스트
	public List<MainDTO> selectUserStyle(Map<String, Object> hmap) {
		
		List<MainDTO> lists = sqlSession.selectList("mainMapper.selectUserStyle",hmap);
		return lists;
	}
	
}
