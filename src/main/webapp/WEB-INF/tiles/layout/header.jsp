<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                        What Should wear Today?</a>
                    </div>
                </div>
                <div class="col-xl-6 col-lg-7">
                    <nav class="header__menu">
                        <ul>
                            <li class="active"><a href="main.action">Home</a></li>
                            <li><a href="#">Women's</a></li>
                            <li><a href="#">Men's</a></li>
                            <li><a href="shop.action">Shop</a></li>
                            <li><a href="#">Pages</a>
                                <ul class="dropdown">
                                    <li><a href="product-details.action">Product Details</a></li>
                                    <li><a href="shop-cart.action">Shop Cart</a></li>
                                    <li><a href="checkout.action">Checkout</a></li>
                                    <li><a href="blog-details.action">Blog Details</a></li>
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
                            <a href="#">Login</a>
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
</body>
</html>