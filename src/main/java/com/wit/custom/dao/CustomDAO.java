package com.wit.custom.dao;

import java.util.Map;

import com.wit.custom.dto.CustomDTO;

public interface CustomDAO {
	
	public String idCheck(String id) throws Exception;	//ȸ������ �� ���̵� �ߺ�üũ
	public void addCustom(CustomDTO dto) throws Exception;	//ȸ������ �Ϸ� �� DB insert
	public CustomDTO loginCheck(CustomDTO dto) throws Exception;	//�α��� �� ����� �� �������� Ȯ��
	public String findID(Map<String, String> hMap) throws Exception;	//���̵� ã�� �� ����� �� �������� Ȯ��
	public String findPWD(Map<String, String> hMap) throws Exception;	//��й�ȣ ã�� �� ����� �� �������� Ȯ��
	public void newPWD(Map<String, String> hMap) throws Exception;	//�ӽ� ��й�ȣ�� DB update
	public void modifyCustom(CustomDTO dto) throws Exception;	//ȸ������ ���� �� DB update

}
