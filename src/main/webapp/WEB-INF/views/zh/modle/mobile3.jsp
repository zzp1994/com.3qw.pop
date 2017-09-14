<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>模板</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp" %>
	
	<link rel="stylesheet" type="text/css" href="${path}/css/resetmobile.css">
	<link rel="stylesheet" type="text/css" href="${path}/css/rshop.css">
	<script type="text/javascript" src="${path}/js/product/zh/category.js"></script>
	</script>
</head>
<body class="bo">

	<div class="header">
		<div class="nav">
			<h2><a href="#"><img src="${path}/images/slogo.png"></a></h2>
			<ul>
				<li><a href="${path}/store/modle/preview?modleNum=3"><img src="${path}/images/pc.png"><i></i></a></li>
				<li class="on"><a href="${path}/store/modle/mobile?modleNum=3"><img src="${path}/images/mobile.png"><i></i></a></li>
			</ul>
		</div>
	</div>

	<div class="cont mr">
	    <div class="pic">
	    	<div class="ov">
	    	    <a href="#"><img src="${path}/images/te7.jpg"></a>
	    	</div>
	    </div>
	</div>

</body>
</html>