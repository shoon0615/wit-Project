package com.wit.product.dto;

import java.util.List;

public class reviewDTO {
	
	private String prod_code;
	private String user_id;
	private String review_contents;
	private String ceo_contents;
	private int review_score;
	private String review_created;
	private String prod_subcode;
	private String review_num;
	private String user_name;
	private int user_height;
	private int user_weight;
	private String user_form;
	private String user_style;
	private String user_gender;
	private String order_code;
	private int prod_qty;
	private int reportCnt;
	
	
	private List<String> review_img;
	
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
	public String getReview_num() {
		return review_num;
	}
	public void setReview_num(String review_num) {
		this.review_num = review_num;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public int getUser_height() {
		return user_height;
	}
	public void setUser_height(int user_height) {
		this.user_height = user_height;
	}
	public int getUser_weight() {
		return user_weight;
	}
	public void setUser_weight(int user_weight) {
		this.user_weight = user_weight;
	}
	public String getUser_form() {
		return user_form;
	}
	public void setUser_form(String user_form) {
		this.user_form = user_form;
	}
	public String getUser_style() {
		return user_style;
	}
	public void setUser_style(String user_style) {
		this.user_style = user_style;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getOrder_code() {
		return order_code;
	}
	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}
	public int getProd_qty() {
		return prod_qty;
	}
	public void setProd_qty(int prod_qty) {
		this.prod_qty = prod_qty;
	}
	public List<String> getReview_img() {
		return review_img;
	}
	public void setReview_img(List<String> list) {
		this.review_img = list;
	}
	public int getReportCnt() {
		return reportCnt;
	}
	public void setReportCnt(int reportCnt) {
		this.reportCnt = reportCnt;
	}
	


}
