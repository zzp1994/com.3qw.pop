<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>商家后台管理系统-修改商品分类</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp" %>
	<link rel="stylesheet" type="text/css" href="${path}/css/zh/fenlei.css">
	<script type="text/javascript" src="${path}/js/product/zh/editCategory.js"></script>
	</script>
</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>
		<div class="c2">
		
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;&gt;&nbsp;</p>
					<p>商品管理&nbsp;&gt;&nbsp;</p>
					<p>修改商品&nbsp;&gt;&nbsp;</p>
					<p class="c1">修改商品分类</p>
					<div class="clear"></div>
				</div>
			</div>
			<div class="blank10"></div>
			
			<div class="c22">
				<div class="s1">
					<h2>选择分类</h2>
					<input type="hidden" value="${firCategoryId}" id="firCategoryId"/>
				    <input type="hidden" value="${secCategoryId}" id="secCategoryId"/>
				    <input type="hidden" value="${thiCategoryId}" id="thiCategoryId"/>
				    <input type="hidden" value="${fouCategoryId}" id="fouCategoryId"/>
				    <form id="productAction" >
				    	<input type="hidden" value="${productId}" id="productId" name="productId"/>
				    	<input type="hidden" id="cateId" name="cateId"/>
				    </form>
				</div>
				 
		<div class="main">
			<div class="main_m main_m_fir">
				<ul>
					<%-- <c:forEach items="${list}" var="v">
						<li pval="${v.catePubId }" pid="${v.leaf}"><a href="javascript:;">${v.pubNameCn }</a>
					</li>
					</c:forEach> --%>
					<c:forEach items="${categorys}" var="cate">
						<c:choose>
									   <c:when test="${cate.cid ==firCategoryId}">
										   <li class="color" pval="${cate.cid}" pid="${cate.leaf}" title="${fn:escapeXml(cate.nameCn)}">
												<a href="javascript:;">${fn:escapeXml(cate.nameCn)}</a>
										   </li>
									   </c:when>
									   <c:otherwise>  
										    <li pval="${cate.cid}" pid="${cate.leaf}" title="${fn:escapeXml(cate.nameCn)}">
												<a href="javascript:;">${fn:escapeXml(cate.nameCn)}</a>
											</li>
									   </c:otherwise>
									</c:choose>
					</c:forEach>
				</ul>
			</div>
			<div class="main_m original main_m_sec"><ul></ul></div>
			<div class="main_m original main_m_thi"><ul></ul></div>
			<div class="main_m original main_m_fou"><ul></ul></div>
			
			<div class="clear"></div>
			
			<div class="main_b">
			 	<div class="app" id="selectCategory">
			 		你当前选择的类目： 
			 	</div>
				<input type="hidden" id="path" value="${path}">
				<div class="s3" id="nextView"><a href="#">修改商品分类信息</a></div>
				
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
<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
</body>
</html>