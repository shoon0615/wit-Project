package com.wit.cart.dao;

import java.util.List;
import java.util.Map;

import com.wit.cart.dto.CartDTO;

public interface CartDAO {
	
	public List<CartDTO> selectCart(String user_id); //카트 셀렉트
	public void updateCart(Map<String,Object> hmap); //카트업데이트
	public int selectTotalAmount(String user_id); //토탈금액
	public void deleteCart(Map<String,Object> hmap); //카트삭제
	public List<CartDTO> selectColor(String prod_subcode); //카트 옵션변경 컬러 셀렉트
	public List<CartDTO> selectSize(String prod_subcode); //카트 옵션변경 size 셀렉트
	public void updateCartOption(Map<String,Object> hmap); //카트업데이트(옵션변경)
	public void addUpdateCartOption(Map<String,Object> hmap); //add click 카트업데이트(옵션변경)
	public void insertCartOption(Map<String,Object> hmap); //카트insert(옵션변경)
	public int selectChk(Map<String,Object> hmap);
	public void deleteCartOption(Map<String,Object> hmap); //카트 delete (옵션변경)
	
}
