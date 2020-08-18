package com.wit.product.dto;

public class ProductDTO {
	
	private String PROD_SUBCODE;		// 상품 브랜드
	private String PROD_CONTENTS;		// 상품 상세설명
	private int PROD_PRICE;				// 상품 가격
	private String PROD_CATEGORY1;		// 상품 카테고리(대분류)
	private String PROD_CATEGORY2;		// 상품 카테고리(중분류)
	private String PROD_STYLE;			// 상품 스타일
	private String PROD_GENDER;			// 상품 성별
	private int PROD_COUNT;				// 상품 조회수
	
	public String getPROD_SUBCODE() {
		return PROD_SUBCODE;
	}
	public void setPROD_SUBCODE(String pROD_SUBCODE) {
		PROD_SUBCODE = pROD_SUBCODE;
	}
	public String getPROD_CONTENTS() {
		return PROD_CONTENTS;
	}
	public void setPROD_CONTENTS(String pROD_CONTENTS) {
		PROD_CONTENTS = pROD_CONTENTS;
	}
	public int getPROD_PRICE() {
		return PROD_PRICE;
	}
	public void setPROD_PRICE(int pROD_PRICE) {
		PROD_PRICE = pROD_PRICE;
	}
	public String getPROD_CATEGORY1() {
		return PROD_CATEGORY1;
	}
	public void setPROD_CATEGORY1(String pROD_CATEGORY1) {
		PROD_CATEGORY1 = pROD_CATEGORY1;
	}
	public String getPROD_CATEGORY2() {
		return PROD_CATEGORY2;
	}
	public void setPROD_CATEGORY2(String pROD_CATEGORY2) {
		PROD_CATEGORY2 = pROD_CATEGORY2;
	}
	public String getPROD_STYLE() {
		return PROD_STYLE;
	}
	public void setPROD_STYLE(String pROD_STYLE) {
		PROD_STYLE = pROD_STYLE;
	}
	public String getPROD_GENDER() {
		return PROD_GENDER;
	}
	public void setPROD_GENDER(String pROD_GENDER) {
		PROD_GENDER = pROD_GENDER;
	}
	public int getPROD_COUNT() {
		return PROD_COUNT;
	}
	public void setPROD_COUNT(int pROD_COUNT) {
		PROD_COUNT = pROD_COUNT;
	}
	
}
