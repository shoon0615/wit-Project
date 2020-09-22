package com.wit.myPage.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.myPage.dto.MyPageDTO;

@Repository("myPageDAO")
public class MyPageDAOImpl implements MyPageDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 내가 주문한 내역
	@Override
	public List<MyPageDTO> getOrder(String user_id) {
		List<MyPageDTO> lists = sqlSession.selectList("myPageMapper.getOrder", user_id);
		return lists;
	}
	
	// 내가 리뷰 작성한 내역
	@Override
	public List<MyPageDTO> getReview(String user_id) {
		List<MyPageDTO> lists = sqlSession.selectList("myPageMapper.getReview", user_id);
		return lists;
	}
	
	// 내가 찜한 상품 목록
	@Override
	public List<MyPageDTO> getHeart(String user_id) {
		List<MyPageDTO> lists = sqlSession.selectList("myPageMapper.getHeart", user_id);
		return lists;
	}

}
