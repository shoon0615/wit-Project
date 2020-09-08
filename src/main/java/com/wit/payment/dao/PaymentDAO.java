package com.wit.payment.dao;

import java.util.List;
import java.util.Map;

import com.wit.payment.dto.PaymentDTO;

public interface PaymentDAO {
	public List<Map<String, Object>> getProdCode(String prodStr); 	// 바로 구매 리스트
	public void insertOrderMain(PaymentDTO dto);					// Order_Main 테이블 삽입
}
