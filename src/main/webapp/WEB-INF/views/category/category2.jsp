<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<ul>
	<c:forEach var="list" items="${category2_list}">
		<li><a style="cursor:pointer" onclick="productList('all','1','TOP','SLV')">${list }</a></li>
	</c:forEach>
</ul>