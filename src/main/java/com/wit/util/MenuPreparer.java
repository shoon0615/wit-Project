package com.wit.util;

import java.util.HashMap;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
		MainDTO dto = new MainDTO();
		dto.setUser_id("user");
		
		HashMap<String, Object> hmap = maindao.selectUserHeartCart(dto.getUser_id());
		
		attributeContext.putAttribute("hmap", new Attribute(hmap), true);	
	}
	
}
