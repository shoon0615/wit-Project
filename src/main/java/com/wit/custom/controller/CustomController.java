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

	//페이지매핑**********************************************************************
	
	//	회원가입 페이지
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() throws Exception {
		return ".tiles/custom/join";
	}

	//	로그인 페이지
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() throws Exception {
		return ".tiles/custom/login";
	}
	
	//	아이디, 비밀번호 찾기 페이지
	@RequestMapping(value = "/find_account", method = RequestMethod.GET)
	public String fine_account() throws Exception {
		return ".tiles/custom/findAccount";
	}
	
	//	회원 정보 수정 시도 페이지
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String try_modify() throws Exception {
		return ".tiles/custom/tryModify";
	}
	
	//	회원 정보 수정  페이지
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify() throws Exception {
		return ".tiles/custom/modify";
	}
	
	//******************************************************************************

	//	회원가입 시 중복 아이디 체크
	@ResponseBody
	@RequestMapping(value = "/check_id", method = RequestMethod.POST)
	public String check_id(String id) throws Exception {
		String result = customDAO.idCheck(id);
		return result;
	}

	//	회원가입 완료 -> DB에 INSERT
	@RequestMapping(value = "/add_custom", method = RequestMethod.POST)
	public String add_custom(CustomDTO dto) throws Exception {

		//체형 계산
		double bmi = dto.getUser_weight() / (dto.getUser_height() * dto.getUser_height() * 0.0001);

		if(bmi<18.5) {//마름
			dto.setUser_form("SLIM");
		}else if(bmi<25) {//보통
			dto.setUser_form("NORMAL");
		}else {//통통
			dto.setUser_form("FAT");
		}

		//확인용
		log.debug("키: " + dto.getUser_height());
		log.debug("몸무게: " + dto.getUser_weight());
		log.debug("bmi: " + bmi);

		//DB에 INSERT
		customDAO.addCustom(dto);
		
		return "redirect:/main/main";
		
	}
	
	//	로그인 처리
	@ResponseBody
	@RequestMapping(value = "/check_login", method = RequestMethod.POST)
	public String check_login(CustomDTO dto, HttpSession session) throws Exception {
		
		log.debug("입력한 id: " + dto.getUser_id());
		log.debug("입력한 pwd: " + dto.getUser_pwd());
		
		//해당 id,pwd로 계정이 있는지 확인 -> 게정 있으면 정보 가져옴
		CustomDTO dtoC = customDAO.loginCheck(dto);
		
		//Ajax 반환 data
		String result = "false";
		
		//계정이 있으면
		if(dtoC != null) {
			session.setAttribute("customInfo", dtoC);	//세션에 계정정보 올리기
			result = "true";	//Ajax 반환 data
			//세션확인
			CustomDTO dtoS = (CustomDTO)session.getAttribute("customInfo");			
			log.debug("세션 name: " + dtoS.getUser_name());
			log.debug("세션 tel: " + dtoS.getUser_tel());
			log.debug("세션 form: " + dtoS.getUser_form());
			log.debug("세션 style: " + dtoS.getUser_style());
		}
		
		log.debug("result: " + result);
		
		return result;
		
	}
	
	//	카카오 계정으로 로그인
	@RequestMapping(value = "/kakaoLogin", method = {RequestMethod.GET, RequestMethod.POST})
	public String kakaoLogin(@RequestParam("code") String code, HttpSession session) throws Exception {

		// 인증 code로 access_token 받아오기
		String access_Token = kakao.getAccessToken(code);
		System.out.println("controller access_token : " + access_Token);
		
		// access_token 으로 사용자 정보 가져오기
		HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);	   
	    System.out.println("login Controller : " + userInfo);
	    
	    //	    클라이언트의 이메일이 존재할 때 세션에 해당 이메일,닉네임 토큰 등록
	    if (userInfo.get("email") != null) {
	        session.setAttribute("email", (String)userInfo.get("email"));
	        session.setAttribute("nickname", (String)userInfo.get("nickname"));
	        session.setAttribute("access_Token", access_Token);
	        session.setAttribute("kakao", "ok");
	    }
	    
		return "redirect:/main/main";		
		
	}
	
	//	로그아웃 처리
	@RequestMapping(value = "/logout", method = {RequestMethod.GET,RequestMethod.POST})
	public String logout(HttpSession session) throws Exception {
		
		//일반 로그인 되있을 시 세션에서 정보 삭제하기
		session.removeAttribute("customInfo");
		
		//카카오 계정으로 로그인 되어 있으면
		if(session.getAttribute("access_Token") != null) {
		    session.removeAttribute("access_Token");
		    session.removeAttribute("nickname");
		    session.removeAttribute("email");
		    session.removeAttribute("kakao");
		    return "redirect:https://kauth.kakao.com/oauth/logout?client_id=46a7983f1090447e062943a08473a49f&logout_redirect_uri=http://localhost:8081/wit/custom/main";
		}

		return "redirect:/main/main";
		
	}
	
	//	아이디 찾기 처리
	@ResponseBody
	@RequestMapping(value = "/find_id", method = RequestMethod.POST)
	public String find_id(String user_name, String user_email) throws Exception {

		//입력한 name,email을 map에 세팅
		Map<String, String> hMap = new HashMap<String, String>();
		hMap.put("user_name", user_name);
		hMap.put("user_email", user_email);
		
		//해당 name,email로 계정이 존재하는지 확인
		String result = customDAO.findID(hMap);
		
		//계정이 있다면 이메일로 아이디 전송
		if(result!=null) {
			
			MailHandler sendMail = new MailHandler(mailSender);	//메일보내기 유틸 클래스
			
			sendMail.setSubject("[ WIT 홈페이지 아이디 확인 ]");
			sendMail.setText("<h3>안녕하세요. WIT 아이디 찾기 메일입니다.</h3><br>"
					+ "회원님의 아이디는 <b>" + result + "</b> 입니다.");
			sendMail.setFrom("hyeona73@gamil.com", "[WIT]");
			sendMail.setTo(user_email);
			sendMail.send();
			
			return "true";
			
		}
		
		return "false";
		
	}
	
	//	비밀번호 찾기 처리
	@ResponseBody
	@RequestMapping(value = "/find_pwd", method = RequestMethod.POST)
	public String find_pwd(String user_id, String user_email) throws Exception {

		//입력한 id,email을 map에 세팅
		Map<String, String> hMap = new HashMap<String, String>();
		hMap.put("user_id", user_id);
		hMap.put("user_email", user_email);
		
		//해당 id,email로 계정이 존재하는지 확인
		String result = customDAO.findPWD(hMap);
		
		log.debug("result: " + result);
		
		//계정이 있다면 이메일 전송
		if(result.equals("true") || result=="true") {
			
			MailHandler sendMail = new MailHandler(mailSender);	//메일보내기 유틸 클래스
			TempKey tempkey = new TempKey();	//임시 비밀번호 생성 클래스
			
			String key = tempkey.getKey(10, true);	//임시 비밀번호 생성하기
			log.debug("key: " + key);
			
			//메일전송
			sendMail.setSubject("[ WIT 홈페이지 임시 비밀번호 ]");
			sendMail.setText("<h3>안녕하세요. WIT 비밀번호 찾기 메일입니다.</h3><br>"
					+ "회원님의 임시 비밀번호는 <b>" + key + "</b> 입니다.");
			sendMail.setFrom("hyeona73@gamil.com", "[WIT]");
			sendMail.setTo(user_email);
			sendMail.send();
			
			hMap.put("key", key);	//임시 비밀번호 map에 세팅
			customDAO.newPWD(hMap);	//임시 비밀번호로 DB update 하기
			
		}
		
		return result;
		
	}
	
	//	회원정보 수정 처리
	@RequestMapping(value = "/modify_custom", method = RequestMethod.POST)
	public String modify_custom(CustomDTO dto) throws Exception {
		
		//체형 계산
		double bmi = dto.getUser_weight() / (dto.getUser_height() * dto.getUser_height() * 0.0001);

		if(bmi<18.5) {//마름
			dto.setUser_form("SLIM");
		}else if(bmi<25) {//보통
			dto.setUser_form("NORMAL");
		}else {//통통
			dto.setUser_form("FAT");
		}

		//확인용
		log.debug("아이디: " + dto.getUser_id());
		log.debug("비밀번호: " + dto.getUser_pwd());
		log.debug("키: " + dto.getUser_height());
		log.debug("몸무게: " + dto.getUser_weight());
		log.debug("성별: " + dto.getUser_gender());
		log.debug("취향: " + dto.getUser_style());
		log.debug("bmi: " + bmi);

		//DB에 UPDATE
		customDAO.modifyCustom(dto);
		
		return "redirect:/main/main";
		
	}
	
	
	//템플릿 미리보기 매핑***********************************************************************
	
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
