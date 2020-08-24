<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

</head>

 <body>
  	<div class='wrap'>
  		<tiles:insertAttribute name="header" />
	  		<div class="content">
	  			<tiles:insertAttribute name="content"/>
	  		</div>
  		<tiles:insertAttribute name="footer" />
  	</div>
  </body>
</body>

</html>
