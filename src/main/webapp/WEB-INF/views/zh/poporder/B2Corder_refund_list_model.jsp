<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
request.setAttribute("path",path);
%>
	<div class="tb-void">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<th width="300">商品名称</th>
							<th width="110">单价<i class="rmb-unit">¥</i></th>
							<th width="110">数量</th>
							<th width="110">实付款<i class="rmb-unit">¥</i></th>
							<th width="110">状态</th>
							<th width="80">操作</th>
						</tr>
					</tbody>
					
					<tbody>
					
						<c:forEach items="${pageBean.result }" var="orderList">
							<tr class="tr-th">
								<td colspan="6">
									<span class="fl"><fmt:formatDate value="${orderList.createTime }" type="both"/></span>
									<span class="fc"> 订单号:<a href="javascript:void(0)">${orderList.id }</a></span>
									<span class="fr"> 买家:<i>${orderList.userName } </i>     &nbsp;&nbsp;&nbsp;买家ID:<i>${orderList.userId }</i> </span>
									<c:if test="${!empty orderList.message }">
										<span class="tcolr"><button type="button" class="lyan">订单留言</button></span>
										<div class="reply" style="display:none;">
											${orderList.message }
		 				                </div>
									</c:if>
								</td>
							</tr>
							<tr>
							  <td>
						   <div class="qu">
			                			<c:if test="${orderList.supplyType eq 1}"><a href="javascript:void(0)"><span class="at">国内发货</span></a></c:if>
		        						<c:if test="${orderList.supplyType eq 11}"><a href="javascript:void(0)"><span class="ac">海外直邮</span></a></c:if>
		        						<c:if test="${orderList.supplyType eq 12}"><a href="javascript:void(0)"><span class="ah">保税区发货</span></a></c:if>
		        						<c:if test="${orderList.supplyType eq 21}"><a href="javascript:void(0)"><span  style="background:#F02146 ">韩国直邮</span></a></c:if>
			                		<span>
	        						</span>
			                	</div> 
			                	
			                      <ul class="goods-list clearfix">
			                      <c:forEach items="${orderList.productList }" var="productList">
			                         <li>
			                            <div class="goods-box">
			                                <div class="goods-pic"><a href="javascript:void(0)"><img src="${productList.imgUrl }" width="60" height="60"></a></div>
			                                <div class="goods-txt">
				                              <span class="sku">商品:${productList.pName }</span>
				                               <span class="amount">数量:${productList.count }</span>
			                                </div>
			                            </div>
			                         </li>
			                       
								  </c:forEach>
			                       </ul>
	                            </td>
								<td><fmt:formatNumber value="${orderList.unitPrice }" pattern="0.00#"></fmt:formatNumber> </td>
								<%-- ${orderList.receiveName } --%>
								<td>${orderList.totalQty }</td>
								<td><fmt:formatNumber value="${orderList.paidPrice }" pattern="0.00#"></fmt:formatNumber></td>
								
								<td>
									<c:if test="${orderList.status eq  1}">待支付</c:if>
									<c:if test="${orderList.status eq  21}">已支付</c:if>
									<c:if test="${orderList.status eq  31}">待海关审核</c:if>
									<c:if test="${orderList.status eq  41}">待发货</c:if>
									<c:if test="${orderList.status eq  67}">海关审核订单失败(待退款)</c:if>
									<c:if test="${orderList.status eq  68}">海关支付单审核失败(待退款)</c:if>
									<c:if test="${orderList.status eq  69}">海关物流单审核失败(待退款)</c:if>
									<c:if test="${orderList.status eq  70}">海关审核失败(待退款)</c:if>
									<c:if test="${orderList.status eq  79}">已退款</c:if>
									<c:if test="${orderList.status eq  81}">待收货</c:if>
									<c:if test="${orderList.status eq  91}">已收货</c:if>
									<c:if test="${orderList.status eq  99}">用户取消</c:if>
									<c:if test="${orderList.status eq  100}">自动取消</c:if>
								</td>
								<td class="order-doi">
									<%-- <c:if test="${!empty buttonsMap['退款订单-订单退款'] }">--%>
										<c:if test="${orderList.status eq 55}"> 
											<a href="#" onclick="goRefundOrderByOrderId('${orderList.id }')" class="refund">订单退款</a></br></br>
											<a href="#" onclick="refundOrderByOrderId('${orderList.id }')" class="refund">不良退单</a>
										 </c:if>
										<%--</c:if> --%>
									
									<c:if test="${!empty buttonsMap['退款订单-订单详情'] }">
										<a href="../customerRefundOrder/getCustomerRefundOrderDetailsById?orderId=${orderList.id }" target="_blank">订单详情</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<c:if test="${!empty pageBean.result}">
				<%@include file="../include/basePage.jsp" %>
			</c:if>