<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.mall.mybatis.utility.PageBean" %>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%  
    String path = request.getContextPath();
    String url = request.getServletPath();
	request.setAttribute("path",path);
%>
            	<table id="J_BoughtTable" class="bought-table" data-spm="9" width="100%">
            		<colgroup>
                       <col class="baobei">
						<col class="price" >
						<col class="quantity" >
						<col class="amount">
						<col class="trade-status" >
						<col class="trade-operate" >
					</colgroup>

					<thead>
						<tr class="col-name">
							<th class="baobei">商品</th>
							<th class="price">单价</th>
							<th class="quantity">数量</th>
							<th class="amount">实付款</th>
							<th class="trade-status">交易状态</th>
							<th class="trade-operate">交易操作</th>
						</tr>
					</thead>	    

					<tbody class="data"> 
					
					 <c:forEach items="${pb.result }" var="o">
						<tr class="sep-row">
							<td colspan="6"></td>
						</tr> 
						<tr class="order-hd" style="position: relative;">
							<td class="first" colspan="6">
								<div class="summary">
									<span class="number last-item">采购单号：<em>${o.poId }</em></span>
									<span class="column" style="width:580px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; display: block; float:right; text-align: left;" title="${o.dealerName }">${o.dealerName }</span>
									
								</div>
							</td>
							<%-- <td class="column" colspan="4">
								${o.dealerName }
							</td> --%>
						
						</tr>
						<tr class="order-bd last order-last" >
							<td class="baobei"  >
								<a class="pic J_MakePoint">
								<img src="${o.imgUrl}" alt="查看宝贝详情">
								</a>
								<div class="desc" title="${fn:escapeXml(o.pName)}">
									<p class="baobei-name">
									<i> ${fn:escapeXml(o.pName)}</i>
									</p>
								</div>
								</td>
								<td class="price">
									<i class="special-num">
										<span>${o.moneyUnitSymbols} 
											<c:choose>
												<c:when test="${o.productPriceMin == o.productPriceMax}">
													<fmt:formatNumber pattern="0.0000#" value="${o.productPriceMin}"></fmt:formatNumber>
												</c:when>
												<c:otherwise>
													<fmt:formatNumber pattern="0.0000#" value="${o.productPriceMin}"></fmt:formatNumber>
													 ~
													 <fmt:formatNumber pattern="0.0000#" value="${o.productPriceMax}"></fmt:formatNumber>
												</c:otherwise>
											</c:choose>
										</span>
									</i>
								</td>
								<td class="quantity" title="${o.qty }">
								<i class="special-num">${o.qty }</i>
								</td>
								<td class="amount" rowspan="1">
								<i class="real-price special-num"> 
									${o.moneyUnitSymbols}
									<fmt:formatNumber pattern="0.0000#" value="${o.price}"></fmt:formatNumber>
								</i>
								</td>
								<td class="trade-status" rowspan="1">
										<c:if test="${o.status=='1' }">
											<i class="status" >等待分配采购单</i>
										</c:if>
										<c:if test="${o.status=='21' }">
											<i class="status" >等待经销商下单</i>
										</c:if>
										<c:if test="${o.status=='31' }">
											<i class="status" >已生成采购单</i>
										</c:if>
										<c:if test="${o.status=='32' }">
											<i class="status" >待填写合同</i>
										</c:if>
										<c:if test="${o.status=='33' }">
											<i class="status" >等待经销商确认合同</i>
										</c:if>
										<c:if test="${o.status=='34' }">
											<i class="status" >待确认合同</i>
										</c:if>
										<c:if test="${o.status=='41' }">
											<i class="status" >合同已生成</i>
										</c:if>
										<c:if test="${o.status=='51' }">
											<i class="status" >买家已付款</i>
										</c:if>
											
										<c:if test="${o.status=='61' }">
											<i class="status" >等待打印发货单</i>
										</c:if>
										<c:if test="${o.status=='62' }">
											<i class="status" >待发货</i>
										</c:if>
										<c:if test="${o.status=='71' }">
											<i class="status" >已发货</i>
											</c:if>
										<c:if test="${o.status=='81' }">
											<i class="status" >已完成</i>
										</c:if>
								
								</td>
								<td class="trade-operate" rowspan="1">
								<c:if test="${supplierId == o.supplierId }">
										<c:if test="${o.status=='32' }">
											<a class="gb" href="javascript:void(0)" onclick="editContract('${o.poId}')">填写合同</a>
										</c:if>
										<c:if test="${o.status=='34' }">
											<a class="gb" href="${path}/order/affirmUI?orderId=${o.poId}" target="_blank">确认合同</a>
										</c:if>
										<c:if test="${o.status=='51' }">
											<a class="gb" href="javascript:void(0)" onclick="confirmOrder('${o.poId}','61')">确认收款</a>
										</c:if>
										<c:if test="${o.status=='61' }">
											<a class="tm-btn tm-skin-blue" href="javascript:void(0)" onclick="printDespatch('${o.poId}')">打印发货单</a>
										</c:if>
										<c:if test="${o.status=='62' }">
											<a class="tm-btn tm-skin-blue" href="${path}/order/toDespatchUI?orderId=${o.poId}" target="_blank">确认发货</a>
											
										</c:if>
									</c:if>
									<c:if test="${o.status!='32'&&o.status!='34'}">
									
										<a href="${path}/order/viewerContract?orderId=${o.poId}" target="_blank">合同预览 </a>
									</c:if>
									<a class="tm-h" href="javascript:void(0)" onclick="lineitem('${o.poId}')"> 订单详情 </a>
							  </td>
						 </c:forEach>
				</tbody>
			</table>
			
			<c:if test="${!empty pb.result}">
				<%@include file="/WEB-INF/views/zh/include/paging.jsp" %>	
			</c:if>
			