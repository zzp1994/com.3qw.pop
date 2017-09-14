<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/WEB-INF/views/zh/include/base.jsp"%>


<table id="J_BoughtTable" class="bought-table" data-spm="9"
	style="width:100%;">
		<thead>
			<tr class="col-name">
				<th>序号</th>
				<th>商户名称</th>
				<th>商品名称</th>
				<th>SKU ID</th>
				<th>SKU条码</th>
				<th>采购价格</th>
				<th>有效起始时间</th>
				<th>有效结束时间</th>
			</tr>
		</thead>
		<tbody class="data"  id="showListTbody">
			<c:if test="${empty pb.result}">
					<tr>
						<td colspan="6">
							<center><img src="${path }/images/no.png" /></center>
						</td>
					</tr>
				</c:if>
				
				<c:forEach items="${pb.result}" var="pbr" varStatus="status">
					<tr class="order-bd" >
						<td class="trade-status">${status.index + 1}</td>
						<td class="trade-status">${pbr.supplierName }</td>
						<td class="trade-status">${pbr.productName }</td>
						<td class="trade-status">${pbr.skuId }</td>
						<td class="trade-status">${pbr.skuCode }</td>
						<td class="trade-status">${pbr.purchasePrice }</td>
						<td class="trade-status"><fmt:formatDate value="${pbr.beginTime }" type="date" /></td>
						<td class="trade-status"><fmt:formatDate value="${pbr.endTime }" type="date" /></td>
					</tr>
				</c:forEach>
		</tbody>
</table>

<%@include file="/WEB-INF/views/zh/include/paging.jsp" %>