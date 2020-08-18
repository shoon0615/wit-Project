package com.wit.product.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.product.dto.ProductDTO;

@Repository("productDAO")
public class ProductDAOImpl implements ProductDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 상품 정보
	public ProductDTO selectProd() {
		
		ProductDTO dto = sqlSession.selectOne("productMapper.selectProd");
		
		return dto;
	}
	
	// 상품 이미지 정보
	public List<String> selectProdImg() {
		
		List<String> lists = sqlSession.selectList("productMapper.selectProdImg");
		
		return lists;
	}
	
	// 상품 별점/리뷰수
	public HashMap<String, Object> selectProdScore() {
		
		HashMap<String, Object> map = sqlSession.selectOne("productMapper.selectProdScore");
		
		return map;
	}
	
	// 상품 찜 여부
	public boolean selectProdHeart() {
		
		if(sqlSession.selectOne("productMapper.selectProdHeart") == null) {
			return false;
		}
		
		return true;
	}
	
	// 상품 장바구니 여부
	public boolean selectProdCart() {
		
		if(sqlSession.selectOne("productMapper.selectProdCart") == null) {
			return false;
		}
		
		return true;
	}
	
	// 상품 사이즈/컬러 데이터
	public List<String> selectProdChoice() {
		
		List<String> lists = sqlSession.selectList("productMapper.selectProdChoice");
		
		return lists;
	}
}
