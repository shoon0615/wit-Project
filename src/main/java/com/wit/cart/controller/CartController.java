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

	@RequestMapping(value = "/shopcart_ok", method = {RequestMethod.POST})
	public String shopcart_ok(HttpServletRequest req) {

		String user_id = "users";
		List<CartDTO> lists = dao.selectCart(user_id);
		int total_amount = dao.selectTotalAmount(user_id);
		req.setAttribute("lists", lists);
		req.setAttribute("total_amount", total_amount);

		return "/cart/cartDetail";
	}

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

	@RequestMapping(value = "/updateCartOption", method = RequestMethod.POST)
	public  String updateCartOption(HttpServletRequest req,String prod_code,String prod_subcode,String prod_color,String prod_size) {

		String user_id = "users";
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("user_id", user_id);
		hMap.put("prod_code", prod_code);
		hMap.put("prod_subcode", prod_subcode);
		hMap.put("prod_color", prod_color);
		hMap.put("prod_size", prod_size);

		dao.updateCartOption(hMap);

		List<CartDTO> lists = dao.selectCart(user_id);	
		req.setAttribute("lists", lists);

		return"cart/cartOptionModal";	

	}

	@RequestMapping(value = "/insertCartOption", method = RequestMethod.POST)
	public  String insertCartOption(HttpServletRequest req,String prod_code,String prod_subcode,String prod_color,String prod_size) {

		//cart select해서 prod_code가 존재하면 업데이트 

		String user_id = "users";
		Map<String, Object> hMap = new HashMap<String, Object>();
		hMap.put("user_id", user_id);
		hMap.put("prod_code", prod_code);
		hMap.put("prod_subcode", prod_subcode);
		hMap.put("prod_color", prod_color);
		hMap.put("prod_size", prod_size);

		dao.insertCartOption(hMap);

		List<CartDTO> lists = dao.selectCart(user_id);	
		req.setAttribute("lists", lists);

		return"cart/cartOptionModal";

	}


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

		List<CartDTO> color_lists = dao.selectColor(prod_subcode);
		List<CartDTO> size_lists = dao.selectSize(prod_subcode);

		req.setAttribute("color_lists", color_lists);
		req.setAttribute("size_lists", size_lists);
		req.setAttribute("prod_code", prod_code);
		req.setAttribute("prod_subcode", prod_subcode);
		return "cart/cartOptionModal";
	}

}
