<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();  %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Find Account</title>

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

<style>

.mt20 {
	margin-top: 20px;
}

</style>

<script type="text/javascript">

	// id찾기 로직 처리
	function fn_find_id(){

		var name = $("#name").val();
		var email = $("#email1").val();
	
		$.ajax({
			type : "post",
			url : "<%=cp%>/custom/find_id",
			dataType : "text",
			data : {user_name:name , user_email:email},
			success : function(data){
				if(data == "true"){//해당 name,email로 계정이 있으면 
					$("#id_result").text("이메일로 아이디를 전송했습니다. 입력하신 이메일을 확인해주세요.");
					$("#id_result").css('color','green');
				}else{//해당 name,email로 계정이 없으면
					$("#id_result").text("계정에 존재하지 않는 이름이거나, 잘못된 이메일입니다.");
					$("#id_result").css('color','red');
				}
			},
			error : function(data){
				alert("Ajax error");
			}
		});

	}

	// password 찾기 로직 처리
	function fn_find_pwd(){

		var id = $("#id").val();
		var email = $("#email2").val();

		$.ajax({
			type : "post",
			url : "<%=cp%>/custom/find_pwd",
			dataType : "text",
			data : {user_id:id , user_email:email},
			success : function(data){
				if(data == "true"){//해당 id,email로 계정이 있으면 
					$("#pwd_result").text("이메일로 임시 비밀번호를 전송했습니다. 입력하신 이메일을 확인해주세요.");
					$("#pwd_result").css('color','green');
				}else{//해당 id,email로 계정이 없으면
					$("#pwd_result").text("가입하지 않은 아이디이거나, 잘못된 이메일입니다.");
					$("#pwd_result").css('color','red');
				}
			},
			error : function(data){
				alert("Ajax error");
			}
		});

	}

	// 두 번 이상 아이디 찾기 시도하는 경우 Ajax로 확인된 메세지 지워주기
	function fn_click_name(){
		$("#name").val("");
		$("#id_result").text("");		
	}

	// 두 번 이상 아이디 찾기 시도하는 경우 Ajax로 확인된 메세지 지워주기
	function fn_click_email1(){
		$("#email1").val("");
		$("#id_result").text("");		
	}

	// 두 번 이상 비밀번호 찾기 시도하는 경우 Ajax로 확인된 메세지 지워주기
	function fn_click_id(){
		$("#id").val("");
		$("#pwd_result").text("");		
	}

	// 두 번 이상 비밀번호 찾기 시도하는 경우 Ajax로 확인된 메세지 지워주기
	function fn_click_email2(){
		$("#email2").val("");
		$("#pwd_result").text("");		
	}

</script>

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
            <a href="<%=cp %>/custom/main"><img src="/wit/resources/img/logo.png" alt=""></a>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__auth">
            <a href="<%=cp %>/custom/login">Login</a>
            <a href="<%=cp %>/custom/join">Register</a>
        </div>
    </div>
    <!-- Offcanvas Menu End -->

    <!-- Header Section Begin -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-2">
                    <div class="header__logo">
                        <a href="<%=cp %>/custom/main"><img src="/wit/resources/img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
                        <ul>
                            <li><a href="<%=cp %>/custom/main">Home</a></li>
                            <li><a href="#">Women's</a></li>
                            <li><a href="#">Men's</a></li>
                            <li class="active"><a href="./shop.html">Shop</a></li>
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
                            <a href="<%=cp %>/custom/login">Login</a>
                            <a href="<%=cp %>/custom/join">Register</a>
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
                        <a href="<%=cp %>/custom/main"><i class="fa fa-home"></i> Home</a>
                        <span>Find Account</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h6 class="coupon__link"><span class="icon_tag_alt"></span> Please enter your information</h6>
                </div>
            </div>
            <form name="custom_findAccount" action="" class="checkout__form" method="post">
            <div class="row">
                    <div class="col-lg-6">
                        <h5>Find ID</h5>
                        <div class="row">                         
                            <div class="col-lg-12">
                            	<div class="checkout__form__input">
                                    <p>Name</p>
                                    <input type="text" name="user_name" id="name" style="margin-bottom: 10px;" placeholder="Enter your name" onclick="fn_click_name()">                                                                       
                                </div>
                            	<div class="checkout__form__input mt20">
                                    <p>Email</p>
                                    <input type="text" name="user_email" id="email1" style="margin-bottom: 10px;" placeholder="Enter your email" onclick="fn_click_email1()">                                    
                                </div>
                                <div class="checkout__form__input mt20">                                                                        
                                    <span id="id_result" style="font-size: 15px;"></span>                                   
                                </div>                                                                                                                            
                            </div>                                                                                                        
                            <div class="mt20" style="padding-left: 30%;">
                            	<button type="button" class="site-btn" style="font-size: 18px;" onclick="fn_find_id()">
                            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Find ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            	</button>
                            </div>                                                                        
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <h5>Find Password</h5>
                        <div class="row">                         
                            <div class="col-lg-12">
                            	<div class="checkout__form__input">
                                    <p>ID</p>
                                    <input type="text" name="user_id" id="id" style="margin-bottom: 10px;" placeholder="Enter your ID" onclick="fn_click_id()">                                                                       
                                </div>
                            	<div class="checkout__form__input mt20">
                                    <p>Email</p>
                                    <input type="text" name="user_email" id="email2" style="margin-bottom: 10px;" placeholder="Enter your email" onclick="fn_click_email2()">                                    
                                </div>
                                <div class="checkout__form__input mt20">                                                                        
                                    <span id="pwd_result" style="font-size: 15px;"></span>                                   
                                </div>                                                                                             
                            </div>                                                                                                        
                            <div class="mt20" style="padding-left: 25%;">
                            	<button type="button" class="site-btn" style="font-size: 18px;" onclick="fn_find_pwd()">
                            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Find Password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            	</button>
                            </div>                                                                        
                        </div>
                    </div>    
            </div>
            </form>
        </div>
    </section>
    <!-- Checkout Section End -->

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
                                <a href="<%=cp %>/custom/main"><img src="/wit/resources/img/logo.png" alt=""></a>
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
        <!-- 다음 주소 API -->
        <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    </body>

    </html>