<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<div class="section-title">
	<h4>SHOP BY SIZE</h4>
</div>

<div id="sizeList" class="size__list">
	<c:forEach var="list" items="${categorySize }">
		<label for="${category1 }_${list }"> ${list } <input type="checkbox" id="${category1 }_${list }" value="${list }"/>
			<span class="checkmark"></span>
		</label>
	</c:forEach>
</div>

<script type="text/javascript">
//정렬 버튼 클릭 이벤트
$('#sizeList label input').click(function(){
	var pageNum = $("#pageNum").val(); //페이지 넘버
	var category1 = $("#category1").val(); //카테고리1
	var category2 = $("#category2").val(); //카테고리2
	productList("all",pageNum,category1,category2,this);               
});

</script>