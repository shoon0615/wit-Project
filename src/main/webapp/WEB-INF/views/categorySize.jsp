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
<div class="section-title">
	<h4>사이즈</h4>
</div>
<c:if test="${category1 eq 'TOP'}">
	<div id="sizeList" class="size__list">
		<label for="TOP_XS"> XS <input type="checkbox" id="TOP_XS" value="XS">
			<span class="checkmark"></span>
		</label> <label for="TOP_S"> S <input type="checkbox" id="TOP_S" value="S">
			<span class="checkmark"></span>
		</label> <label for="TOP_M"> M <input type="checkbox" id="TOP_M" value="M">
			<span class="checkmark"></span>
		</label> <label for="TOP_L"> L <input type="checkbox" id="TOP_L" value="L">
			<span class="checkmark"></span>
		</label> <label for="TOP_XL"> XL <input type="checkbox" id="TOP_XL" value="XL">
			<span class="checkmark"></span>
		</label> <label for="TOP_XXL"> XXL <input type="checkbox" id="TOP_XXL" value="XXL">
			<span class="checkmark"></span>
		</label>
	</div>
</c:if>
<c:if test="${category1 eq 'BOTTOM'}">
	<div class="size__list">
		<label for="BOTTOM_S"> S <input type="checkbox" id="BOTTOM_S" value="S">
			<span class="checkmark"></span>
		</label>
		<label for="BOTTOM_M"> M <input type="checkbox" id="BOTTOM_M" value="M">
			<span class="checkmark"></span>
		</label>
		<label for="BOTTOM_L"> L <input type="checkbox" id="BOTTOM_L" value="L">
			<span class="checkmark"></span>
		</label> 
		<label for="BOTTOM_XL"> XL <input type="checkbox" id="BOTTOM_XL" value="XL"> <span
			class="checkmark"></span>
		</label>
	</div>
</c:if>
<c:if test="${category1 eq 'SHOES'}">
	<div class="size__list">
		<label for="SHOES_220"> 220 <input type="checkbox" id="SHOES_220" value="220">
			<span class="checkmark"></span>
		</label> 
		<label for="SHOES_230"> 230 <input type="checkbox" id="SHOES_230" value="230"> <span
			class="checkmark"></span>
		</label> 
		<label for="SHOES_240"> 240 <input type="checkbox" id="SHOES_240" value="240">
			<span class="checkmark"></span>
		</label>
		<label for="SHOES_250"> 250 <input type="checkbox" id="SHOES_250" value="250">
			<span class="checkmark"></span>
		</label>
		<label for="SHOES_260"> 260 <input type="checkbox" id="SHOES_260" value="260">
			<span class="checkmark"></span>
		</label>
		<label for="SHOES_270"> 270 <input type="checkbox" id="SHOES_270" value="270">
			<span class="checkmark"></span>
		</label>
		<label for="SHOES_280"> 280 <input type="checkbox" id="SHOES_280" value="280">
			<span class="checkmark"></span>
		</label>
	</div>
</c:if>
<c:if test="${category1 eq 'OPS' || category1 eq 'ACC'}">
	<div class="size__list">
		<label for="ACC_FREE"> FREE <input type="checkbox" id="ACC_FREE" value="FREE">
			<span class="checkmark"></span>
		</label> 
	</div>
</c:if>
<script type="text/javascript">
//정렬 버튼 클릭 이벤트
$('#sizeList label input').click(function(){
	var pageNum = $("#pageNum").val(); //페이지 넘버
	var category1 = $("#category1").val(); //카테고리1
	var category2 = $("#category2").val(); //카테고리2
	productList("all",pageNum,category1,category2,this);               
});

</script>