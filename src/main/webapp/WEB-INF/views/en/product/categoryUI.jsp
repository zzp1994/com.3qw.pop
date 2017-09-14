<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Supplier-Post Products</title>
	<%@include file="/WEB-INF/views/en/include/base.jsp" %>
	<link rel="stylesheet" type="text/css" href="${path}/css/en/fenlei.css">
	<script type="text/javascript" src="${path}/js/product/en/category.js"></script>
	</script>
</head>
<body>
<%@include file="/WEB-INF/views/en/include/header.jsp" %>
<%@include file="/WEB-INF/views/en/include/leftProduct.jsp" %>
		<div class="c2">
		
			<div class="c21">
				<div class="title">
					<p>Seller Center&nbsp;>&nbsp; </p>
					<p>Product&nbsp;>&nbsp; </p>
					<p class="c1">Post Products</p>
				</div>
			</div>
			<div class="blank10"></div>
			
			<div class="c22">
				<div class="s1">
					<h2>Select Category</h2>
				</div>
				 
		<div class="main">
			<div class="main_m main_m_fir">
				<ul>
					<%-- <c:forEach items="${list}" var="v">
						<li pval="${v.catePubId }" pid="${v.leaf}"><a href="javascript:;">${v.pubNameCn }</a>
					</li>
					</c:forEach> --%>
					<c:forEach items="${categorys}" var="cate">
						<li pval="${cate.cid}" pid="${cate.leaf}" title="${fn:escapeXml(cate.name)}">
									<%-- <span><img src="${path}/images/k9.jpg"></span> --%>
							<a href="javascript:;">${fn:escapeXml(cate.name)}</a>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="main_m original main_m_sec">
				<ul>
				</ul>
			</div>
			<div class="main_m original main_m_thi">
				<ul>
				</ul>
			</div>
			<div class="main_m original main_m_fou">
				<ul>
				</ul>
			</div>
			
			<div class="clear"></div>
			
			<div class="main_b">
			 	<div class="app" id="selectCategory">
			 		Currently Selected Category： 
			 	</div>
				<input type="hidden" id="path" value="${path}">
				<div class="s3" id="nextView"><a href="#">Continue with product details</a></div>
				
			</div>
		</div>
	</div>
		<div class="clear"></div>
	<div class="dw_temp" style="display:none;">
		<ul>
			<li value="">
				<a href="javascript:;"></a>
			</li>
		</ul>
<div class="blank10"></div>

		</div>
</div>
</div>
<!-- 底部 start -->
<%@include file="/WEB-INF/views/en/include/last.jsp"%>
</body>
</html>