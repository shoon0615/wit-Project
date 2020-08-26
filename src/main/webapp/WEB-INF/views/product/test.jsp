<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="/wit/resources/js/jquery-3.1.1.js"></script>

<script type="text/javascript">

	$(function() {

		var proQty = $('.pro-qty');
		proQty.prepend('<span class="dec qtybtn" style="cursor: pointer;">-</span>');
		proQty.append('<span class="inc qtybtn" style="cursor: pointer;">+</span>');
		
		proQty.on('click', '.qtybtn', function () {
			alert("A");
		});	

		$('.testing').on('click', function () {
			$(".prod__qty").append($('<div/>', {class: 'pro-qty'}));
			$(".prod__qty").find("div:last").append('<input type="text" value="1" disabled="disabled"/>');
			$(".prod__qty").find("div:last").prepend('<span class="dec qtybtn" style="cursor: pointer;">-</span>');
			$(".prod__qty").find("div:last").append('<span class="inc qtybtn" style="cursor: pointer;">+</span>');
		});	

		$('.prod__qty').on("click", ".qtybtn", function(){
		    alert("ok");
		});
		
	});

</script>

</head>
<body>

<input type="button" value="click" class="testing"/>

<div class="prod__qty">
	<div class="pro-qty">
		<input type="text" value="1" disabled="disabled"/>
	</div>
	
	<div class="pro-qty">
		<input type="text" value="1" disabled="disabled"/>
	</div>
</div>

</body>
</html>