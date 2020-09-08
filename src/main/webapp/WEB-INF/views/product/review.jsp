<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	request.setCharacterEncoding("UTF-8"); 
String cp = request.getContextPath();%>

<script type="text/javascript" src="/wit/resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript">


</script>

<c:forEach var="dto1" items="${review_lists}" varStatus="status">
   	 <c:if test="${status.index%2 == 0 }">
        <div class="blog__comment__item">
           <div class="blog__comment__item__pic">
         <c:forEach var="dto2" items="${dto1.review_img }">
             <img src="/wit/resources/img/blog/details/${dto2 }" alt="">		                                    		
		</c:forEach>
              </div>
              <div class="blog__comment__item__text">
                  <h6>${dto1.user_id} ${dto1.review_score  }</h6>
                  <div class="rating">
                                  <c:if test="${dto1.review_score  > 0 }">
                           	   <c:forEach begin="1" end="${dto1.review_score  }">
                                  <i class="fa fa-star"></i>
                               </c:forEach>
                               <c:forEach begin="1" end="${5 - dto1.review_score  }">
                                  <span class="fa fa-star"></span>
                               </c:forEach>
                            </c:if>
                            <c:if test="${dto1.review_score == 0 }">
                            	<c:forEach begin="1" end="${5 - dto1.review_score  }">
                                  <span class="fa fa-star"></span>
                               </c:forEach>
                            </c:if>
            		</div>
                  <p>${dto1.review_contents } </p>
                  <ul>
                      <li><i class="fa fa-clock-o"></i>${dto1.review_created }</li>
                      <li><i class="fa fa-heart-o"></i> 12</li>
                      <li><i class="fa fa-share"></i> 1</li>
                  </ul>
              </div>
      	</div>
      </c:if> 
      <c:if test="${status.index%2 != 0 }">
        		<div class="blog__comment__item blog__comment__item--reply">
              <div class="blog__comment__item__pic">
                  <c:forEach var="dto2" items="${dto1.review_img }">
                 		<img src="/wit/resources/img/blog/details/${dto2 }" alt="">		                                    		
					</c:forEach>			            
              </div>            
              <div class="blog__comment__item__text">
                  <h6>${dto1.user_id} ${dto1.review_score  }</h6>
                  <div class="rating">
                                  <c:if test="${dto1.review_score  > 0 }">
                           	   <c:forEach begin="1" end="${dto1.review_score  }">
                                  <i class="fa fa-star"></i>
                               </c:forEach>
                               <c:forEach begin="1" end="${5 - dto1.review_score  }">
                                  <span class="fa fa-star"></span>
                               </c:forEach>
                            </c:if>
                            <c:if test="${dto1.review_score == 0 }">
                            	<c:forEach begin="1" end="${5 - dto1.review_score  }">
                                  <span class="fa fa-star"></span>
                               </c:forEach>
                            </c:if>
            		</div>
                  <p>${dto1.review_contents }</p>
                  <ul>
                      <li><i class="fa fa-clock-o"></i>${dto1.review_created }</li>
                      <li><i class="fa fa-heart-o"></i> 12</li>
                      <li><i class="fa fa-share"></i> 1</li>
                  </ul>
              </div>
      	</div>
      </c:if>   
</c:forEach>
    
<input type="hidden" id="reviewPageNum" value="${pageNum}" />
<input type="hidden" id="totalPage" value="${totalPage}" />


