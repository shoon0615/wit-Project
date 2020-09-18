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
    <title>Login</title>

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

	// login 로직 처리
	function fn_check_login(){

		var id = $("#id").val();
		var pwd = $("#pwd").val();

		$.ajax({
			type : "post",
			url : "<%=cp%>/custom/check_login",
			dataType : "text",
			data : {user_id:id , user_pwd:pwd},
			success : function(data){
				if(data == "true"){//해당 id,pwd로 계정이 있으면 
					document.custom_login.action = "<%=cp %>/main/main";	//controller에서 requesetmapping -> post로도 되어있어야 함!
					document.custom_login.submit();
				}else{//해당 id,pwd로 계정이 없으면
					$("#login_result").text("가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.");
					$("#login_result").css('color','red');
				}
			},
			error : function(data){
				alert("Ajax error");
			}
		});

	}

	// 두 번 이상 로그인 시도하는 경우 Ajax로 확인된 메세지 지워주기
	function fn_click_id(){
		$("#id").val("");
		$("#login_result").text("");		
	}

	// 두 번 이상 로그인 시도하는 경우 Ajax로 확인된 메세지 지워주기
	function fn_click_pwd(){
		$("#pwd").val("");
		$("#login_result").text("");		
	}

</script>

<body>
    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="<%=cp %>/custom/main"><i class="fa fa-home"></i> Home</a>
                        <span>Login</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Checkout Section Begin -->
    <section class="checkout spad">
        <div class="container">
            <div class="row" style="padding-left: 25%;">
                <div class="col-lg-8">
                    <h6 class="coupon__link"><span class="icon_tag_alt"></span> Please enter your account information</h6>
                </div>
            </div>
            <form name="custom_login" action="" class="checkout__form" method="post">
                <div class="row" style="padding-left: 25%;">
                    <div class="col-lg-8">
                        <h5>Login</h5>
                        <div class="row">                         
                            <div class="col-lg-12">
                            	<div class="checkout__form__input">
                                    <p>ID</p>
                                    <input type="text" name="user_id" id="id" style="margin-bottom: 10px;" placeholder="Enter your ID" onclick="fn_click_id()">                                                                       
                                </div>
                            	<div class="checkout__form__input mt20">
                                    <p>Password</p>
                                    <input type="password" name="user_pwd" id="pwd" style="margin-bottom: 10px;" placeholder="Enter your password" onclick="fn_click_pwd()">                                    
                                </div>
                                <div class="checkout__form__input mt20">                                                                        
                                    <span id="login_result" style="font-size: 15px;"></span>                                   
                                </div>
                                <div class="checkout__form__checkbox mt20">
                                	<p><label onclick="javascript:location.href='<%=cp %>/custom/find_account';" style="padding-left: 0px;color: red;text-align: right;"><i class="icofont-question-circle"></i>Forgot ID or Password ?</label></p>
                                </div>
                                <div class="checkout__form__checkbox mt20">
                                	<p><label onclick="javascript:location.href='<%=cp %>/custom/join';" style="padding-left: 0px;color: red;text-align: right;"><i class="icofont-question-circle"></i>Would you like to join ?</label></p>
                                </div>                                                                                             
                            </div>                                                                                                        
                            <div class="mt20" style="padding-left: 33%;">
                            	<button type="button" class="site-btn" style="font-size: 18px;" onclick="fn_check_login()">
                            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Login&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            	</button>
                            </div>
                            <div class="mt20" style="padding-left: 31%;">
                            	<a href="https://kauth.kakao.com/oauth/authorize?client_id=46a7983f1090447e062943a08473a49f&redirect_uri=http://localhost:8081/wit/custom/kakaoLogin&response_type=code">
                            		<img src="<%=cp %>/resources/kakao/kakao_login_btn1.png" align="middle">
                            	</a>
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