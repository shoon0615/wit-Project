package com.wit.payment.dto;

public class PaymentDTO {
	
	// Order_Main
	private String order_code;	
	private String user_id;
	private String user_tel;	
	private String order_contents;	
	private String order_status;
	private int order_qty;	
	private int order_amount;	
	private String delivery_addr1;	
	private String delivery_addr2;	
	private String order_created;
	
	public String getOrder_code() {
		return order_code;
	}
	public void setOrder_code(String order_code) {
		this.order_code = order_code;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public String getOrder_contents() {
		return order_contents;
	}
	public void setOrder_contents(String order_contents) {
		this.order_contents = order_contents;
	}
	public String getOrder_status() {
		return order_status;
	}
	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}
	public int getOrder_qty() {
		return order_qty;
	}
	public void setOrder_qty(int order_qty) {
		this.order_qty = order_qty;
	}
	public int getOrder_amount() {
		return order_amount;
	}
	public void setOrder_amount(int order_amount) {
		this.order_amount = order_amount;
	}
	public String getDelivery_addr1() {
		return delivery_addr1;
	}
	public void setDelivery_addr1(String delivery_addr1) {
		this.delivery_addr1 = delivery_addr1;
	}
	public String getDelivery_addr2() {
		return delivery_addr2;
	}
	public void setDelivery_addr2(String delivery_addr2) {
		this.delivery_addr2 = delivery_addr2;
	}
	public String getOrder_created() {
		return order_created;
	}
	public void setOrder_created(String order_created) {
		this.order_created = order_created;
	}
}	