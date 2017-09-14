<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
</head>
<body>


<table>
	<tr>
		<th class="t1">单选</th>
		<th class="t2">商品名称</th>
		<th class="t2">商品PID</th>
		<!-- <th class="t2">商品URL</th> -->
		<th class="t2">国内价格(￥)</th>
		<th class="t2">零售价格(￥)</th>
	</tr>
	<c:forEach items="${supplierList}" var="service">
	<tr>
		<td class="t1">
			<input type="radio" name="service"
			productid = "${fn:escapeXml(service.productid)}"
			productName = "${fn:escapeXml(service.b2cProductName)}"
			imageurl = "${fn:escapeXml(service.imageurl)}"
			domesticPrice = "${fn:escapeXml(service.domesticPrice)}"
			unitPrice = "${fn:escapeXml(service.unitPrice)}"
			value="${fn:escapeXml(service.productid)}">
		</td>
		<td class="t2" title="${service.b2cProductName }">
			<span>${service.b2cProductName }</span>
		</td>
		<td class="t2" title="${service.productid }">
			<span>${service.productid }</span>
		</td>
		<%-- <td class="t2" title="${service.imageurl }">
			<span>${files}${service.imageurl }</span>
			<span><a target="_blank" href="${files}${service.imageurl }">商品图片</a></span>
		</td> --%>
		<td class="t2" title="${service.domesticPrice }">
			<span>${service.domesticPrice }</span>
		</td>
		<td class="t2" title="${service.unitPrice }">
			<span>${service.unitPrice }</span>
		</td>
	</tr>
	</c:forEach>
</table>
</body>
</html>