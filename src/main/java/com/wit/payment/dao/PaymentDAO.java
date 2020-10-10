package com.wit.payment.dao;

import java.util.List;
import java.util.Map;

import com.wit.cart.dto.CartDTO;
import com.wit.payment.dto.PaymentDTO;

public interface PaymentDAO {
	public List<Map<String, Object>> getProdCode(String user_id, List<CartDTO> cart_lists); // 바로 구매 리스트(카트 -> 결제)
	public List<Map<String, Object>> getProdCode(String prodStr);							// 바로 구매 리스트(바로 결제)
	public void insertOrderMain(PaymentDTO dto);											// Order_Main 테이블 삽입
	public void insertOrderDetail(String prod_list, String order_code);						// Order_Detail 테이블 삽입
	public void insertPayment(PaymentDTO dto);												// Payment 테이블 삽입
}
