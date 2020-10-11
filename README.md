# Wit Project
해외 디자인을 참고해 심플한 형태로 구현한 쇼핑몰 사이트


## 목차
- [기본 구조](#기본-구조)
- 디테일 구조
  - [cart](#cart)
  - [category](#category)
  - [custom](#custom)
  - [main](#main)
  - [myPage](#mypage)
  - [payment](#payment)
  - [product](#product)


## 기본 구조
Spring 프레임워크로 구현되어 해당 구조인 MVC 형태로 구성   
**Model**   
Oracle로 mapper는 resources - mybatis로 참조함(DTO 정보는 models에 참조)   
**Controller**      
@어노테이션을 통한 Bean 등록이 기본   
DAO(기능)은 인터페이스를 이용   
DTO(정보)는 해당 구조의 테이블 컬럼 정보   
**View**   
tiles를 이용한 header, content(구조), footer로 구성   

**OS** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Windows10   
**DBMS** &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; : &nbsp; Oracle 11g   
**SERVER** &nbsp; &nbsp; &nbsp; : &nbsp; Tomcat 8.5   
**IDE** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; : &nbsp; Spring 4   
**CONTROL** &nbsp; : &nbsp; Java   
**VIEW** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Jsp(Jstl, J-Query), Css   
**VCS** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Git   

## cart
cart

## category
category

## custom
custom

## main
main

## mypage
mypage

## payment
payment

## product
product

> 여기는 인용문입니다.
```
public class helloWorld {
	public static void main(String[] args) {
		System.out.println("Hello World!");
	} 
}
```
