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

	//īƮ ������ ����Ʈ �Ѹ�
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

	//īƮ���� ���� +,-Ŭ���� ������Ʈ
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
					lists.get(i).setCart_qty(dto.getCart_qty()); //���� ����
					lists.get(i).setCart_amount(lists.get(i).getCart_qty() * dto.getProd_price()); //�Ѿ� ����
				}
			}
			
			//����Ʈ ������Ʈ ���� �� ��ü �Ѿ� ����
			for(int j=0; j<lists.size(); j++) {
				total_amount += lists.get(j).getCart_qty() * lists.get(j).getProd_price(); 
			}
		}

		return total_amount;
	}

	//�ɼǺ��濡�� change�ϸ� update
	@RequestMapping(value = "/updateCartOption", method = RequestMethod.POST)
	public  String updateCartOption(HttpServletRequest req,CartDTO dto) {
		HttpSession session = req.getSession();
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");
		String select_prod_code = dao.selectChkProdCode(dto);

		//ȸ��
		if(dtoSession != null) {
			dto.setUser_id(dtoSession.getUser_id());
			int select_cart_qty = dao.selectChk(dto);
			//���� ������ prod_code�� �̹� ��ٱ��Ͽ� �ִٸ�
			if(select_cart_qty != -1) {	

				//�Ȱ��� �ɼ��� �������� �ʾҴٸ�
				if(!select_prod_code.equals(dto.getProd_code())) {		
					dto.setCart_qty(dto.getCart_qty() + select_cart_qty);
					dao.updateCartOption(dto);	//������Ʈ					
					dto.setCart_qty(select_cart_qty);
					dao.deleteCartOption(dto); //���� ��ٱ��Ͽ� ����ִ� ������ prod_code�� ������ ����	
				}

			}else {
				//���ٸ�
				dao.updateCartOption(dto);	//������Ʈ			
			}

		//��ȸ��
		}else {
			@SuppressWarnings("unchecked")
			List<CartDTO> lists = (List<CartDTO>)session.getAttribute("cart_lists");

			//��ٱ��Ͽ� ���� ������ prod_code�� �����ϴ��� ����
			boolean chk = false;
			for(int i =0; i<lists.size(); i++) {
				if(select_prod_code.equals(lists.get(i).getProd_code())) {
					chk = true;
					break;
				}
			}
			
			//�� �ڽ��� �����Ѱ� �ƴ϶��
			if(!select_prod_code.equals(dto.getProd_code())) { 
				int select_cart_qty = dto.getCart_qty(); 
				int temp = -1; // Ȥ�� temp�� index���� ����ȵȰ�� �ƹ��͵� �����ȵǰ��Ϸ��� �⺻������ -1 ���� 
				for(int j=0; j<lists.size(); j++) { 
					//list���ִ� j��° �ڵ尡 ���� �ɼǺ����� prod_code�� 
					if(lists.get(j).getProd_code().equals(select_prod_code)) {
						lists.get(j).setCart_qty(lists.get(j).getCart_qty() + select_cart_qty); //���� ���ؼ� set
						lists.get(j).setCart_amount(lists.get(j).getCart_qty() * dto.getProd_price()); //�Ѿ� set
					//list���ִ� j��° prod_code�� �� ���� prod_code��, ���� ������ �ɼ�(prod_code)�� ��ٱ��Ͼȿ� ���� ���
					}else if(lists.get(j).getProd_code().equals(dto.getProd_code()) && chk ==true) { 
						temp = j; //�ε��� ���� 
					//list���ִ� j��° prod_code�� �� ���� prod_code��, ���� ������ �ɼ�(prod_code)�� ��ٱ��Ͼȿ� ���� ��� 
					}else if(lists.get(j).getProd_code().equals(dto.getProd_code()) && chk == false) {
						lists.get(j).setProd_code(select_prod_code); //�� prod_code�� ������ �ɼ��� prod_code�� set 
					} 
				} 
				//������ �ε��� ��ȣ ������ ����
				if(temp != -1) { 
					lists.remove(temp); 
				}
			}

		}

		return"cart/cartOptionModal";
	}

	//�ɼǺ��濡�� �߰��ϸ� insert
	@RequestMapping(value = "/insertCartOption", method = RequestMethod.POST)
	public String insertCartOption(HttpServletRequest req,CartDTO dto) {
		HttpSession session = req.getSession();
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");

		if(dtoSession != null) {
			dto.setUser_id(dtoSession.getUser_id());
			int select_cart_qty = dao.selectChk(dto);

			//���� ������ prod_code�� �̹� ��ٱ��Ͽ� �ִٸ�
			if(select_cart_qty != -1) {
				dto.setCart_qty(1 + select_cart_qty);
				dao.addUpdateCartOption(dto);	//������Ʈ	
			}else {
				//���ٸ� insert
				dao.insertCartOption(dto);
			}
		}else {

			@SuppressWarnings("unchecked")
			List<CartDTO> lists = (List<CartDTO>)session.getAttribute("cart_lists");
			String select_prod_code = dao.selectChkProdCode(dto);

			//��ٱ��Ͽ� ���� ������ prod_code�� �����ϴ��� ����
			boolean chk = false;
			for(int i =0; i<lists.size(); i++) {
				if(select_prod_code.equals(lists.get(i).getProd_code())) {
					chk = true;
					break;
				}
			}
			//��ٱ��Ͽ� �����Ͱ� ������
			if(chk == true) {
				for(int i=0; i<lists.size(); i++) {
					if(lists.get(i).getProd_code().equals(select_prod_code)) {
						lists.get(i).setCart_qty(lists.get(i).getCart_qty()+1); // ������ prod_code�� ���� + 1
						lists.get(i).setCart_amount(lists.get(i).getCart_qty() * dto.getProd_price()); // �Ѿ� set
					}
				}
			//��ٱ��Ͽ� �����Ͱ� ������
			}else {
				//�߰�
				dto.setProd_code(select_prod_code);
				dto.setCart_qty(1);
				dto.setProd_price(dto.getProd_price());
				dto.setCart_amount(dto.getProd_price());
				lists.add(dto);
			}


		}
		return"cart/cartOptionModal";	
	}

	//��ٱ��ϻ���
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
		
		//ȸ��
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

		//��ȸ��
		}else {

			@SuppressWarnings("unchecked")
			List<CartDTO> lists = (List<CartDTO>)session.getAttribute("cart_lists");
			
			//����Ʈ ������ ����
			for(int j=0; j<prod_code_arr.length; j++) { 
				for(int i=0; i<lists.size(); i++) { 	
					if(lists.get(i).getProd_code().equals(prod_code_arr[j])) {
						lists.remove(i);
					}		
				}
			}
			// ����Ʈ ���� �� ��ǰ ��ü �Ѿ� set
			for(int i=0; i<lists.size(); i++) {
				total_amount += lists.get(i).getCart_qty() * lists.get(i).getProd_price();
			}
			req.setAttribute("lists", lists);
			req.setAttribute("total_amount", total_amount);
		}

		return "cart/cartDetail";
	}


	//��ٱ��� �ɼǺ���
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
