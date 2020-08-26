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

	// �긽�뭹 �젙蹂�
	@Override
	public ProductDTO selectProd(String PROD_SUBCODE) {
		
		ProductDTO dto = sqlSession.selectOne("productMapper.selectProd", PROD_SUBCODE);
		
		return dto;
	}
	
	// �긽�뭹 �씠誘몄� �젙蹂�
	@Override
	public List<String> selectProdImg() {
		
		List<String> lists = sqlSession.selectList("productMapper.selectProdImg");
		
		return lists;
	}
	
	// �긽�뭹 蹂꾩젏/由щ럭�닔
	@Override
	public HashMap<String, Object> selectProdScore() {
		
		HashMap<String, Object> map = sqlSession.selectOne("productMapper.selectProdScore");
		
		return map;
	}
	
	// �긽�뭹 李� �뿬遺�
	@Override
	public boolean selectProdHeart() {
		
		if(sqlSession.selectOne("productMapper.selectProdHeart") == null) {
			return false;
		}
		
		return true;
	}
	
	// �긽�뭹 �옣諛붽뎄�땲 �뿬遺�
	@Override
	public boolean selectProdCart() {
		
		if(sqlSession.selectOne("productMapper.selectProdCart") == null) {
			return false;
		}
		
		return true;
	}
	
	// �긽�뭹 �궗�씠利�/而щ윭 �뜲�씠�꽣
	@Override
	public List<String> selectProdChoice(String PROD_INFO, String PROD_SUBCODE) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();

		params.put("PROD_INFO", PROD_INFO);
		params.put("PROD_SUBCODE", PROD_SUBCODE);

		List<String> lists = sqlSession.selectList("productMapper.selectProdChoice", params);
		
		return lists;
	}

	@Override
	public ProductDTO choiceProd(ProductDTO dto) {
		
		ProductDTO dto_ch = sqlSession.selectOne("productMapper.choiceProd", dto);
		
		return dto_ch;
	}
}
