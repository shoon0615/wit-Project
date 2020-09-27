<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<div class="shop__cart__table">
	<table>
	    <thead>
	        <tr>
				<th style="padding-left: 26px;">Order Code</th>
                <th style="padding-left: 115px;">Product</th>
                <th>Buy Date</th>
                <th style="padding-left: 10px;">Total</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="dto" items="${lists }">
	            <tr>
	            	<c:if test="${dto.review_num == dto.order_code_cnt }">
	            		<td class="cart__ordercode" rowspan="${dto.order_code_cnt }" style="padding-left: 26px;">${dto.order_code }</td>
	            	</c:if>
	                <td class="cart__product__item"> 	
	                    <img src="/wit/resources/img/shop-cart/cp-1.jpg" alt="">
	                    <div class="cart__product__item__title">
	                       	<h6>${dto.prod_subcode } × ${dto.prod_qty }</h6>
	                       	<span>[ ${dto.prod_color }/${dto.prod_size } ]</span>
	                    </div>
	                </td>
	                <td class="cart__buydate">${dto.review_created }</td>
	                <td class="cart__total">￦ <fmt:formatNumber value="${dto.prod_price }" type="number"/></td>
	                <td id="${dto.prod_code }" class="myPage__order__insert">
	              		<a>Write Review</a>
	                </td>
	            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>