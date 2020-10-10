<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<c:forEach var="dto" items="${lists }">
	<div class="myPage__review__text">
		<img src="<spring:url value='/product/${dto.prod_img }'/>" alt=""/>
		<div class="myPage__review__item">
			<span>${dto.review_created }</span>
	        <h3>${dto.prod_subcode } <span>[ ${dto.prod_color }/${dto.prod_size } ]</span></h3>
			<div class="rating">
				<c:forEach begin="1" end="${dto.review_score }">
                   	<i class="fa fa-star"></i>
                </c:forEach>
                <c:forEach begin="1" end="${5 - dto.review_score }">
                   	<span class="fa fa-star"></span>
                </c:forEach>
			</div>
		</div>
	   	<div id="${dto.review_num }" class="myPage__review__tags">
	          <a>Show Detail</a>
	          <a>Delete This</a>
	    </div>
	   	<p>${dto.review_contents }</p>
	</div>
</c:forEach>