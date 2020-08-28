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
    <title>Join</title>

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

	<!-- jQuery -->
	<script src="/wit/resources/js/jquery-3.1.1.js"></script>

<style>

.mt20 {
	margin-top: 20px;
}

.mt20 span {
	color: red;
}

</style>

<script type="text/javascript">

	// 정규식 틀
	var idRegex = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,15}$/;	//아이디 정규식(문자와 숫자를 조합하여 8~15자리)
	var pwdRegex = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,20}$/;	//패스워드 정규식(문자와 숫자를 조합하여 8~20자리)
	var phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;	//폰번호 정규식(010-1234-1234)
	var emailRegex = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;	//이메일 정규식
	//		/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	// submit 전에 최종확인
	var compare_id = false;
	var compare_pwd1 = false;
	var compare_pwd2 = false;
	var compare_name = false;
	var compare_tel = false;
	var compare_email = false;
	var compare_addr1 = false;
	var compare_addr2 = false;
	
	// 아이디 중복확인 , 아이디 형식 확인
	function fn_check_id(){

		var _id = $("#id").val();

		$.ajax({
			type : "post",
			url : "<%=cp %>/custom/check_id",
			dataType : "text",
			data : {id:_id},
			success : function(data){

				if (data == 'false') {//DB에 중복 아이디 없으면
					if(idRegex.test(_id)){//정규식에 맞으면
						$("#id_result").text('');
						$("#id").css("border-color", "green");
						compare_id = true;
					}else if(_id == ""){//공백일 경우
						$("#id_result").text("사용하실 아이디를 입력하세요 !");
						$("#id_result").css("color", 'red');
						$("#id").css("border-color", 'red');
						compare_id = false;
					}else if(!idRegex.test(_id)){//정규식에 맞지 않으면
						$("#id_result").text("아이디는 숫자, 문자를 조합하여 8 ~ 15 자리야합니다.");
						$("#id_result").css("color", 'red');
						$("#id").css("border-color", 'red');
						compare_id = false;
					}
				} else {//DB에서 사용중인 아이디이면
					$("#id_result").text("이미 사용중인 아이디입니다 !");
					$("#id_result").css("color", 'red');
					$("#id").css("border-color", 'red');
					compare_id = false;
				}		
						
			},
			error : function(data){
				alert("Ajax error");
			}
		});
	
	}

	// 패스워드 형식 확인
	function fn_check_pwd1(){

		var pwd1 = $("#pwd1").val();
		var pwd2 = $("#pwd2").val();

		if(pwdRegex.test(pwd1)){//정규식에 맞으면
			$("#pwd1_result").text('');
			$("#pwd1").css("border-color", "green");
			compare_pwd1 = true;
		}else if(pwd1 == ""){//공백일 경우
			$("#pwd1_result").text("사용하실 비밀번호를 입력하세요 !");
			$("#pwd1").css("border-color", 'red');
			compare_pwd1 = false;
		}else if(!pwdRegex.test(pwd1)){//정규식에 맞지 않으면
			$("#pwd1_result").text("비밀번호는 숫자, 문자를 조합하여 8 ~ 20 자리야합니다.");
			$("#pwd1").css("border-color", 'red');
			compare_pwd1 = false;
		}

		//pwd2까지 확인한 후 다시 pwd1을 수정했을 경우를 고려
		if(pwd1==pwd2){
			if(pwd2!=""){
				$("#pwd2_result").text('');
				$("#pwd2").css("border-color", "green");
				compare_pwd1 = true;
			}
		}else{
			if(pwd2!=""){
				$("#pwd2_result").text("비밀번호가 일치하지 않습니다 !!!");
				$("#pwd2").css("border-color", "red");
				compare_pwd1 = false;
			}
		}
		
	}

	// 패스워스 재확인
	function fn_check_pwd2(){

		var pwd1 = $("#pwd1").val();
		var pwd2 = $("#pwd2").val();

		if(pwd2 == ""){//공백일 경우
			$("#pwd2_result").text("비밀번호를 다시 확인해주세요 !");
			$("#pwd2").css("border-color", 'red');
			compare_pwd2 = false;
		}else{//pwd2 입력했을 때
			if(pwd1 == pwd2){//비밀번호 일치하면
				$("#pwd2_result").text('');
				$("#pwd2").css("border-color", "green");
				compare_pwd2 = true;
			}else{//비밀번호 일치하지 않으면
				$("#pwd2_result").text("비밀번호가 일치하지 않습니다 !!!");
				$("#pwd2").css("border-color", "red");
				compare_pwd2 = false;
			}
		}
		
	}

	// 이메일 형식 확인
	function fn_check_email(){

		var email = $("#email").val();

		if(emailRegex.test(email)){//정규식에 맞으면
			$("#email_result").text('');
			$("#email").css("border-color", "green");
			compare_email = true;
		}else if(email == ""){//공백일 경우
			$("#email_result").text("이메일을 입력하세요 !");
			$("#email").css("border-color", 'red');
			compare_email = false;
		}else if(!emailRegex.test(email)){//정규식에 맞지 않으면
			$("#email_result").text("이메일 형식에 맞추어 입력하세요!");
			$("#email").css("border-color", 'red');
			compare_email = false;
		}
	
	}

	// 이름 입력 확인
	function fn_check_name(){

		var name = $("#name").val();

		if(name == ""){//공백일 경우
			$("#name_result").text("이름을 입력해주세요 !");
			$("#name").css("border-color", 'red');
			compare_name = false;
		}else{//이름 입력하면
			$("#name_result").text('');
			$("#name_result").css('color', 'green');
			$("#name").css("border-color", 'green');
			compare_name = true;
		}
		
	}

	// 폰번호 입력 확인
	function fn_check_phone(){

		var phone = $("#phone").val();

		if(phoneRegex.test(phone)){//정규식에 맞으면
			$("#phone_result").text('');
			$("#phone").css("border-color", "green");
			compare_tel = true;
		}else if(phone == ""){//공백일 경우
			$("#phone_result").text("핸드폰 번호를 입력해주세요 !");
			$("#phone").css("border-color", 'red');
			compare_tel = false;
		}else if(!phoneRegex.test(phone)){//정규식에 맞지 않으면
			$("#phone_result").text("010-XXXX-XXXX 형식으로 입력하세요.");
			$("#phone").css("border-color", 'red');
			compare_tel = false;
		}
		
	}

	// 주소 검색 (다음 우편번호 API)
	function fn_search_addr1(){

		new daum.Postcode({
	        oncomplete: function(data) {
	            $("#addr1").val(data.address);
				$("#addr1").css("border-color", 'green');
				compare_addr1 = true;
	        }
	    }).open();
		
	}

	// 상세 주소 입력 확인
	function fn_check_addr2(){

		var addr2 = $("#addr2").val();

		if(addr2 == ""){//공백일 경우
			$("#addr2_result").text("동, 호수 등 상세 주소를 입력해주세요 !");
			$("#addr2").css("border-color", 'red');
			compare_addr2 = false;
		}else{//상세주소 입력하면
			$("#addr2_result").text('');
			$("#addr2_result").css('color', 'green');
			$("#addr2").css("border-color", 'green');
			compare_addr2 = true;
		}
		
	}

	// 키 단위 (cm붙이기)
	function fn_unit_height(){

		$("#user_height").val($("#height").val());//cm 제외한 숫자만 form으로 보낼 value로 세팅
		
		if($("#height").val().indexOf("cm")==-1){//cm가 없으면 cm를 붙여라 (보여주기용)
			var height = $("#height").val() + " cm";
			$("#height").val(height);
		}
		
	}

	// 몸무게 단위 (kg붙이기)
	function fn_unit_weight(){

		$("#user_weight").val($("#weight").val());//kg 제외한 숫자만 form으로 보낼 value로 세팅
		
		if($("#weight").val().indexOf("kg")==-1){//kg이 없으면 kg을 붙여라 (보여주기용)
			var weight = $("#weight").val() + " kg";
			$("#weight").val(weight);
		}
		
	}

	// 취향 체크된 속성 값 가져오기
    function fn_taste_checked(){

    	var obj = $("input[name=taste]");
    	
    	 for(var i=0; i<obj.length; i++){
     		if(obj[i].checked==true){
				$("#taste_result").val(obj[i].value);
     		}
     	}

    }

    // 성별 체크된 속성 값 가져오기
    function fn_gender_checked(){

    	var obj = $("input[name=gender]");
    	
    	 for(var i=0; i<obj.length; i++){
     		if(obj[i].checked==true){
				$("#gender_result").val(obj[i].value);
     		}
     	}

    }

    // Create Account
    function fn_addCustom(){

		//필수항목 값들
        var id = $("#id").val();
        var pwd1 = $("#pwd1").val();
		var pwd2 = $("#pwd2").val();
		var name = $("#name").val();
		var phone = $("#phone").val();
		var email = $("#email").val();
		var addr1 = $("#addr1").val();
		var addr2 = $("#addr2").val();

		//필수항목을 채우지 않고 가입하려 하면
		if(!id || !pwd1 || !pwd2 || !name || !phone || !email || !addr1 || !addr2){
			alert(" * 가 있는 부분은 필수항목입니다 !")
			return;
		}

		//양식에 맞지 않는데 가입하려고 하면
		if(!compare_id || !compare_pwd1 || !compare_pwd2 || !compare_name || !compare_tel || !compare_email || !compare_addr1 || !compare_addr2){
			alert("양식에 맞게 입력해주세요.....");
			return;
		}
        
        //체크박스 체크속성 값 세팅
    	fn_taste_checked();
    	fn_gender_checked();

    	//컨트롤러로~
		document.custom_join.action = "<%=cp %>/custom/add_custom";
		document.custom_join.submit();
		
    }

    $(function(){

    	// input 박스 클릭시 value값 사라지도록 
		$(".Del").click(function(){
			$(this).val("");
		});

		// 취향 체크박스 중복선택 막기
		$(".tas").click(function(){
			$(".tas").prop("checked", false);
			$(this).prop("checked", true);
			
		});

		// 성별 체크박스 중복선택 막기
		$(".gen").click(function(){
			$(".gen").prop("checked", false);
			$(this).prop("checked", true)
		});
		
    });

</script>

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
            <a href="<%=cp %>/custom/main"><img src="/wit/resources/img/logo.png" alt=""></a>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__auth">
            <a href="<%=cp%>/custom/login">Login</a>
            <a href="">Register</a>
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
                            <a href="<%=cp%>/custom/login">Login</a>
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
                        <a href="<%=cp %>/custom/main"><i class="fa fa-home"></i> Home</a>
                        <span>Create Account</span>
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
                    <h6 class="coupon__link"><span class="icon_tag_alt"></span> Please enter your information...</h6>
                </div>
            </div>
            <form name="custom_join" action="" class="checkout__form" method="post">
                <div class="row" style="padding-left: 25%;">
                    <div class="col-lg-8">
                        <h5>Join us</h5>
                        <div class="row">                         
                            <div class="col-lg-12">
                            	<div class="checkout__form__input">
                                    <p>ID <span>*</span></p>
                                    <input type="text" name="user_id" id="id" style="margin-bottom: 10px;" placeholder="Enter your ID" onkeyup="fn_check_id()">                                    
                                    <span id="id_result" style="font-size: 15px;"></span>                                   
                                </div>
                            	<div class="checkout__form__input mt20">
                                    <p>Password <span>*</span></p>
                                    <input type="password" name="user_pwd" id="pwd1" style="margin-bottom: 10px;" placeholder="Enter your password" onkeyup="fn_check_pwd1()">
                                    <span id="pwd1_result" style="font-size: 15px;"></span>
                                </div>
                                <div class="checkout__form__input mt20">
                                    <p>Check Password <span>*</span></p>
                                    <input type="password" id="pwd2" style="margin-bottom: 10px;" placeholder="Check your password" onkeyup="fn_check_pwd2()">
                                    <span id="pwd2_result" style="font-size: 15px;"></span>
                                </div>
                                <div class="checkout__form__input mt20">
                                    <p>Name <span>*</span></p>
                                    <input type="text" name="user_name" id="name" style="margin-bottom: 10px;" placeholder="Enter your name" onkeyup="fn_check_name()">
                                    <span id="name_result" style="font-size: 15px;"></span>
                                </div>
                                <div class="checkout__form__input mt20">
                                    <p>Phone <span>*</span></p>
                                    <input type="text" name="user_tel" id="phone" style="margin-bottom: 10px;" placeholder="Enter your phone number" onkeyup="fn_check_phone()">
                                    <span id="phone_result" style="font-size: 15px;"></span>
                                </div>
                                <div class="checkout__form__input mt20">
                                    <p>Email <span>*</span></p>
                                    <input type="text" name="user_email" id="email" style="margin-bottom: 10px;" placeholder="Enter your email" onkeyup="fn_check_email()">
                                    <span id="email_result" style="font-size: 15px;"></span>
                                </div>
                                <div class="checkout__form__input mt20">
                                    <p>Address <span>*</span></p>
                                    <input type="text" name="user_addr1" id="addr1" placeholder="Street Address" onclick="fn_search_addr1()" onkeyup="fn_search_addr1()">
                                    <input type="text" name="user_addr2" id="addr2" placeholder="Apartment. suite, unite ect ( optinal )" style="margin-bottom: 10px;" onkeyup="fn_check_addr2()">
                                    <span id="addr2_result" style="font-size: 15px;"></span>
                                </div>                                                              
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="checkout__form__input mt20">
                                    <p>Height</p>
                                    <input type="text" id="height" style="margin-bottom: 10px;" placeholder="Enter your height" onblur="fn_unit_height()" onfocus="this.value=''">
                                    <input type="hidden" name="user_height" id="user_height">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="checkout__form__input mt20">
                                    <p>Weight</p>
                                    <input type="text" id="weight" style="margin-bottom: 10px;" placeholder="Enter your weight" onblur="fn_unit_weight()" onfocus="this.value=''">
                                    <input type="hidden" name="user_weight" id="user_weight">
                                </div>
                            </div>
                            <div class="col-lg-12">
                            <div class="checkout__form__input mt20">
                                    <p>Preferred taste</p>
                            </div>
                            <div class="sidebar__sizes" style="margin-bottom: 0px;">
                            	<div class="size__list">
		                                <label for="cas">
		                                    Casual
		                                    <input type="checkbox" id="cas" name="taste" class="tas" value="CAS">
		                                    <span class="checkmark"></span>
		                                </label>
		                                <label for="off">
		                                    Office
		                                    <input type="checkbox" id="off" name="taste" class="tas" value="OFF">
		                                    <span class="checkmark"></span>
		                                </label>
		                                <label for="str">
		                                    Street
		                                    <input type="checkbox" id="str" name="taste" class="tas" value="STR">
		                                    <span class="checkmark"></span>
		                                </label>
		                                <label for="spo">
		                                    Sports
		                                    <input type="checkbox" id="spo" name="taste" class="tas" value="SPO">
		                                    <span class="checkmark"></span>
		                                </label>
		                                <label for="vin">
		                                    Vintage
		                                    <input type="checkbox" id="vin" name="taste" class="tas" value="VIN">
		                                    <span class="checkmark"></span>
		                                </label>
		                                <label for="dan">
		                                    Dandy
		                                    <input type="checkbox" id="dan" name="taste" class="tas" value="DAN">
		                                    <span class="checkmark"></span>
		                                </label>
		                                <label for="cut">
		                                    Cute
		                                    <input type="checkbox" id="cut" name="taste" class="tas" value="CUT">
		                                    <span class="checkmark"></span>
		                                </label>
		                                <label for="fun">
		                                    Punk
		                                    <input type="checkbox" id="fun" name="taste" class="tas" value="FUN">
		                                    <span class="checkmark"></span>
		                                </label>
		                                <input type="hidden" name="user_style" id="taste_result"><!-- 체크된 취향 -->
                            	</div>
                            </div>
                            <div class="checkout__form__input mt20">
                                    <p>Gender</p>
                            </div>
                            <div class="sidebar__sizes">
                            	<div class="size__list">		                                
		                                <label for="female">
		                                    Female
		                                    <input type="checkbox" id="female" name="gender" class="gen" value="FEMALE">		                                    
		                                    <span class="checkmark"></span>
		                                </label>
		                                <label for="male">
		                                    Male
		                                    <input type="checkbox" id="male" name="gender" class="gen" value="MALE">		                                  
		                                    <span class="checkmark"></span>
		                                </label>
		                                <input type="hidden" name="user_gender" id="gender_result"><!-- 체크 된 성별 -->
                            	</div>
                            </div>
                            <div class="mt20" style="padding-left: 33%;">
                            	<button type="button" class="site-btn" style="font-size: 17px;" onclick="fn_addCustom()">Create Account</button>
                            </div>
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