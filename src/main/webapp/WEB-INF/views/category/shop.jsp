<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>SHOP</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
    rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="/wit/resources/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="/wit/resources/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="/wit/resources/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="/wit/resources/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="/wit/resources/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="/wit/resources/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="/wit/resources/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="/wit/resources/css/style.css" type="text/css">
</head>
<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="./index.html"><i class="fa fa-home"></i> Home</a>
                        <span>Shop</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Shop Section Begin -->
    <section class="shop spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-3">
                    <div class="shop__sidebar">
                        <div class="sidebar__categories">
                            <div class="section-title">
                                <h4>Categories</h4>
                            </div>
                            <div class="categories__accordion">
                                <div class="accordion" id="accordionExample">
	      							<c:forEach var="list" items="${category1_list }" varStatus="status">
	                                    <div class="card">
	                                        <div class="card-heading">
	                                            <a id="${list.CODE }" style="cursor:pointer;"
	                                            	data-toggle="collapse" data-target="#collapse${status.index+1 }">${list.CODE_NAME }</a>
	                                        </div>
	                                        <div id="collapse${status.index+1 }" class="collapse" data-parent="#accordionExample" data-index="${status.index+1 }">
	                                            <div class="card-body">
	                                                
	                                            </div>
	                                        </div>
	                                    </div>
									</c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="sidebar__filter">
                            <div class="section-title">
                                <h4>SHOP BY PRICE</h4>
                            </div>
                            <div class="filter-range-wrap">
                                <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                data-min="${pagePrice.MIN }" data-max="${pagePrice.MAX }"></div>
                                <div class="range-slider">
                                    <div class="price-input">
                                        <p>Price:</p>
                                        <input type="text" id="minamount">
                                        <input type="text" id="maxamount">
                                    </div>
                                </div>
                            </div>
                            <!-- Filter 버튼 제거 -->
                            <!-- <a href="#">Filter</a> -->
                        </div>
                        <div id="categorySizeDiv" class="sidebar__sizes">
                            <div class="section-title">
								<h4>SHOP BY SIZE</h4>
							</div>

							<div id="sizeList" class="size__list" data-cate1="" data-cate2="">
							
							</div>
                        </div>
                    </div>
                </div>
            	
                <!-- 상품 리스트 시작 -->
                <div class="col-lg-9 col-md-9">
                	<div class="sortNav" align="right">
		 				<input type="button" id="priceSort" value="Price" data-sort="" style="border: 0; background: white;">|
		 				<input type="button" id="viewSort" value="View" data-sort="" style="border: 0; background: white;">|
		 				<input type="button" id="starSort" value="Star" data-sort="" style="border: 0; background: white;">|
		 				<input type="button" id="reviewSort" value="ReView" data-sort="" style="border: 0; background: white;">
            		</div>
                    <div id="productDiv" class="row">
                    	
                    </div>
                </div>
                <!-- 상품 리스트 끝 -->
        	</div>
    	</div>
    </section>
    <!-- Shop Section End -->

    <!-- Instagram Begin -->
    <div class="instagram">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-2 col-md-4 col-sm-4 p-0">
                    <div class="instagram__item set-bg" data-setbg="/wit/resources/img/instagram/insta-1.jpg">
                        <div class="instagram__text">
                            <i class="fa fa-instagram"></i>
                            <a href="#">@ ashion_shop</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-4 p-0">
                    <div class="instagram__item set-bg" data-setbg="/wit/resources/img/instagram/insta-2.jpg">
                        <div class="instagram__text">
                            <i class="fa fa-instagram"></i>
                            <a href="#">@ ashion_shop</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-4 p-0">
                    <div class="instagram__item set-bg" data-setbg="/wit/resources/img/instagram/insta-3.jpg">
                        <div class="instagram__text">
                            <i class="fa fa-instagram"></i>
                            <a href="#">@ ashion_shop</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-4 p-0">
                    <div class="instagram__item set-bg" data-setbg="/wit/resources/img/instagram/insta-4.jpg">
                        <div class="instagram__text">
                            <i class="fa fa-instagram"></i>
                            <a href="#">@ ashion_shop</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-4 p-0">
                    <div class="instagram__item set-bg" data-setbg="/wit/resources/img/instagram/insta-5.jpg">
                        <div class="instagram__text">
                            <i class="fa fa-instagram"></i>
                            <a href="#">@ ashion_shop</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-4 col-sm-4 p-0">
                    <div class="instagram__item set-bg" data-setbg="/wit/resources/img/instagram/insta-6.jpg">
                        <div class="instagram__text">
                            <i class="fa fa-instagram"></i>
                            <a href="#">@ ashion_shop</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Instagram End -->

    <!-- Search Begin -->
    <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch">+</div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
    <!-- Search End -->

    <!-- Js Plugins -->
    <script src="/wit/resources/js/jquery-3.3.1.min.js"></script>
    <script src="/wit/resources/js/bootstrap.min.js"></script>
    <script src="/wit/resources/js/jquery.magnific-popup.min.js"></script>
    <script src="/wit/resources/js/jquery-ui.min.js"></script>
    <script src="/wit/resources/js/mixitup.min.js"></script>
    <script src="/wit/resources/js/jquery.countdown.min.js"></script>
    <script src="/wit/resources/js/jquery.slicknav.js"></script>
    <script src="/wit/resources/js/owl.carousel.min.js"></script>
    <script src="/wit/resources/js/jquery.nicescroll.min.js"></script>
    <script src="/wit/resources/js/main.js"></script>
    
    <script type="text/javascript">
    	var sizeArr = new Array();	//선택한 사이즈를 담아줄 배열
    	var priceChk = 0;			//금액스크롤바 마우스 이벤트

    	//정렬 버튼 초기화 함수
		function searchTypeReset() {
			$('.sortNav input').each(function(i){
	    		$(this).val($(this).val().replace("↓", "").replace("↑", ""));
	    	});
			$('.sortNav input').attr("data-sort", "");
		}

		//금액바 초기화 함수
		function pagePriceReset(cate1,cate2) {
			var param = "prod_category1=" + cate1;
			param += "&prod_category2=" + cate2;

			$.ajax({
				type: 'POST',
	        	url: "<%=cp%>/category/categoryPrice.action",
	       		data: param,
	        	async: false,
	        	success: function(args) {
		        	var rangeSlider = $(".price-range");
		        	// 슬라이더 하단 금액 재설정
	            	$('#minamount').val('￦ ' + args.MIN);
	   				$('#maxamount').val('￦ ' + args.MAX);

	   				// 슬라이더 옵션 금액 재설정
	   				rangeSlider.slider("option", "min", args.MIN);
	   				rangeSlider.slider("option", "max", args.MAX);
	   				rangeSlider.slider("option", "values", [args.MIN, args.MAX]);

					// 슬라이더 금액바 무조건 full로 출력
					rangeSlider.children("div").attr("style", "left: 0%; width: 100%;");
					rangeSlider.children("span").first().attr("style", "left: 0%;");
					rangeSlider.children("span").last().attr("style", "left: 100%;");
	            }
			});
		}

		//상품 리스트 호출 함수(정렬,페이지번호,대분류,중분류,사이즈)
		function productList(page,cate1,cate2,target) {
			var type = null;
			var sort = null;
			var url = "<%=cp%>/category/productList.action";
			//사이즈 선택이 있으면
			if(target == "sizeArr") {
				//사이즈 선택한 상태로 정렬클릭시 사이즈 그대로 유지한 채로 배열 넘김
			} else if(target) {
				if(sizeArr.indexOf("0") != -1) {		//첫 사이즈 선택시 0 제거
					sizeArr.splice(sizeArr.indexOf("0"),1);
				}
				var sizeValue = target.val();			//선택한 사이즈 값
				var sizeCheck = target.prop("checked");	//check여부 확인
				//check true
				if(sizeCheck == true) {
					sizeArr.push(sizeValue)				//체크한 값 배열에 추가
				} else {
					sizeArr.splice(sizeArr.indexOf(sizeValue),1);//체크 해제한 값은 배열에서 제거
					if(sizeArr.length == 0) {
						sizeArr.push("0");
					}
				}
			} else {
				sizeArr = new Array();
				sizeArr.push("0");
			}

			//정렬한 경우, 정렬 데이터를 받아옴
			$('.sortNav input').each(function(i){
	    		if($(this).attr("data-sort") != "") {
		    		type = $(this).attr("id");
					sort = $(this).attr("data-sort");
			    }
	    	});

			var minA = $('#minamount').val().replace("￦", "").trim();
			var maxA = $('#maxamount').val().replace("￦", "").trim();

			$.post(url,{
				searchType : type,	//상품 리스트(all/가격/조회수/리뷰/별점)
				pageNum : page,		//페이지 넘버
				category1 : cate1,	//카테고리1
				category2 : cate2,	//카테고리2
				searchSort : sort,	//정렬 타입(↑↓)
				sizeArray : sizeArr,//사이즈 배열(선택없으면 0)
				minAmount : minA,	//금액바 최소 금액
				maxAmount : maxA,	//금액바 최대 금액
				},function(args){
				$('#productDiv').html(args);
			});

			$('#sizeList').attr("data-cate1", cate1);
			$('#sizeList').attr("data-cate2", cate2);
				      
			$('#productDiv').show();
		}
	
		//DOM 트리를 생성한 후
		$(document).ready(function () {

			//카테고리 항목 클릭 시 정렬 설정 초기화 및 카테고리 리스트 호출
			$('.card-heading').click(function(){
				searchTypeReset();    

				var url = "<%=cp%>/category/category2.action";
				var id = $(this).children().attr("id");   
				var card = $(this).parent();
				var code_form = card.find('.collapse').attr("data-index");

				// 금액바 초기화
				pagePriceReset(id, '');
				
				// 해당 카테고리 상품 리스트 호출
				productList('1',id,'');	

				// 중분류 리스트 호출(첫 페이지 category2 클릭이 리스트 생성전에 진행되어 동기식 진행)
				$.ajax({
					type: 'POST',
		        	url: url,
		       		data: {code_form : code_form},
		        	async: false,
		        	success: function(args) {
		        		card.find('.card-body').html(args);
		            }
				});

				// 상품별 다른 사이즈 호출
				url = "<%=cp%>/category/categorySize.action";
				$.post(url,{category1 : code_form},function(args){
					$('#sizeList').html(args);
				});

				$('#sizeList').find('input').prop("checked", false); //체크박스 초기화
			});

			// 카테고리 중분류 클릭 시 
			$('.card-body').on('click','a',function(){
				searchTypeReset();
				
				var category1 = $(this).closest('.card').children('.card-heading').children().attr("id");
				var category2 = $(this).attr("id");

				// 선택한 중분류에만 색 구분 추가(초기화 -> 색 구분 추가)
				$(this).closest("ul").find("a").css({"color":"", "font-weight":""});
				$(this).css({"color":"black", "font-weight":"500"});

				// 금액바 초기화
				pagePriceReset(category1,category2);

				// 해당 카테고리 상품 리스트 호출
				productList('1',category1,category2);
				
				$('#sizeList').find('input').prop("checked", false); //체크박스 초기화
			});

			//정렬 버튼 클릭 이벤트
			$('.sortNav input').click(function(){			
				var pageNum = $('#pageNum').val(); 							//페이지 넘버
				var category1 = $('#sizeList').attr("data-cate1"); 			//카테고리1
				var category2 = $('#sizeList').attr("data-cate2"); 			//카테고리2
				var sort = $(this).attr("data-sort"); 						//버튼의 정렬값	

				searchTypeReset();											//정렬 버튼 초기화
				
				//data-sort에 따라 정렬 방식 전환
				if (sort != "0") {											//처음 클릭 시 무조건 ↓				
					$(this).val($(this).val()+"↓"); 						//조건에 input에 ↓,↑ 표시
					$(this).attr("data-sort", 0);
				}else { 								
					$(this).val($(this).val()+"↑");
					$(this).attr("data-sort", 1);
				}      

				if(sizeArr.indexOf("0") != -1) {							// 사이즈 미선택시
					productList(pageNum,category1,category2); 
				} else {													// 사이즈가 선택되어있을시
					productList(pageNum,category1,category2,"sizeArr"); 	// 그대로 배열 넘김
				}  
			});

			// 사이즈 체크박스 선택 시
			$('#sizeList').on('click','input',function(){
				var category1 = $('#sizeList').attr("data-cate1");
				var category2 = $('#sizeList').attr("data-cate2");
				var pageNum = $('#pageNum').val(); 		//페이지 넘버

				productList('1',category1,category2,$(this));        
			});

			// 금액 스크롤바 마우스 클릭 시
			$('.price-range span').mousedown(function(){
				priceChk = 1;
			});

			// 금액 스크롤바 마우스 클릭 끝났을 시
			$('html').mouseup(function(){
				if(priceChk == 1) {
					var category1 = $('#sizeList').attr("data-cate1"); 			//카테고리1
					var category2 = $('#sizeList').attr("data-cate2"); 			//카테고리2
					productList('1',category1,category2,"sizeArr"); 
					priceChk = 0;
				}
			});

			// 찜하기 버튼 클릭 시
			$('html').on('click','.heart_alt',function(){
				// 로그인 시에만 등록되도록 설정
				if('${customInfo}') {
					var url = "<%=cp%>/myPage/heartInsert.action";
					var prod_subcode = $(this).closest("ul").attr("id");

					$.post(url,{prod_subcode:prod_subcode},function(args){
						if(args == "true") {				// boolean으로 받을시 args만 써도되나 over의 경우로 인해 String으로 받음
							alert("찜 목록에 등록되었습니다!");
						} else if(args == "over") {
							alert("찜 목록은 30개까지만 가능합니다!");
						} else {
							alert("이미 찜 목록에 존재하는 상품이 있습니다!");
						}

						$(".header").load(location.href + " .header");
						$(".header").removeClass("header");
					});
				// 비회원은 로그인 창으로 이동
				} else {
					window.location.href = "<%=cp%>/custom/login";
				}
			});	
		});
		
		//모든 게 로드된 후
		$(window).on('load',function(){
			$('#${category1}').trigger("click");
			$('#${category2}').trigger("click");
		});
		
	</script>
</body>

</html>