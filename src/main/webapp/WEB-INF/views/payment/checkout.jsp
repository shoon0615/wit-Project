<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ashion Template">
    <meta name="keywords" content="Ashion, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ashion | Template</title>

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
    
    <style type="text/css">
    
    	.row {
    		padding-left: 7%;
    	}
    
    	.col-lg-8 {
		    max-width: 54.666667%;
		}
		
		.checkout__form .checkout__form__input input[name=delivery_addr1] {
			margin-bottom: 15px;
		}	
		
    </style>
    
    <script type="text/javascript">

    	var phoneRegex = /^\d{3}-\d{3,4}-\d{4}$/;								//폰번호 정규식(010-1234-1234)
		var emailRegex = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;	//이메일 정규식(abc@gmail.com)

		$(function(){

			// .replace(/^"(.+(?="$))"$/, '$1')									// 맨 앞뒤만 큰따옴표 제거
			// .replace(/"([^"]+(?="))"/g, '$1')								// 모든 문자열에서 큰따옴표 제거(replaceAll)
			//$('input[name=prod_list]').val(JSON.stringify(eval('${prod_list_json }')));	// json 형식으로 변환(앞뒤 큰따옴표 제거)
			
			// 로그인되어있다면 '주문자 정보와 동일' 체크 설정
			if(!'${customInfo}') {
				$('.checkout__form__checkbox input').prop("checked", true);
				
				// name 칸의 text 속성 disabled 설정
				$('input[name=user_id]').attr("disabled", true);
				// $('.row').find('.checkout__form__input').children("input").first().attr("disabled", true); // 같은 내용 selector로 설정
			}

			// Total 금액칸이 로드될 시
			$('.checkout__order__total').show(function(){
				var totalAmount = 0;
				var totalQty = 0;
				$('.checkout__order__product li').each(function(i){
					// 첫번째는 명칭이라 제외
					if(i!=0) {
						var orderInfo = $(this).contents();
						
						totalQty += Number(orderInfo.eq(0).text().charAt(orderInfo.eq(0).text().indexOf("×")+2)); // ×를 통해 qty 자리값을 불러옴
						totalAmount += Number(orderInfo.eq(1).text().replace(/[^0-9]/g,''));	// 두번째 <span>값만 숫자로 불러옴
					}
				});
				$('.checkout__order__total li').children("span").text("￦ " + totalAmount);
				$(this).append($('<input/>', {type: 'hidden', name: 'order_qty', value: totalQty}));		// form에서 받기위해 append 처리
				$(this).append($('<input/>', {type: 'hidden', name: 'order_amount', value: totalAmount}));
			});

			// 체크박스 '주문자 정보와 동일'을 클릭 시
			$('.checkout__form__checkbox input').click(function(){
				// 체크 표시 설정 시 session 정보와 동일화 시킴
				if($(this).prop("checked")) {
					$('input[name=user_id]').val('${customInfo.user_id}');
					$('input[name=user_id]').attr("disabled", true);				// 이름 칸 입력 가능 설정
					$('input[name=user_tel]').val('${customInfo.user_tel}');
					$('input[name=user_email]').val('${customInfo.user_email}');
					$('input[name=delivery_addr1]').val('${customInfo.user_addr1}');
					$('input[name=delivery_addr2]').val('${customInfo.user_addr2}');
				// 체크 표시 해제 시 모든 text칸 빈값으로 초기화
				} else {
					$('.row').find('.checkout__form__input input').val("");			// 모든 칸 초기화
					$('input[name=user_id]').attr("disabled", false);				// 이름 칸 입력 불가 설정
					$('.checkout__form__input').children("input").each(function(i){	// 경고메세지 초기화
						$(this).next().text("");
					});
				}
			});

			// 이름 확인
			$('input[name=user_id]').keyup(function(){
				$(this).next().text("");							// 입력되는 순간 경고메세지 초기화
			});

			// 핸드폰 번호 형식 확인
			$('input[name=user_tel]').keyup(function(){
				if(phoneRegex.test($(this).val())){					// 정규식에 맞으면
					$(this).next().text("");
				} else {
					$(this).next().text("010-XXXX-XXXX 형식으로 입력하세요");
				}
			});

			// 이메일 형식 확인
			$('input[name=user_email]').keyup(function(){
				if(emailRegex.test($(this).val())){					// 정규식에 맞으면
					$(this).next().text("");
				} else {
					$(this).next().text("이메일 형식에 맞추어 입력하세요");
				}
			});

			// 주소 창 클릭 시
			$('input[name=delivery_addr1]').click(function(){
				var temp = $(this);									// ajax 내부에서 click시의 this가 적용되지않으므로 미리 저장
				new daum.Postcode({
			        oncomplete: function(data) {
			            temp.val(data.address);
						temp.next().focus();
			        }
			    }).open();
			});

			// 상세주소 확인
			$('input[name=delivery_addr2]').keyup(function(){
				$(this).next().text("");							// 입력되는 순간 경고메세지 초기화
			});
			
			// 주문 버튼 클릭 시(최종)
			$('.site-btn').click(function(){
				var result = true;
				
				// 빈 칸이 있는 경우 경고메세지 출력
				$('.checkout__form__input').children("input").each(function(i){
					if(!$(this).val()) {		
						// <p>태그 안의 맨 앞 텍스트만 가져오게 설정	
						$(this).next().text("Enter your " + $(this).parent().children().first().contents().first().text());
					} 

					// 경고메세지가 하나라도 있다면
					if($(this).next().text()) {		
						result = false;
					}
				});

				// 동의 칸에 동의하지 않았다면
				if(!$('#o-acc').prop("checked")) {
					alert("Please agree to the checkbox");
					result = false;
				}

				if(result) {
					var f = document.payForm;
			    	var url = "insertOrder.action";

					$.ajax({
						type: 'POST',
			        	url: url,
			       		data: $(f).serialize(),
			        	success: function(orderCode) {
			        		IMP.init("imp17939014"); 
							IMP.request_pay({
								  pg : 'inicis',
								  pay_method : 'card',
								  merchant_uid : 'merchant_' + new Date().getTime(),	
								  name: "이상훈",
						          amount: 100,
						          buyer_email: "shoon0615@gmail.com",
						          buyer_name: "wit",
						          buyer_tel: "010-6664-5210",
						          buyer_addr: "서울특별시 강동구 ",
						          buyer_postcode: "1004"
							}, function(rsp) {
							    if (rsp.success) {
							    	url = "insertPayment.action";
			                       	alert("결제가 완료되었습니다");

			                       	$.post(url,{
			                       		order_code : orderCode,									// 카드 승인번호(rsp.apply_num)
			                       		payment_type : rsp.pay_method.toUpperCase(),			// 결제 방법
			                       		payment_account : rsp.card_number,						// 계좌,카드번호
			                       		payment_bank : rsp.card_name,							// 결제 은행사
			                       		payment_point : 0,										// 사용 포인트
			                       		payment_amount : $('input[name=order_amount]').val()	// 최종 결제 총액(rsp.paid_amount)
		    	                       	},function(args){
		    	                       	f.submit();
			        				});
							    } else {
							        alert(rsp.error_msg);
								}
							});
			            }
					});
				} else {
					alert("fail");
				}
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
            <a href="./index.html"><img src="/wit/resources/img/logo.png" alt=""></a>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="offcanvas__auth">
            <a href="#">Login</a>
            <a href="#">Register</a>
        </div>
    </div>
    <!-- Offcanvas Menu End -->

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="./index.html"><i class="fa fa-home"></i> Home</a>
                        <span>Shopping cart</span>
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
                <div class="col-lg-12" style="max-width: 88%;">
                    <h6 class="coupon__link"><span class="icon_tag_alt"></span> <a href="#">Have a coupon?</a> Click
                    here to enter your code.</h6>
                </div>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/main/main.action" class="checkout__form" name="payForm">
                <div class="row">
                    <div class="col-lg-8">
                    	<div class="subject">
                        	<h5>Billing detail</h5>
                        </div>
                        <div class="row" style="padding-left: 0;">
                            <!-- <div class="col-lg-6 col-md-6 col-sm-6"> -->
                            <div class="col-lg-12">
                                <div class="checkout__form__input">
                                    <span style="color: #212529;font-weight: 500;">Name <font color="#ca1515">*</font></span>
                                    <div class="checkout__form__checkbox">
		                                <label for="acc" style="display: inline;float: right;">
		                                    Same as orderer information
		                                    <input type="checkbox" id="acc">
		                                    <span class="checkmark"></span>
		                                </label>
			                        </div>
                                    <input type="text" name="user_id" placeholder="Enter your Name">
                                    <span></span>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="checkout__form__input">
                                    <p>Phone <span>*</span></p>
                                    <input type="text" name="user_tel" placeholder="Enter your Phone">
                                    <span></span>
                                </div>
                                <div class="checkout__form__input">
                                    <p>Email <span>*</span></p>
                                    <input type="text" name="user_email" placeholder="Enter your Email">
                                    <span></span>
                                </div>
                                <div class="checkout__form__input">
                                    <p>Address <span>*</span></p>
                                    <input type="text" name="delivery_addr1" placeholder="Street Address" readonly>
                                    <input type="text" name="delivery_addr2" placeholder="Apartment. suite, unite ect ( optinal )">
                                    <span></span>
                                </div>
                                <div class="checkout__form__input">
                                    <p>Message <span>*</span></p>
                                    <input type="text" name="order_contents">
                                </div>
                            </div> 
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="checkout__order">
                            <h5>Your order</h5>
                            <div class="checkout__order__product">
                            <!-- value를 ""으로 사용시 json을 문자열로 인식해서인지 값을 제대로 못불러옴 -->
                            <input type="hidden" name="prod_list" value='${prod_list_json }'/>	
                                <ul>
                                    <li>
                                        <span class="top__text">Product</span>
                                        <span class="top__text__right">Total</span>
                                    </li>
                                    <c:forEach var="list" items="${prod_list }" varStatus="status">
                                    	<li>
                                    		<c:if test="${status.index+1<=9 }">0</c:if>${status.index+1 }. 
                                    		${list.PROD_SUBCODE } × ${list.CART_QTY }
                                    		<span>￦ <fmt:formatNumber value="${list.PROD_PRICE*list.CART_QTY }" type="number"/></span><br/>	
                                    		[ ${list.PROD_OPTION } ]
                                    	</li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <div class="checkout__order__total">
                                <ul>
                                    <li>Total <span></span></li>
                                </ul>
                            </div>
                            <div class="checkout__order__widget">
                                <label for="o-acc">
									Would you like to agree?
                                    <input type="checkbox" id="o-acc">
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <button type="button" class="site-btn">Place Order</button>
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
    <!-- 아임포트 결제 API -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</body>

</html>