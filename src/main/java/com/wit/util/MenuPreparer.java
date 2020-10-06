package com.wit.util;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.wit.cart.dto.CartDTO;
import com.wit.custom.dto.CustomDTO;
import com.wit.main.dao.MainDAO;
import com.wit.main.dto.MainDTO;

//@Repository �� bean ��ü������ �����.
@Repository("menuPreparer")
public class MenuPreparer implements ViewPreparer {

	@Autowired
	MainDAO maindao;
	
	@Override
	public void execute(Request tilesContext, AttributeContext attributeContext) {

		//��,��ٱ��� ī��Ʈ
		HashMap<String, Object> hmap = new HashMap<String, Object>();
		
		// Override�� ���� HttpServletRequest�� ��ü�� ���� �޾ƿ�
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session = req.getSession();
		CustomDTO dtoSession = (CustomDTO)session.getAttribute("customInfo");
		@SuppressWarnings("unchecked")
		List<CartDTO> lists = (List<CartDTO>)session.getAttribute("cart_lists");
		
		// �α��� ������ ī��Ʈ �Ǻ�
		if(dtoSession == null) {
			hmap.put("HEARTCNT", 0);
			hmap.put("CARTCNT", lists == null ? 0 : lists.size());
		} else {
			hmap = maindao.selectUserHeartCart(dtoSession.getUser_id());
		}
		
		attributeContext.putAttribute("hmap", new Attribute(hmap), true);	
	}
	
}
