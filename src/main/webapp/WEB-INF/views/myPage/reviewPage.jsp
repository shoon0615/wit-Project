<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<c:forEach var="dto" items="${lists }">
	<div class="myPage__review__text">
		<img src="/wit/resources/img/shop-cart/cp-1.jpg" alt=""/>
		<div class="myPage__review__item">
			<span>${dto.review_created }</span>
	        <h3>${dto.prod_subcode } <span>[ ${dto.prod_color }/${dto.prod_size } ]</span></h3>
	        <div class="rating">
	            <i class="fa fa-star"></i>
	            <i class="fa fa-star"></i>
	            <i class="fa fa-star"></i>
	            <i class="fa fa-star"></i>
	            <span class="fa fa-star"></span>
	        </div>
		</div>
	   	<div class="myPage__review__tags">
	          <a href="#">Show Detail</a>
	          <a href="#">Delete This</a>
	    </div>
	   	<p>${dto.review_contents }</p>
	</div>
</c:forEach>