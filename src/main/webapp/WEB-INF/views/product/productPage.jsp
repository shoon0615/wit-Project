<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
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
    
    <script src="/wit/resources/js/jquery-3.1.1.js"></script>

	<script type="text/javascript">
	
		$(function() {
			var checked = "";
			var checkedSubcode = '${dto.PROD_SUBCODE }';
			var f = document.prodForm;

			// 컬러와 사이즈를 선택한 경우 상품 정보를 추가해주는 함수
		    var checkedInsert = function() {
			    // radio 및 label로 인해 디자인 초기화(radio는 설정이 안됨)
		    	$(".color__checkbox label input").after("<style type='text/css'>"
		    		+ ".product__details__widget ul li .color__checkbox label input:checked~:after {opacity: 0;}"
		    		+ ".product__details__widget ul li .color__checkbox label input[id='white']:checked~:after {opacity: 0;}</style>");
				$(".color__checkbox label input").removeAttr('checked');
				$(".size__btn label").removeClass('active');

		    	var checkedColor = $(':radio[name=color__radio]:checked').attr('id').toUpperCase();
				var checkedSize = $(':radio[name=size__radio]:checked').attr('id').replace("-btn", " ").trim().toUpperCase();
				
				$.post("choiceProd.action", {PROD_SUBCODE:checkedSubcode, PROD_COLOR:checkedColor, PROD_SIZE:checkedSize}, function(data){

					var proTable = $(".product__details__list table");
					var prod_COLOR = data.prod_COLOR;
					var prod_SIZE = data.prod_SIZE;
					var prod_SUBCODE = data.prod_SUBCODE;
					var prod_PRICE = data.prod_PRICE;

					var prod_id = '#' + prod_COLOR + '-' + prod_SIZE;

					// 상품 정보가 이미 추가돼있는 경우 기존에 더해짐
					if($(prod_id).length != 0) {
				    	var oldQty = $(prod_id).closest("tr").find("td.prod__qty").find('input');
						var oldPrice = $(prod_id).closest("tr").find("td.prod__price").children("span");
									
						oldPrice.text(parseFloat(oldPrice.text()) + parseFloat(prod_PRICE));
						oldQty.val(parseFloat(oldQty.val()) + 1);
					// 상품 정보가 존재하지 않는 경우 추가됨
				    } else {
					    proTable.append('<tr><td class="prod__sub"><span id="' + prod_COLOR + '-' + prod_SIZE + '"> ' 
					    	+ '<b>' + prod_SUBCODE + '</b><br/>- ' 
					    	+ prod_COLOR + '/' + prod_SIZE + '</span></td>');
					    proTable.find("tr:last").append('<td class="prod__qty">');	
					    proTable.find("td:last").prepend($('<div/>', {class: 'pro-qty'}));
					    proTable.find("div:last").append('<input type="text" value="1" disabled="disabled"/></td>');
						proTable.find("div:last").prepend('<span class="dec qtybtn" style="padding-left: 3px;">-</span>');
						proTable.find("div:last").append('<span class="inc qtybtn">+</span>');
						proTable.find("tr:last").append('<td class="prod__close"><span class="icon_close"></span></td>');
						proTable.find("tr:last").append('<td class="prod__price">￦ <span>' + prod_PRICE + '</span></td></tr>');
					}
					
					// 총금액도 기존 금액에 더해짐
					var totalAmount = $(".product__details__amount").children("span");
					totalAmount.text(parseFloat(totalAmount.text()) + parseFloat(prod_PRICE));
				}, "json");
		    }

		    // 컬러 리스트 또는 사이즈 리스트 클릭 시
		    $('.color__checkbox label input, .size__btn label input').click(function(){	   
			    // 처음 클릭 시엔 속성 값만 바뀌도록 설정 
				if(checked == "") {
					checked = $(this).attr("name").indexOf("color") == -1 ? "size" : "color";
				// 클릭한 리스트의 속성과 변수에 저장한 속성이 다를 경우(다른 리스트끼리 선택한 경우)
				} else if($(this).attr("name").indexOf(checked) == -1){
					checkedInsert();
					checked = "";
		        }

		        // input 대신 label로 보이게되어있어 label의 속성만 바뀜(디자인)
				if(checked == "color") {
		    		$('.color__checkbox label input').removeAttr("checked");
		        	$(this).attr('checked', true);
		        	$('.color__checkbox label style').remove();
		        } else if(checked == "size") {
		        	$('.size__btn label').removeClass("active");
		        	$(this).closest("label").addClass("active");
		        } 	    	
			});

			// 수량 변경 버튼 클릭 시(+, -)
			$('.product__details__list').on("click", '.qtybtn', function () {
				var oldQty = $(this).parent().find('input');										// 기존 수량								
				//var oldAmt = $('.product__details__price').text().substring(2).replace(",", "");	// 상품 단일 금액(selector)
				var oldAmt = '${dto.PROD_PRICE }';													// 상품 단일 금액
				var newQty = parseFloat(oldQty.val());												// 수량 변경 저장 함수
				var oldPrc = $(this).closest("tr").find('td.prod__price').children("span");			// 상품 수량에 따른 금액
				var newPrc = parseFloat(oldPrc.text());												// 상품 금액 저장 함수
				var totalAmt = $('.product__details__amount').children("span");						// 총 금액

				if ($(this).hasClass('inc')) {
					newQty = newQty + 1;
					newPrc = newPrc + parseFloat(oldAmt);
					totalAmt.text(parseFloat(totalAmt.text()) + parseFloat(oldAmt));
				} else {
					// 수량 1 미만 안되게 설정(Don't allow decrementing below zero)
					if (parseFloat(oldQty.val()) > 1) {
						newQty = newQty - 1;
						newPrc = newPrc - parseFloat(oldAmt);
						totalAmt.text(parseFloat(totalAmt.text()) - parseFloat(oldAmt));
					} else {
						newQty = 1;
						newPrc = parseFloat(oldAmt);
					}
				}

				oldQty.val(newQty);
				oldPrc.text(newPrc);
		    });

			// 상품 정보의 닫기(x) 버튼 클릭 시
		    $('.product__details__list').on("click", '.icon_close', function () {
		    	var totalAmt = $('.product__details__amount').children("span");
		    	var oldAmt = $(this).closest("tr").find('td.prod__price').children("span").text();

		    	// 총금액에서 상품 수량에 따른 금액을 차감함
		    	totalAmt.text(parseFloat(totalAmt.text()) - parseFloat(oldAmt));
		    	$(this).closest("tr").remove();
		    });

		    // 바로 결제 버튼 클릭 시
			$('.cart-btn').click(function(){
				var prodStr = "";																//선택한 상품 리스트를 담아줄 문자열
				$('.product__details__list tr').each(function(index){
					if(index != 0) {															// 첫 tr은 디자인용이므로 제외		
						prodStr += "-" + $(this).find('.prod__sub span').attr("id");			// 문자열에 상품 id(코드) 삽입
						prodStr += "-" + $(this).find('.prod__qty input').val();				// 문자열에 수량 삽입
					} 
				});

				if(prodStr == "") {
					alert("구매할 상품이 없습니다!");
					return;
				} else {
					prodStr = checkedSubcode + prodStr;												// 문자열(0)에 subcode 삽입
					$(f).append($('<input/>', {type: 'hidden', name: 'prodStr', value: prodStr}));	// form에 매개변수 저장 후 이동
					f.submit();
				}
			});

		    // 찜하기(heart) 버튼 클릭 시
			$('.heart-btn').on("click", function () {
				// 로그인 시에만 등록되도록 설정
				if('${customInfo}') {
					var url = '${pageContext.request.contextPath}/myPage/heartInsert.action';

					$.post(url,{prod_subcode:checkedSubcode},function(args){
						if(args == "true") {				// boolean으로 받을시 args만 써도되나 over의 경우로 인해 String으로 받음
							alert("찜 목록에 등록되었습니다!");
						} else if(args == "over") {
							alert("찜 목록은 30개까지만 가능합니다!");
						} else {
							alert("이미 찜 목록에 존재하는 상품이 있습니다!");
						}

						// header의 찜 목록 수량도 바로 변경되게 수정(header가 2개 생겨 제거하려했으나 안되어 임시로 class만 제거함)
						$(".header").load(location.href + " .header");
						$(".header").removeClass("header");
					});
				// 비회원은 로그인 창으로 이동
				} else {
					window.location.href = '${pageContext.request.contextPath}/custom/login';
				}
		    });

		    // 장바구니(cart) 버튼 클릭 시
			$('.bag-btn').on('click', function () {		    	
		    	var prod_info = [];

		    	// 상품 정보를 [색상-사이즈-수량]의 배열로 보냄  *예시) BLACK-250-1
		    	$('.product__details__list tr').each(function(i){
		    		prod_info.push($(this).find('td.prod__sub').children("span").attr("id") 
		    		+ '-' + $(this).find('div.pro-qty').children("input").val());
		    	});

		    	// 디자인으로 인한 맨 앞의 빈 tr 제거
		    	prod_info.splice(0, 1);
		    	
		    	if(prod_info.length == 0) {
		    		alert("장바구니에 담을 내역이 없습니다!");
		    	} else {
		    		$.post("selectBag.action", {PROD_SUBCODE:checkedSubcode, PROD_INFO:prod_info}, function(data){
		    			if(data != "") {
			    			var message = "이미 장바구니에 존재하는 상품이 있습니다.\r\n";
							for(var i in data) {
								message += "[" + data[i] + "]\r\n";
							}	
							message += "그대로 진행하시겠습니까?"
							var ok = confirm(message);
						}
						
						if(data == "" || ok == true) {
							$.post("insertBag.action", {PROD_SUBCODE:checkedSubcode, PROD_INFO:prod_info}, function(data){
								alert("장바구니에 담겼습니다!");
								// header의 장바구니 수량도 바로 변경되게 수정(header가 2개 생겨 제거하려했으나 안되어 임시로 class만 제거함)
								//$(".header").load(location.href + " .header");
								//$(".header").removeClass("header");
								window.location.href = "/wit/cart/shopcart";
							});
						}
					});
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

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="./index.html"><i class="fa fa-home"></i> Home</a>
                        <a href="#">Shop </a>
                        <span>${dto.PROD_CATEGORY1 }</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Product Details Section Begin -->
    <section class="product-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="product__details__pic">
                        <div class="product__details__pic__left product__thumb nice-scroll">
                        	<c:forEach items="${PROD_IMG }" var="img" varStatus="status">
                            	<a class="pt" href="#product-${status.index+1 }">
                               		<img src="/wit/resources/img/product/details/${img }" alt="" style="height: 122px;">
                            	</a>
                            </c:forEach>
                        </div>
                        <div class="product__details__slider__content">
                            <div class="product__details__pic__slider owl-carousel">
                            	<c:forEach items="${PROD_IMG }" var="img" varStatus="status">
                                	<img data-hash="product-${status.index+1 }" class="product__big__img" 
                                		src="/wit/resources/img/product/details/${img }" alt="" style="height: 549px;">
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="product__details__text">
                        <h3>${dto.PROD_SUBCODE }</h3>
                        <div class="rating">
                        	<c:if test="${map.CNT > 0 }">
                        		<c:forEach begin="1" end="${map.AVG }">
	                            	<i class="fa fa-star"></i>
	                            </c:forEach>
	                            <c:forEach begin="1" end="${5 - map.AVG }">
	                            	<span class="fa fa-star"></span>
	                            </c:forEach>
	                            <span>( ${map.CNT } reviews )</span>
                            </c:if>
                        </div>
                        <!-- <div class="product__details__price">$ 75.0 <span>$ 83.0</span></div> -->
                        <div class="product__details__price">￦ <fmt:formatNumber value="${dto.PROD_PRICE }" type="number"/></div>
                        
                        <div class="product__details__widget">
                            <ul>
                                <!-- 재고 내용 주석(Stock)
                                <li>
                                    <span>Availability:</span>
                                    <div class="stock__checkbox">
                                        <label for="stockin">
                                            In Stock
                                            <input type="checkbox" id="stockin">
                                            <span class="checkmark"></span>
                                        </label>
                                    </div>
                                </li> 
                                -->
                                <li>
                                    <span>Available color:</span>
                                    <div class="color__checkbox">
                                    	<c:forEach items="${PROD_COLOR }" var="color">
	                                        <label for="${color }">
	                                            <input type="radio" name="color__radio" id="${color }">
	                                            <span class="checkmark ${color }-bg"></span>
	                                        </label>
	                                    </c:forEach>    
                                    </div>
                                </li>
                                <li>
                                    <span>Available size:</span>
                                    <div class="size__btn">
                                    	<c:forEach items="${PROD_SIZE }" var="size">
	                                        <label for="${size }-btn">
	                                            <input type="radio" name="size__radio" id="${size }-btn">
	                                            ${size }
	                                        </label>
                                       </c:forEach>
                                    </div>
                                </li>
                                <li>
                                    <span>Promotions:</span>
                                    <p>Free shipping</p>
                                </li>
                            </ul>
                        </div>
                        <div class="product__details__list">
                        	<table>
                        		<tr></tr>
                            </table>
                        </div>
                        <div class="product__details__amount">
                        	<h6><span>Total Amount: </span></h6>
                        	￦ <span>0</span>
                        </div>
                        <div class="product__details__button">  
                            <form method="POST" action="${pageContext.request.contextPath}/payment/checkout.action" name="prodForm">
                            	<a href="#" class="cart-btn"><span class="icon_wallet"></span>&nbsp;&nbsp;&nbsp;Buy it now</a>
                            </form>
                            <ul class="product__details__hover">
                                <li><a class="heart-btn" style="cursor: pointer;"><span class="icon_heart_alt"></span></a></li>
                                <li><a class="bag-btn" style="cursor: pointer;"><span class="icon_bag_alt"></span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="product__details__tab">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">Description</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">Specification</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-3" onclick="sendReview('review_created');" role="tab">Reviews ( ${map.CNT } )</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tabs-1" role="tabpanel">
                            	<div class="tab-img" style="text-align: -webkit-center;">
                            		<c:forEach items="${PROD_IMG }" var="img">
                            			<img src="/wit/resources/img/product/details/${img }" alt="" 
                            				style="display: block;width: 580px;height: 549px;margin-bottom: 30px;"/>
                            				
                            		</c:forEach>
                            	</div>
                            	<div class="tab-cross" style="text-align: -webkit-center;">
                            		<table>
                            			<tr>
		                            		<c:forEach items="${PROD_IMG }" var="img" varStatus="status">
		                            			<c:if test="${status.index%2 == 0 }"></tr><tr></c:if>
		                            			<td><img src="/wit/resources/img/product/details/${img }" alt=""
		                            				style="width: 520px;height: 549px;margin: 10px 15px 30px 15px;"/></td>
		                            		</c:forEach>
	                            		</tr>
                            		</table>
                            	</div>
                                <p>${dto.PROD_CONTENTS }</p>
                            </div>
                            <div class="tab-pane" id="tabs-2" role="tabpanel">
                                <h6>Specification</h6>
                                <p>Semo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut loret fugit, sed
                                    quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt loret.
                                    Neque porro lorem quisquam est, qui dolorem ipsum quia dolor si. Nemo enim ipsam
                                    voluptatem quia voluptas sit aspernatur aut odit aut loret fugit, sed quia ipsu
                                    consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Nulla
                                consequat massa quis enim.</p>
                                <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget
                                    dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes,
                                    nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium
                                quis, sem.</p>
                            </div>
                            <!-- 리뷰  -->                    
                            <div class="tab-pane" id="tabs-3" role="tabpanel">
                              	<div class="reviewSortNav" align="right">
                              		포토리뷰
                              		<input type="checkbox" id="photoReview" onclick="sendReview('');" style="border: 0; background: white;"><br/>
                              		체형별
					 				<input type="checkbox" id="myFormReview" onclick="sendReview('');" style="border: 0; background: white;"><br/>
                              		<input type="button" id="review_created" onclick="sendReview('review_created');" value="최신순" style="border: 0; background: white;">|
					 				<input type="button" id="review_score" onclick="sendReview('review_score');"  value="별점순"   style="border: 0; background: white;">|	 				
			            		</div>
			            		<!-- 리뷰 리스트  -->
			            		<span id="reviewSort"></span>
			            		<div class="viewMore" style="text-align: center;">
			            			<input type="button" id="reviewMore" value="view more" style="border: 0; background: white;">
			            		</div>
                            </div>
                            
                            <!-- 리뷰 끝  -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="related__title">
                        <h5>RELATED PRODUCTS</h5>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="/wit/resources/img/product/related/rp-1.jpg">
                            <div class="label new">New</div>
                            <ul class="product__hover">
                                <li><a href="/wit/resources/img/product/related/rp-1.jpg" class="image-popup"><span class="arrow_expand"></span></a></li>
                                <li><a href="#"><span class="icon_heart_alt"></span></a></li>
                                <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6><a href="#">Buttons tweed blazer</a></h6>
                            <div class="rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <div class="product__price">$ 59.0</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="/wit/resources/img/product/related/rp-2.jpg">
                            <ul class="product__hover">
                                <li><a href="/wit/resources/img/product/related/rp-2.jpg" class="image-popup"><span class="arrow_expand"></span></a></li>
                                <li><a href="#"><span class="icon_heart_alt"></span></a></li>
                                <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6><a href="#">Flowy striped skirt</a></h6>
                            <div class="rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <div class="product__price">$ 49.0</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="/wit/resources/img/product/related/rp-3.jpg">
                            <div class="label stockout">out of stock</div>
                            <ul class="product__hover">
                                <li><a href="/wit/resources/img/product/related/rp-3.jpg" class="image-popup"><span class="arrow_expand"></span></a></li>
                                <li><a href="#"><span class="icon_heart_alt"></span></a></li>
                                <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6><a href="#">Cotton T-Shirt</a></h6>
                            <div class="rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <div class="product__price">$ 59.0</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="/wit/resources/img/product/related/rp-4.jpg">
                            <ul class="product__hover">
                                <li><a href="/wit/resources/img/product/related/rp-4.jpg" class="image-popup"><span class="arrow_expand"></span></a></li>
                                <li><a href="#"><span class="icon_heart_alt"></span></a></li>
                                <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6><a href="#">Slim striped pocket shirt</a></h6>
                            <div class="rating">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                            </div>
                            <div class="product__price">$ 59.0</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Details Section End -->

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

var PROD_SUBCODE = "${dto.PROD_SUBCODE }";
var sortChk = null;
var mode = null;
var url = "<%=cp%>/product/review.action";

//처음 리뷰를 클릭했을때 || 정렬 or 체크박스 선택시 타는 함수
function sendReview(sort, pageNum){

	if(!sort) {
		sort = sortChk;
	}

	if(!pageNum) {
		pageNum = 1;
	}

	$(".reviewSortNav input").each(function(){
		
		var cnt = $("input:checkbox:checked").length; 	//체크박스 개수 카운트

		if(cnt == 0) {
			mode = null; //정렬 || 체크박스 아무것도 선택하지 않았을시
		} 
		
		if($(this).prop("checked") == true) { 
			if(cnt == 1) {					
				mode = $(this).attr("id"); //포토리뷰 || 체형별리뷰		
			} else {
				mode = "all"; //내 체형 && 포토리뷰 둘다 선택						
			}
		}

		$('.reviewSortNav input').css("font-weight", "");
		$('#' + sort).css("font-weight", "bold"); //선택한 정렬 볼드체	

	});

	$.ajax({
		type:"POST",
		url:url,
		data:{sort : sort, PROD_SUBCODE : PROD_SUBCODE, mode : mode, pageNum : pageNum},
		async: false,									//동기식으로 변환
		success:function(args){
			$('#reviewSort').html(args);			
		},
		error:function(e){
			alert(e.responseText);
		}
	});

	var	totalPage = $('#totalPage').val(); //토탈페이지

	//더보기 show/hide
	if(totalPage<=pageNum || totalPage == 0){	//마지막 페이지일떄 || 데이터가 없을때
		$("#reviewMore").hide();
	}else{
		$("#reviewMore").show();
	}

	sortChk = sort; //sort는 매개변수로 넘어왔기때문에 sortChk에 sort를 담아서 저장해놈

}

//더보기를 클릭했을때 타는 함수

$('.viewMore').on('click','input',function(){

	addPageReview(); //페이징 
	
	var totalPage = $('#totalPage').attr("value");
	var pageNum = $('#reviewPageNum').attr("value");

	$.ajax({
		type:"POST",
		url:url,
		data:{sort : sortChk, PROD_SUBCODE : PROD_SUBCODE, mode : mode, pageNum : pageNum},
		async: false,									//동기식으로 변환
		success:function(args){
			$('#reviewSort').html(args);	
		},
		error:function(e){
			alert(e.responseText);
		}	
	});
	
	if(totalPage<=pageNum || totalPage == 0 ) {
		$("#reviewMore").hide();
	}	
});	

//페이징 함수
function addPageReview() {

	var pageNum = Number($('#reviewPageNum').attr("value"))+1; //더보기를 누르면 페이지넘 +1
	$('#reviewPageNum').attr("value",pageNum); // review.jsp에 reviewPageNum이라는 아이디의 value값을 변경
}

</script>

</body>

</html>