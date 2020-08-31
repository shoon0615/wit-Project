package com.wit.category.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.category.dto.CategoryDTO;

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
	
	//높은 가격
	@Override
	public List<CategoryDTO> getExpensiveProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getExpensiveProductList",hmap);
		return list;
	}
	
	//낮은 가격
	@Override
	public List<CategoryDTO> getCheapProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getCheapProductList",hmap);
		return list;
	}

	//새로운 상품
	@Override
	public List<CategoryDTO> getNewProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getNewProductList",hmap);
		return list;
	}
	
	//오래된 상품
	@Override
	public List<CategoryDTO> getOldProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getOldProductList",hmap);
		return list;
	}
	
	//별점 높은
	@Override
	public List<CategoryDTO> getHighStarRatingProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getHighStarRatingProductList",hmap);
		return list;
	}
	
	//별점 낮은
	@Override
	public List<CategoryDTO> getLowStarRatingProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getLowStarRatingProductList",hmap);
		return list;
	}
	
	//리뷰 적은
	@Override
	public List<CategoryDTO> getLittleReviewCountProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getLittleReviewCountProductList",hmap);
		return list;
	}

	//리뷰 많은
	@Override
	public List<CategoryDTO> getManyReviewCountProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getManyReviewCountProductList",hmap);
		return list;
	}
	
	//조회수 낮은
	@Override
	public List<CategoryDTO> getLowViewOrderProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getLowViewOrderProductList",hmap);
		return list;
	}

	//조회수 높은
	@Override
	public List<CategoryDTO> getHighViewOrderProductList(Map<String, Object> hmap) {
		List<CategoryDTO> list = sqlSession.selectList("categoryMapper.getHighViewOrderProductList",hmap);
		return list;
	}

	@Override
	public List<String> getCategory(String code_form) {
		List<String> list = sqlSession.selectList("categoryMapper.getCategory",code_form);
		return list;
	}
	
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
	
}
