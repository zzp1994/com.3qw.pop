<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/WEB-INF/views/zh/include/base2.jsp"%>

<script type="text/javascript">
	$(document).ready(function(){
		
	});
</script>
		<div class="xia" style="min-height: 80px;">
			<p class="p1">
			<c:if test="${type eq 1}">
				<span style="font-size: 20px;width: initial;">未结算红旗券:&nbsp;&nbsp;${noHqq}&nbsp;券</span>
			</c:if>
			<c:if test="${type eq 2}">
				<span style="font-size: 20px;width: initial;">已结算红旗券:&nbsp;&nbsp;${yesHqq}&nbsp;券</span>
			</c:if>
			</p>
		</div>
		<div class="blank10"></div>
<table id="J_BoughtTable" class="bought-table" data-spm="9"
style="width:100%;">
	<thead>
		<tr class="col-name">
			<th>日期</th>
			<th>订单编号</th>
			<th>支付方式</th>
<!-- 			<th>订单金额</th> -->
			<th>应结算红旗券</th>
			<th>欠款扣账</th>
			<c:if test="${type eq 2}">
				<th>扣减平台交易费</th>
			</c:if>
			<th>操作</th>
		</tr>
	</thead>
	<tbody class="data"  id="showListTbody">
		<c:if test="${empty balancePage.result}">
			<tr>
				<td colspan="6">
					<center><img src="${path }/images/no.png" /></center>
				</td>
			</tr>
		</c:if>
		<c:forEach items="${balancePage.result}" var="result">
			<tr class="order-bd">
				<td><fmt:formatDate value="${result.operatorTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${fn:escapeXml(result.refObjId)}</td>
				<td>${fn:escapeXml('红旗券')}</td>
<!-- 				<td></td> -->
				<td>${fn:escapeXml(result.earning)}</td>
				<td>${fn:escapeXml(result.payFenqi)}</td>
				<c:if test="${type eq 2}">
					<td>${fn:escapeXml(result.payDealfee)}</td>
				</c:if>
				<td>
				<a style="color: blue" href="../order/getCustomerOrderDetailsById?orderId=${fn:escapeXml(result.refObjId)}" target="_blank">订单详情</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<%-- <c:if test="${!empty balancePage.result}"> --%>
<%-- 	<%@include file="/WEB-INF/views/zh/include/paging.jsp" %> --%>
<%-- </c:if> --%>
<c:if test="${!empty balancePage.result}">
	<%@include file="/WEB-INF/views/zh/include/paging2.jsp" %>
</c:if>
