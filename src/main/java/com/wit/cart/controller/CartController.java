package com.wit.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.wit.cart.dao.CartDAO;
import com.wit.cart.dto.CartDTO;
import com.wit.product.controller.ProductController;
import com.wit.util.MyUtil;

@Controller
@RequestMapping(value = "/cart")
public class CartController {

	@Autowired
	CartDAO dao;

	@Autowired
	MyUtil myUtil;

	private Logger log = LoggerFactory.getLogger(ProductController.class);

	@RequestMapping(value = "/shopcart", method = {RequestMethod.GET})
	public String shopcart(HttpServletRequest req) {

		return ".tiles/cart/shop-cart";
	}

	//카트 데이터 리스트 뿌림
	@RequestMapping(value = "/shopcart_ok", method = {RequestMethod.POST})
	public String shopcart_ok(HttpServletRequest req) {

		String user_id = "users";
		List<CartDTO> lists = dao.selectCart(user_id);
		int total_amount = dao.selectTotalAmount(user_id);
		req.setAttribute("lists", lists);
		req.setAttribute("total_amount", total_amount);

		return "/cart/cartDetail";
	}

	//카트에서 수량 +,-클릭시 업데이트
	@RequestMapping(value = "/updateCart", method = RequestMethod.POST)
	public @ResponseBody int updateCart(HttpServletRequest req,String prod_code) {

		String user_id = "users";
		int cart_qty = Integer.parseInt(req.getParameter("cart_qty"));
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("user_id", user_id);
		hMap.put("cart_qty", cart_qty);
		hMap.put("prod_code", prod_code);

		dao.updateCart(hMap);

		int total_amount = dao.selectTotalAmount(user_id);

		return total_amount;

	}

	//옵션변경에서 change하면 update
	@RequestMapping(value = "/updateCartOption", method = RequestMethod.POST)
	public  String updateCartOption(HttpServletRequest req,String prod_code,String prod_subcode,String prod_color,String prod_size) {

		String user_id = "users";
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("user_id", user_id);
		hMap.put("prod_code", prod_code);
		hMap.put("prod_subcode", prod_subcode);
		hMap.put("prod_color", prod_color);
		hMap.put("prod_size", prod_size);
		int cart_qty = Integer.parseInt(req.getParameter("cart_qty")); 
		int select_cart_qty = dao.selectChk(hMap);

		//내가 변경할 prod_code가 이미 장바구니에 있다면
		if(select_cart_qty != -1) {	
			hMap.put("cart_qty",  cart_qty + select_cart_qty); //옵션변경 전 prod_code의 수량 + 옵션변경할 prod_code의 수량
			dao.updateCartOption(hMap);	//업데이트		
			hMap.put("cart_qty", select_cart_qty); 
			dao.deleteCartOption(hMap); //원래 장바구니에 담겨있던 변경할 prod_code의 데이터 삭제
		}else {
			//없다면
			hMap.put("cart_qty",  cart_qty); //옵션변경 전 prod_code의 수량
			dao.updateCartOption(hMap);	//업데이트			
		}

		List<CartDTO> lists = dao.selectCart(user_id);	
		req.setAttribute("lists", lists);

		return"cart/cartOptionModal";	

	}

	//옵션변경에서 추가하면 insert
	@RequestMapping(value = "/insertCartOption", method = RequestMethod.POST)
	public String insertCartOption(HttpServletRequest req,String prod_code,String
			prod_subcode,String prod_color,String prod_size) {

		String user_id = "users";
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("user_id", user_id);
		hMap.put("prod_code", prod_code);
		hMap.put("prod_subcode", prod_subcode);
		hMap.put("prod_color", prod_color);
		hMap.put("prod_size", prod_size);

		int select_cart_qty = dao.selectChk(hMap);

		//내가 변경할 prod_code가 이미 장바구니에 있다면
		if(select_cart_qty != -1) {
			hMap.put("cart_qty",  1 + select_cart_qty); // prod_code의 수량 + 1
			dao.addUpdateCartOption(hMap);	//업데이트	
		}else {
			//없다면 insert
			dao.insertCartOption(hMap);
		}

		List<CartDTO> lists = dao.selectCart(user_id);	
		req.setAttribute("lists", lists);

		return"cart/cartOptionModal";	

	}

	//장바구니삭제
	@RequestMapping(value = "/deleteCart", method = RequestMethod.POST)
	public String deleteCart(HttpServletRequest req,String prod_code) {

		log.debug(prod_code);

		String[] prod_code_arr = null;
		String user_id = "users";
		Map<String, Object> hMap = new HashMap<String, Object>();

		prod_code = prod_code.substring(0, prod_code.length()-1);
		prod_code_arr = prod_code.split(",");

		for(int i=0; i<prod_code_arr.length; i++) {

			hMap.put("user_id", user_id);
			hMap.put("prod_code", prod_code_arr[i]);
			log.debug(prod_code_arr[i]);
			dao.deleteCart(hMap);
		}

		List<CartDTO> lists = dao.selectCart(user_id);		
		int total_amount = dao.selectTotalAmount(user_id);

		req.setAttribute("lists", lists);
		req.setAttribute("total_amount", total_amount);

		return "cart/cartDetail";
	}


	//장바구니 옵션변경
	@RequestMapping(value = "cartOptionChange", method = RequestMethod.GET)
	public String cartOptionChange(HttpServletRequest req,String prod_code,String prod_subcode) {

		int cart_qty = Integer.parseInt(req.getParameter("cart_qty"));

		List<CartDTO> color_lists = dao.selectColor(prod_subcode);
		List<CartDTO> size_lists = dao.selectSize(prod_subcode);

		req.setAttribute("color_lists", color_lists);
		req.setAttribute("size_lists", size_lists);
		req.setAttribute("prod_code", prod_code);
		req.setAttribute("prod_subcode", prod_subcode);
		req.setAttribute("cart_qty", cart_qty);

		return "cart/cartOptionModal";
	}

}
