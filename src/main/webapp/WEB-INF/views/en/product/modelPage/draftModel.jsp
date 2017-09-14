<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.mall.mybatis.utility.PageBean"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<table id="J_BoughtTable" class="bought-table" data-spm="9" width="100%">
	<colgroup>
		<col width="">
		<col width="100px">
		<col width="100px">
	</colgroup>
	<thead>
		<tr class="col-name">
			<th>Product Name</th>
			<th>Update Time</th>
			<th>Opertion</th>
		</tr>
	</thead>

	<tbody class="data" id="showListTbody">
		<c:forEach items="${pb.result}" var="pbr">
			
			<tr class="order-bd">
				<td class="baobei">
				    <a class="pic J_MakePoint"><img src="${pbr.imageurl}" alt="无图片"> </a>
					<div class="desc" title="${fn:escapeXml(pbr.productName)}">
						<p class="baobei-name">
							<i> ${fn:escapeXml(pbr.productName)} </i>
						</p>
					</div>
				</td>
			
				<td class="trade-status">
					<fmt:formatDate value="${pbr.createddate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="trade-operate">
						<c:if test="${supplierId == pbr.supplierid }">
							<p><a class="tm-btn" href="toDraftEdit?productId=${pbr.productid}">Edit</a></p>
						</c:if>
							<p><a class="tm-btn"href="javascript:void(0)" onclick="proDel('${pbr.productid}')">delete</a></p>
					</td>
			</tr>
			<tr style="height:10px;"></tr>
		</c:forEach>
	</tbody>
</table>
			
<c:if test="${!empty pb.result}">
	<%@include file="/WEB-INF/views/en/include/paging.jsp" %>	
</c:if>