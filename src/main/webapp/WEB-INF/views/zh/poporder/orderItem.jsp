<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
request.setAttribute("path",path);
%>





<script type="text/javascript">
/* 删除 */
function prodelOrder(oid){
	if(oid==null&&oid==""){
		alert("选择数据再操作");
		return false;
	}else{
		
		if(window.confirm("确定删除订单!")){
			
			var oid_array = new Array();
			oid_array.push(oid);
		
			$.ajax({
				type : "post", 
				url : "deleteOrder", 
				data:"oid="+oid_array.join(","),
				success : function(msg) { 
					if(msg==1){
						alert("操作成功");
						byConditionSearchCustomerOrder(1);
					}else{
						alert("操作失败 ，请稍后再试");
					}
				}
			});

		}

	}
}
</script>

<style>
	#liuyan{float: right;}

</style>

	<div class="tb-void">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<th width="300">商品名称</th>
							<th width="110">收货人</th>
							<th width="110">数量</th>
							<th width="110">实付现金</th>
							<th width="110">实付红旗劵</th>
							<th width="110">状态</th>
							<th width="80">操作</th>
						</tr>
					</tbody>
					
					<tbody>
					
						<c:forEach items="${pageBean.result }" var="orderList" varStatus="i">
					 
							<tr class="tr-th">
								<td colspan="8" style="position: relative;">
									<span class="fl"><fmt:formatDate value="${orderList.createTime }" type="both"/></span>
									<span class="fc"> 订单号:<a href="javascript:void(0)">${orderList.id }</a></span>
									<span class="fr"> 买家:<i>${orderList.userName } </i>     &nbsp;&nbsp;&nbsp;买家ID:<i>${orderList.userId }</i> </span>
									<c:if test="${!empty orderList.message }">
										<!-- <span class="tcolr"><button type="button" onclick=getLiuYan() class="lyan">订单留言</button></span> -->
										<span class="tcolr"><button type="button" onclick="getLiuYan(${i.index})" class="lyan">订单留言</button></span>
										<div class="reply"  id="rep${i.index}" style="display:none;">
											${orderList.message }
											<span id="liuyan"> <input type="button" onclick="qvXiaoLiuYan(${i.index})" style="float: right;" value="隐藏"></span>
		 				                </div>
									</c:if>
								</td>
							</tr>
							<tr>
							  <td>
						   <div class="qu">
						   <!-- 11.宁波海外直邮  12.宁波保税区发货 13.郑州海外直邮 14.郑州保税区发货  1.国内发货 21.韩国直邮 -->
			                			<c:if test="${orderList.supplyType eq 1}"><a href="javascript:void(0)"><span class="at">国内发货</span></a></c:if>
		        						<c:if test="${orderList.supplyType eq 21}"><a href="javascript:void(0)"><span class="ac">海外直邮</span></a></c:if>
		        						<c:if test="${orderList.supplyType eq 12}"><a href="javascript:void(0)"><span class="ah">保税区发货</span></a></c:if>
		        						<c:if test="${orderList.supplyType eq 11}"><a href="javascript:void(0)"><span  style="background:#F02146 ">海外直邮</span></a></c:if>
		        						<c:if test="${orderList.supplyType eq 31}"><a href="javascript:void(0)"><span  style="background:#FC0EE0 ">卓悦发货</span></a></c:if>
							   			<c:if test="${orderList.supplyType eq 50}"><a href="javascript:void(0)"><span  style="background:#FC0EE0 ">特卖商品</span></a></c:if>
							   			<%-- <c:if test="${orderList.supplyType eq 51}"><a href="javascript:void(0)"><span  style="background:#FC0EE0 "></span></a></c:if> --%>
		        						<%-- <c:if test="${orderList.supplyType eq 13}"><a href="javascript:void(0)"><span  style="background:#F02146 ">郑州海外直邮</span></a></c:if>
		        						<c:if test="${orderList.supplyType eq 14}"><a href="javascript:void(0)"><span  style="background:#F02146 ">郑州保税区发货</span></a></c:if> --%>
		        						
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
								<td>${orderList.receiveName }</td>
								<%-- ${orderList.receiveName } --%>
								<td>${orderList.totalQty }</td>
						<%-- 		<td>
									<c:if test="${orderList.cashPrice ==0  && orderList.hqjPrice ==0}">
									<fmt:formatNumber value="${orderList.paidPrice }" pattern="0.00#"></fmt:formatNumber>
									</c:if>
									<fmt:formatNumber value="${orderList.paidPrice }" pattern="0.00#"></fmt:formatNumber>
									<c:if test="${orderList.cashPrice !=0}">
									
									</c:if> 
								</td> --%>
								


								<td>
								
								<c:if test="${orderList.mixPayStatus==1&&orderList.paidPrice>0&&orderList.cashPrice>0 && orderList.orderType==39}">
									<fmt:formatNumber value="${orderList.cashPrice}" pattern="0.00#"></fmt:formatNumber>
								</c:if>
								
								</td>
								
								<td>
								<c:if test="${orderList.mixPayStatus==1&&orderList.paidPrice>0&&orderList.cashPrice>0 && orderList.orderType==39}">
									<fmt:formatNumber value="${orderList.hqjPrice}" pattern="0.00#"></fmt:formatNumber>
								</c:if>
								<c:if test="${orderList.orderType!=39}">
								<fmt:formatNumber value="${orderList.paidPrice }" pattern="0.00#"></fmt:formatNumber>
								</c:if>
								</td>

								
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
									<c:if test="${orderList.status eq  81}">已发货</c:if>
									<c:if test="${orderList.status eq  91}">已收货</c:if>
									<c:if test="${orderList.status eq  99}">用户取消</c:if>
									<c:if test="${orderList.status eq  100}">自动取消</c:if>
								</td>
								<td class="order-doi">
									<a href="../order/getCustomerOrderDetailsById?orderId=${orderList.id }" target="_blank">订单详情</a>
										<c:if test="${orderList.status eq 41}">
											<a class="t-btn" href="javascript:void(0)" onclick="showWuLiu('${orderList.id }', '${orderList.receiveName }','${orderList.receiveMobilePhone }','${orderList.receiveAddress }')">整单发货 </a>
											<c:if test="${fn:length(orderList.productList)>1}">
											<a class="t-btn" href="../order/getCustomerOrderFenDanById?orderId=${orderList.id }">分单发货 </a>
											</c:if>
											<input id="currentPageId" type="hidden" value="${pageBean.page }"/>
										</c:if>
										<c:if test="${orderList.status eq 100}">
											<p><a class="tm-btn" href="javascript:void(0);" onclick="prodelOrder('${orderList.id }')">删除</a></p>
											
										</c:if>
										<%-- <c:if test="${orderList.status eq 91 && orderList.orderType eq 39}">
											<p><a class="tm-btn" href="javascript:void(0);" onclick="prodelOrder('${orderList.id }')">退单申请</a></p>
											
										</c:if> --%>
									<%-- 	<c:if test="${orderList.status eq 91}">
											<p><a class="tm-btn" href="javascript:void(0);" onclick="prodelOrder('${orderList.id }')">删除</a></p>
											
										</c:if>
										<c:if test="${orderList.status eq 99}">
											<p><a class="tm-btn" href="javascript:void(0);" onclick="prodelOrder('${orderList.id }')">删除</a></p>
											
										</c:if> --%>
										
										
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<c:if test="${!empty pageBean.result}">
				<%@include file="../include/basePage.jsp" %>
			</c:if>