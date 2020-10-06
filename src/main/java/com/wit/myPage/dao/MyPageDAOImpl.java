package com.wit.myPage.dao;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.myPage.dto.MyPageDTO;

@Repository("myPageDAO")
public class MyPageDAOImpl implements MyPageDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 내가 주문한 내역
	@Override
	public List<MyPageDTO> getOrder(String user_id) {
		List<MyPageDTO> lists = sqlSession.selectList("myPageMapper.getOrder", user_id);
		return lists;
	}
	
	// 다음 자리의 리뷰번호 호출
	@Override
	public int getMaxReview_Num() {
		int Review_Num = sqlSession.selectOne("myPageMapper.getMaxReview_Num");
		return Review_Num;
	}
	
	// 리뷰 작성
	@Override
	public void insertReview(MyPageDTO dto) {
		sqlSession.insert("myPageMapper.insertReview", dto);
	}
	
	// 리뷰 이미지 저장
	@Override
	public void insertReview_Img(MyPageDTO dto) {
		// 파일이 하나 이상 있을 경우에만 실행
		if(dto.getUpload_img().size() > 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			// 현재 날짜를 to_char형식으로 동일하게 받아옴
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			Date sysdate = new Date();		
			String toDate = dateFormat.format(sysdate);
			map.put("review_num", dto.getReview_num());
			
			// 마지막에 빈값으로 하나 들어가는 부분이 있어 -1 처리
			for(int i=0;i<dto.getUpload_img().size()-1;i++) {
				String fileName = toDate + "_" + dto.getUpload_img().get(i).getOriginalFilename();

				try {
					File file = new File("C:/work/img/" + fileName);
					dto.getUpload_img().get(i).transferTo(file);
				} catch (Exception e) {
					System.out.println(e.toString());
				} 

				map.put("review_img", fileName);
				sqlSession.insert("myPageMapper.insertReview_Img", map);
			}	
		}
	}
	
	// 내가 리뷰 작성한 내역
	@Override
	public List<MyPageDTO> getReview(String user_id) {
		List<MyPageDTO> lists = sqlSession.selectList("myPageMapper.getReview", user_id);
		return lists;
	}
	
	// 선택한 리뷰 삭제
	@Override
	public void deleteReview(String review_num) {
		sqlSession.delete("myPageMapper.deleteReview", review_num);
	}
	
	// 선택한 찜한 상품 등록
	@Override
	public void insertHeart(MyPageDTO dto) {
		sqlSession.insert("myPageMapper.insertHeart", dto);
	}
	
	// 내가 찜한 상품 목록
	@Override
	public List<MyPageDTO> getHeart(String user_id) {
		List<MyPageDTO> lists = sqlSession.selectList("myPageMapper.getHeart", user_id);
		return lists;
	}
	
	// 선택한 찜한 상품 삭제
	@Override
	public void deleteHeart(MyPageDTO dto) {
		sqlSession.delete("myPageMapper.deleteHeart", dto);
	}

}
