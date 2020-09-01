package com.wit.category.dao;

import java.util.List;
import java.util.Map;

import com.wit.category.dto.CategoryDTO;

public interface CategoryDAO {
	
	public int getProductCount(Map<String,Object> hmap);
	public List<CategoryDTO> getAllProductList(Map<String,Object> hmap); //전체
	public List<CategoryDTO> getPriceProductList(Map<String,Object> hmap); //가격순
	public List<CategoryDTO> getViewOrderProductList(Map<String,Object> hmap); //조회순
	public List<CategoryDTO> getStarRatingProductList(Map<String,Object> hmap); //별점순 
	public List<CategoryDTO> getReviewCountProductList(Map<String,Object> hmap); //리뷰순
	public List<CategoryDTO> getNewProductList(Map<String,Object> hmap); //신상품순
	public List<Map<String, Object>> getCategory(String code_form); // 카테고리 리스트
	public List<String> getCategorySize(String code_form); // 카테고리 사이즈 리스트
	
}
