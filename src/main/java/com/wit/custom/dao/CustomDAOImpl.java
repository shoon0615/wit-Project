package com.wit.custom.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("customDAO")
public class CustomDAOImpl implements CustomDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;


}
