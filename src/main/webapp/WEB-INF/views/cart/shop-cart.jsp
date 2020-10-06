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
<html lang="zxx">

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
</head>

<body>
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

 <span class="cartDetail"></span>

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

	//shopcart.action 들어오면 리스트 띄우기
	function startCart(){

		var url = "<%=cp%>/cart/shopcart_ok.action";
		 
		$.ajax({
			type:"POST",
			url:url,
			async: false,
			success:function(args){
				$(".cartDetail").html(args);
			},error:function(e){
		
			}	
		});
	}

    $(window).on('load',function(){
     
    	startCart();

    	//수량변화 (+,-) 눌렀을때
        $('.cartDetail').on('click','.qtybtn','.pro-qty',function(){
        	hide(); //옵션변경 hide
        	var parent = $(this).closest("tr");
            var cartQtyValue = parent.find('.cartQtyValue').val(); //선택한 상품의 수량
            var cartAmountValue = parent.find('.cart__total').text(); //선택한 상품의 총액 
            var cartPriceValue = parent.find('.cart__price').text(); //선택한 상품의 한개의 가격
        	var url = "<%=cp%>/cart/updateCart.action";
            var prod_code = parent.find('.cart_prod_code').val(); //선택한 상품의 prod_code

			// +를 눌렀을때
        	if($(this).hasClass('inc')){
    			cartQtyValue = Number(cartQtyValue) + 1; //수량은 +1
    			cartAmountValue = Number(cartAmountValue) + Number(cartPriceValue) ; //지금 총액 + 원래 상품 한개의 가격
    			
    		}else{ //- 눌렀을때
        		
    			if(Number(cartQtyValue) > 1) {	
    				cartQtyValue = Number(cartQtyValue) - 1; //수량 -1
    				cartAmountValue = Number(cartAmountValue) - Number(cartPriceValue) ; //지금 총액 - 원래 상품 한개의 가격
    			}
    		}
	    		$.post(url,{cart_qty : cartQtyValue, prod_code : prod_code, prod_price : cartPriceValue},function(args){
	    			//db 업데이트 성공했을시
	    			parent.find('.cartQtyValue').val(cartQtyValue); //뷰단에서 수량 변경
	    			parent.find('.cart__total').text(cartAmountValue); //총액 변경
	    			$('.total_amount').text(args); //모든 상품의 총액 변경			
	    			
	    		});	
      	});

    	//체크박스 선택한것들 삭제
        $('.cartDetail').on('click','.deleteCart',function(){

            var prod_code = "";
        	var url = "<%=cp%>/cart/deleteCart.action";

            $(".cart__product__item input:checkbox").each(function(){
            	var parent = $(this).closest("tr");
                if($(this).prop("checked")){
                	prod_code += parent.find('.cart_prod_code').val() + ",";
                }
            });

    		$.post(url,{prod_code : prod_code},function(args){	
    			$(".cartDetail").html(args);
    		});
       
        });

    	//한개씩 삭제
        $('.cartDetail').on('click','.icon_close',function(){
    		
        	var url = "<%=cp%>/cart/deleteCart.action";
    		var parent = $(this).closest("tr");   
    		var prod_code = parent.find('.cart_prod_code').val() + ","; //체크박스랑 같은 메소드를 사용해서 뒤에 ,넣어줌
            
    		$.post(url,{prod_code : prod_code},function(args){	
    			$(".cartDetail").html(args);
    		});	    		
       
        });
     
    	//전체 체크박스 선택했을시
        $('.cartDetail').on('click','.chkAll',function(){
     
            if($(".chkAll").prop("checked")){
                $("input[class=cart_check]").prop("checked",true);
                
            }else{ 	  
                $("input[class=cart_check]").prop("checked",false);  
            }
        
        });

    	//전체체크한 후 한개라도 체크를 해제하면 전체체크박스 체크 해제
        $('.cartDetail').on('click','.cart_check',function(){

        	var allCnt = $("input:checkbox").length; //전체 체크박스 개수
        	var chkCnt = $("input:checkbox:checked").length; //체크된 체크박스 개수

        	 if(chkCnt != allCnt) {
      	     	$("input[class=chkAll]").prop("checked",false);
      	     }   
            
        });             
    		
	});


</script>

</body>

</html>