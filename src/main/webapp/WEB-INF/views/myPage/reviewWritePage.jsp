<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	request.setCharacterEncoding("UTF-8"); %>

<form method="post" action="reviewInsert.action" class="checkout__form" name="reviewForm" enctype="multipart/form-data">	
	<div class="subject">
	   	<h5 style="padding-top: 3px;padding-left: 26px;">Write Review</h5>
	</div>
	<div class="col-lg-9">
		<div class="row">
	        <div class="col-lg-12">
	            <div class="checkout__form__input">
	                <p>Score <span>*</span></p>
	                <div class="rating">
	                	<c:forEach var="i" begin="0" end="4">
	                		<input type="radio" id="star${5-i }" name="review_score" value="${5-i }"/>
	                       	<label class="fa fa-star" for="star${5-i }"></label> 
	                    </c:forEach>
	               	</div>
	            </div>
	            <div class="checkout__form__input">
	                <p>Message <span>*</span></p>
	                <textarea rows="10" name="review_contents" placeholder="Enter your Message"></textarea>
	            </div>
	            <div class="checkout__form__input">
	                <p>Photo <span>*</span></p>
	                <label class="file__upload">File Upload</label>
	                <span style="color: #3c3c3c;"></span>
	            	<input type="file" name="upload_img" style="display: none;" accept=".jpg,.jpeg,.png,.gif,.bmp" multiple/>
	            </div>
	            <button type="submit" class="myPage__write__review">
	            	<span class="icon_pencil-edit"></span>&nbsp;&nbsp;Write Review
	            </button>
	            <input type="hidden" name="order_code" value="${order_code }"/>
	            <input type="hidden" name="prod_code" value="${prod_code }"/>
	        </div> 
        </div>
    </div>
</form>