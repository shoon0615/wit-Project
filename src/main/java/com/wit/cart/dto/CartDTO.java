package com.wit.cart.dto;

public class CartDTO {
	
	//p.prod_subcode,p.prod_color,p.prod_size,c.cart_qty,c.cart_qty*pi.prod_price as cart_amount,img.prod_img
	private String prod_subcode;
	private String prod_color;
	private String prod_size;
	private int cart_qty;
	private int cart_amount;
	private String prod_img;
	private int prod_price;
	private String prod_code;
	private int total_amount;

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
	public int getCart_qty() {
		return cart_qty;
	}
	public void setCart_qty(int cart_qty) {
		this.cart_qty = cart_qty;
	}
	public int getCart_amount() {
		return cart_amount;
	}
	public void setCart_amount(int cart_amount) {
		this.cart_amount = cart_amount;
	}
	public String getProd_img() {
		return prod_img;
	}
	public void setProd_img(String prod_img) {
		this.prod_img = prod_img;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public String getProd_code() {
		return prod_code;
	}
	public void setProd_code(String prod_code) {
		this.prod_code = prod_code;
	}
	public int getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}
	
	
	

}
