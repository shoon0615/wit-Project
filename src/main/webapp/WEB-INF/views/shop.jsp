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

    <!-- Offcanvas Menu Begin -->
    <div class="offcanvas-menu-overlay"></div>
    <div class="offcanvas-menu-wrapper">
        <div class="offcanvas__close">+</div>
        <ul class="offcanvas__widget">
            <li><span class="icon_search search-switch"></span></li>
            <li><a href="#"><span class="icon_heart_alt"></span>
                <div class="tip">2</div>
            </a></li>
            <li><a href="#"><span class="icon_bag_alt"></span>
                <div class="tip">2</div>
            </a></li>
        </ul>
        <div class="offcanvas__logo">
            <a href="./index.html"><img src="/wit/resources/img/logo.png" alt=""></a>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__auth">
            <a href="#">Login</a>
            <a href="#">Register</a>
        </div>
    </div>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-2">
                    <div class="header__logo">
                        <a href="./index.html"><img src="/wit/resources/img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
                        <ul>
                            <li><a href="main.action">Home</a></li>
                            <li><a href="#">Women's</a></li>
                            <li><a href="#">Men's</a></li>
                            <li class="active"><a href="shop.action">Shop</a></li>
                            <li><a href="#">Pages</a>
                                <ul class="dropdown">
                                    <li><a href="./product-details.html">Product Details</a></li>
                                    <li><a href="./shop-cart.html">Shop Cart</a></li>
                                    <li><a href="./checkout.html">Checkout</a></li>
                                    <li><a href="./blog-details.html">Blog Details</a></li>
                                </ul>
                            </li>
                            <li><a href="./blog.html">Blog</a></li>
                            <li><a href="./contact.html">Contact</a></li>
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3">
                    <div class="header__right">
                        <div class="header__right__auth">
                            <a href="#">Login</a>
                            <a href="#">Register</a>
                        </div>
                        <ul class="header__right__widget">
                            <li><span class="icon_search search-switch"></span></li>
                            <li><a href="#"><span class="icon_heart_alt"></span>
                                <div class="tip">2</div>
                            </a></li>
                            <li><a href="#"><span class="icon_bag_alt"></span>
                                <div class="tip">2</div>
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="canvas__open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
    <!-- Header Section End -->

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
                                <h4>카테고리</h4>
                            </div>
                            <div class="categories__accordion">
                                <div class="accordion" id="accordionExample">
                                    <div class="card">
                                        <div class="card-heading active">
                                            <a style="cursor:pointer" onclick="productList('all','1','TOP','');categorySize('TOP');" data-toggle="collapse" data-target="#collapseOne">상의</a>
                                        </div>
                                        <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <ul>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','TOP','SLV')">나시</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','TOP','TSHT')">티셔츠</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','TOP','MTM')">맨투맨</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','TOP','BLS')">블라우스</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','TOP','SHT')">셔츠</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','TOP','TRN')">트레이닝</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','TOP','OUT')">아우터</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-heading">
                                            <a style="cursor:pointer" onclick="productList('all','1','BOTTOM','');categorySize('BOTTOM');" data-toggle="collapse" data-target="#collapseTwo">하의</a>
                                        </div>
                                        <div id="collapseTwo" class="collapse" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <ul>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','BOTTOM','SHORT')">반바지</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','BOTTOM','SLX')">슬렉스</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','BOTTOM','DNM')">청바지</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','BOTTOM','CTN')">코튼</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','BOTTOM','TRN')">트레이닝</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','BOTTOM','SKT')">치마</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-heading">
                                            <a style="cursor:pointer" onclick="productList('all','1','SHOES','');categorySize('SHOES');" data-toggle="collapse" data-target="#collapseThree">신발</a>
                                        </div>
                                        <div id="collapseThree" class="collapse" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <ul>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','SHOES','RUN')">운동화</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','SHOES','SDL')">샌들</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','SHOES','SLP')">슬리퍼</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','SHOES','SNK')">스니커즈</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','SHOES','HYL')">구두</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','SHOES','RW')">로퍼/워커</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-heading">
                                            <a style="cursor:pointer" onclick="productList('all','1','OPS','');categorySize('OPS');" data-toggle="collapse" data-target="#collapseFour">원피스</a>
                                        </div>
                                        <div id="collapseFour" class="collapse" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <ul>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','OPS','OPS')">원피스</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card">
                                        <div class="card-heading">
                                            <a style="cursor:pointer" onclick="productList('all','1','ACC','');categorySize('ACC');" data-toggle="collapse" data-target="#collapseFive">ACC</a>
                                        </div>
                                        <div id="collapseFive" class="collapse" data-parent="#accordionExample">
                                            <div class="card-body">
                                                <ul>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','ACC','BAG')" >가방</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','ACC','NCL')" >목걸이</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','ACC','RING')" >반지</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','ACC','EAR')" >귀걸이</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','ACC','CAP')" >모자</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','ACC','WLT')" >지갑</a></li>
                                                    <li><a style="cursor:pointer" onclick="productList('all','1','ACC','WAT')" >시계</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="sidebar__filter">
                            <div class="section-title">
                                <h4>가격</h4>
                            </div>
                            <div class="filter-range-wrap">
                                <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                data-min="33" data-max="99"></div>
                                <div class="range-slider">
                                    <div class="price-input">
                                        <p>Price:</p>
                                        <input type="text" id="minamount">
                                        <input type="text" id="maxamount">
                                    </div>
                                </div>
                            </div>
                            <a href="#">Filter</a>
                        </div>
                        <div id="categorySizeDiv" class="sidebar__sizes">
                            
                            
                        </div>
                    </div>
                </div>
            	
                <!-- 상품 리스트 시작 -->
                <div class="col-lg-9 col-md-9">
                	<div id="sortNav" align="right">
		 				<input type="button" id="priceSort" value="가격" style="border: 0; background: white;">|
		 				<input type="button" id="viewSort" value="조회수" style="border: 0; background: white;">|
		 				<input type="button" id="starSort" value="별점" style="border: 0; background: white;">|
		 				<input type="button" id="reviewSort" value="리뷰" style="border: 0; background: white;">
            		</div>
                    <div id="productDiv" class="row">
                    	
                    </div>
                </div>
                <!-- 상품 리스트 끝 -->
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

    <!-- Footer Section Begin -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-7">
                    <div class="footer__about">
                        <div class="footer__logo">
                            <a href="./index.html"><img src="/wit/resources/img/logo.png" alt=""></a>
                        </div>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
                        cilisis.</p>
                        <div class="footer__payment">
                            <a href="#"><img src="/wit/resources/img/payment/payment-1.png" alt=""></a>
                            <a href="#"><img src="/wit/resources/img/payment/payment-2.png" alt=""></a>
                            <a href="#"><img src="/wit/resources/img/payment/payment-3.png" alt=""></a>
                            <a href="#"><img src="/wit/resources/img/payment/payment-4.png" alt=""></a>
                            <a href="#"><img src="/wit/resources/img/payment/payment-5.png" alt=""></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-5">
                    <div class="footer__widget">
                        <h6>Quick links</h6>
                        <ul>
                            <li><a href="#">About</a></li>
                            <li><a href="#">Blogs</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">FAQ</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-2 col-md-3 col-sm-4">
                    <div class="footer__widget">
                        <h6>Account</h6>
                        <ul>
                            <li><a href="#">My Account</a></li>
                            <li><a href="#">Orders Tracking</a></li>
                            <li><a href="#">Checkout</a></li>
                            <li><a href="#">Wishlist</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-8 col-sm-8">
                    <div class="footer__newslatter">
                        <h6>NEWSLETTER</h6>
                        <form action="#">
                            <input type="text" placeholder="Email">
                            <button type="submit" class="site-btn">Subscribe</button>
                        </form>
                        <div class="footer__social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-youtube-play"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                            <a href="#"><i class="fa fa-pinterest"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    <div class="footer__copyright__text">
                        <p>Copyright &copy; <script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a></p>
                    </div>
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->

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
    var sizeArr = new Array();//선택한 사이즈를 담아줄 배열
    var pageNum = $("#pageNum").val(); //페이지 넘버
	
    //정렬 버튼 클릭 이벤트
	$('#sortNav input').click(function(){
		var id = $(this).attr('id'); //버튼의 아이디
		var value = $(this).val(); //버튼의 값
		var category1 = $("#category1").val(); //카테고리1
		var category2 = $("#category2").val(); //카테고리2
		//↑,↓에 따라 정렬 방식 전환
		if (value.indexOf("↓") != -1) {
			searchTypeRest(); //전체 버튼 초기화
			value = $(this).val(); //버튼의 값 초기화
			productList(value+"↑",pageNum,category1,category2); //Ajax요청 보냄(value,pageNum)
			$(this).val(value+"↑"); //조건에 input에 ↑,↓ 표시
			return;
		}else { //처음 클릭 시 무조건 ↓
			searchTypeRest();
			value = $(this).val();
			productList(value+"↓",pageNum,category1,category2);
			$(this).val(value+"↓");
			return;
		}
	                      
	});
	
	//카테고리 항목 클릭 시 정렬 설정 초기화
	$('.card').click(function(){
		searchTypeRest();          
	});
	//전체 버튼 초기화
	function searchTypeRest() {
		$("#priceSort").val('가격');
		$("#viewSort").val('조회수');
		$("#starSort").val('별점');
		$("#reviewSort").val('리뷰');
	}

	//DOM 트리를 생성한 후
	$(document).ready(function () {
		productList('all','1','TOP','','');
		categorySize('TOP');
	});
	
	//모든 게 로드된 후
	$(window).on('load',function(){
		
	});
	
	//상품 리스트 호출 함수(정렬,페이지번호,대분류,중분류,사이즈)
	function productList(type,page,cate1,cate2,target) {
	var url = "<%=cp%>/category/productList.action";
	//사이즈 선택이 있으면
	if(target){
		sizeArr.splice(sizeArr.indexOf("0"),1);
		var sizeValue = target.value;//선택한 사이즈 값
		var sizeCheck = target.checked;//check여부 확인
		//check true
		if(sizeCheck == true){
			sizeArr.push(sizeValue)//체크한 값 배열에 추가
		}else{
			sizeArr.splice(sizeArr.indexOf(sizeValue),1);//체크 해제한 값은 배열에서 제거
		}
	}else{
		sizeArr.push("0");
	}
	
	$.post(url,{
		searchType : type,
		pageNum : page,
		category1 : cate1,
		category2 : cate2,
		sizeArray : sizeArr},function(args){
		$("#productDiv").html(args);
	});
		      
	$("#productDiv").show();
	}

	//상품별 다른 사이즈 호출 함수
	function categorySize(cate1) {
	var url = "<%=cp%>/category/categorySize.action";
	
	$.post(url,{
		category1 : cate1},function(args){
		$("#categorySizeDiv").html(args);
	});
		      
	$("#categorySizeDiv").show();
	}
	</script>
</body>

</html>