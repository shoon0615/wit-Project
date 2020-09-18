package com.wit.product.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.product.dto.ProductDTO;
import com.wit.product.dto.reviewDTO;

@Repository("productDAO")
public class ProductDAOImpl implements ProductDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 상품 정보
	@Override
	public ProductDTO selectProd(String PROD_SUBCODE) {
		
		ProductDTO dto = sqlSession.selectOne("productMapper.selectProd", PROD_SUBCODE);
		
		return dto;
	}
	
	// 상품 이미지 정보
	@Override
	public List<String> selectProdImg(String PROD_SUBCODE) {
		
		List<String> lists = sqlSession.selectList("productMapper.selectProdImg", PROD_SUBCODE);
		
		return lists;
	}
	
	// 상품 별점/리뷰수
	@Override
	public HashMap<String, Object> selectProdScore() {
		
		HashMap<String, Object> map = sqlSession.selectOne("productMapper.selectProdScore");
		
		return map;
	}
	
	// 상품 찜 여부
	@Override
	public boolean selectProdHeart() {
		
		if(sqlSession.selectOne("productMapper.selectProdHeart") == null) {
			return false;
		}
		
		return true;
	}
	
	// 상품 장바구니 여부
	@Override
	public boolean selectProdCart() {
		
		if(sqlSession.selectOne("productMapper.selectProdCart") == null) {
			return false;
		}
		
		return true;
	}
	
	// 상품 사이즈/컬러 데이터
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
	
	// 상품 리스트가 cart에 존재하는지 비교
	@Override
	public List<String> selectBag(String USER_ID, String PROD_SUBCODE, List<String> PROD_INFO) {
		
		ProductDTO dto = new ProductDTO();
		dto.setPROD_SUBCODE(PROD_SUBCODE);			// SUBCODE는 고정으로 받아둠

		List<String> lists = new ArrayList<String>();	
		Iterator<String> it = PROD_INFO.iterator();
		
		while(it.hasNext()) {
			String[] info = it.next().split("-");	// [색상-사이즈] 배열로 들어옴 (예시: {RED,250}, {RED,260})
				
			dto.setPROD_COLOR(info[0]);				// info[0] : 색상
			dto.setPROD_SIZE(info[1]);				// info[1] : 사이즈
			
			String PROD_CODE = sqlSession.selectOne("productMapper.choiceProdCode", dto);	// 매번 DTO의 값을 덮어써서 보냄
			
			HashMap<String, Object> params = new HashMap<String, Object>();

			params.put("USER_ID", USER_ID);
			params.put("PROD_CODE", PROD_CODE);		// 조회한 상품코드를 map에 넣고 보냄
			
			if(sqlSession.selectOne("productMapper.selectBag", params) != null) {
				lists.add(PROD_SUBCODE + ", " + info[0] + ", " + info[1]);
			} 
		}
		
		return lists;
	}

	@Override
	public void insertBag(String USER_ID, String PROD_SUBCODE, List<String> PROD_INFO) {
		
		ProductDTO dto = new ProductDTO();
		dto.setPROD_SUBCODE(PROD_SUBCODE);			// SUBCODE는 고정으로 받아둠
		
		Iterator<String> it = PROD_INFO.iterator();
		
		while(it.hasNext()) {
			String[] info = it.next().split("-");	// [색상-사이즈-수량] 배열로 들어옴 (예시: {RED,250,1}, {RED,260,1})
			
			dto.setPROD_COLOR(info[0]);				// info[0] : 색상
			dto.setPROD_SIZE(info[1]);				// info[1] : 사이즈
			
			String PROD_CODE = sqlSession.selectOne("productMapper.choiceProdCode", dto);	// 매번 DTO의 값을 덮어써서 보냄
			
			HashMap<String, Object> params = new HashMap<String, Object>();
			
			params.put("USER_ID", USER_ID);
			params.put("PROD_CODE", PROD_CODE);		// 조회한 상품코드를 map에 넣고 보냄
			params.put("CART_QTY", info[2]);		// info[2] : 수량
			
			if(sqlSession.selectOne("productMapper.selectBag", params) == null) {
				sqlSession.insert("productMapper.insertBag", params);
			} else {
				sqlSession.update("productMapper.updateBag", params);
			}
		}
	}

	@Override
	public List<reviewDTO> selectProductReview(Map<String, Object> hmap) {
		List<reviewDTO> list = sqlSession.selectList("productMapper.selectProductReview",hmap);
		return list;
	}

	@Override
	public List<String> selectReviewImg(String review_num) {
		List<String> list = sqlSession.selectList("productMapper.selectReviewImg",review_num);
		return list;
	}

	@Override
	public List<reviewDTO> selectPhotoReview(Map<String, Object> hmap) {
		List<reviewDTO> list = sqlSession.selectList("productMapper.selectPhotoReview",hmap);
		return list;
	}

	@Override
	public List<reviewDTO> selectUserFormReview(Map<String, Object> hmap) {
		List<reviewDTO> list = sqlSession.selectList("productMapper.selectUserFormReview",hmap);
		return list;
	}

	@Override
	public List<reviewDTO> selectAllChkReview(Map<String, Object> hmap) {
		List<reviewDTO> list = sqlSession.selectList("productMapper.selectAllChkReview",hmap);
		return list;
	}

	@Override
	public int selectCountReview(String PROD_SUBCODE) {
		int reviewCnt =  sqlSession.selectOne("productMapper.selectCountReview",PROD_SUBCODE);
		return reviewCnt;
	}

	@Override
	public int selectCountPhotoReview(String PROD_SUBCODE) {
		int photoCnt =  sqlSession.selectOne("productMapper.selectCountPhotoReview",PROD_SUBCODE);
		return photoCnt;
	}

	@Override
	public int selectCountFormReview(Map<String,Object> hmap) {
		int formCnt =  sqlSession.selectOne("productMapper.selectCountFormReview", hmap);
		return formCnt;
	}

	@Override
	public int selectCountAllChkReview(Map<String,Object> hmap) {
		int allChkCnt =  sqlSession.selectOne("productMapper.selectCountAllChkReview",hmap);
		return allChkCnt;
	}

	@Override
	public void insertReport(Map<String, Object> hmap) {	
		sqlSession.insert("productMapper.insertReport",hmap);
	}

	@Override
	public void deleteReview() {	
		sqlSession.delete("productMapper.deleteReview");
	}

	@Override
	public void deleteReport() {
		sqlSession.delete("productMapper.deleteReport");
		
	}


}
