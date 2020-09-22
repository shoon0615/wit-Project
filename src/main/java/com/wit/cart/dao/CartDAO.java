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
	public void updateCartOption(Map<String,Object> hmap); //īƮ������Ʈ(�ɼǺ���)
	public void addUpdateCartOption(Map<String,Object> hmap); //add click īƮ������Ʈ(�ɼǺ���)
	public void insertCartOption(Map<String,Object> hmap); //īƮinsert(�ɼǺ���)
	public int selectChk(Map<String,Object> hmap);
	public void deleteCartOption(Map<String,Object> hmap); //īƮ delete (�ɼǺ���)
	
}
