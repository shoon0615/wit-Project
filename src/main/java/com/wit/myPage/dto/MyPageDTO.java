package com.wit.myPage.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MyPageDTO {

	// Review
	private int review_num;				// 리뷰 번호
	private String order_code;			// 주문 번호
	private String prod_code;			// 상품 코드
	private String user_id;				// 유저ID
	private String review_contents;		// 리뷰 내용
	private String ceo_contents;		// 사장님 리뷰 내용
	private int review_score;			// 리뷰 별점
	private String review_created;		// 리뷰 작성일자

	// Product
	private String prod_subcode;		// 상품 브랜드
	private String prod_color;			// 상품 색상
	private String prod_size;			// 상품 사이즈
	
	// Product_Info
	private int prod_price;				// 상품 가격
	
	// Product_Img
	private String prod_img;			// 상품 이미지
	
	// Order_Detail
	private int prod_qty;				// 상품 주문 개수
	
	// Void Variable
	private int order_code_cnt;				// 주문 번호 상품 개수
	private List<MultipartFile> upload_img;	// 파일 이미지
	
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public String getOrder_code() {
		return order_code;
	}
	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}
	public String getProd_code() {
		return prod_code;
	}
	public void setProd_code(String prod_code) {
		this.prod_code = prod_code;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getReview_contents() {
		return review_contents;
	}
	public void setReview_contents(String review_contents) {
		this.review_contents = review_contents;
	}
	public String getCeo_contents() {
		return ceo_contents;
	}
	public void setCeo_contents(String ceo_contents) {
		this.ceo_contents = ceo_contents;
	}
	public int getReview_score() {
		return review_score;
	}
	public void setReview_score(int review_score) {
		this.review_score = review_score;
	}
	public String getReview_created() {
		return review_created;
	}
	public void setReview_created(String review_created) {
		this.review_created = review_created;
	}
	public String getProd_subcode() {
		return prod_subcode;
	}
	public void setProd_subcode(String prod_subcode) {
		this.prod_subcode = prod_subcode;
	}
	public String getProd_color() {
		return prod_color;
	}
	public void setProd_color(String prod_color) {
		this.prod_color = prod_color;
	}
	public String getProd_size() {
		return prod_size;
	}
	public void setProd_size(String prod_size) {
		this.prod_size = prod_size;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public String getProd_img() {
		return prod_img;
	}
	public void setProd_img(String prod_img) {
		this.prod_img = prod_img;
	}
	public int getProd_qty() {
		return prod_qty;
	}
	public void setProd_qty(int prod_qty) {
		this.prod_qty = prod_qty;
	}
	public int getOrder_code_cnt() {
		return order_code_cnt;
	}
	public void setOrder_code_cnt(int order_code_cnt) {
		this.order_code_cnt = order_code_cnt;
	}
	public List<MultipartFile> getUpload_img() {
		return upload_img;
	}
	public void setUpload_img(List<MultipartFile> upload_img) {
		this.upload_img = upload_img;
	}
	
}	
