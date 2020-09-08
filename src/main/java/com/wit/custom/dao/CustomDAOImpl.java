package com.wit.custom.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.custom.dto.CustomDTO;

@Repository("customDAO")
public class CustomDAOImpl implements CustomDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public String idCheck(String id) throws Exception {
		return sqlSession.selectOne("customMapper.idCheck", id);
	}

	@Override
	public void addCustom(CustomDTO dto) throws Exception {
		sqlSession.insert("customMapper.addCustom", dto);
	}

	@Override
	public CustomDTO loginCheck(CustomDTO dto) throws Exception {
		return sqlSession.selectOne("customMapper.loginCheck", dto);
	}

	@Override
	public String findID(Map<String, String> hMap) throws Exception {
		return sqlSession.selectOne("customMapper.findID", hMap);
	}

	@Override
	public String findPWD(Map<String, String> hMap) throws Exception {
		return sqlSession.selectOne("customMapper.findPWD", hMap);
	}

	@Override
	public void newPWD(Map<String, String> hMap) throws Exception {
		sqlSession.update("customMapper.newPWD", hMap);
	}

	@Override
	public void modifyCustom(CustomDTO dto) throws Exception {
		sqlSession.update("customMapper.modifyCustom", dto);
	}


}
