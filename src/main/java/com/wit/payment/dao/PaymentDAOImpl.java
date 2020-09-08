package com.wit.payment.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.payment.dto.PaymentDTO;
import com.wit.product.dto.ProductDTO;

@Repository("paymentDAO")
public class PaymentDAOImpl implements PaymentDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 결제 페이지에 띄울 바로 결제 리스트 내역
	@Override
	public List<Map<String, Object>> getProdCode(String prodStr) {

		List<Map<String, Object>> map = new ArrayList<Map<String, Object>>();	// return용 저장 변수 선언(PROD_CODE, PROD_PRICE, PROD_QTY)
		
		// 카트 페이지에서 결제한 경우
		if(prodStr == null) {
			
			map = sqlSession.selectList("paymentMapper.getCartProdInfo");		// 카트의 상품정보 받아옴	
			
		// 상품 페이지에서 바로 결제한 경우
		} else {
			
			String[] prodStrArr = prodStr.split("-");							// [SUBCODE-색상-사이즈-수량]으로 들어옴 (예시: ADIDAS-RED-250-2-RED-260-1)
			ProductDTO dto = new ProductDTO();									// Mapper에서 DTO로 받게하여 빈 DTO 객체 생성
			dto.setPROD_SUBCODE(prodStrArr[0]);									// prodStrArr[0] : SUBCODE
			
			for(int i=1;i<prodStrArr.length;i+=3) {
				dto.setPROD_COLOR(prodStrArr[i]);								// prodStrArr[1] : 색상
				dto.setPROD_SIZE(prodStrArr[i+1]);								// prodStrArr[2] : 사이즈
				
				Map<String, Object> hMap = sqlSession.selectOne("paymentMapper.getProdInfo", dto);
				hMap.put("CART_QTY", prodStrArr[i+2]);							// prodStrArr[3] : 수량
				map.add(hMap);
			}	
		}
		
		return map;
	}

	@Override
	public void insertOrderMain(PaymentDTO dto) {
		sqlSession.insert("paymentMapper.insertOrderMain", dto);
	}
}
