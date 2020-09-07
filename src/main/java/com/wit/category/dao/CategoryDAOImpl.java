package com.wit.category.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.category.dto.CategoryDTO;
import com.wit.product.dto.ProductDTO;

@Repository("categoryDAO")
public class CategoryDAOImpl implements CategoryDAO {
	//DB객체
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//ProductInfo에 상품개수 가져오기
	@Override
	public int getProductCount(Map<String,Object> hmap) {
		int productCount = sqlSession.selectOne("categoryMapper.getProductCount",hmap);
		return productCount;
	}
	
	//전체 상품
	@Override
	public List<CategoryDTO> getAllProductList(Map<String,Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getAllProductList",hmap);
		return list;
	}
	
	//가격순
	@Override
	public List<CategoryDTO> getPriceProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getPriceProductList",hmap);
		return list;
	}
	
	//조회순
	@Override
	public List<CategoryDTO> getViewOrderProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getViewOrderProductList",hmap);
		return list;
	}
	
	//별점순
	@Override
	public List<CategoryDTO> getStarRatingProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getStarRatingProductList",hmap);
		return list;
	}

	//리뷰순
	@Override
	public List<CategoryDTO> getReviewCountProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getReviewCountProductList",hmap);
		return list;
	}
	
	//신상품순
	@Override
	public List<CategoryDTO> getNewProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getNewProductList",hmap);
		return list;
	}
	
	//판매순
		@Override
		public List<CategoryDTO> getOrderCount(Map<String, Object> hmap) {
			List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getOrderCount",hmap);
			return list;
		}

	//카테고리 리스트 출력
	@Override
	public List<Map<String, Object>> getCategory(String code_form) {
		List<Map<String, Object>> list = sqlSession.selectList("categoryMapper.getCategory",code_form);
		return list;
	}
	
	//카테고리 사이즈 리스트 출력
	@Override
	public List<String> getCategorySize(String code_form) {
		
		if(code_form.equals("1")) {			// TOP
			code_form = "TOP";
		} else if(code_form.equals("2")) {	// BOTTOM
			code_form = "TOP_BOTTOM";
		} else if(code_form.equals("3")) {	// SHOES
			code_form = "SHOES";
		} else {							// OPS, ACC
			code_form = "SIZE";
		} 		
		
		List<String> list = sqlSession.selectList("categoryMapper.getCategorySize",code_form);
		return list;
	}

	// 상품 리스트 금액범위 출력
	@Override
	public Map<String, Integer> getProductPrice(CategoryDTO dto) {
		Map<String, Integer> map = sqlSession.selectOne("categoryMapper.getProductPrice",dto);
		
		if(map == null) {
			map = new HashMap<String, Integer>();
			map.put("MIN", 0);
			map.put("MAX", 0);
		}
		
		return map;
	}
	
}
