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
            <tr>
            	<td class="cart__ordercode" rowspan="2" style="padding-left: 26px;">20200918171943</td>
                <td class="cart__product__item"> 	
                    <img src="/wit/resources/img/shop-cart/cp-1.jpg" alt="">
                    <div class="cart__product__item__title">
                       	<h6>Chain bucket bag × 2</h6>
                       	<span>[ RED/260 ]</span>
                    </div>
                </td>
                <td class="cart__buydate">2020.09.21</td>
                <td class="cart__total">￦ 55000</td>
                <td class="myPage__order__insert">
              		<a href="#">Write Review</a>
                </td>
            </tr>
            <tr>
                <td class="cart__product__item"> 	
                    <img src="/wit/resources/img/product/ADIDAS1.jpg" alt="">
                    <div class="cart__product__item__title">
                       	<h6>Chain bucket bag × 2</h6>
                       	<span>[ RED/260 ]</span>
                    </div>
                </td>
                <td class="cart__buydate">2020.09.21</td>
                <td class="cart__total">￦ 55000</td>
                <td class="myPage__order__insert">
              		<a href="#">Write Review</a>
                </td>
            </tr>
            <c:forEach var="dto" items="${lists }">
	            <tr>
	            	<td class="cart__ordercode" rowspan="1" style="padding-left: 26px;">${dto.order_code }</td>
	                <td class="cart__product__item"> 	
	                    <img src="/wit/resources/img/shop-cart/cp-1.jpg" alt="">
	                    <div class="cart__product__item__title">
	                       	<h6>${dto.prod_subcode } × ${dto.prod_qty }</h6>
	                       	<span>[ ${dto.prod_color }/${dto.prod_size } ]</span>
	                    </div>
	                </td>
	                <td class="cart__buydate">${dto.review_created }</td>
	                <td class="cart__total">￦ <fmt:formatNumber value="${dto.prod_price }" type="number"/></td>
	                <td class="myPage__order__insert">
	              		<a href="#">Write Review</a>
	                </td>
	            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>