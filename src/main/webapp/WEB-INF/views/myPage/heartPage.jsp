<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<div class="myPage__heart__text">
	<c:forEach var="dto" items="${lists }">
		<div class="myPage__heart__item">
			<label></label>
			<input type="checkbox"/>
			<img src="/wit/resources/img/shop-cart/cp-1.jpg" alt="">
			<h6>${dto.prod_subcode }</h6>
			<div class="rating">
				<i class="fa fa-star"></i>
               	<i class="fa fa-star"></i>
            	<i class="fa fa-star"></i>
             	<i class="fa fa-star"></i>
               	<i class="fa fa-star"></i>
			</div>
			<div class="myPage__heart__item__price">￦ <fmt:formatNumber value="${dto.prod_price }" type="number"/></div>
		</div>
	</c:forEach>
</div>
                            