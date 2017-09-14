<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0" />
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<title>B2C_ 订单详情</title>
<%@include file="/WEB-INF/views/zh/include/base.jsp" %>
<link href="${path}/css/poporder/orderdetails.css" rel="stylesheet" type="text/css">
<script>
$(document).ready(function(){
		    //根据状态加载订单状态的图片
	    	var status = $("#orderStatus").val();
	    	if(status==1){
	    		$("#p2 img").attr("src","../images/c_orderstatus1.png");
	    	}else if(status==21 || status==31){
	    		$("#p2 img").attr("src","../images/c_orderstatus2.png");
	    	}else if(status==41){
	    		$("#p2 img").attr("src","../images/c_orderstatus3.png");
	    	}else if(status==81){
	    		$("#p2 img").attr("src","../images/c_orderstatus4.png");
	    	}else if(status==91){
	    		$("#p2 img").attr("src","../images/c_orderstatus5.png");
	    	}else if(status==99 || status==100){
	    		$("#p2 img").attr("src","../images/orderquxiao.png");
	    	}
	    	else if(status==67 || status==68 || status==69 || status==70){
	    		$("#p2 img").attr("src","../images/auditerror.png");
	    	}
	    	else if(status==79){
	    		$("#p2 img").attr("src","../images/refund1.png");
	    	}
	    	else{
	    	}
		});
</script>
</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
<div class="wrap" id="orderDetail">
	<div class="logo3">
		<p class="p1">您的位置： 订单管理&gt;<a href="#">POP订单管理</a>&gt;<span>POP订单详情</span></p>
		<p class="p2" id="p2"><img src="/web-platform/commons/images/spotStatus1.png"></p>
	</div>	
    <div class="order-item">
        <div class="order-hd">
        <input type="hidden"  id="orderStatus" value="${orderDTO.status}">
            <h2>订单号：${orderDTO.id } &nbsp;&nbsp;&nbsp;&nbsp;
            	订单状态：<span>
            				<c:if test="${orderDTO.status eq  1}">待支付</c:if>
							<c:if test="${orderDTO.status eq  21}">已支付</c:if>
							<c:if test="${orderDTO.status eq  31}">待海关审核</c:if>
							<c:if test="${orderDTO.status eq  41}">待发货</c:if>
							<c:if test="${orderDTO.status eq  67}">海关审核订单失败(待退款)</c:if>
							<c:if test="${orderDTO.status eq  68}">海关支付单审核失败(待退款)</c:if>
							<c:if test="${orderDTO.status eq  69}">海关物流单审核失败(待退款)</c:if>
							<c:if test="${orderDTO.status eq  70}">海关审核失败(待退款)</c:if>
							<c:if test="${orderDTO.status eq  79}">已退款</c:if>
							<c:if test="${orderDTO.status eq  81}">待收货</c:if>
							<c:if test="${orderDTO.status eq  91}">已收货</c:if>
							<c:if test="${orderDTO.status eq  99}">用户取消</c:if>
							<c:if test="${orderDTO.status eq  100}">自动取消</c:if>
            	        </span> &nbsp;&nbsp;&nbsp;&nbsp;
            	配送方式：<span>
	            	        <c:if test="${orderDTO.shipType eq  0}">普通</c:if>
			            	<c:if test="${orderDTO.shipType eq  1}">自提</c:if>
			            	<c:if test="${orderDTO.shipType eq  2}">货到付款</c:if>
		            	</span> &nbsp;&nbsp;&nbsp;&nbsp;
            	支付方式：<span>
	            	        <c:if test="${orderDTO.payType eq  0}">线上</c:if>
			            	<c:if test="${orderDTO.payType eq  1}">货到付款</c:if>
		            	</span>
            </h2>
        </div>
        <div class="order-bd">
        	<p></p>
        	<p>成交时间：<span><fmt:formatDate value="${orderDTO.createTime }" type="both"/> </span></p>
            <p>订单金额：<span class="red">¥${orderDTO.orderPrice }</span></p>
            <p>运    &nbsp;&nbsp;&nbsp;费：¥${orderDTO.realTransferprice }</p>
        </div>
    </div>
    
     <c:if test="${orderDTO.supplyType ne 1 and orderDTO.supplyType ne 51 }">
             <div class="order-item">
		       <div class="order-hd">
		           <h2>物流信息</h2>
		       </div>
		       <div class="order-bd">
		    
		           <div class="order-track">  
		           	<div class="order-ti">
				        	<span>物流编号：${orderDTO.logisticsCarriersId }</span>  
				        	<span>物流公司：${orderDTO.logisticsCarriersName }</span>
				        	<span>运单号码：${orderDTO.logisticsNumber }</span>
			        	</div>
		           <c:choose>
		            <c:when test="${empty orderDTO.orderLogisticsMsgs  }">
		            	暂无物流信息
		            </c:when>
		            <c:otherwise>
		               <%-- 	<div class="order-ti">
				        	<span>物流编号：${orderDTO.logisticsCarriersId }</span>  
				        	<span>物流公司：${orderDTO.logisticsCarriersName }</span>
				        	<span>运单号码：${orderDTO.logisticsNumber }</span>
			        	</div> --%>
			            <c:forEach items="${orderDTO.orderLogisticsMsgs }" var="logisticsMsgs" varStatus="count">
				            <c:if test="${count.last}">
					     		<dl class="purple">
				                    <dt></dt>
				                    <dd><fmt:formatDate value="${logisticsMsgs.createTime }" type="both"/>  &nbsp;&nbsp; ${logisticsMsgs.msg } </dd>
				                </dl>
				            </c:if> 
			               <c:if test="${!count.last}">
					     		<dl>
				                    <dt></dt>
				                    <dd><fmt:formatDate value="${logisticsMsgs.createTime }" type="both"/>  &nbsp;&nbsp; ${logisticsMsgs.msg }</dd>
				                </dl>
				            </c:if>
			            </c:forEach>
		            </c:otherwise>
		           </c:choose>     
		           </div>
		       </div>
		   </div>
     </c:if> 
        
    <div class="order-item">
        <div class="order-hd">
            <h2>订单信息</h2>
        </div>
        <div class="order-bd">
        	<h4>收货人信息</h4>
            <p class="u_name">收  货 人：${orderDTO.receiveName }  </p>
            <p class="u_name">联系电话：${orderDTO.receiveMobilePhone }  </p>
            <p class="u_address">收货地址：${orderDTO.receiveAddress } </p>
        </div>
         <div class="order-bd">
            <h4>买家信息</h4>
            <p class="u_name">用户昵称：${user.userName  }  </p>
            <p class="u_name">真实姓名：${user.realName  }  </p>
            <p class="u_name">电子邮箱：${user.email  }  </p>
            <p class="u_name">联系电话：${user.mobile  }  </p>
            <p class="u_address">用户地址：${user.address  } </p>
        </div>
    </div>

    <div class="order-item">
        <div class="order-hd">
            <h2>付款信息</h2>
        </div>
        <div class="order-bd">
            <p>订单件数：${orderDTO.totalQty } </p>
            <p>订单金额：¥<fmt:formatNumber value="${orderDTO.orderPrice }" pattern="0.00#"/> </p>
            <p>实际运费：¥ <fmt:formatNumber value="${orderDTO.realTransferprice }" pattern="0.00#"/></p>
            <p>折扣金额：¥ <fmt:formatNumber value="${orderDTO.discountPrice }" pattern="0.00#"/></p>
            <p>商品关税：¥ <fmt:formatNumber value="${orderDTO.realTotalTax }" pattern="0.00#"/></p>
            <p>应付金额：<span class="red">¥ <fmt:formatNumber value="${orderDTO.price }" pattern="0.00#"/></span></p>
        </div>
    </div>
   <c:if test="${orderDTO.supplyType eq 1 or orderDTO.supplyType eq 51}">
     <div class="area" id="logisticsInfo">
        <div class="order-hd"><h2>物流信息</h2></div>
		<div class="area-bd">
		          <c:choose>
		         <c:when test="${empty orderDTO.shipOrderDTOs}">
		          	<div class="no-logistics"> 暂无物流信息</div>  
		         </c:when>
		         <c:otherwise>
			         <c:forEach items="${orderDTO.shipOrderDTOs}" var="shipOrderDTO" varStatus="count">
			         <div class="item">
	                    <div class="sub"> <span class="year">
	                    <fmt:formatDate value="${shipOrderDTO.createTime}" pattern="yyyy"/></span> <span class="month">
	                    <fmt:formatDate value="${shipOrderDTO.createTime}" pattern="MM/dd"/></span>
	                    <div class="clr"></div>
	                    <span class="total"><em>¥</em><fmt:formatNumber value="${shipOrderDTO.price }" pattern="0.00#"/></span> </div>
	                    <div class="main">
<!-- 	                        <div class="main-content"> -->
<!-- 	                            <div class="mc-hd">  -->
<%-- 		                            <span class="tips">国内包裹   ${count.index+1} </span> --%>
<%-- 		                            <span class="consignor">发货人：${shipOrderDTO.lastEditBy }</span> &nbsp;&nbsp;&nbsp; --%>
<%-- 		                            <span class="consignor">包裹号：${shipOrderDTO.packNo }</span>  --%>
<!-- 	                            </div> -->
<!-- 	                            <div class="mc-bd"> -->
<!-- 	                                <ul class="goods-list clearfix"> -->
<%-- 		                                <c:forEach items="${shipOrderDTO.shipItemDtoList }" var="shipItemDtoList"> --%>
<!-- 	                                     <li> -->
<!-- 	                                         <div class="goods-box"> -->
<%-- 	                                             <div class="goods-pic"><a href="javascript:void(0)"><img src="${shipItemDtoList.productUrl }" width="60" height="60" /></a></div> --%>
<%-- 	                                             <div class="goods-txt"><span class="sku" title="${shipItemDtoList.pName}">商品：${shipItemDtoList.pName} </span><span class="amount"  title="${shipItemDtoList.qty}">数量：${shipItemDtoList.qty}</span></div> --%>
<!-- 	                                         </div> -->
<!-- 	                                     </li> -->
<%-- 		                                </c:forEach> --%>
<!-- 	                                </ul> -->
<!-- 	                            </div> -->
<!-- 	                        </div> -->
	                        <div class="main-bar">
	                            <div class="box"> 
		                            <c:if test="${shipOrderDTO.logisticsCarriersName != null }">
		                            	<span class="kd-name">${shipOrderDTO.logisticsCarriersName }</span> 
		                             	<span class="kd-code">快递单号：<a href="javascript:void(0)"><em>${shipOrderDTO.logisticsNumber }</em></a></span>
		                            </c:if>
		                             <c:if test="${shipOrderDTO.logisticsCarriersName == null }">
		                            	<span class="kd-name">暂无物流信息</span>
		                            </c:if>
	                            </div>
	                        </div>
			              </div>
			            </div>
			         </c:forEach>
		       </c:otherwise>
		       </c:choose> 
           </div>
    </div>
  </c:if>
       
    <div class="order-item">
        <div class="order-hd">
            <h2>商品详情</h2>
        </div>
        <div class="order-bd">
            <table class="tb-void">
            	<tr>
            		<th width="300">商品</th>
            		<th width="200">规格</th>
            		<th width="200">单价(元)</th>
            		<th width="200">数量</th>
            		<th width="200">交易状态</th>
            	</tr>
            	<c:forEach items="${orderDTO.orderItemDTOs }" var="orderItemDTO">
	            	<tr>
	            		<td>
	            		    <div class="goods-pic"><img src="${orderItemDTO.imgUrl }" /></div>
	            		      <div class="goods-info">
	                              <span class="name">${orderItemDTO.pName }</span>
	                        </div>
	            		</td>
	            		<c:if test="${orderItemDTO.productType eq 1}">
	            		<td><span>${orderItemDTO.skuNameCn }<p class="red"><font style="color: red">赠品</font></p></span></td>
	            		</c:if>
	            		<c:if test="${orderItemDTO.productType ne 1}">
	            		<td><span>${orderItemDTO.skuNameCn }</span></td>
	            		</c:if>
	            		<td><fmt:formatNumber value="${orderItemDTO.price }" pattern="0.00#"/></td>
	            		<td>${orderItemDTO.skuQty }</td>
	            		<td>
            				<c:if test="${orderDTO.status eq  1}">待支付</c:if>
							<c:if test="${orderDTO.status eq  21}">已支付</c:if>
							<c:if test="${orderDTO.status eq  31}">待海关审核</c:if>
							<c:if test="${orderDTO.status eq  41}">待发货</c:if>
							<c:if test="${orderDTO.status eq  67}">海关审核订单失败(待退款)</c:if>
							<c:if test="${orderDTO.status eq  68}">海关支付单审核失败(待退款)</c:if>
							<c:if test="${orderDTO.status eq  69}">海关物流单审核失败(待退款)</c:if>
							<c:if test="${orderDTO.status eq  70}">海关审核失败(待退款)</c:if>
							<c:if test="${orderDTO.status eq  79}">已退款</c:if>
							<c:if test="${orderDTO.status eq  81}">待收货</c:if>
							<c:if test="${orderDTO.status eq  91}">已收货</c:if>
							<c:if test="${orderDTO.status eq  99}">用户取消</c:if>
							<c:if test="${orderDTO.status eq  100}">自动取消</c:if>
	            		</td>
	            	</tr>
            	</c:forEach>
            </table>  
        </div>
    </div>
    
      <div class="total">
			<ul>
				<li><span>总商品金额：</span>￥<fmt:formatNumber value="${orderDTO.orderPrice }" pattern="0.00#"/></li>
				<li><span> - 优惠：</span>￥<fmt:formatNumber value="${orderDTO.discountPrice }" pattern="0.00#"/></li>
				<li><span>+ 运费：</span>￥<fmt:formatNumber value="${orderDTO.realTransferprice }" pattern="0.00#"/></li>
				<li><span>+ 关税：</span>￥<fmt:formatNumber value="${orderDTO.realTotalTax }" pattern="0.00#"/></li>
				<li class="to"><span>应付总额：</span><b>￥ <fmt:formatNumber value="${orderDTO.price }" pattern="0.00#"/></b><li>
			</ul>
	  </div>
</div>
<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
</body>
</html>