package com.wit.cart.dao;

import java.util.List;
import java.util.Map;

import com.wit.cart.dto.CartDTO;

public interface CartDAO {
	
	public List<CartDTO> selectCart(String user_id); //īƮ ����Ʈ
	public void updateCart(Map<String,Object> hmap); //īƮ������Ʈ
	public int selectTotalAmount(String user_id); //��Ż�ݾ�
	public void deleteCart(Map<String,Object> hmap); //īƮ����
	public List<CartDTO> selectColor(String prod_subcode); //īƮ �ɼǺ��� �÷� ����Ʈ
	public List<CartDTO> selectSize(String prod_subcode); //īƮ �ɼǺ��� size ����Ʈ
	public void updateCartOption(CartDTO dto); //īƮ������Ʈ(�ɼǺ���)
	public void addUpdateCartOption(CartDTO dto); //add click īƮ������Ʈ(�ɼǺ���)
	public void insertCartOption(CartDTO dto); //īƮinsert(�ɼǺ���)
	public int selectChk(CartDTO dto);
	public String selectChkProdCode(CartDTO dto);
	public void deleteCartOption(CartDTO dto); //īƮ delete (�ɼǺ���)
	
}
