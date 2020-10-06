<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    
    <style type="text/css">
    
		.container {
			max-width: 1030px;
		}
    	.nav {
    		background: #F1F1F1;
    	}
    	.nav::before {
    		background: #F1F1F1;
    	}
    	.nav::after {
    		background: #F1F1F1;
    	}
    	.nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
		    background-color: #F1F1F1;
		}
		.nav-item {
		    margin: 0 140px 0 0;
		    padding: 12px 0 12px 0;
		}
		.nav-item .nav-link {
		    color: #9B9B9B;
		}
		.shop__cart__table tbody tr .cart__product__item {
		    width: 430px;
		}
		.shop__cart__table tbody tr .cart__product__item img {
		    width: 90px;
		    height: 90px;
		}
    
    </style>
    
    <script type="text/javascript">

    	// 화면마다의 url 셋팅
	    var urlArr = new Array(
	    		"orderPage.action",
	    		"reviewPage.action",
	    		"heartPage.action"
	    		);
		var reviewWrite = false;
		var fileArr = new Array();

    	// 페이지 호출(1: orderPage, 2: reviewPage, 3: heartPage)
    	function getPage(choice){
			$.ajax({
				type: 'POST',
	        	url: urlArr[choice-1],
	        	async: false,
	        	success: function(args) {
	        		$('#tabs-' + choice).html(args);
	        	}
			});
        }

    	$(function(){
			// 페이지가 로드되면 첫 화면을 미리 셋팅해둠
    		for(var i=1;i<=urlArr.length;i++) {
    			getPage(i);
   			}

			// 특정 페이지 요청시 해당 화면으로 셋팅
			$(".nav-item:eq(" + ${choice } + ")").children().trigger("click");

			// Review 클릭 시(리뷰 작성 창이라면 초기화)
    		$('.nav-item:eq(1)').on('click', "a", function(){
				if(reviewWrite) {
					getPage(2);	
					reviewWrite = false;
				}
        	});
    		
        	// heart의 체크박스 라벨 클릭 시
			$('.tab-pane').on('click', '.myPage__heart__item', function(){
				var children = $(this).children().first();
				children.toggleClass("active");
				children.next().prop("checked", function(index, prop){
				    return prop == true ? false : true;
				});
			});

        	// Order의 Write Review 클릭 시
			$('#tabs-1').on('click', "a", function(){
				var order_code = $(this).closest("tr").attr("id");
				var prod_code = $(this).parent().attr("id");
				var url = "reviewWritePage.action";

				$.post(url, {order_code:order_code, prod_code:prod_code}, function(args){
					reviewWrite = false;
					$(window).scrollTop(200);
	   				$('#tabs-2').html(args);
	   				$(".nav-item:eq(1)").children().trigger("click");
					reviewWrite = true;
	   			});
			});

        	// Write Review의 File Upload 클릭 시
			$('#tabs-2').on('click', '.file__upload', function(){
				$(this).parent().children().last().trigger("click");
			});

			// Write Review의 File을 올렸을 시
			$('#tabs-2').on('change', 'input[type=file]', function(){
				var fileLength = fileArr.length;
			  	Array.prototype.push.apply(fileArr, $(this)[0].files);	// object File, object File... 으로 보내짐
			  	//fileArr.push($(this)[0].files);						// object FileList 로 보내짐	
			  	
			  	if(fileArr.length<=4) {
			  		$(this).parent().append($(this).clone());
			  		$(this).next().val("");
			  		$(this).parent().children("span").text(fileArr.length + " files");
			  	} else {
			  		fileArr.splice(fileLength);
			  		$(this).val("");	
					alert("이미지는 4개까지만 첨부가능합니다");
				}  	
			});

			// Write Review의 Write Review(submit) 클릭 시
			$('#tabs-2').on('click', "input[type=submit]", function(){
				fileArr = new Array();
			});

			// Review의 Show Detail 클릭 시
			$('#tabs-2').on('click', "a:first-child", function(){
				alert($(this).parent().attr("id"));
			});

			// Review의 Delete This 클릭 시
    		$('#tabs-2').on('click', "a:last-child", function(){
				var ok = confirm("Are you sure you want to delete?");
				
				if(ok) {
					var url = "reviewDelete.action";
					var param = $(this).parent().attr("id");
					
					$.post(url, {review_num:param}, function(args){
						getPage(2);
		   			});
				}
			});

    		// Heart의 Select All 클릭 시
			$('#tabs-3').on('click', "a:first-child", function(){
				if($('.myPage__heart__item input').length == $('.myPage__heart__item input:checked').length) {
					$('.myPage__heart__item label').removeClass("active"); 	//체크박스 초기화
					$('.myPage__heart__item input').prop("checked", false); //체크박스 초기화
				} else {
					$('.myPage__heart__item label').addClass("active"); 	//체크박스 초기화
					$('.myPage__heart__item input').prop("checked", true); 	//체크박스 초기화
				}	
			});

			// Heart의 Delete 클릭 시
			$('#tabs-3').on('click', "a:last-child", function(){
				var ok = confirm("Are you sure you want to delete?");
				
				if(ok) {
					var url = "heartDelete.action";
					var prod_subcode = "";
					
					$('.myPage__heart__item input:checked').each(function(i){
						prod_subcode += "'" + $(this).parent().children("h6").text() + "',";
					});
					
					$.post(url, {prod_subcode:prod_subcode.slice(0, -1)}, function(args){
						getPage(3);
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
                        <span>MyPage</span>
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
                <div class="col-lg-12">
	                <ul class="nav nav-tabs" role="tablist">
	                    <li class="nav-item">
	                        <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">Order</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">Review</a>
	                    </li>
	                    <li class="nav-item">
	                        <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">Heart</a>
	                    </li>
	                </ul>
	                <div class="tab-content">
	                    <div class="tab-pane active" id="tabs-1" role="tabpanel"></div>
	                    <div class="tab-pane" id="tabs-2" role="tabpanel"></div>
	                    <div class="tab-pane" id="tabs-3" role="tabpanel"></div>
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
    
</body>

</html>