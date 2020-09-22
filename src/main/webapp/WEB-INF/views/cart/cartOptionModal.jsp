<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!doctype html>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <title>Document</title>
 </head>
 <script src="/wit/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

function addOrChange(mode){
		
   	var prod_color = $('#optionColor option:selected').text(); //선택한 컬러
   	var prod_size = $('#optionSize option:selected').text(); //선택한 사이즈
   	var prod_code = "${prod_code}"; //옵션변경하기전 원래 prod_code
	var prod_subcode = "${prod_subcode}"; //prod_subcode
	var cart_qty = "${cart_qty}";

	if(mode == 'insert'){
		var url = "<%=cp%>/cart/insertCartOption.action";
	}else{
		var url = "<%=cp%>/cart/updateCartOption.action";
	}

	 $.post(url,{prod_color : prod_color, 
		 prod_size : prod_size,
		 prod_code : prod_code,
		 prod_subcode : prod_subcode,
		 cart_qty : cart_qty
		 },function(args){
			 //성공했을시
			 //부모 jsp(shop-cart.jsp)의 startCart 함수 호출
			 top.startCart(); 		
		}); 	
 }

$(window).on('load',function(){

	//x(닫기)버튼을 눌렀을때
	$('.optionHide').on('click',function(){
		top.hide(); //부모jsp (cartDetail.jsp)의 hide 함수 호출
	});

});
	
</script>

 <body>

 <div style="background: skyblue;width: 300px; margin-left: -9px; height: 35px; margin-top: -9px; text-align: right; margin-bottom: -15px;">
<p align="center">옵션변경 <input type="button" value="x" class="optionHide"></p>
</div>
<br/>
<div id="cartOptionModal" align="center">
	product&nbsp;:&nbsp;${prod_subcode }<br/>
 	option&nbsp;:&nbsp;${prod_code }<br/>	
 	
 	<select id="optionColor">
 	<c:forEach var="color" items="${color_lists }">
 		<option>${color.prod_color }</option>
 	</c:forEach>
 	</select>	
 	
 	<select id="optionSize">
 	<c:forEach var="size" items="${size_lists }">
 		<option>${size.prod_size }</option>
 	</c:forEach>
 	</select>
  </div>
  <div align="center">
  <input type="button" value="add" class="optionAdd" onclick="addOrChange('insert');">
  <input type="button" value="change" class="optionChange" onclick="addOrChange('update');">
  </div>
 </body>
</html>
