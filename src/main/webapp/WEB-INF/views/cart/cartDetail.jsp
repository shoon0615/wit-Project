<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<script src="/wit/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

//옵션변경을 클릭했을때
$('.optionChange').on('click',function(){
	hide(); //옵션창 하나만 선택되게 하기위해 우선 하이드해줌
	var next = $(this).next();
	next.find('#cartOptionModal').html(); //div id cartOptionModal이 있는 html(cartOptionModal.jsp)을 찾아서 불러옴
	next.attr("style","display: block;"); //show

});

//아이프레임(옵션창) 숨기기
function hide() {
	$('.my_iframe').hide();
}

</script>

   <!-- Shop Cart Section Begin -->
    <section class="shop-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shop__cart__table">
                        <table>
                            <thead>
                                <tr> 
                                	<input type="checkbox" class="chkAll"> 
                                    <th style="padding-left: 35px;">Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                    <th></th> 
                                </tr>
                            </thead>
                            <tbody>
                            
                            <c:forEach var="dto" items="${lists }">
                                <tr>
                                    <td class="cart__product__item">
                                     <input type="checkbox" class="cart_check">
                                        <img src="/wit/resources/img/shop-cart/cp-1.jpg" alt="">
                                        <div class="cart__product__item__title">
                                            <h6>${dto.prod_subcode }</h6>
                                             <input type="text" class="cart_prod_code" value="${dto.prod_code }" style="font: -webkit-small-control; color: #cccccc; border: 0;">
                                            <div class="rating">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                            <input type="button" class="optionChange" value="option 변경">
                                            <iframe class="my_iframe" 
                                            SRC='<%=cp%>/cart/cartOptionChange.action?prod_code=${dto.prod_code}&prod_subcode=${dto.prod_subcode}&cart_qty=${dto.cart_qty}&prod_price=${dto.prod_price}' 
                                            style="display: none;"></iframe>
                                        </div>
                                    </td>
                                    <td class="cart__price">${dto.prod_price}</td>
                                    <td class="cart__quantity">
                                        <div class="pro-qty">
                                        	<input class="dec qtybtn" type="button" value="-">
                                            <input class="cartQtyValue" disabled="disabled" type="text" value="${dto.cart_qty }">
                                            <input class="inc qtybtn" type="button" value="+">            
                                        </div>
                                    </td>
                                    <td class="cart__total">${dto.cart_amount}</td>
                                    <td class="cart__close"><span class="icon_close"></span></td>
                                </tr>       
							</c:forEach>  	
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="cart__btn">
                        <a href="#">Continue Shopping</a>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="cart__btn update__btn">
                        <!-- <span class="icon_loading"></span> -->
                        <input type="button" class="deleteCart" value=" Delete cart">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="discount__content">
                        <h6>Discount codes</h6>
                        <form action="#">
                            <input type="text" placeholder="Enter your coupon code">
                            <button type="submit" class="site-btn">Apply</button>
                        </form>
                    </div>
                </div>
                <div class="col-lg-4 offset-lg-2">
                    <div class="cart__total__procced">
                        <h6>Cart total</h6>
                        <ul>
                            <li>Total <span class="total_amount">${total_amount }</span></li>
                        </ul>
                        <a href="#" class="primary-btn">Proceed to checkout</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Cart Section End -->
