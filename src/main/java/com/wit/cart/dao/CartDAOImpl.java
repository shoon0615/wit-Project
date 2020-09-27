package com.wit.cart.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.wit.cart.dto.CartDTO;

@Repository("cartDAO")
public class CartDAOImpl implements CartDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<CartDTO> selectCart(String user_id) {
		List<CartDTO> list = sqlSession.selectList("cartMapper.selectCart",user_id);
		return list;
	}

	@Override
	public void updateCart(Map<String, Object> hmap) {
		sqlSession.update("cartMapper.updateCart",hmap);

	}

	@Override
	public int selectTotalAmount(String user_id) {
		int total_amount =  sqlSession.selectOne("cartMapper.selectTotalAmount", user_id);
		return total_amount;
	}

	@Override
	public void deleteCart(Map<String, Object> hmap) {
		sqlSession.delete("cartMapper.deleteCart",hmap);

	}

	@Override
	public List<CartDTO> selectColor(String prod_subcode) {
		List<CartDTO> list = sqlSession.selectList("cartMapper.selectColor",prod_subcode);
		return list;
	}

	@Override
	public List<CartDTO> selectSize(String prod_subcode) {
		List<CartDTO> list = sqlSession.selectList("cartMapper.selectSize",prod_subcode);
		return list;
	}

	@Override
	public void updateCartOption(CartDTO dto) {
		sqlSession.update("cartMapper.updateCartOption",dto);

	}

	@Override
	public void insertCartOption(CartDTO dto) {
		sqlSession.insert("cartMapper.insertCartOption",dto);

	}

	@Override
	public int selectChk(CartDTO dto) {

		if(sqlSession.selectOne("cartMapper.selectChk",dto) == null) {
			return -1;
		}else {
			int cart_qty = sqlSession.selectOne("cartMapper.selectChk",dto);
			return cart_qty;
		}

	}

	@Override
	public void deleteCartOption(CartDTO dto) {
		sqlSession.delete("cartMapper.deleteCartOption",dto);

		
	}

	@Override
	public void addUpdateCartOption(CartDTO dto) {
		sqlSession.update("cartMapper.addUpdateCartOption",dto);
		
	}

	@Override
	public String selectChkProdCode(CartDTO dto) {	
		String select_prod_code = sqlSession.selectOne("cartMapper.selectChkProdCode",dto);
		return select_prod_code;
	}

}
