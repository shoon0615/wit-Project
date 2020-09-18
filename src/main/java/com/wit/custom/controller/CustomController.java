package com.wit.custom.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.SessionScope;

import com.wit.custom.dao.CustomDAOImpl;
import com.wit.custom.dto.CustomDTO;

@Controller
@RequestMapping(value = "/custom")
public class CustomController {

	private Logger log = LoggerFactory.getLogger(CustomController.class);

	@Autowired
	private CustomDAOImpl customDAO;
	
	@Autowired
	private KakaoAPI kakao;
	
	@Autowired
	private JavaMailSender mailSender;

	//����������**********************************************************************
	
	//	ȸ������ ������
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() throws Exception {
		return ".tiles/custom/join";
	}

	//	�α��� ������
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() throws Exception {
		return ".tiles/custom/login";
	}
	
	//	���̵�, ��й�ȣ ã�� ������
	@RequestMapping(value = "/find_account", method = RequestMethod.GET)
	public String fine_account() throws Exception {
		return ".tiles/custom/findAccount";
	}
	
	//	ȸ�� ���� ���� �õ� ������
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String try_modify() throws Exception {
		return ".tiles/custom/tryModify";
	}
	
	//	ȸ�� ���� ����  ������
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify() throws Exception {
		return ".tiles/custom/modify";
	}
	
	//******************************************************************************

	//	ȸ������ �� �ߺ� ���̵� üũ
	@ResponseBody
	@RequestMapping(value = "/check_id", method = RequestMethod.POST)
	public String check_id(String id) throws Exception {
		String result = customDAO.idCheck(id);
		return result;
	}

	//	ȸ������ �Ϸ� -> DB�� INSERT
	@RequestMapping(value = "/add_custom", method = RequestMethod.POST)
	public String add_custom(CustomDTO dto) throws Exception {

		//ü�� ���
		double bmi = dto.getUser_weight() / (dto.getUser_height() * dto.getUser_height() * 0.0001);

		if(bmi<18.5) {//����
			dto.setUser_form("SLIM");
		}else if(bmi<25) {//����
			dto.setUser_form("NORMAL");
		}else {//����
			dto.setUser_form("FAT");
		}

		//Ȯ�ο�
		log.debug("Ű: " + dto.getUser_height());
		log.debug("������: " + dto.getUser_weight());
		log.debug("bmi: " + bmi);

		//DB�� INSERT
		customDAO.addCustom(dto);
		
		return "redirect:/main/main";
		
	}
	
	//	�α��� ó��
	@ResponseBody
	@RequestMapping(value = "/check_login", method = RequestMethod.POST)
	public String check_login(CustomDTO dto, HttpSession session) throws Exception {
		
		log.debug("�Է��� id: " + dto.getUser_id());
		log.debug("�Է��� pwd: " + dto.getUser_pwd());
		
		//�ش� id,pwd�� ������ �ִ��� Ȯ�� -> ���� ������ ���� ������
		CustomDTO dtoC = customDAO.loginCheck(dto);
		
		//Ajax ��ȯ data
		String result = "false";
		
		//������ ������
		if(dtoC != null) {
			session.setAttribute("customInfo", dtoC);	//���ǿ� �������� �ø���
			result = "true";	//Ajax ��ȯ data
			//����Ȯ��
			CustomDTO dtoS = (CustomDTO)session.getAttribute("customInfo");			
			log.debug("���� name: " + dtoS.getUser_name());
			log.debug("���� tel: " + dtoS.getUser_tel());
			log.debug("���� form: " + dtoS.getUser_form());
			log.debug("���� style: " + dtoS.getUser_style());
		}
		
		log.debug("result: " + result);
		
		return result;
		
	}
	
	//	īī�� �������� �α���
	@RequestMapping(value = "/kakaoLogin", method = {RequestMethod.GET, RequestMethod.POST})
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session) throws Exception {

		// ���� code�� access_token �޾ƿ���
		String access_Token = kakao.getAccessToken(code);
		System.out.println("controller access_token : " + access_Token);
		
		// access_token ���� ����� ���� ��������
		HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);	   
	    System.out.println("login Controller : " + userInfo);
	    
	    //	    Ŭ���̾�Ʈ�� �̸����� ������ �� ���ǿ� �ش� �̸���,�г��� ��ū ���
	    if (userInfo.get("email") != null) {
	        session.setAttribute("email", (String)userInfo.get("email"));
	        session.setAttribute("nickname", (String)userInfo.get("nickname"));
	        session.setAttribute("access_Token", access_Token);
	        session.setAttribute("kakao", "ok");
	    }
	    
		return "redirect:/main/main";		
		
	}
	
	//	�α׾ƿ� ó��
	@RequestMapping(value = "/logout", method = {RequestMethod.GET,RequestMethod.POST})
	public String logout(HttpSession session) throws Exception {
		
		//�Ϲ� �α��� ������ �� ���ǿ��� ���� �����ϱ�
		session.removeAttribute("customInfo");
		
		//īī�� �������� �α��� �Ǿ� ������
		if(session.getAttribute("access_Token") != null) {
		    session.removeAttribute("access_Token");
		    session.removeAttribute("nickname");
		    session.removeAttribute("email");
		    session.removeAttribute("kakao");
		    return "redirect:https://kauth.kakao.com/oauth/logout?client_id=46a7983f1090447e062943a08473a49f&logout_redirect_uri=http://localhost:8081/wit/custom/main";
		}

		return "redirect:/main/main";
		
	}
	
	//	���̵� ã�� ó��
	@ResponseBody
	@RequestMapping(value = "/find_id", method = RequestMethod.POST)
	public String find_id(String user_name, String user_email) throws Exception {

		//�Է��� name,email�� map�� ����
		Map<String, String> hMap = new HashMap<String, String>();
		hMap.put("user_name", user_name);
		hMap.put("user_email", user_email);
		
		//�ش� name,email�� ������ �����ϴ��� Ȯ��
		String result = customDAO.findID(hMap);
		
		//������ �ִٸ� �̸��Ϸ� ���̵� ����
		if(result!=null) {
			
			MailHandler sendMail = new MailHandler(mailSender);	//���Ϻ����� ��ƿ Ŭ����
			
			sendMail.setSubject("[ WIT Ȩ������ ���̵� Ȯ�� ]");
			sendMail.setText("<h3>�ȳ��ϼ���. WIT ���̵� ã�� �����Դϴ�.</h3><br>"
					+ "ȸ������ ���̵�� <b>" + result + "</b> �Դϴ�.");
			sendMail.setFrom("hyeona73@gamil.com", "[WIT]");
			sendMail.setTo(user_email);
			sendMail.send();
			
			return "true";
			
		}
		
		return "false";
		
	}
	
	//	��й�ȣ ã�� ó��
	@ResponseBody
	@RequestMapping(value = "/find_pwd", method = RequestMethod.POST)
	public String find_pwd(String user_id, String user_email) throws Exception {

		//�Է��� id,email�� map�� ����
		Map<String, String> hMap = new HashMap<String, String>();
		hMap.put("user_id", user_id);
		hMap.put("user_email", user_email);
		
		//�ش� id,email�� ������ �����ϴ��� Ȯ��
		String result = customDAO.findPWD(hMap);
		
		log.debug("result: " + result);
		
		//������ �ִٸ� �̸��� ����
		if(result.equals("true") || result=="true") {
			
			MailHandler sendMail = new MailHandler(mailSender);	//���Ϻ����� ��ƿ Ŭ����
			TempKey tempkey = new TempKey();	//�ӽ� ��й�ȣ ���� Ŭ����
			
			String key = tempkey.getKey(10, true);	//�ӽ� ��й�ȣ �����ϱ�
			log.debug("key: " + key);
			
			//��������
			sendMail.setSubject("[ WIT Ȩ������ �ӽ� ��й�ȣ ]");
			sendMail.setText("<h3>�ȳ��ϼ���. WIT ��й�ȣ ã�� �����Դϴ�.</h3><br>"
					+ "ȸ������ �ӽ� ��й�ȣ�� <b>" + key + "</b> �Դϴ�.");
			sendMail.setFrom("hyeona73@gamil.com", "[WIT]");
			sendMail.setTo(user_email);
			sendMail.send();
			
			hMap.put("key", key);	//�ӽ� ��й�ȣ map�� ����
			customDAO.newPWD(hMap);	//�ӽ� ��й�ȣ�� DB update �ϱ�
			
		}
		
		return result;
		
	}
	
	//	ȸ������ ���� ó��
	@RequestMapping(value = "/modify_custom", method = RequestMethod.POST)
	public String modify_custom(CustomDTO dto) throws Exception {
		
		//ü�� ���
		double bmi = dto.getUser_weight() / (dto.getUser_height() * dto.getUser_height() * 0.0001);

		if(bmi<18.5) {//����
			dto.setUser_form("SLIM");
		}else if(bmi<25) {//����
			dto.setUser_form("NORMAL");
		}else {//����
			dto.setUser_form("FAT");
		}

		//Ȯ�ο�
		log.debug("���̵�: " + dto.getUser_id());
		log.debug("��й�ȣ: " + dto.getUser_pwd());
		log.debug("Ű: " + dto.getUser_height());
		log.debug("������: " + dto.getUser_weight());
		log.debug("����: " + dto.getUser_gender());
		log.debug("����: " + dto.getUser_style());
		log.debug("bmi: " + bmi);

		//DB�� UPDATE
		customDAO.modifyCustom(dto);
		
		return "redirect:/main/main";
		
	}
	
	
	//���ø� �̸����� ����***********************************************************************
	
	@RequestMapping(value = "/main", method = {RequestMethod.GET,RequestMethod.POST})
	public String main() {		
		// log.debug("AAA");
		return ".tiles/main/index";
	}

	@RequestMapping(value = "/contact", method = RequestMethod.GET)
	public String contact() {
		return "contact";
	}

	@RequestMapping(value = "/checkout", method = RequestMethod.GET)
	public String checkout() {
		return "checkout";
	}

	@RequestMapping(value = "/blog", method = RequestMethod.GET)
	public String blog() {
		return "blog";
	}

	@RequestMapping(value = "/blog-details", method = RequestMethod.GET)
	public String blog_details() {
		return "blog-details";
	}

	@RequestMapping(value = "/product-details", method = RequestMethod.GET)
	public String product_details() {
		return "product-details";
	}

	@RequestMapping(value = "/shop", method = RequestMethod.GET)
	public String shop() {
		return "shop";
	}

	@RequestMapping(value = "/shop-cart", method = RequestMethod.GET)
	public String shop_cart() {
		return "shop-cart";
	}

}
