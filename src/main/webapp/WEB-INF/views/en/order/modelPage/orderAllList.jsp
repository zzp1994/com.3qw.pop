<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.mall.mybatis.utility.PageBean" %>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%  
    String path = request.getContextPath();
    String url = request.getServletPath();
	request.setAttribute("url",url);
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
							<th class="baobei">Product</th>
							<th class="price">Unit Price</th>
							<th class="quantity">Number</th>
							<th class="amount">Actual Payments</th>
							<th class="trade-status">Trading Status</th>
							<th class="trade-operate">Trading Operation</th>
						</tr>
					</thead>	    

					<tbody class="data"> 
					 <c:forEach items="${pb.result }" var="o">
						<tr class="sep-row">
							<td colspan="6"></td>
						</tr> 
						<tr class="order-hd" style="position: relative;">
							<td class="first" colspan="6">
								<div class="summary" >
									<span class="number last-item">Order Number：<em>${o.poId }</em></span>
									<span class="column" style="width:580px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; display: block; float:right; text-align: left;" title="${fn:escapeXml(o.dealerName)}">${fn:escapeXml(o.dealerName)}</span>
								</div>
							</td>
							<%-- <td class="column" colspan="3">
								${o.dealerName}
							</td> --%>
							
						</tr>
						<tr class="order-bd last order-last" >
							<td class="baobei"  >
								<a class="pic J_MakePoint">
								<img src="${o.imgUrl}" alt="details">
								</a>
								<div class="desc" title="${fn:escapeXml(o.pName )}">
									<p class="baobei-name">
									<i > ${fn:escapeXml(o.pName)}</i>
									</p>
								</div>
								</td>
								<td class="price" >
									<i class="special-num">
										<span> 
										${o.moneyUnitSymbols}
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
								<td class="quantity">
								<i class="special-num">${fn:escapeXml(o.qty )}</i>
								</td>
								<td class="amount" rowspan="1">
								<i class="real-price special-num"> ${o.moneyUnitSymbols}
									<fmt:formatNumber pattern="0.0000#" value="${o.price}"></fmt:formatNumber>
								</i>
								</td>
								<td class="trade-status" rowspan="1">
										<c:if test="${o.status=='1' }">
											<i class="status" >Purchase orders to be assigned</i>
										</c:if>
										<c:if test="${o.status=='21' }">
											<i class="status" >Waiting for dealer order</i>
										</c:if>
										<c:if test="${o.status=='31' }">
											<i class="status" >Purchase Order Submitted</i>
										</c:if>
										<c:if test="${o.status=='32' }">
											<i class="status" >Waiting for supplier to fill out the contract</i>
										</c:if>
										<c:if test="${o.status=='33' }">
											<i class="status" >Waiting for dealer to confirm the contract</i>
										</c:if>
										<c:if test="${o.status=='34' }">
											<i class="status" >Waiting for supplier to confirm the contract</i>
										</c:if>
										<c:if test="${o.status=='41' }">
											<i class="status" > Contracts have been submitted</i>
										</c:if>
										<c:if test="${o.status=='51' }">
											<i class="status" > The buyers has paid the order</i>
										</c:if>
											
										<c:if test="${o.status=='61' }">
											<i class="status" > Waiting to print Dispatch Bill</i>
										</c:if>
										<c:if test="${o.status=='62' }">
											<i class="status" > Waiting for shipment</i>
										</c:if>
										<c:if test="${o.status=='71' }">
											<i class="status" >Delivered</i>
											</c:if>
										<c:if test="${o.status=='81' }">
											<i class="status" > Completed</i>
										</c:if>
									
									
								</td>
								<td class="trade-operate" rowspan="1">
										<c:if test="${supplierId == o.supplierId }">
											<c:if test="${o.status=='32' }">
												<a class="gb" href="javascript:void(0)" onclick="editContract('${o.poId}')">Fill in the Contract</a>
											</c:if>
											<c:if test="${o.status=='34' }">
												<a class="gb" href="${path}/order/affirmUI?orderId=${o.poId}" target="_blank">Confirm Contract</a>
											</c:if>
											<c:if test="${o.status=='51' }">
												<a class="gb" href="javascript:void(0)" onclick="confirmOrder('${o.poId}','61')">Confirm Payment</a>
											</c:if>
											<c:if test="${o.status=='61' }">
												<a class="tm-btn tm-skin-blue" href="javascript:void(0)" onclick="printDespatch('${o.poId}')">Print Dispatch Bill</a>
											</c:if>
											<c:if test="${o.status=='62' }">
												<a class="tm-btn tm-skin-blue" href="${path}/order/toDespatchUI?orderId=${o.poId}">Confirm Delivery</a>
												
											</c:if>
										</c:if>
										<c:if test="${o.status!='32'&&o.status!='34' }">
											<a href="${path}/order/viewerContract?orderId=${o.poId}" target="_blank">Contract Preview</a>
										</c:if>
										<a class="tm-h" href="javascript:void(0)" onclick="lineitem('${o.poId}')"> Order Details </a>
								 </td>
						 </c:forEach>
				</tbody>
			</table>
				
			<c:if test="${!empty pb.result}">
				<%@include file="/WEB-INF/views/zh/include/paging.jsp" %>	
			</c:if>