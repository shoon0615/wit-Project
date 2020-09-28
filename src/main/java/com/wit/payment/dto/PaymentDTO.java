package com.wit.payment.dto;

public class PaymentDTO {
	
	// Payment
	private String order_code;	
	private String payment_type;	
	private String payment_account;	
	private String payment_bank;	
	private int payment_point;	
	private int payment_amount;	
	private String payment_created;
	
	// Order_Main
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
	public String getPayment_type() {
		return payment_type;
	}
	public void setPayment_type(String payment_type) {
		this.payment_type = payment_type;
	}
	public String getPayment_account() {
		return payment_account;
	}
	public void setPayment_account(String payment_account) {
		this.payment_account = payment_account;
	}
	public String getPayment_bank() {
		return payment_bank;
	}
	public void setPayment_bank(String payment_bank) {
		this.payment_bank = payment_bank;
	}
	public int getPayment_point() {
		return payment_point;
	}
	public void setPayment_point(int payment_point) {
		this.payment_point = payment_point;
	}
	public int getPayment_amount() {
		return payment_amount;
	}
	public void setPayment_amount(int payment_amount) {
		this.payment_amount = payment_amount;
	}
	public String getPayment_created() {
		return payment_created;
	}
	public void setPayment_created(String payment_created) {
		this.payment_created = payment_created;
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