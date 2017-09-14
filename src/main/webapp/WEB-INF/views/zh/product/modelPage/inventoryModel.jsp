<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.mall.mybatis.utility.PageBean" %>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<table class="tb-stock" width="100%">

	<colgroup>
	
		<col width="25%">
		
		<col width="25%">
		
		<col width="25%">
		
		<col width="25%">
	
	</colgroup>
	
	
	<c:forEach items="${data}" var="stockProd">
	
		<thead>
		
			<tr>
			
				<th colspan="4" class="title"><h3>商品名称:${stockProd.key}</h3></th>
				
			</tr>
			
			<tr>
			
				<th>商品规格</th>
				
				<th>现货库存</th>
				
				<th>订单预定量</th>
				
				<th>操作</th>
				
			</tr>
			
		</thead>
		
		<tbody>
		
			<c:forEach items="${stockProd.value}" var="prodSku">
			
				<tr>
				
					<td>${prodSku.skuName}</td>
					
					<td>${prodSku.qty}</td>
					
					<td>${prodSku.presubQty}</td>
					
					<td class="tac">
						<c:if test="${supplierId == prodSku.supplierId }">
							<span class="xg" onclick="inventoryAmountByEditType('${prodSku.id}')">修改</span>
						</c:if>
						
					</td>
					
				</tr>
				
			</c:forEach>
		
		</tbody>
		
	</c:forEach>
	
</table>
<c:if test="${!empty data}">
	<%@include file="/WEB-INF/views/zh/include/paging.jsp"%>
</c:if>
