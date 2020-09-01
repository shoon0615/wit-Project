<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<c:forEach var="list" items="${categorySize }">
	<label for="${category1 }_${list }"> ${list } <input type="checkbox" id="${category1 }_${list }" value="${list }"/>
		<span class="checkmark"></span>
	</label>
</c:forEach>