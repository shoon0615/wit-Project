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
Git을 통해 공유 및 프로젝트 작업 진행(각 브랜치 Push -> master에서 Merge)      
단, 보안 문제상 파일 경로, DB 정보, 메일 정보는 Ignore로 숨김 후 서버에서 따로 보관 처리   

- **Model**   
서버는 Oracle로 버추얼 박스를 통해 운영되며, 서버 및 Git 정보는 localhost로 기본값 설정      
mapper는 resources - mybatis로 참조(DTO 정보는 models에 참조)     
이미지/파일/데이터 올릴시에 서버 측으로 업로드   

- **Controller**      
@어노테이션을 통한 Bean 등록이 기본   
DAO(기능)은 인터페이스를 이용   
DTO(정보)는 해당 구조의 테이블 컬럼 정보    

- **View**   
tiles를 이용한 header, content(구조), footer로 구성   
구조는 기본 7개 주제로 구성[cart, category, custom, main, myPage, payment, product(review)]   
디자인은 부트스트랩을 이용   
   
**OS** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Windows 10   
**DBMS** &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; : &nbsp; Oracle 11g   
**SERVER** &nbsp; &nbsp; &nbsp; : &nbsp; Tomcat 8.5   
**IDE** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; : &nbsp; Spring 4   
**CONTROL** &nbsp; : &nbsp; Java   
**VIEW** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Jsp(Jstl, J-Query), Css   
**VCS** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Git   
   
    
## cart
- **Model**   
   

- **Controller**      
   

- **View**   
   
   
- **Weakness**   
   
   
## category
- **Model**   
DTO 대신 hashMap 이용   
   
- **Controller**      
처음 페이지 접속 시 DTO를 통해 category1,2 값을 가지고 이동(대분류 리스트 및 금액바도 셋팅)      

- **View**   
productList 함수를 통해 상품 리스트를 ajax로 가져오는 운영 방식   
적용될수 있는 변수로는 총 6가지로 대분류, 중분류, 사이즈, 금액바, 정렬 방식, 페이지 번호     
category1,2 값을 받았을때 trigger("click") 방식으로 페이지 로딩

- **Weakness**   
－ hashMap 대신에 DTO로 이용   
－ category1,2 값이 보관된 hidden 불필요   
－ 이전, 다음 버튼 미구현   
－ mapper 내용이 order by만 다르기에 mapper는 ${sort} 하나로 구현하고   
 &nbsp; &nbsp; 1. 각 DAO에 각 sort 값을 설정   
 &nbsp; &nbsp; 2. 하나의 DAO에 매개변수를 통한 sort 값을 설정   
 
## custom
- **Model**   
decode(case when과 유사) 이용      

- **Controller**      
로그인 시 jsp에서 이전 주소를 변수로 보내며 시도하고, 성공하면 session에 로그인 정보 추가 및 이전 주소로 롤백(referrer)   
로그아웃 시 session을 remove 실행(카카오는 redirect:logout)   
회원정보가 입력되면 체형은 자동으로 공식에 맞춰 진행   
비밀번호 찾기 시 임시 비밀번호로 변경되며 MailHandler를 통해 메일로 전송   
   
- **View**   
input 태그와 keyup 등을 이용한 DOM 방식 페이지 구현      
로그인은 카카오 API(REST 방식) 로그인 기능 추가   
회원가입은 J-Query 방식(next 빈도 높음) 및 ajax 다중 이벤트 구현   
정보찾기는 mail API를 통한 정보 수신 기능 추가   
정보수정은 컨트롤러의 GET, POST 방식을 이용한 재확인   
   
- **Weakness**   
－ if()를 통해 compare 변수를 false로 바꾸는것 대신 경고메세지.text만 바꾸고   
 &nbsp; &nbsp;&nbsp; 마지막에 if(!compare)로 체크하여 color를 red 바꾸는 방식으로 변경   
－ 특정 양식이 잘못됨을 알려주는게 아니라면 compare 변수를 하나만 사용   
－ ajax 이용시 매개변수를 직접 부여하지않고 form.serialize() 이용   
－ 체크박스 hidden에 값을 부여하는 함수를 for문 대신 $.each(input:checked) 사용   
－ 회원가입 시 전체값을 일일히 받았으나 $.each로 input을 확인(+값이 없을 경우 경고메세지도 추가)   
－ 로그인 시 click 함수 대신 J-Query를 통한 click 함수 통일($(this) 이용)   
－ check_login 시 String result 없이 직접 선언 또는 boolean으로 return      
－ 정보찾기 시 매개변수에 hashMap 대신 DTO 이용   
－ TempKey 클래스 전역변수 대신 생성자/메소드(매개변수) 구조로 변경   
      
## main
- **Model**   
   

- **Controller**      
로그인 시 고객 취향 추천, 비회원 시 판매순으로 상품 리스트 조회   
그 외 공통으로 조회순, 리뷰순, 별점순으로 상품 리스트 조회(category mapper)   

- **View**   
   
   
- **Weakness**   
－ 뿌려준 상품 리스트에 대한 기능만 동작하고, 나머지 부분이 모두 미구현(배너가 3개라 체형 조회하는등..)      
－ 공통으로 조회되는 상품 리스트는 jsp - foreach 부분의 내용이 모두 같은데      
 &nbsp; &nbsp; 1. List<List<CategoryDTO>> 및 title[] 배열을 보낸뒤 foreach(varStatus) 이용       
 &nbsp; &nbsp; 2. Map<String, List<CategoryDTO>> 으로 key에는 title을 넣어 보낸뒤       
 &nbsp; &nbsp; &nbsp; foreach(var=map)으로 사용해 title은 ${map.key}, 내용은 foreach(var=${map.value}) 로 이용   
－ header의 search 기능 간소화가 Main에만 적용됨(다른 jsp의 search-model 삭제)      
－ header의 카테고리가 하드코딩으로 뿌려지는데 Controller에서   
 &nbsp; &nbsp; 대분류 : List<Map<String, Object>> = getCategory()   
 &nbsp; &nbsp; 중분류 : Map<int, List<Map<String, Object>>> 선언한뒤 for(int i=1;i<대분류.size();i++) { Map.put(i, getCategory(i)) }   
 &nbsp; &nbsp; 이후 View에서   
```
<c:forEach "대분류" varStatus>
	<a category1=${대분류.code}> ${대분류.code_name} </a>
	<c:forEach "중분류.status+1">
		<a category1=${대분류.code}, category2=${중분류.code}> ${중분류.code_name} </a>
	</c:forEach>
</c:forEach>
}
```  
## mypage
- **Model**   
   

- **Controller**      
   

- **View**     
   
   
- **Weakness**   
   
   
## payment
- **Model**   
prod_option 컬럼 생성 및 hashMap 이용   

- **Controller**      
cart에서 회원으로 결제한 경우, cart 테이블의 정보 추출
cart에서 비회원으로 결제한 경우, session - List<CartDTO>의 정보 추출   
상품 페이지에서 바로 결제한 경우, String으로 파싱해 받았기에 split을 통해 List에 셋팅하여 정보 추출<br>   
추출한 List를 직접 View에 뿌림      
추가로 Total 처리 및 String 파싱 대신 배열 파싱을 위해 추출한 List를 json으로 파싱하여 뿌림<br>      
결제가 성공하면 Order_Main(기본 정보), Order_Detail(json으로 받은 List 파싱), Payment(IMP 결제 데이터) 테이블에 데이터 생성   
   
- **View**   
추출받은 결제 상품 리스트와 사용자 정보가 기본 페이지 셋팅(로그인의 경우, session정보로 자동 셋팅)   
결제 진행 클릭 시 전체 정보의 빈 칸 및 경고 메세지를 each로 확인하며 통과했을 경우, IMP API를 통해 구매 화면으로 이동   
구매 화면에서 정상 결제에 성공하면 form의 데이터와 IMP의 결제 데이터를 가지고 컨트롤러로 이동   
   
- **Weakness**   
－ Order_Main 테이블에 user_name 컬럼이 없고 user_id 컬럼으로 진행되기에    
 &nbsp; &nbsp; 로그인했는데 이름을 바꾼 경우 또는 비회원이 존재하는 user_id를 사용한 경우, 문제가 발생   
 &nbsp; &nbsp; (user_name 컬럼을 추가, 비회원은 user_id에 빈값 처리 요망)
   
## product
- **Model**   
test에 listAgg 이용   

- **Controller**      
처음 페이지 접속 시 DTO(정보), 별점/이미지/컬러/사이즈 리스트를 가지고 이동

- **View**   
컬러/사이즈 리스트를 각각 한번씩 클릭할 경우 상품 정보가 생성(전역변수와 $(this) 비교)       
상품 정보는 [정보/수량/닫기/금액] 형식으로 생성(selector와 append 구현)      
바로 결제는 페이지 이동으로 인해 상품 정보 리스트를 form에 String 형식으로 파싱,   
장바구니는 ajax가 가능하여 배열로 파싱(회원은 cart 테이블, 비회원은 session - List<CartDTO>)   
	
- **Weakness**     
－ 상품 검색으로 받아온 prod_subcode가 잘못된 코드일 경우 이전 페이지로 되돌아가나 메세지를 띄우지않음(getHeader - referer)      
－ 처음 페이지 접속 시 일일히 List를 뿌리는 점이 비효율적으로 생각되기에   
 &nbsp; &nbsp; mapper에서 리스트 내역을 listAgg를 이용해 해당 컬럼마다 전체로 저장하여 가져온뒤    
 &nbsp; &nbsp; 1. DTO에 각 리스트 내역을 따로 List 형식으로 만들어놓고 mapper에서 가져왔을때 Arrays와 split을 통해 셋팅하여 DTO를 뿌림   
 &nbsp; &nbsp; 2. DTO에 String으로 받아놨다가 split을 통해 배열로 뿌림   
	
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
