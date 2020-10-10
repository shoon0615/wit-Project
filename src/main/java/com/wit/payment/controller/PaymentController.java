package com.wit.payment.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.wit.cart.dto.CartDTO;
import com.wit.custom.dto.CustomDTO;
import com.wit.payment.dao.PaymentDAO;
import com.wit.payment.dto.PaymentDTO;

@Controller
@RequestMapping(value = "/payment")
public class PaymentController {

	private Logger log = LoggerFactory.getLogger(PaymentController.class);
	
	@Autowired
	// @Qualifier("productDAO")
	PaymentDAO dao;
	
	@RequestMapping(value = "/checkout", method = {RequestMethod.GET, RequestMethod.POST})
	public String checkout(HttpServletRequest request, String prodStr) {	
		
		ObjectMapper mapper = new ObjectMapper();	
		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();	
		
		// 카트 페이지에서 결제한 경우
		if(prodStr == null) {
			HttpSession session = request.getSession();
			CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");
			@SuppressWarnings("unchecked")
			List<CartDTO> cart_lists = (List<CartDTO>)session.getAttribute("cart_lists");

			list = dao.getProdCode(dtoSession == null ? null : dtoSession.getUser_id(), cart_lists);
		// 상품 페이지에서 바로 결제한 경우
		} else {
			list = dao.getProdCode(prodStr);
		}
		
		try {
			// list에 qty를 가져올수없어 map에 추가했기 때문에 이대로 json 형태로 보냄
			String list_json = mapper.writeValueAsString(list);
			
			request.setAttribute("prod_list", list);
			request.setAttribute("prod_list_json", list_json);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return ".tiles/payment/checkout";
	}
	
	@RequestMapping(value = "/insertOrder", method = RequestMethod.POST)
	public @ResponseBody String insertOrder(HttpServletRequest request, PaymentDTO dto, String prod_list) {
		
		// 현재 날짜를 to_char형식으로 동일하게 받아옴
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		Date sysdate = new Date();		
		String toDate = dateFormat.format(sysdate);

		dto.setOrder_code(toDate);					// order_code를 컨트롤러에서 생성
		String order_code = dto.getOrder_code();
			
		dao.insertOrderMain(dto);
		dao.insertOrderDetail(prod_list, order_code);
		dao.insertPayment(dto);

		return "";
	}
	
}
