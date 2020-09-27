package com.wit.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.wit.cart.dao.CartDAO;
import com.wit.cart.dto.CartDTO;
import com.wit.custom.dto.CustomDTO;
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

		HttpSession session = req.getSession();
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");

		if(dtoSession == null) {
			int total_amount = 0;
			@SuppressWarnings("unchecked")
			List<CartDTO> lists = (List<CartDTO>)session.getAttribute("cart_lists");
			for(int i=0; i<lists.size(); i++) {
				total_amount += lists.get(i).getCart_qty() * lists.get(i).getProd_price();
			}
			req.setAttribute("total_amount", total_amount);
			req.setAttribute("lists", lists);
		}else {
			List<CartDTO> lists = dao.selectCart(dtoSession.getUser_id());
			int total_amount = dao.selectTotalAmount(dtoSession.getUser_id());	
			req.setAttribute("lists", lists);
			req.setAttribute("total_amount", total_amount);
		}
		return "/cart/cartDetail";
	}

	//카트에서 수량 +,-클릭시 업데이트
	@RequestMapping(value = "/updateCart", method = RequestMethod.POST)
	public @ResponseBody int updateCart(HttpServletRequest req,CartDTO dto) {

		HttpSession session = req.getSession();
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");	
		int total_amount = 0;

		if(dtoSession != null) {
			Map<String, Object> hMap = new HashMap<String, Object>();
			hMap.put("user_id", dtoSession.getUser_id());
			hMap.put("cart_qty", dto.getCart_qty());
			hMap.put("prod_code", dto.getProd_code());

			dao.updateCart(hMap);

			total_amount = dao.selectTotalAmount(dtoSession.getUser_id());

		}else {
			@SuppressWarnings("unchecked")
			List<CartDTO> lists = (List<CartDTO>)session.getAttribute("cart_lists");
			
			for(int i=0; i<lists.size(); i++) {
				if(lists.get(i).getProd_code().equals(dto.getProd_code())) {
					lists.get(i).setCart_qty(dto.getCart_qty()); //수량 세팅
					lists.get(i).setCart_amount(lists.get(i).getCart_qty() * dto.getProd_price()); //총액 세팅
				}
			}
			
			//리스트 업데이트 끝난 후 전체 총액 세팅
			for(int j=0; j<lists.size(); j++) {
				total_amount += lists.get(j).getCart_qty() * lists.get(j).getProd_price(); 
			}
		}

		return total_amount;
	}

	//옵션변경에서 change하면 update
	@RequestMapping(value = "/updateCartOption", method = RequestMethod.POST)
	public  String updateCartOption(HttpServletRequest req,CartDTO dto) {
		HttpSession session = req.getSession();
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");
		String select_prod_code = dao.selectChkProdCode(dto);

		//회원
		if(dtoSession != null) {
			dto.setUser_id(dtoSession.getUser_id());
			int select_cart_qty = dao.selectChk(dto);
			//내가 변경할 prod_code가 이미 장바구니에 있다면
			if(select_cart_qty != -1) {	

				//똑같은 옵션을 선택하지 않았다면
				if(!select_prod_code.equals(dto.getProd_code())) {		
					dto.setCart_qty(dto.getCart_qty() + select_cart_qty);
					dao.updateCartOption(dto);	//업데이트					
					dto.setCart_qty(select_cart_qty);
					dao.deleteCartOption(dto); //원래 장바구니에 담겨있던 변경할 prod_code의 데이터 삭제	
				}

			}else {
				//없다면
				dao.updateCartOption(dto);	//업데이트			
			}

		//비회원
		}else {
			@SuppressWarnings("unchecked")
			List<CartDTO> lists = (List<CartDTO>)session.getAttribute("cart_lists");

			//장바구니에 내가 선택한 prod_code가 존재하는지 검증
			boolean chk = false;
			for(int i =0; i<lists.size(); i++) {
				if(select_prod_code.equals(lists.get(i).getProd_code())) {
					chk = true;
					break;
				}
			}
			
			//내 자신을 선택한게 아니라면
			if(!select_prod_code.equals(dto.getProd_code())) { 
				int select_cart_qty = dto.getCart_qty(); 
				int temp = -1; // 혹시 temp에 index값이 저장안된경우 아무것도 삭제안되게하려고 기본값으로 -1 저장 
				for(int j=0; j<lists.size(); j++) { 
					//list에있는 j번째 코드가 내가 옵션변경할 prod_code면 
					if(lists.get(j).getProd_code().equals(select_prod_code)) {
						lists.get(j).setCart_qty(lists.get(j).getCart_qty() + select_cart_qty); //수량 더해서 set
						lists.get(j).setCart_amount(lists.get(j).getCart_qty() * dto.getProd_price()); //총액 set
					//list에있는 j번째 prod_code가 내 원래 prod_code고, 내가 선택한 옵션(prod_code)가 장바구니안에 있을 경우
					}else if(lists.get(j).getProd_code().equals(dto.getProd_code()) && chk ==true) { 
						temp = j; //인덱스 저장 
					//list에있는 j번째 prod_code가 내 원래 prod_code고, 내가 선택한 옵션(prod_code)가 장바구니안에 없을 경우 
					}else if(lists.get(j).getProd_code().equals(dto.getProd_code()) && chk == false) {
						lists.get(j).setProd_code(select_prod_code); //내 prod_code를 선택한 옵션의 prod_code로 set 
					} 
				} 
				//저장한 인덱스 번호 데이터 삭제
				if(temp != -1) { 
					lists.remove(temp); 
				}
			}

		}

		return"cart/cartOptionModal";
	}

	//옵션변경에서 추가하면 insert
	@RequestMapping(value = "/insertCartOption", method = RequestMethod.POST)
	public String insertCartOption(HttpServletRequest req,CartDTO dto) {
		HttpSession session = req.getSession();
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");

		if(dtoSession != null) {
			dto.setUser_id(dtoSession.getUser_id());
			int select_cart_qty = dao.selectChk(dto);

			//내가 변경할 prod_code가 이미 장바구니에 있다면
			if(select_cart_qty != -1) {
				dto.setCart_qty(1 + select_cart_qty);
				dao.addUpdateCartOption(dto);	//업데이트	
			}else {
				//없다면 insert
				dao.insertCartOption(dto);
			}
		}else {

			@SuppressWarnings("unchecked")
			List<CartDTO> lists = (List<CartDTO>)session.getAttribute("cart_lists");
			String select_prod_code = dao.selectChkProdCode(dto);

			//장바구니에 내가 선택한 prod_code가 존재하는지 검증
			boolean chk = false;
			for(int i =0; i<lists.size(); i++) {
				if(select_prod_code.equals(lists.get(i).getProd_code())) {
					chk = true;
					break;
				}
			}
			//장바구니에 데이터가 있으면
			if(chk == true) {
				for(int i=0; i<lists.size(); i++) {
					if(lists.get(i).getProd_code().equals(select_prod_code)) {
						lists.get(i).setCart_qty(lists.get(i).getCart_qty()+1); // 선택한 prod_code의 수량 + 1
						lists.get(i).setCart_amount(lists.get(i).getCart_qty() * dto.getProd_price()); // 총액 set
					}
				}
			//장바구니에 데이터가 없으면
			}else {
				//추가
				dto.setProd_code(select_prod_code);
				dto.setCart_qty(1);
				dto.setProd_price(dto.getProd_price());
				dto.setCart_amount(dto.getProd_price());
				lists.add(dto);
			}


		}
		return"cart/cartOptionModal";	
	}

	//장바구니삭제
	@RequestMapping(value = "/deleteCart", method = RequestMethod.POST)
	public String deleteCart(HttpServletRequest req,String prod_code) {

		log.debug(prod_code);

		String[] prod_code_arr = null;
		HttpSession session = req.getSession();
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");
		Map<String, Object> hMap = new HashMap<String, Object>();
		int total_amount = 0;

		prod_code = prod_code.substring(0, prod_code.length()-1);
		prod_code_arr = prod_code.split(",");
		
		//회원
		if(dtoSession != null) {

			for(int i=0; i<prod_code_arr.length; i++) {

				hMap.put("user_id", dtoSession.getUser_id());
				hMap.put("prod_code", prod_code_arr[i]);
				log.debug(prod_code_arr[i]);
				dao.deleteCart(hMap);
			}

			List<CartDTO> lists = dao.selectCart(dtoSession.getUser_id());		
			total_amount = dao.selectTotalAmount(dtoSession.getUser_id());

			req.setAttribute("lists", lists);
			req.setAttribute("total_amount", total_amount);

		//비회원
		}else {

			@SuppressWarnings("unchecked")
			List<CartDTO> lists = (List<CartDTO>)session.getAttribute("cart_lists");
			
			//리스트 데이터 삭제
			for(int j=0; j<prod_code_arr.length; j++) { 
				for(int i=0; i<lists.size(); i++) { 	
					if(lists.get(i).getProd_code().equals(prod_code_arr[j])) {
						lists.remove(i);
					}		
				}
			}
			// 리스트 삭제 후 상품 전체 총액 set
			for(int i=0; i<lists.size(); i++) {
				total_amount += lists.get(i).getCart_qty() * lists.get(i).getProd_price();
			}
			req.setAttribute("lists", lists);
			req.setAttribute("total_amount", total_amount);
		}

		return "cart/cartDetail";
	}


	//장바구니 옵션변경
	@RequestMapping(value = "cartOptionChange", method = RequestMethod.GET)
	public String cartOptionChange(HttpServletRequest req,CartDTO dto) {

		List<CartDTO> color_lists = dao.selectColor(dto.getProd_subcode());
		List<CartDTO> size_lists = dao.selectSize(dto.getProd_subcode());

		req.setAttribute("color_lists", color_lists);
		req.setAttribute("size_lists", size_lists);
		req.setAttribute("dto", dto);

		return "cart/cartOptionModal";
	}

}
