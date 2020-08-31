package com.wit.category.dao;

import java.util.List;
import java.util.Map;

import com.wit.category.dto.CategoryDTO;

public interface CategoryDAO {
	
	public int getProductCount(Map<String,Object> hmap);
	public List<CategoryDTO> getAllProductList(Map<String,Object> hmap); //전체
	public List<CategoryDTO> getExpensiveProductList(Map<String,Object> hmap); //높은 가격순
	public List<CategoryDTO> getCheapProductList(Map<String,Object> hmap); //낮은 가격순
	public List<CategoryDTO> getNewProductList(Map<String,Object> hmap); //새로운 상품순
	public List<CategoryDTO> getOldProductList(Map<String,Object> hmap); //오래된 상품순
	public List<CategoryDTO> getLowViewOrderProductList(Map<String,Object> hmap); //조회수 낮은 순
	public List<CategoryDTO> getHighViewOrderProductList(Map<String,Object> hmap); //조회수 높은 순
	public List<CategoryDTO> getHighStarRatingProductList(Map<String,Object> hmap); //별점 높은 순
	public List<CategoryDTO> getLowStarRatingProductList(Map<String,Object> hmap); //별점 낮은 
	public List<CategoryDTO> getLittleReviewCountProductList(Map<String,Object> hmap); //리뷰 적은 순
	public List<CategoryDTO> getManyReviewCountProductList(Map<String,Object> hmap); //리뷰 많은 순
	public List<String> getCategory(String code_form); // 카테고리 리스트
	public List<String> getCategorySize(String code_form); // 카테고리 사이즈 리스트
	
}
