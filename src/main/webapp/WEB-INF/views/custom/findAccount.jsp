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
    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="<%=cp %>/main/main"><i class="fa fa-home"></i> Home</a>
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