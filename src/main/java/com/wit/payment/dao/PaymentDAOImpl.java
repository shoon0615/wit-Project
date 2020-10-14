package com.wit.payment.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wit.cart.dto.CartDTO;
import com.wit.payment.dto.PaymentDTO;
import com.wit.product.dto.ProductDTO;

@Repository("paymentDAO")
public class PaymentDAOImpl implements PaymentDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 결제 페이지에 띄울 바로 결제 리스트 내역(카트 -> 결제)
	@Override
	public List<Map<String, Object>> getProdCode(String user_id, List<CartDTO> cart_lists) {

		List<Map<String, Object>> lists = new ArrayList<Map<String, Object>>();		// return용 저장 변수 선언(PROD_CODE, PROD_PRICE, PROD_QTY)
		
		// 로그인 정보가 있을 경우
		if(user_id != null) {
			lists = sqlSession.selectList("paymentMapper.getCartProdInfo", user_id); // 카트의 상품정보 받아옴
		// 비회원 상태일 경우
		} else {
			for(int i=0;i<cart_lists.size();i++) {
				Map<String, Object> hMap = new HashMap<String, Object>();

				hMap.put("PROD_CODE", cart_lists.get(i).getProd_code());
				hMap.put("PROD_SUBCODE", cart_lists.get(i).getProd_subcode());
				hMap.put("PROD_OPTION", cart_lists.get(i).getProd_color()+"/"+cart_lists.get(i).getProd_size());
				hMap.put("PROD_PRICE", cart_lists.get(i).getProd_price());
				hMap.put("CART_QTY", cart_lists.get(i).getCart_qty());
				lists.add(hMap);
			}
		}
		
		for(int i=0;i<lists.size();i++) {
			System.out.println(lists.get(i).get("PROD_CODE"));
		}
		
		return lists;
	}
		
	// 결제 페이지에 띄울 바로 결제 리스트 내역(바로 결제)
	@Override
	public List<Map<String, Object>> getProdCode(String prodStr) {

		List<Map<String, Object>> lists = new ArrayList<Map<String, Object>>();	// return용 저장 변수 선언(PROD_CODE, PROD_PRICE, PROD_QTY)
		
		String[] prodStrArr = prodStr.split("-");								// [SUBCODE-색상-사이즈-수량]으로 들어옴 (예시: ADIDAS-RED-250-2-RED-260-1)
		ProductDTO dto = new ProductDTO();										// Mapper에서 DTO로 받게하여 빈 DTO 객체 생성
		dto.setPROD_SUBCODE(prodStrArr[0]);										// prodStrArr[0] : SUBCODE
		
		for(int i=1;i<prodStrArr.length;i+=3) {
			dto.setPROD_COLOR(prodStrArr[i]);									// prodStrArr[1] : 색상
			dto.setPROD_SIZE(prodStrArr[i+1]);									// prodStrArr[2] : 사이즈
			
			Map<String, Object> hMap = sqlSession.selectOne("paymentMapper.getProdInfo", dto);
			hMap.put("CART_QTY", prodStrArr[i+2]);								// prodStrArr[3] : 수량
			lists.add(hMap);	
		}	
		// prodStr = String.join("-", prodStrArr);								// split의 반대(배열을 String으로)
		
		return lists;
	}

	// Order_Main 테이블 삽입
	@Override
	public void insertOrderMain(PaymentDTO dto) {
		sqlSession.insert("paymentMapper.insertOrderMain", dto);
	}
	
	// Order_Detail 테이블 삽입
	@Override
	public void insertOrderDetail(String prod_list, String order_code) {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> hMap = new HashMap<String, Object>();
		
		try {
			List<Map<String, Object>> list = mapper.readValue(prod_list, new TypeReference<ArrayList<HashMap<String, Object>>>() {});	
			hMap.put("order_code", order_code);
			
			for(int i=0;i<list.size();i++) {
				hMap.put("prod_code", list.get(i).get("PROD_CODE"));
				hMap.put("prod_qty", list.get(i).get("CART_QTY"));
				sqlSession.insert("paymentMapper.insertOrderDetail", hMap);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	
	// Payment 테이블 삽입
	@Override
	public void insertPayment(PaymentDTO dto) {
		// 삼항연산자로 처리가 안되어 부득이하게 if문으로 진행(javascript에서 글자 null로 넘겨짐)
		if(dto.getPayment_bank() == null || dto.getPayment_bank().equals("null")) {
			dto.setPayment_bank("");
		} else {
			dto.setPayment_bank(dto.getPayment_bank().replace("카드", ""));
		}
		
		dto.setPayment_bank((String)sqlSession.selectOne("paymentMapper.getPaymentBank", dto.getPayment_bank()));	// 은행사 code 출력
		sqlSession.insert("paymentMapper.insertPayment", dto);
	}	
	
}
