<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	request.setCharacterEncoding("UTF-8"); 
String cp = request.getContextPath();%>

<script type="text/javascript" src="/wit/resources/js/jquery-3.1.1.js"></script>
<script type="text/javascript">

//..more 을 눌렀을때 (상세리뷰)
$('.blog__comment__item__text').on('click','input',function(){

	var parent = $(this).parents("div");

	//..more show
	if($(this).attr("data-chk") == "show"){
		 parent.children(".reviewOption").show(); 
		 parent.children(".reviewDetailImg").show();
		 $(this).attr("data-chk","hide");
		 $(this).attr("value","..before");
	}else{
		//..more hide
		parent.children(".reviewOption").hide();
		parent.children(".reviewDetailImg").hide();
		$(this).attr("data-chk","show");
		$(this).attr("value","..more");
	}
});

//신고버튼을 눌렀을때
$('.blog__comment__item__text').on('click','i','.fa fa-heart-o',function(){
	
	var parent = $(this).parents("div");
	var review_num = parent.children(".reviewNum").val();
	var url = "<%=cp%>/product/report.action";
	var idx = $(this).attr('data-idx'); //신고한 버튼에 인덱스

	if($('#reportCnt' + idx).attr("value") != null) { //신고 카운트가 0 이 아닐때
		Number($('#reportCnt' + idx).attr("value"))+1; //원래 카운트 +1
	}else{
		$('#reportCnt' + idx).attr("value",1); //신고 카운트가 0일시 value값에 1 부여
	}

	var reportCnt = $('#reportCnt' + idx).attr("value"); //신고 카운트 저장	

	$.ajax({
		type:"POST",
		url:url,
		data:{review_num : review_num},					
		error:function(e){
			alert("이미 신고하셨습니다!");
		}	
	});
	
});

$(document).ready(function(){

	$('.reviewOption').hide();
	$('.reviewDetailImg').hide();
});

</script>	

<c:forEach var="dto1" items="${review_lists}" varStatus="status">
   	 <c:if test="${status.index%2 == 0 }">
        <div class="blog__comment__item">
           <div class="blog__comment__item__pic">
           <c:forEach var="dto2" items="${dto1.review_img }" begin="1" end="1">
           		<img src="/wit/resources/img/blog/details/${dto2 }" alt="">
           </c:forEach>
              </div>
              <div class="blog__comment__item__text">
              	  <input type="hidden" class="reviewNum" value="${dto1.review_num }">
                  <h6>${dto1.user_id} ${dto1.review_score  }</h6>
                  	<p class="reviewOption"  style="font: -webkit-small-control;">option : <br/></p>
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
                  <p>${dto1.review_contents } <br/>
                  	<input type="button" class="reviewDetail" data-chk="show" value="..more" style="border: 0; background: white; font-size: smaller; color: #cccccc;">
                  </p>
                  <p class="reviewDetailImg">
                  	<c:forEach var="dto2" items="${dto1.review_img }">
           				<img src="/wit/resources/img/blog/details/${dto2 }" alt="">
           			</c:forEach>
                  </p>
                  <ul>
                      <li><i class="fa fa-clock-o"></i>${dto1.review_created }</li>
                      <li><i class="fa fa-heart-o" data-idx="${status.index }"></i>&nbsp;<input id="reportCnt${status.index }" data-save="${reportCnt }" type="text" style="border: 0;"></li>
                      <li><i class="fa fa-share"></i> 1</li>
                  </ul>
              </div>
      	</div>
      </c:if> 
      <c:if test="${status.index%2 != 0 }">
        		<div class="blog__comment__item blog__comment__item--reply">
              <div class="blog__comment__item__pic">
                  <c:forEach var="dto2" items="${dto1.review_img }" begin="1" end="1">
                 		<img src="/wit/resources/img/blog/details/${dto2 }" alt="">		                                    		
					</c:forEach>			            
              </div>            
              <div class="blog__comment__item__text">
              	  <input type="hidden" class="reviewNum" value="${dto1.review_num }">
                  <h6>${dto1.user_id} ${dto1.review_score  }</h6>
                  <p class="reviewOption" style="font: -webkit-small-control;">option : <br/></p>
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
                  <p>${dto1.review_contents }<br/>
                  	<input type="button" class="reviewDetail" value="..more" data-chk="show" style="border: 0; background: white; font-size: smaller; color: #cccccc;">
                  </p>
                  <p class="reviewDetailImg">
                  	<c:forEach var="dto2" items="${dto1.review_img }">
           				<img src="/wit/resources/img/blog/details/${dto2 }" alt="">
           			</c:forEach>
                  </p>
                  <ul>
                      <li><i class="fa fa-clock-o"></i>${dto1.review_created }</li>
                      <li><i class="fa fa-heart-o" data-idx="${status.index }">&nbsp;<input id="reportCnt${status.index }" data-save="${reportCnt }" type="text" style="border: 0;"></i></li>
                      <li><i class="fa fa-share"></i> 1</li>
                  </ul>
              </div>
      	</div>
      </c:if>   
</c:forEach>
    
<input type="hidden" id="reviewPageNum" value="${pageNum}"/>
<input type="hidden" id="totalPage" value="${totalPage}"/>
