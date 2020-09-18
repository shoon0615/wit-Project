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

	// submit 전에 최종확인
	var compare_id = false;
	var compare_pwd1 = false;
	var compare_pwd2 = false;
	var compare_name = false;
	var compare_tel = false;
	var compare_email = false;
	var compare_addr1 = false;
	var compare_addr2 = false;
	
    $(function(){


    	// 아이디 중복확인 , 아이디 형식 확인
    	$("#id").keyup(function(){

        	var id = $(this);

    		$.ajax({
    			type : "post",
    			url : "<%=cp %>/custom/check_id",
    			dataType : "text",
    			data : {id:$(this).val()},
    			success : function(data){
        			
    				if (data == 'false') {//DB에 중복 아이디 없으면
    					if(idRegex.test(id.val())){//정규식에 맞으면
    						id.next().text("");
    						id.css("border-color", "green");
    						compare_id = true;
    					}else if(id.val()==""){//공백일 경우
    						id.next().text("아이디를 입력하세요 !");
    						id.next().css("color", 'red');
    						id.css("border-color", 'red');
    						compare_id = false;
            			}else if(!idRegex.test(id.val())){//정규식에 맞지 않으면
    						id.next().text("아이디는 숫자, 문자를 조합하여 8 ~ 15 자리야합니다.");
    						id.next().css("color", 'red');
    						id.css("border-color", 'red');
    						compare_id = false;
    					}
    				} else {//DB에서 사용중인 아이디이면
    					id.next().text("이미 사용중인 아이디입니다 !");
    					id.next().css("color", 'red');
    					id.css("border-color", 'red');
    					compare_id = false;
    				}		
    						
    			},
    			error : function(data){
    				alert("Ajax error");
    			}
    		});

        });

		
		// 패스워드 형식 확인
		$("#pwd1").keyup(function(){
			
			if(pwdRegex.test($(this).val())){//정규식에 맞으면
				$(this).next().text('');
				$(this).css("border-color", "green");
				compare_pwd1 = true;
			}else if($(this).val()==""){//공백일 경우
				$(this).next().text("비밀번호를 입력하세요 !");
				$(this).next().css("color", 'red');
				$(this).css("border-color", 'red');
				compare_pwd1 = false;
			}else if(!pwdRegex.test($(this).val())){//정규식에 맞지 않으면
				$(this).next().text("비밀번호는 숫자, 문자를 조합하여 8 ~ 20 자리야합니다.");
				$(this).css("border-color", 'red');
				compare_pwd1 = false;
			}

			//pwd2까지 확인한 후 다시 pwd1을 수정했을 경우를 고려
			if($(this).val()==$("#pwd2").val()){
				if($("#pwd2").val()!=""){
					$("#pwd2_result").text('');
					$("#pwd2").css("border-color", "green");
					compare_pwd1 = true;
				}
			}else{
				if($("#pwd2").val()!=""){
					$("#pwd2_result").text("비밀번호가 일치하지 않습니다 !!!");
					$("#pwd2").css("border-color", "red");
					compare_pwd1 = false;
				}
			}
			
		});

		
		// 패스워드 재확인
		$("#pwd2").keyup(function(){

			if($("#pwd1").val()==$(this).val()){//비밀번호 일치하면
				$(this).next().text('');
				$(this).css("border-color", "green");
				compare_pwd2 = true;
			}else if($(this).val()==""){//공백일 경우
				$(this).next().text("비밀번호를 확인해주세요 !");
				$(this).next().css("color", 'red');
				$(this).css("border-color", 'red');
				compare_pwd2 = false;
			}else{//비밀번호 일치하지 않으면
				$(this).next().text("비밀번호가 일치하지 않습니다 !!!");
				$(this).css("border-color", "red");
				compare_pwd2 = false;
			}

		});


		// 이름 입력 확인
		$("#name").keyup(function(){

			if($(this).val()!=""){//이름 입력했으면
				$(this).next().text('');
				$(this).next().css('color', 'green');
				$(this).css("border-color", 'green');
				compare_name = true;
			}else{//공백일 경우
				$(this).next().text("이름을 입력해주세요 !");
				$(this).next().css("color", 'red');
				$(this).css("border-color", 'red');
				compare_name = false;
			}

		});
		
		
		// 핸드폰 번호 형식 확인
		$("#phone").keyup(function(){

			if(phoneRegex.test($(this).val())){//정규식에 맞으면
				$(this).next().text('');
				$(this).css("border-color", "green");
				compare_tel = true;
			}else if($(this).val()==""){//공백일 경우
				$(this).next().text("핸드폰 번호를 입력해주세요 !");
				$(this).next().css("color", 'red');
				$(this).css("border-color", 'red');
				compare_tel = false;
			}else if(!phoneRegex.test($(this).val())){//정규식에 맞지 않으면
				$(this).next().text("010-XXXX-XXXX 형식으로 입력하세요.");
				$(this).css("border-color", 'red');
				compare_tel = false;
			}

		});
		
		
		// 이메일 형식 확인
		$("#email").keyup(function(){

			if(emailRegex.test($(this).val())){//정규식에 맞으면
				$(this).next().text('');
				$(this).css("border-color", "green");
				compare_email = true;
			}else if($(this).val()==""){//공백일 경우
				$(this).next().text("이메일을 입력해주세요 !");
				$(this).next().css("color", 'red');
				$(this).css("border-color", 'red');
				compare_email = false;
			}else if(!emailRegex.test($(this).val())){//정규식에 맞지 않으면
				$(this).next().text("이메일 형식에 맞추어 입력하세요!");
				$(this).css("border-color", 'red');
				compare_email = false;
			}

		});


		// 주소 검색 (다음 우편번호 API)
		$("#addr1").on({

			click: function(){
				new daum.Postcode({
			        oncomplete: function(data) {
			            $("#addr1").val(data.address);
						$("#addr1").css("border-color", 'green');
						$("#addr1").blur();
						compare_addr1 = true;
			        }
			    }).open();
			},
			keyup: function(){
				new daum.Postcode({
			        oncomplete: function(data) {
			            $("#addr1").val(data.address);
						$("#addr1").css("border-color", 'green');
						$("#addr1").blur();
						compare_addr1 = true;
			        }
			    }).open();
			}

		});


		// 상세 주소 입력 확인
		$("#addr2").keyup(function(){

			if($(this).val()!=""){//상세주소 입력했으면
				$(this).next().text('');
				$(this).next().css('color', 'green');
				$(this).css("border-color", 'green');
				compare_addr2 = true;
			}else{//공백일 경우
				$(this).next().text("동,호수 등 상세주소를 입력해주세요 !");
				$(this).next().css("color", 'red');
				$(this).css("border-color", 'red');
				compare_addr2 = false;
			}

		});
		

		// 키 단위 (cm붙이기)
		$("#height").on({

			blur: function(){
				$(this).next().val($(this).val());//cm 제외한 숫자만 form으로 보낼 value로 세팅
				if($(this).val().indexOf("cm")==-1){//cm가 없으면 cm를 붙여라 (보여주기용)
					var height = $(this).val() + " cm";
					$(this).val(height);
				}
			},
			focus: function(){
				$(this).val("");
			}

		});

		
		// 몸무게 단위 (kg붙이기)
		$("#weight").on({

			blur: function(){
				$(this).next().val($(this).val());//kg 제외한 숫자만 form으로 보낼 value로 세팅
				if($(this).val().indexOf("kg")==-1){//kg이 없으면 kg을 붙여라 (보여주기용)
					var weight = $(this).val() + " kg";
					$(this).val(weight);
				}
			},
			focust: function(){
				$(this).val("");
			}

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

		
		// Create Account
		$("#addCustom").click(function(){
			
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

		});
			
		
    });

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
    
</script>

</head>

<body>
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
                                    <input type="text" name="user_id" id="id" style="margin-bottom: 10px;" placeholder="Enter your ID">                                    
                                    <span style="font-size: 15px;"></span>                                   
                                </div>
                            	<div class="checkout__form__input mt20">
                                    <p>Password <span>*</span></p>
                                    <input type="password" name="user_pwd" id="pwd1" class="nec" style="margin-bottom: 10px;" placeholder="Enter your password">
                                    <span style="font-size: 15px;"></span>
                                </div>
                                <div class="checkout__form__input mt20">
                                    <p>Check Password <span>*</span></p>
                                    <input type="password" id="pwd2" class="nec" style="margin-bottom: 10px;" placeholder="Check your password">
                                    <span style="font-size: 15px;"></span>
                                </div>
                                <div class="checkout__form__input mt20">
                                    <p>Name <span>*</span></p>
                                    <input type="text" name="user_name" id="name" class="nec" style="margin-bottom: 10px;" placeholder="Enter your name">
                                    <span style="font-size: 15px;"></span>
                                </div>
                                <div class="checkout__form__input mt20">
                                    <p>Phone <span>*</span></p>
                                    <input type="text" name="user_tel" id="phone" class="nec" style="margin-bottom: 10px;" placeholder="Enter your phone number">
                                    <span style="font-size: 15px;"></span>
                                </div>
                                <div class="checkout__form__input mt20">
                                    <p>Email <span>*</span></p>
                                    <input type="text" name="user_email" id="email" class="nec" style="margin-bottom: 10px;" placeholder="Enter your email">
                                    <span style="font-size: 15px;"></span>
                                </div>
                                <div class="checkout__form__input mt20">
                                    <p>Address <span>*</span></p>
                                    <input type="text" name="user_addr1" id="addr1" class="nec" placeholder="Street Address">
                                    <input type="text" name="user_addr2" id="addr2" class="nec" placeholder="Apartment. suite, unite ect ( optinal )" style="margin-bottom: 10px;">
                                    <span style="font-size: 15px;"></span>
                                </div>                                                              
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="checkout__form__input mt20">
                                    <p>Height</p>
                                    <input type="text" id="height" style="margin-bottom: 10px;" placeholder="Enter your height">
                                    <input type="hidden" name="user_height" id="user_height">
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="checkout__form__input mt20">
                                    <p>Weight</p>
                                    <input type="text" id="weight" style="margin-bottom: 10px;" placeholder="Enter your weight">
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
                            	<button type="button" id="addCustom" class="site-btn" style="font-size: 17px;">Create Account</button>
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