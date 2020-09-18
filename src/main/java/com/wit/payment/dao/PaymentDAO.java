package com.wit.payment.dao;

import java.util.List;
import java.util.Map;

import com.wit.payment.dto.PaymentDTO;

public interface PaymentDAO {
	public List<Map<String, Object>> getProdCode(String prodStr); 						// 바로 구매 리스트
	public String getPaymentBank(String paymentBank); 									// 은행사 code 출력
	public void insertPayment(PaymentDTO dto);											// Payment 테이블 삽입
	public void insertOrderMain(PaymentDTO dto);										// Order_Main 테이블 삽입
	public void insertOrderDetail(List<Map<String, Object>> list, String order_code);	// Order_Detail 테이블 삽입
}
