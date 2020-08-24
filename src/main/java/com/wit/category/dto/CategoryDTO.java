package com.wit.category.dto;

public class CategoryDTO {

	private String prod_subcode;   		// 상품 ID
	private String prod_contents;   	// 상품 이름
	private int prod_price;  		// 상품 이미지
	private String prod_category1;  		// 상품 가격
	private String prod_category2;  		// 상품 조회수
	private String prod_style;   // 상품 설명(내용)
	private int prod_count;
	private String prod_gender;
	public String getProd_subcode() {
		return prod_subcode;
	}
	public void setProd_subcode(String prod_subcode) {
		this.prod_subcode = prod_subcode;
	}
	public String getProd_contents() {
		return prod_contents;
	}
	public void setProd_contents(String prod_contents) {
		this.prod_contents = prod_contents;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public String getProd_category1() {
		return prod_category1;
	}
	public void setProd_category1(String prod_category1) {
		this.prod_category1 = prod_category1;
	}
	public String getProd_category2() {
		return prod_category2;
	}
	public void setProd_category2(String prod_category2) {
		this.prod_category2 = prod_category2;
	}
	public String getProd_style() {
		return prod_style;
	}
	public void setProd_style(String prod_style) {
		this.prod_style = prod_style;
	}
	public int getProd_count() {
		return prod_count;
	}
	public void setProd_count(int prod_count) {
		this.prod_count = prod_count;
	}
	public String getProd_gender() {
		return prod_gender;
	}
	public void setProd_gender(String prod_gender) {
		this.prod_gender = prod_gender;
	}
	
	
}
