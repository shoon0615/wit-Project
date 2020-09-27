package com.wit.myPage.dao;

import java.util.List;

import com.wit.myPage.dto.MyPageDTO;

public interface MyPageDAO {
	public List<MyPageDTO> getOrder(String user_id);		// 1: 내가 주문한 내역
	public int getMaxReview_Num();							// 1: 다음 자리의 리뷰번호 호출
	public void insertReview(MyPageDTO dto);				// 1: 리뷰 작성
	public void insertReview_Img(MyPageDTO dto);			// 1: 리뷰 이미지 저장
	public List<MyPageDTO> getReview(String user_id);		// 2: 내가 리뷰 작성한 내역
	public void deleteReview(String review_num);			// 2: 선택한 리뷰 삭제
	public List<MyPageDTO> getHeart(String user_id);		// 3: 내가 찜한 상품 목록
	public void deleteHeart(MyPageDTO dto);					// 3: 선택한 찜한 상품 삭제
}
