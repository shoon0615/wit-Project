package com.wit.product.dao;

import java.util.HashMap;
import java.util.List;

import com.wit.product.dto.ProductDTO;

public interface ProductDAO {
	
	public ProductDTO selectProd(String PROD_SUBCODE);
	public List<String> selectProdImg(String PROD_SUBCODE);
	public HashMap<String, Object> selectProdScore();
	public boolean selectProdHeart();
	public boolean selectProdCart();
	public List<String> selectProdChoice(String PROD_INFO, String PROD_SUBCODE);
	public ProductDTO choiceProd(ProductDTO dto);
}
