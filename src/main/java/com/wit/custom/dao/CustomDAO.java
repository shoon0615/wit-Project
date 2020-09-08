package com.wit.custom.dao;

import java.util.Map;

import com.wit.custom.dto.CustomDTO;

public interface CustomDAO {
	
	public String idCheck(String id) throws Exception;	//회원가입 시 아이디 중복체크
	public void addCustom(CustomDTO dto) throws Exception;	//회원가입 완료 시 DB insert
	public CustomDTO loginCheck(CustomDTO dto) throws Exception;	//로그인 시 제대로 된 계정인지 확인
	public String findID(Map<String, String> hMap) throws Exception;	//아이디 찾기 시 제대로 된 계정인지 확인
	public String findPWD(Map<String, String> hMap) throws Exception;	//비밀번호 찾기 시 제대로 된 계정인지 확인
	public void newPWD(Map<String, String> hMap) throws Exception;	//임시 비밀번호로 DB update
	public void modifyCustom(CustomDTO dto) throws Exception;	//회원정보 수정 시 DB update

}
