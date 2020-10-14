<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();  %>

<!DOCTYPE html>
<html>
<head>
<!-- 날씨 js  -->
<script type = "text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type = "text/javascript" src="/wit/resources/js/weather.js"></script>
<script type="text/javascript">

	$(function(){
		var searchUrl = "/wit/product/productDetail.action?PROD_SUBCODE=";

		// 돋보기 버튼을 클릭했을 시
	    $('.search-switch').click(function(){
	    	var input = $(this).parent().prev();	
	    	
	    	// hide 여부 체크 및 텍스트가 없을 경우(뒤로가기로 인해 추가)
	    	if(!input.is(':visible') || !input.children().val()) {
		    	input.toggle();
		    	input.children().val("");
		    	input.children().focus();
			} else {
				window.location.href = searchUrl + input.children().val();
			}
		});

	    // 검색창에서 엔터키를 눌렀을 시
	    $('.header__right__input').keyup(function(){
	    	if(window.event.keyCode == 13) {
	    		window.location.href = searchUrl + $(this).val();
		    }
		});
	});

</script>

    <meta charset="UTF-8">
    <meta name="description" content="What should I wear Today?">
    <meta name="keywords" content="WIT, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>What should I wear Today?</title>
</head>
<body onload="weather();">

<tiles:importAttribute name="hmap"/>

<!-- 날씨  -->
<div style="text-align-last: right; padding-right: 34px;">
<div class="temp">&nbsp;<img class="weatherImg" src=""></div>
</div>
<!-- 날씨 끝  -->

  <!-- Header Section Begin -->
    <header class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-3 col-lg-2">
                    <div class="header__logo">
                        <a href="${pageContext.request.contextPath}/main/main.action" style="font: bold; color: black;"><!-- <img src="/wit/resources/img/logo.png" alt=""> -->
                        What Should I wear Today?</a>
                    </div>
                </div>
                <div class="col-xl-5 col-lg-7">
                    <nav class="header__menu">
                        <ul>
                            <li class="active"><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=TOP">TOP</a>
                            	<ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=TOP&prod_category2=SLV">
											SLEEVELESS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=TOP&prod_category2=MTM">
                                    		MTM</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=TOP&prod_category2=BLS">
                                    		BLOUSE</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=TOP&prod_category2=SHT">
                                    		SHIRTS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=TOP&prod_category2=TRN">
                                    		TRAINING</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=TOP&prod_category2=OUTER">
                                    		OUTER</a></li>
                                </ul>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=BOTTOM">BOTTOM</a>
                            	<ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=BOTTOM&prod_category2=SHORT">
											SHORTS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=BOTTOM&prod_category2=SLX">
                                    		SLAX</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=BOTTOM&prod_category2=DNM">
                                    		DENIM</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=BOTTOM&prod_category2=CTN">
                                    		COTTON</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=BOTTOM&prod_category2=SKT">
                                    		SKIRT</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=BOTTOM&prod_category2=TRN">
                                    		TRAINING</a></li>
                                </ul>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=SHOES">SHOES</a>
                            	<ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=SHOES&prod_category2=RUN">
											RUNNING</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=SHOES&prod_category2=SDL">
                                    		SANDALS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=SHOES&prod_category2=SLP">
                                    		SLIPPER</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=SHOES&prod_category2=SNK">
                                    		SNEAKERS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=SHOES&prod_category2=HYL">
                                    		HILL</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=SHOES&prod_category2=RW">
                                    		LOAFERS&<BR/>WALKER</a></li>
                                </ul>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=OPS">OPS</a>
                            	<ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=OPS&prod_category2=OPS_JS">
											OPS&<BR/>
											JUMPSUIT</a></li>
                                </ul>
                            </li>
 
                            <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=ACC">ACC</a>
                               <ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=ACC&prod_category2=WAT">
											WATCH</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=ACC&prod_category2=CAP">
                                    		CAP</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=ACC&prod_category2=EAR">
                                    		EARING</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=ACC&prod_category2=RING">
                                    		RING</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=ACC&prod_category2=NCL">
                                    		NECKLESS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?prod_category1=ACC&prod_category2=BAG">
                                    		BAG</a></li>
                                </ul>
                            </li>
                            <!-- <li><a href="blog.action">Blog</a></li>
                            <li><a href="contact.action">Contact</a></li> -->
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-4">
                
                    <div class="header__right">
                        <div class="header__right__auth">
                        	<c:if test="${sessionScope.customInfo.user_id == null}">
                            	<a href="<%=cp%>/custom/login">Login</a>
                            	<a href="<%=cp%>/custom/join">Register</a>
                            </c:if>  
                            <c:if test="${sessionScope.customInfo.user_id != null}">
                            	<a href="<%=cp%>/custom/logout">Logout</a>
                            	<a href="<%=cp%>/custom/modify">Modify</a>
                            </c:if> 
                            
                        </div>
                        
                        <ul class="header__right__widget">
                        	<li style="display: none;"><input class="header__right__input" type="text"/></li>
                            <li><span class="icon_search search-switch"></span></li>
                            <li>
                            	<a href="${pageContext.request.contextPath}/myPage/mainPage.action?choice=2">
                            		<span class="icon_heart_alt"></span>
                                	<div class="tip">${hmap.HEARTCNT }</div>
                            	</a>
                            </li>
                            <li>
                            	<a href="${pageContext.request.contextPath}/cart/shopcart.action">
                            		<span class="icon_bag_alt"></span>
                                	<div class="tip">${hmap.CARTCNT }</div>
                            	</a>
                            </li>
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
</body>
</html>