/*  ---------------------------------------------------
Template Name: Ashion
Description: Ashion ecommerce template
Author: Colorib
Author URI: https://colorlib.com/
Version: 1.0
Created: Colorib
---------------------------------------------------------  */

'use strict';

(function ($) {

	var checked = "";

    /*------------------
        Preloader
    --------------------*/
    $(window).on('load', function () {
        $(".loader").fadeOut();
        $("#preloder").delay(200).fadeOut("slow");

        /*------------------
            Product filter
        --------------------*/
        $('.filter__controls li').on('click', function () {
            $('.filter__controls li').removeClass('active');
            $(this).addClass('active');
        });
        if ($('.property__gallery').length > 0) {
            var containerEl = document.querySelector('.property__gallery');
            var mixer = mixitup(containerEl);
        }
    });

    /*------------------
        Background Set
    --------------------*/
    $('.set-bg').each(function () {
        var bg = $(this).data('setbg');
        $(this).css('background-image', 'url(' + bg + ')');
    });

    //Search Switch
    $('.search-switch').on('click', function () {
        $('.search-model').fadeIn(400);
    });

    $('.search-close-switch').on('click', function () {
        $('.search-model').fadeOut(400, function () {
            $('#search-input').val('');
        });
    });

    //Canvas Menu
    $(".canvas__open").on('click', function () {
        $(".offcanvas-menu-wrapper").addClass("active");
        $(".offcanvas-menu-overlay").addClass("active");
    });

    $(".offcanvas-menu-overlay, .offcanvas__close").on('click', function () {
        $(".offcanvas-menu-wrapper").removeClass("active");
        $(".offcanvas-menu-overlay").removeClass("active");
    });

    /*------------------
		Navigation
	--------------------*/
    $(".header__menu").slicknav({
        prependTo: '#mobile-menu-wrap',
        allowParentLinks: true
    });

    /*------------------
        Accordin Active
    --------------------*/
    $('.collapse').on('shown.bs.collapse', function () {
        $(this).prev().addClass('active');
    });

    $('.collapse').on('hidden.bs.collapse', function () {
        $(this).prev().removeClass('active');
    });

    /*--------------------------
        Banner Slider
    ----------------------------*/
    $(".banner__slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 1,
        dots: true,
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true
    });

    /*--------------------------
        Product Details Slider
    ----------------------------*/
    $(".product__details__pic__slider").owlCarousel({
        loop: false,
        margin: 0,
        items: 1,
        dots: false,
        nav: true,
        navText: ["<i class='arrow_carrot-left'></i>","<i class='arrow_carrot-right'></i>"],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: false,
        mouseDrag: false,
        startPosition: 'URLHash'
    }).on('changed.owl.carousel', function(event) {
        var indexNum = event.item.index + 1;
        product_thumbs(indexNum);
    });

    function product_thumbs (num) {
        var thumbs = document.querySelectorAll('.product__thumb a');
        thumbs.forEach(function (e) {
            e.classList.remove("active");
            if(e.hash.split("-")[1] == num) {
                e.classList.add("active");
            }
        })
    }


    /*------------------
		Magnific
    --------------------*/
    $('.image-popup').magnificPopup({
        type: 'image'
    });


    $(".nice-scroll").niceScroll({
        cursorborder:"",
        cursorcolor:"#dddddd",
        boxzoom:false,
        cursorwidth: 5,
        background: 'rgba(0, 0, 0, 0.2)',
        cursorborderradius:50,
        horizrailenabled: false
    });

    /*------------------
        CountDown
    --------------------*/
    // For demo preview start
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();

    if(mm == 12) {
        mm = '01';
        yyyy = yyyy + 1;
    } else {
        mm = parseInt(mm) + 1;
        mm = String(mm).padStart(2, '0');
    }
    var timerdate = mm + '/' + dd + '/' + yyyy;
    // For demo preview end


    // Uncomment below and use your date //

    /* var timerdate = "2020/12/30" */

	$("#countdown-time").countdown(timerdate, function(event) {
        $(this).html(event.strftime("<div class='countdown__item'><span>%D</span> <p>Day</p> </div>" + "<div class='countdown__item'><span>%H</span> <p>Hour</p> </div>" + "<div class='countdown__item'><span>%M</span> <p>Min</p> </div>" + "<div class='countdown__item'><span>%S</span> <p>Sec</p> </div>"));
    });

    /*-------------------
		Range Slider
	--------------------- */
	var rangeSlider = $(".price-range"),
    minamount = $("#minamount"),
    maxamount = $("#maxamount"),
    minPrice = rangeSlider.data('min'),
    maxPrice = rangeSlider.data('max');
    rangeSlider.slider({
    range: true,
    min: minPrice,
    max: maxPrice,
    values: [minPrice, maxPrice],
    slide: function (event, ui) {
    	// 20200903 LSH: 슬라이드바 100단위로 수정되게 변경
        minamount.val('￦ ' + (Math.round(ui.values[0]/100)*100));
        maxamount.val('￦ ' + (Math.round(ui.values[1]/100)*100));
        }
    });
    minamount.val('￦ ' + rangeSlider.slider("values", 0));
    maxamount.val('￦ ' + rangeSlider.slider("values", 1));

    /*------------------
		Single Product
	--------------------*/
	$('.product__thumb .pt').on('click', function(){
		var imgurl = $(this).data('imgbigurl');
		var bigImg = $('.product__big__img').attr('src');
		if(imgurl != bigImg) {
			$('.product__big__img').attr({src: imgurl});
		}
    });
    
    /*-------------------
		Quantity change
	--------------------- */
	/*
    var proQty = $('.pro-qty');
	proQty.prepend('<span class="dec qtybtn" style="padding-left: 3px;">-</span>');
	proQty.append('<span class="inc qtybtn">+</span>');
	proQty.on('click', '.qtybtn', function () {
		var $button = $(this);
		var oldValue = $button.parent().find('input').val();
		var oldPrice = $('.product__details__price').text().substring(2);
		if ($button.hasClass('inc')) {
			var newVal = parseFloat(oldValue) + 1;
		} else {
			// Don't allow decrementing below zero
			// 20200818 LSH: 수량 1 미만 안되게 수정(기존 0)
			if (parseFloat(oldValue) > 1) {
				var newVal = parseFloat(oldValue) - 1;
			} else {
				newVal = 1;
			}
		}
	
		$button.parent().find('input').val(newVal);
    });
    */
    
    // 20200826 LSH: 리스트에 추가된 버튼만 조작할수있도록 수정(0829 총금액 추가)
	$('.product__details__list').on('click', '.qtybtn', function () {
		var $button = $(this);
		var oldValue = $button.parent().find('input').val();
		var oldPrice = $('.product__details__price').text().substring(2).replace(",", "");
		var totalAmount = $(".product__details__amount").children("span");	

		if ($button.hasClass('inc')) {
			var newVal = parseFloat(oldValue) + 1;
			var newPrc = parseFloat($button.closest("tr").find("td.prod__price").children("span").text()) + parseFloat(oldPrice);
			totalAmount.text(parseFloat(totalAmount.text()) + parseFloat(oldPrice));
		} else {
			// Don't allow decrementing below zero
			// 20200818 LSH: 수량 1 미만 안되게 수정(기존 0)
			if (parseFloat(oldValue) > 1) {
				var newVal = parseFloat(oldValue) - 1;
				var newPrc = parseFloat($button.closest("tr").find("td.prod__price").children("span").text()) - parseFloat(oldPrice);
				totalAmount.text(parseFloat(totalAmount.text()) - parseFloat(oldPrice));
			} else {
				newVal = 1;
				newPrc = parseFloat(oldPrice);
			}
		}

		$button.parent().find('input').val(newVal);
		$button.closest("tr").find("td.prod__price").children("span").text(newPrc);
    });
    
    /*-------------------
		Radio Btn
	--------------------- */
	// 20200822 LSH: 컬러 클릭시 checked 속성 추가되도록 click 함수 추가 및 두가지 옵션 선택시 초기화되도록 수정
	$(".color__checkbox label input").on('click', function () {
		if (checked == "" || checked == "color") {
        	$(".color__checkbox label input").removeAttr('checked');
        	$(this).attr('checked', true);
        	$('.color__checkbox label style').remove();
        	checked = "color";
        } else {
			checkedInsert();
			checked = "";
        }
    });
	
    $(".size__btn label input").on('click', function () {
    	if (checked == "" || checked == "size") {
        	$(".size__btn label").removeClass('active');
        	$(this).closest("label").addClass('active');
        	checked = "size";
        } else {
			checkedInsert();
			checked = "";
        }
    });
    
    var checkedInsert = function() {
    	$(".color__checkbox label input").after("<style type='text/css'>"
    		+ ".product__details__widget ul li .color__checkbox label input:checked~:after {opacity: 0;}"
    		+ ".product__details__widget ul li .color__checkbox label input[id='white']:checked~:after {opacity: 0;}</style>");
		$(".color__checkbox label input").removeAttr('checked');
		$(".size__btn label").removeClass('active');
		
		var checkedSubcode = $('.product__details__text').find('h3').text();
    	var checkedColor = $(':radio[name=color__radio]:checked').attr('id').toUpperCase();
		var checkedSize = $(':radio[name=size__radio]:checked').attr('id').replace("-btn", " ").trim().toUpperCase();
		
		$.post("choiceProd.action", {PROD_SUBCODE:checkedSubcode, PROD_COLOR:checkedColor, PROD_SIZE:checkedSize}, function(data){

			var proTable = $(".product__details__list table");
			var prod_COLOR = JSON.stringify(data.prod_COLOR).replace("\"", "").replace("\"", "");
			var prod_SIZE = JSON.stringify(data.prod_SIZE).replace("\"", "").replace("\"", "");
			var prod_SUBCODE = JSON.stringify(data.prod_SUBCODE).replace("\"", "").replace("\"", "");
			var prod_PRICE = JSON.stringify(data.prod_PRICE).replace("\"", "").replace("\"", "");

		    // $(".product__details__list table").append($('<tr/>', {type: 'hidden', name: 'shopCode', value: shopCode}));
		    // $(".product__details__list table").find("tr:last").append('<td class="prod__qty"><div class="pro-qty"><input type="text" value="1" disabled="disabled"/></div></td>');
		    
		    if($('#' + prod_COLOR + '-' + prod_SIZE).length != 0) {
		    	var $button = $('#' + prod_COLOR + '-' + prod_SIZE).closest("tr").find("div.pro-qty");
				var oldValue = $button.parent().find('input').val();
				var oldPrice = $('#' + prod_COLOR + '-' + prod_SIZE).closest("tr").find("td.prod__price").children("span").text();
				oldValue = parseFloat(oldValue) + 1;
				$('#' + prod_COLOR + '-' + prod_SIZE).closest("tr").find("td.prod__price").children("span").text(parseFloat(oldPrice) + parseFloat(prod_PRICE));
				$button.parent().find('input').val(oldValue);
		    } else {
			    proTable.append('<tr><td class="prod__sub"><span id="' + prod_COLOR + '-' + prod_SIZE + '"><b>' 
			    	+ prod_SUBCODE + '</b><br/>- ' 
			    	+ prod_COLOR + '/' + prod_SIZE + '</span></td>');
			    proTable.find("tr:last").append('<td class="prod__qty">');	
			    proTable.find("tr:last").find("td.prod__qty").prepend($('<div/>', {class: 'pro-qty'}));
			    proTable.find("tr:last").find("div.pro-qty").append('<input type="text" value="1" disabled="disabled"/></td>');
				proTable.find("tr:last").find("div.pro-qty").prepend('<span class="dec qtybtn" style="padding-left: 3px;">-</span>');
				proTable.find("tr:last").find("div.pro-qty").append('<span class="inc qtybtn">+</span>');
				proTable.find("tr:last").append('<td class="prod__close"><span class="icon_close"></span></td>');
				proTable.find("tr:last").append('<td class="prod__price">￦ <span>' + prod_PRICE + '</span></td></tr>');
			}
			
			// 20200829 LSH: 총금액 추가
			var totalAmount = $(".product__details__amount").children("span");
			totalAmount.text(parseFloat(totalAmount.text()) + parseFloat(prod_PRICE));
		}, "json");
    }
    
    $(".product__details__amount").on('click', function () {
 		totalInsert();
    });
    
    $('.product__details__list').on('click', '.icon_close', function () {
    	var totalAmount = $(".product__details__amount").children("span");
    	var oldAmount = $(this).closest("tr").find("td.prod__price").children("span").text();
    	
    	totalAmount.text(parseFloat(totalAmount.text()) - parseFloat(oldAmount));
    	$(this).closest("tr").remove();
    });
    
    $('.bag-btn').on('click', function () {
    	
    	var test = [];
    	
    	$(".product__details__list table").find("tr").each(function(i){
    		test.push($(this).find("td.prod__sub").children("span").attr("id") 
    		+ '-' + $(this).find("div.pro-qty").children("input").val());
    	});
    	
    	test.splice(0, 1);
    	
    	if(test.length == 0) {
    		alert("장바구니에 담을 내역이 없습니다!");
    	} else {
    		var checkedSubcode = $('.product__details__text').find('h3').text();
    		
    		$.post("selectBag.action", {PROD_SUBCODE:checkedSubcode, PROD_INFO:test}, function(data){
    			if(data != "") {
	    			var textim = "이미 장바구니에 존재하는 상품이 있습니다.\r\n";
					for(var i in data) {
						textim += "[" + data[i] + "]\r\n";
					}	
					textim += "그대로 진행하시겠습니까?"
					var ok = confirm(textim);
				}
				
				if(data == "" || ok == true) {
					$.post("insertBag.action", {PROD_SUBCODE:checkedSubcode, PROD_INFO:test}, function(data){
						alert("장바구니에 담겼습니다!");
						window.location.href = "shopcart.action";
					});
				}
			});
    	}
    });
    
    $(".product__big__img").on('mouseenter', function () {
    	$(".owl-nav").css('display', 'block');
    });
    
    $(".product__big__img").on('mouseleave', function () {
    	$(".owl-nav").css('display', 'none');
    });
    
    $(".owl-nav").on('mouseenter', function () {
    	$(".owl-nav").css('display', 'block');
    });

})(jQuery);