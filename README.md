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
  - [review](#review)
- [Tip](#Tip)
  - [Spring](#Spring)
  - [Git](#Git)
  - [Tiles](#Tiles)
    
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
   
___
**OS** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Windows 10   
**DBMS** &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; : &nbsp; Oracle 11g   
**SERVER** &nbsp; &nbsp; &nbsp; : &nbsp; Tomcat 8.5   
**IDE** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; : &nbsp; Spring 4   
**CONTROL** &nbsp; : &nbsp; Java   
**VIEW** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Jsp(Jstl, J-Query), Css   
**VCS** &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; Git   
___   
       
## cart
- **Model**   
   

- **Controller**      
로그인 시 cart 테이블, 비회원 시 session - List<CartDTO>의 정보 추출   
total_amount는 컨트롤러에서 계산 후 뿌려줌   
Option 변경 역시 로그인 시 cart 테이블, 비회원 시 session - List<CartDTO> 직접 수정   
기존 코드의 옵션 변경 이후 기존 코드를 삭제하는 방식   

- **View**   
전체적인 부분을 cartDetail에 저장 및 호출하는 방식(startCart 함수 이용)   
iframe - src를 통해 Option 변경 가능하며, 이후 창은 hide 함수를 통해 숨김 처리   
수량 및 Option 변경 시 데이터에 직접적으로 변동을 주고 ajax를 통해 화면을 다시 호출(iframe - top)      

- **Weakness**   
－ updateCart에서 hashMap 대신에 DTO로 이용, user_id는 View에서 seesionScope.user_id로 DTO에 전송   
－ updateCart에 cartPriceValue 대신 cartAmountValue 전송(qtyprice -> price 가능)   
－ 컨트롤러에서 select_prod_code 선언받아놓은뒤 mapper에선 모두 하위쿼리로 다시 받아옴      
－ Continue Shopping 버튼(referer) 및 Discount Code 받는 등의 기능 미구현   
 
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
－ 상품 상태 라벨 미구현(New, Out Of Stock, Sale, Best)   
－ 장바구니 버튼 미구현   
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
header에서 필요한 DB 정보는 tiles - preparer를 통해 가져옴   

- **View**   
weather API를 통해 ajax로 날씨 정보를 받아 그 중 필요한 정보만 추출      
   
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
```    
－ footer에 하단 상품 및 instagram 추가   
   
## mypage
- **Model**   
row_number() 및 self-join 이용   
heart에 insert_before trigger 이용(개수 30개 제한)      

- **Controller**      
session이 존재할 경우에만 페이지 이동      
Heart에 찜 등록 시 true(성공), over(trigger 에러), fail(같은 상품 외 기타) 중 return   

- **View**     
tabs에 각 페이지가 저장돼있으며 myPage를 특정 페이지로 불러올경우 choice 변수 필요<br>      
Order는 cart의 디자인을 카피해왔으며 style은 맨 처음 head를 통해 수정   
 &nbsp; OrderCode로 통합하여 조회(첫번째 상품만 rowspan 적용)   
ReviewWrite는 name이 같은 경우 List에 추가가 되는 것을 이용해 List<File>로 데이터를 받아오도록 적용   
 &nbsp; type=file은 초기화 외 직접 변경이 불가하여 hidden으로 file을 append하고, 파일 개수는 배열로 판단   
 &nbsp; 페이지가 새로 여는것이 아닌 Review 페이지에 ajax로 호출(Review 클릭시 기존 페이지로 초기화)   
Heart는 체크박스 대신 label을 통한 디자인   
   
- **Weakness**   
－ Order에 주문 총액, 상세 정보(+결제 정보) 등의 디테일한 정보 부족   
－ Order에 기간 및 상품 검색 기능(+금액) 부족   
－ Review에 Show Detail(...more, 이미지) 기능 미구현   
－ Heart에 찜 등록되며 head 초기화 시 깜빡이는 현상(header 추가로 인해 발생)      
－ 모든 페이지에 더 보기(무한스크롤) 기능 미구현   

   
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
 
## review
- **Model**   
delete를 report - count로 체크하여 삭제

- **Controller**      
product의 부분적 기능 중 하나라 product 컨트롤러에 포함   

- **View**   
onclick을 통해 불러오는 sendReview 함수의 매개변수로 리뷰 리스트를 ajax로 가져오는 방식   
..more 클릭 시 review의 이미지 활성화   
신고 시 PK로 인해 발생하는 ajax - error로 확인하는 방식   

- **Weakness**     
－ hashMap 대신에 DTO로 이용   
－ 비회원 체형별 정렬 조회 미구현   
－ 신고 옆 화살표 아이콘 기능 미구현   

     
## Tip   
### Spring
- **컨테이너 방식(bean 객체)**   
web.xml의 DispatcherServlet을 통한 root, servlet-context.xml 사용 설정   
mapping - url 경로를 참조하며, @RequestMapping을 통해 자동 인식       
servlet-context.xml는 Controller, View 관련 설정 및 일반적인 기능   
root-context.xml는 Model 관련 설정   

- **Ioc(제어 역행)**   
기본적으로 Bean을 미리 xml에 선언 후 사용 가능하나 @어노테이션을 통해 객체에서 Bean을 생성   
@AutoWired : 자동으로 class와 일치하는 컨테이너의 bean 객체를 주입   
@Controller : 웹 요청 class에 사용   
@Repository : DAO 등의 DB 컨트롤러 관련 class에 사용   
@Service &nbsp; &nbsp; &nbsp; : 비즈니스 로직에 사용   
@Component : 그 외 기본적인 등록등에 사용(ex: util)<br>      
@AutoWired를 제외한 나머지는 모두 Bean 등록 기능으로 동일하나 가독성 및 향후 변화로 인해 구분하는 것을 권장   
   
- **DI(의존성 주입)**   
자신이 아닌 외부의 객체로부터 데이터를 받아와 주입하는 방식   
Servlet 방식 및 어노테이션, 선언된 데이터를 받아오는 경우가 이에 해당   

- **AOP(관점지향)**   
가독성 및 공통적 업무 처리를 위해 분리하여 별도 관리(인터페이스, DAO ...)   
POJO 방식으로 단일 책임 원칙을 유지(하나의 객체에선 하나의 기능만을 수행)   

- **트랜잭션**      
DB의 상태가 변화되는 여러 작업   
트랜잭션 처리가 안돼있다면 제한되며, 하나라도 실패할 경우 모두 롤백(commit, rollback) 

- **MVC 구조**   
Model &nbsp; &nbsp; &nbsp; : DB(Oracle, SQL)      
Controller : 웹/DB연결(Java)   
View &nbsp; &nbsp; &nbsp; &nbsp; : 웹 페이지(html, css, js, jsp)   

### Git
- **구조**   
프로젝트 - Commit - local의 .git 저장소에 업로드 - Push - github로 데이터 업로드   
Team - Pull or Merge를 통해 github로부터 데이터 수신   

- **프로젝트 생성**   
github.com 페이지에서 New 를 통해 새 Repository 생성(이름만 설정 후 Create)   
현재 진행하는 프로젝트 우클릭 - Team - Share Project - Create Repository(체크박스 체크) - Finish   
작업 진행시 숨김 폴더로 .git 폴더가 자동으로 생성되며 git의 관리하에 들어감(=git init)   
이하 모든 작업은 우클릭 - Team에서 진행<br>      
  - **master**   
  commit 작업 후 Git Staging에서 확인되면 Push 진행   
  이후 Switch To - New Branch를 통해 클라이언트 브랜치 생성 - Commit and Push(모두 마쳐야 브랜치 생성)   
  github.com 페이지에서 Code 복사한뒤 Settings - Manage access - invite a collabolator를 통해 클라이언트 초대<br>      
  master는 클라이언트가 작업 올린 경우 Merge 작업을 통해 프로젝트 통합   
  - **클라이언트**   
  github.com 페이지에서 자신의 Branch로 설정 및 Code 복사한뒤   
  import - Git - Projects from Git - Clone URI - github ID,PW 입력 - 자신의 Branch만 체크 - 모두 Next - Finish<br>   
  이후 작업한 내용이 생길때마다 Git Staging에서 ++버튼 클릭 후 Commit and Push   
  
- **Git 기능**   
  - **Commit**   
  local의 git 저장소에 업로드(.git)   
  - **Stashes**   
  책갈피 설정   
  - **Push to origin**   
  전체 Branch를 Push(commit이 돼있어야함)   
  - **Fetch from origin**   
  github에서 아직 받지않은 업데이트 내역 확인   
  - **Pull**   
  현재 또는 선택한 Branch에 github로부터 데이터를 불러와 덮어씌움   
  master는 Switch To를 통해 Branch 변경 후 Pull 받으면 local의 Branch도 github와 똑같이 업데이트   
  클라이언트는 Fetch from - Next - master - Add Spec - Finish 이후   
  Pull... - Reference - 스페이스바 - master - Finish 하면 master 데이터를 그대로 덮어씀   
  - **Remote(Fetch from)**   
  다른 Branch로 정보 설정(1회성)   
  - **Switch To**   
  현재 Branch를 다른 Branch로 변경(Branch=사용자로 봐도 무방)      
  - **Merge**   
  다른 Branch의 데이터와 현재 Branch의 데이터를 통합(보통은 master에서 진행)   
  단, non-fast-forward 발생한 경우는 변경된 데이터 내역이 있어 발생   
  reset을 통해 현재 버전으로 재실행 또는 commit으로 변경 내역을 지워주면 해결<br>      
  추가/변동/생성된 파일들을 자동으로 적용하여 통합   
  같은 라인에 수정된 내용 있을 시 충돌 발생하며, Merge tool 또는 직접 수정 후 ctrl+s(저장)으로 해결   
  한 번 Merge된 이후 변동이 없다면 계속 Merge에 포함되지않기때문에 주의 요망   
  예시) A=1, B=2 에서 B=3 을 통합 시 B=2로 Merge하면 이후 해당 Branch의 B=3인 경우는 체크하지않음   
  - **Merge Tool**   
  Merge 통합 시 충돌된 작업에 대해 편의성을 가진 도구   
  Git Staging에서 문제발생한 파일 더블 클릭 시 자동 실행   
  Two-Way Compare - Copy All Non-Conflicting 진행 시 Merge로 전달받은 내용으로 모두 덮어써짐   
  그 외 충돌된 부분 확인이나 Drag&Drop 등 가독성에서도 편의성을 제공   
  - **Rebase**   
  history 라인을 하나로 재배치   
  - **Reset**   
  선택한 Commit 시점으로 롤백   
  일반적으로 hard 선택으로 돌아가며 해당 시점으로 프로젝트를 모두 되돌리나, 돌아간 시점 이후의 시점 및 데이터 모두 삭제   
  - **Revert**   
  현재 시점을 백업해두고 해당 시점으로 프로젝트를 모두 되돌리나, 충돌 부분이 있을 경우 실패함    
  - **Add to Index**   
  Commit 이전 준비 설정(스프링 4 버전 이상에는 필요없음)   
  - **Ignore**   
  설정한 파일/폴더는 Push 해도 github로 전송되지않음(대체적으로 보안 관련)   
  - **Show in History**   
  Git에서 작업한 commit 시점 및 메세지 확인   
  - **Git staging**   
  프로젝트에서 변경이 일어나 git과 달라진 변경 내역 확인(하나라도 존재 시 Pull or Merge 불가)   
  Windows - Show View - Git에 존재   
  
### Tiles
- **설정**   
pom.xml에 tiles 관련 라이브러리 추가 후 root or servlet-context.xml에 tiles.xml 경로 및 우선순위 설정   
tiles.xml에 경로 definition 설정 / 기준 layout.jsp 설정 / header, body, footer 등 파트 분배   
body의 경로는 동적으로 설정(/{1}/{2}.jsp)   
기준 layout.jsp에선 <tiles:insertAttribute>를 통해 각 파트의 내용을 전달<br>      
header, footer 등의 body 외 파트에서 attribute가 필요한 경우 preparer 설정   
context.xml에 preparerFactoryClass 추가 후 tiles.xml에도 preparer 추가   
이후 preparer 넘겨줄 java를 Util에 생성(ViewPreparer로 인터페이스 받고 execute 오버라이딩 고정)   
@어노테이션("명칭")으로 되어있어야 preparer에서 java 호출이 가능   
java에서 attributeContext.putAttribute("명칭", new Attribute(보낼값), true) 작업을 통해 데이터 뿌려줌   
필요한 jsp에서 /<tiles:importAttribute> 선언 후 호출 가능   

> 여기는 인용문입니다.
```
public class helloWorld {
	public static void main(String[] args) {
		System.out.println("Hello World!");
	} 
}
```
