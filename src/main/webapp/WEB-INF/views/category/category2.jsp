<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<ul>
	<c:forEach var="list" items="${category2_list}">
		<li><a id="${list.CODE }" style="cursor:pointer">${list.CODE_NAME }</a></li>
	</c:forEach>
</ul>