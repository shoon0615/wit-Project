<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
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
<!-- Css Styles -->
<link rel="stylesheet" href="/wit/resources/css/bootstrap.min.css"
	type="text/css">
<link rel="stylesheet" href="/wit/resources/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="/wit/resources/css/elegant-icons.css"
	type="text/css">
<link rel="stylesheet" href="/wit/resources/css/jquery-ui.min.css"
	type="text/css">
<link rel="stylesheet" href="/wit/resources/css/magnific-popup.css"
	type="text/css">
<link rel="stylesheet" href="/wit/resources/css/owl.carousel.min.css"
	type="text/css">
<link rel="stylesheet" href="/wit/resources/css/slicknav.min.css"
	type="text/css">
<link rel="stylesheet" href="/wit/resources/css/style.css"
	type="text/css">
<c:forEach var="dto" items="${list}">
	<div class="col-lg-4 col-md-6">
		<div class="product__item">
			<div class="product__item__pic set-bg"
				data-setbg="/wit/resources/img/shop/shop-1.jpg">
				<div class="label new">New</div>
				<!--<div class="label stockout stockblue">Out Of Stock</div>
                    <div class="label">Sale</div>
                -->
				<ul class="product__hover">
					<li><a href="/wit/resources/img/shop/shop-1.jpg"
						class="image-popup"><span class="arrow_expand"></span></a></li>
					<li><a href="#"><span class="icon_heart_alt"></span></a></li>
					<li><a href="#"><span class="icon_bag_alt"></span></a></li>
				</ul>
			</div>
			<div class="product__item__text">
				<h6>
					<a href="#">${dto.prod_contents}</a>
				</h6>
				<div class="rating">
					<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
						class="fa fa-star"></i> <i class="fa fa-star"></i> <i
						class="fa fa-star"></i>
				</div>
				<div class="product__price">${dto.prod_price}원</div>
			</div>
		</div>
	</div>
</c:forEach>
<div class="col-lg-12 text-center">
	<div class="pagination__option">
		<!-- 페이징 -->
		<c:if test="${dataCount != 0 }">${pageIndexList }</c:if>
		<c:if test="${dataCount == 0 }">등록된 게시물이 없습니다</c:if>
	</div>
</div>
<input type="hidden" id="pageNum" value="${pageNum}" />
<input type="hidden" id="category1" value="${category1}" />
<input type="hidden" id="category2" value="${category2}" />

