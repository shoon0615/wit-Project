package com.wit.myPage.dao;

import java.util.List;

import com.wit.myPage.dto.MyPageDTO;

public interface MyPageDAO {
	public List<MyPageDTO> getOrder(String user_id);		// 내가 주문한 내역
	public List<MyPageDTO> getReview(String user_id);		// 내가 리뷰 작성한 내역
	public List<MyPageDTO> getHeart(String user_id);		// 내가 찜한 상품 목록
}
