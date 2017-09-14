<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.mall.mybatis.utility.PageBean" %>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%  
    String path = request.getContextPath();
    String url = request.getServletPath();
	request.setAttribute("path",path);
	int indexs=1;
%>

<table class="home_page">
	<tr>
		<th width="50">序号</th>
		<th width="250">品牌中文名称</th>
		<th width="250">品牌英文名称</th>
	</tr>
	<c:forEach items="${pb.result}" var="bean">

		<tr>
			<td><%=indexs++%></td>
			<td>${bean.nameCn}</td>
			<td>${bean.nameEn}</td>
		</tr>
	</c:forEach>
</table>
<%--<c:if test="${!empty pb.result}">
	<%@include file="/WEB-INF/views/en/include/pagingBrand.jsp"%>
</c:if>--%>

<c:if test="${!empty pb.result}">
<%@include file="/WEB-INF/views/zh/include/pagingbrand.jsp" %>
</c:if>

