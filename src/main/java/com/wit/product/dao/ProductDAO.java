package com.wit.product.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wit.product.dto.ProductDTO;
import com.wit.product.dto.reviewDTO;

public interface ProductDAO {

	public ProductDTO selectProd(String PROD_SUBCODE);
	public List<String> selectProdImg(String PROD_SUBCODE);
	public HashMap<String, Object> selectProdScore();
	public boolean selectProdHeart();
	public boolean selectProdCart();
	public List<String> selectProdChoice(String PROD_INFO, String PROD_SUBCODE);
	public ProductDTO choiceProd(ProductDTO dto);
	public List<String> selectBag(String USER_ID, String PROD_SUBCODE, List<String> PROD_INFO);
	public void insertBag(String USER_ID, String PROD_SUBCODE, List<String> PROD_INFO);
	public List<reviewDTO> selectProductReview(Map<String,Object> hmap); //상품코드에대한 전체리뷰출력
	public List<String> selectReviewImg(String review_num); //상품코드에대한 전체리뷰출력
	public List<reviewDTO> selectPhotoReview(Map<String,Object> hmap); //포토리뷰 출력
	public List<reviewDTO> selectUserFormReview(Map<String,Object> hmap); //내 체형별 리뷰 출력
	public List<reviewDTO> selectAllChkReview(Map<String,Object> hmap); //내 체형별+포토별 리뷰 출력
	public int selectCountReview(String PROD_SUBCODE);
	public int selectCountPhotoReview(String PROD_SUBCODE);
	public int selectCountFormReview(Map<String,Object> hmap);
	public int selectCountAllChkReview(Map<String,Object> hmap);
	
}
