<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<script type="text/javascript">
	$('.set-bg').each(function () {
        var bg = $(this).data('setbg');
        $(this).css('background-image', 'url(' + bg + ')');
    });

	// 페이지 번호 클릭 시
	/* 
	$('.pagination__option').on('click',function(){
      
	}); 
	*/
</script>

<c:forEach var="dto" items="${list}">
	<div class="col-lg-4 col-md-6">
		<div class="product__item">
			<div class="product__item__pic set-bg"
				data-setbg="<spring:url value='/product/${dto.prod_img }'/>">
				<div class="label new">New</div>
				<!--<div class="label stockout stockblue">Out Of Stock</div>
                    <div class="label">Sale</div>
                -->
				<ul id="${dto.prod_subcode}" class="product__hover">
					<!-- <li><a href="/wit/resources/img/shop/shop-1.jpg" class="image-popup"><span class="arrow_expand"></span></a></li> -->
					<li><a href="${pageContext.request.contextPath}/product/productDetail?PROD_SUBCODE=${dto.prod_subcode}"><span class="arrow_expand"></span></a></li>
					<li><a class="heart_alt" style="cursor: pointer;"><span class="icon_heart_alt"></span></a></li>
					<li><a href="#"><span class="icon_bag_alt"></span></a></li>
				</ul>
			</div>
			<div class="product__item__text">
				<h6>${dto.prod_subcode}</h6>
				<div class="rating">
					<c:forEach begin="1" end="${dto.avgscore }">
                    	<i class="fa fa-star"></i>
                    </c:forEach>
                    <c:forEach begin="1" end="${5 - dto.avgscore }">
                    	<span class="fa fa-star"></span>
                    </c:forEach>
				</div>
				<div class="product__price">￦ ${dto.prod_price}</div>
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

