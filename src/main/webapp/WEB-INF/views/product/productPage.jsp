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
			var checkedSubcode = '${dto.PROD_SUBCODE }';
			var f = document.prodForm;
			
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
					prodStr = checkedSubcode + prodStr;												// 문자열(0)에 subcode 삽입												// 문자열(0)에 subcode 삽입	
					$(f).append($('<input/>', {type: 'hidden', name: 'prodStr', value: prodStr}));	// form에 매개변수 저장 후 이동
					f.submit();
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
                        <a href="#">Women's </a>
                        <span>Essential structured blazer</span>
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
                                <a class="nav-link" data-toggle="tab" href="#tabs-3" onclick="sendReview('review_created');" role="tab">Reviews ( 2 )</a>
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