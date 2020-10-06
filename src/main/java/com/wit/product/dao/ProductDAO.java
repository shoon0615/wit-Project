package com.wit.product.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wit.cart.dto.CartDTO;
import com.wit.product.dto.ProductDTO;
import com.wit.product.dto.reviewDTO;

public interface ProductDAO {

	public ProductDTO selectProd(String PROD_SUBCODE);
	public ProductDTO selectProd_test(String PROD_SUBCODE);
	public List<String> selectProdImg(String PROD_SUBCODE);
	public HashMap<String, Object> selectProdScore(String PROD_SUBCODE);
	public boolean selectProdHeart();
	public boolean selectProdCart();
	public List<String> selectProdChoice(String PROD_INFO, String PROD_SUBCODE);
	public ProductDTO choiceProd(ProductDTO dto);
	public List<String> selectBag(String USER_ID, String PROD_SUBCODE, List<String> PROD_INFO);
	public List<String> selectBag(String PROD_SUBCODE, List<String> PROD_INFO, List<CartDTO> lcdto);
	public void insertBag(String USER_ID, String PROD_SUBCODE, List<String> PROD_INFO);
	public List<CartDTO> insertBag(String PROD_SUBCODE, List<String> PROD_INFO, List<CartDTO> lcdto);
	public List<reviewDTO> selectProductReview(Map<String,Object> hmap); //��ǰ�ڵ忡���� ��ü�������
	public List<String> selectReviewImg(String review_num); //��ǰ�ڵ忡���� ��ü�������
	public List<reviewDTO> selectPhotoReview(Map<String,Object> hmap); //���丮�� ���
	public List<reviewDTO> selectUserFormReview(Map<String,Object> hmap); //�� ü���� ���� ���
	public List<reviewDTO> selectAllChkReview(Map<String,Object> hmap); //�� ü����+���亰 ���� ���
	public int selectCountReview(String PROD_SUBCODE); //��ü ���� ī��Ʈ
	public int selectCountPhotoReview(String PROD_SUBCODE); //���丮�� ī��Ʈ
	public int selectCountFormReview(Map<String,Object> hmap); //ü���� ���� ī��Ʈ
	public int selectCountAllChkReview(Map<String,Object> hmap); //���� + ü���� ���� ī��Ʈ
	public void insertReport(Map<String,Object> hmap); //�Ű����̺� �μ�Ʈ
	public void deleteReview(); //�Ű� 3�������� �������̺��� ���� ����
	public void deleteReport(); //�Ű� 3�������� �Ű����̺��� �Ű��� ����

	
}
