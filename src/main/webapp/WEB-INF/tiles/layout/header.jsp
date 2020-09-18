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
                        <a href="main.action" style="font: bold; color: black;"><!-- <img src="/wit/resources/img/logo.png" alt=""> -->
                        What Should I wear Today?</a>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
                        <ul>
                            <li class="active"><a href="${pageContext.request.contextPath}/category/shop.action?category1=TOP">TOP</a>
                            	<ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=TOP&category2=SLV">
											SLEEVELESS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=TOP&category2=MTM">
                                    		MTM</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=TOP&category2=BLS">
                                    		BLOUSE</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=TOP&category2=SHT">
                                    		SHIRTS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=TOP&category2=TRN">
                                    		TRAINING</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=TOP&category2=OUTER">
                                    		OUTER</a></li>
                                </ul>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=BOTTOM">BOTTOM</a>
                            	<ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=BOTTOM&category2=SHORT">
											SHORTS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=BOTTOM&category2=SLX">
                                    		SLAX</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=BOTTOM&category2=DNM">
                                    		DENIM</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=BOTTOM&category2=CTN">
                                    		COTTON</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=BOTTOM&category2=SKT">
                                    		SKIRT</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=BOTTOM&category2=TRN">
                                    		TRAINING</a></li>
                                </ul>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=SHOES">SHOES</a>
                            	<ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=SHOES&category2=RUN">
											RUNNING</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=SHOES&category2=SDL">
                                    		SANDALS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=SHOES&category2=SLP">
                                    		SLIPPER</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=SHOES&category2=SNK">
                                    		SNEAKERS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=SHOES&category2=HYL">
                                    		HILL</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=SHOES&category2=RW">
                                    		LOAFERS&<BR/>WALKER</a></li>
                                </ul>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=OPS">OPS</a>
                            	<ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=OPS&category2=OPS_JS">
											OPS&<BR/>
											JUMPSUIT</a></li>
                                </ul>
                            </li>
 
                            <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=ACC">ACC</a>
                               <ul class="dropdown">
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=ACC&category2=WAT">
											WATCH</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=ACC&category2=CAP">
                                    		CAP</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=ACC&category2=EAR">
                                    		EARING</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=ACC&category2=RING">
                                    		RING</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=ACC&category2=NCL">
                                    		NECKLESS</a></li>
                                    <li><a href="${pageContext.request.contextPath}/category/shop.action?category1=ACC&category2=BAG">
                                    		BAG</a></li>
                                </ul>
                            </li>
                            <li><a href="blog.action">Blog</a></li>
                            <li><a href="contact.action">Contact</a></li>
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
                                <div class="tip">${hmap.HEARTCNT }</div>
                            </a></li>
                            <li><a href="#"><span class="icon_bag_alt"></span>
                                <div class="tip">${hmap.CARTCNT }</div>
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
</body>
</html>