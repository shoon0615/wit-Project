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
- [Tip](#Tip)
   
    
## 기본 구조
Spring 프레임워크로 구현되어 해당 구조인 MVC 형태로 구성      

**Model**   
Oracle로 mapper는 resources - mybatis로 참조(DTO 정보는 models에 참조)  

**Controller**      
@어노테이션을 통한 Bean 등록이 기본   
DAO(기능)은 인터페이스를 이용   
DTO(정보)는 해당 구조의 테이블 컬럼 정보    

**View**   
tiles를 이용한 header, content(구조), footer로 구성   

서버는 버추얼 박스를 통해 운영되며, 서버 및 Git 정보는 localhost로 기본값 설정   
이미지/파일/데이터 올릴시에 서버 측으로 업로드   
구조는 기본 7개 주제로 구성[cart, category, custom, main, myPage, payment, product(review)]   
디자인은 부트스트랩을 이용   
Git을 통해 공유 및 프로젝트 작업 진행(각 브랜치 Push -> master에서 Merge)   
단, 보안 문제상 파일 경로, DB 정보, 메일 정보는 Ignore로 숨김 후 서버에서 따로 보관 처리


**OS** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Windows10   
**DBMS** &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; : &nbsp; Oracle 11g   
**SERVER** &nbsp; &nbsp; &nbsp; : &nbsp; Tomcat 8.5   
**IDE** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; : &nbsp; Spring 4   
**CONTROL** &nbsp; : &nbsp; Java   
**VIEW** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Jsp(Jstl, J-Query), Css   
**VCS** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Git   
   
    
## cart
**Model**   
   

**Controller**      
   

**View**   
   
   
**Weakness**   
   
   
## category
**Model**   

**Controller**      
처음 페이지 접속 시 DTO를 통해 category1,2 값을 가지고 이동(대분류 리스트 및 금액바도 셋팅)      

**View**   
productList 함수를 통해 상품 리스트를 ajax로 가져오는 운영 방식   
적용될수 있는 변수로는 총 6가지로 대분류, 중분류, 사이즈, 금액바, 정렬 방식, 페이지 번호     
category1,2 값을 받았을때 trigger("click") 방식으로 페이지 로딩

**Weakness**   
－ hashMap 대신에 DTO로 이용   
－ category1,2 값이 보관된 hidden 불필요   
－ 이전, 다음 버튼 미구현   
－ mapper 내용이 order by만 다르기에 mapper는 ${sort} 하나로 구현하고   
 1. 각 DAO에 각 sort 값을 설정   
 2. 하나의 DAO에 매개변수를 통한 sort 값을 설정   
 
## custom
**Model**   
   

**Controller**      
   

**View**   
   
   
**Weakness**   
   
   
## main
**Model**   
   

**Controller**      
   

**View**   
   
   
**Weakness**   
   
   
## mypage
**Model**   
   

**Controller**      
   

**View**     
   
   
**Weakness**   
   
   
## payment
**Model**   
   

**Controller**      
   

**View**   
   
   
**Weakness**   
   
   
## product
**Model**   
   

**Controller**      
처음 페이지 접속 시 DTO(정보), 별점/이미지/컬러/사이즈 리스트를 가지고 이동

**View**   
컬러/사이즈 리스트를 각각 한번씩 클릭할 경우 상품 정보가 생성(전역변수와 $(this) 비교)       
상품 정보는 [정보/수량/닫기/금액] 형식으로 생성(selector와 append 구현)      
바로 결제는 페이지 이동으로 인해 상품 정보 리스트를 form에 String 형식으로 파싱,   
장바구니는 ajax가 가능하여 배열로 파싱(회원은 cart 테이블, 비회원은 session - List<CartDTO>)  
**Weakness**     
－ 상품 검색으로 받아온 prod_subcode가 잘못된 코드일 경우 이전 페이지로 되돌아가나 메세지를 띄우지않음(getHeader - referer)      
－ 처음 페이지 접속 시 일일히 List를 뿌리는 점이 비효율적으로 생각되기에   
 &nbsp; &nbsp; mapper에서 리스트 내역을 listAgg를 이용해 해당 컬럼마다 전체로 저장하여 가져온뒤 
 1. DTO에 각 리스트 내역을 따로 List 형식으로 만들어놓고 mapper에서 가져왔을때 Arrays와 split을 통해 셋팅하여 DTO를 뿌림   
 2. DTO에 String으로 받아놨다가 split을 통해 배열로 뿌림      
=> mapper에 listAgg를 이용한 리스트 내역 test로 만들어둠
     
## Tip
   
    
> 여기는 인용문입니다.
```
public class helloWorld {
	public static void main(String[] args) {
		System.out.println("Hello World!");
	} 
}
```
