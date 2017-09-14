<%@ page language="java" import="java.util.*" pageEncoding="utf8" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Supplier-Order Details</title>
<%@include file="/WEB-INF/views/en/include/base.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/en/dingdan.css"/>
    <script type="text/javascript">
    
	    $(document).ready(function(){
	    
	    	var path = $("#address").val();
	    	var status = $("#orderStatus").val();
	    	if(status==32){
	    	$("#p2 img").attr("src",""+path+"/images/buy_statusEn1.png");
	    	$("#purOrderStatus").html("Dealers have filled in the contract");
	    	}
	    	if(status==33){
	    	$("#p2 img").attr("src",""+path+"/images/buy_statusEn2.png");
	    	$("#purOrderStatus").html("Have filled in the contract");
	    	}
	    	if(status==34){
	    	$("#p2 img").attr("src",""+path+"/images/buy_statusEn3.png");
	    	$("#purOrderStatus").html("The seller has paid the order");
	    	}
	    	if(status==62){
	    	$("#p2 img").attr("src",""+path+"/images/buy_statusEn4.png");
	    	$("#purOrderStatus").html("Contracts have been submitted");
	    	}
	    	if(status==71){
	    	$("#p2 img").attr("src",""+path+"/images/buy_statusEn5.png");
	    	$("#purOrderStatus").html("Delivered");
	    	}
	    	if(status==81){
	    	$("#p2 img").attr("src",""+path+"/images/buy_statusEn6.png");
	    	$("#purOrderStatus").html("completed");
	    	}
	    });
    </script>
</head>
<body>
<%@include file="/WEB-INF/views/en/include/header.jsp" %>
	<div class="center">
	
	<input type="hidden" id="address" value="${path }">
	<input type="hidden"  id="orderStatus" value="${purDto.status }">
	<!--logo开始-->
	<div class="logo3">
		<p class="p1">Seller Center > Sold Products > <span>Order Details</span></p>
		<p class="p2" id="p2"><img></p>
	</div>
	<!--logo结束-->
	
	<!--订单状态开始-->
	<div class="ding">
		<div class="ding1">
			Order Number：${purDto.poId } Status：<span id="purOrderStatus">
			<c:if test="${purDto.status=='32' }">
				<i class="status" >Dealers have filled in the contract</i>
			</c:if>
				<c:if test="${purDto.status=='33' }">
				<i class="status" >Have filled in the contract</i>
			</c:if>
			<c:if test="${purDto.status=='34' }">
				<i class="status" >Contracts have been submitted</i>
				</c:if>
				
			<c:if test="${purDto.status=='51' }">
				<i class="status" > Waiting to print Dispatch Bill</i>
				</c:if>
			<c:if test="${purDto.status=='62' }">
				<i class="status" >Contracts have been submitted</i>
				</c:if>
			<c:if test="${purDto.status=='71' }">
				<i class="status" >Delivered</i>
				</c:if>
			<c:if test="${purDto.status=='81' }">
				<i class="status" >Completed</i>
				</c:if>
			
			</span>
		</div>
		
		<div class="ding2">
			<!-- <p> -->
				<span class="s1">Order Information</span>
				<!-- 循环orderMsg集合并取出 -->
				 <c:forEach items="${purDto.retailerOrderMsgDto}" var="msg">
				 <p>
				  	<span class="time"><fmt:formatDate value="${msg.createTime}"  type="both"/></span>
				  	<span class="time1">${fn:escapeXml(msg.createBy)}</span>
				  	<span class="state">${fn:escapeXml(msg.msgEn)}</span>
				 </p>
				 </c:forEach>
				<span class="s2"></span>   
			<!-- </p> -->
		</div>
		
	</div>
	<!--订单状态结束-->

	<!--订单信息开始-->
	<div class="xing">
		<div class="xing1"><p>Order Information</p></div>
		<div class="xing2">
			<dl>
				<dt>Consignee Information</dt>
				<dd>
					<ul>
						<li>Consignee：${fn:escapeXml(purDto.receiveNameEn)}</li>
						<li>Address：<span class="ov" title="${fn:escapeXml(purDto.receiveAddressEn)}">${fn:escapeXml(purDto.receiveAddressEn)}</span></li>
						<li>Mobile：${fn:escapeXml(purDto.receiveMobile)}</li>
					</ul>
				</dd>
			</dl>
		</div>
		<div class="xing3">
			<table>
				<tr class="t1">
					<td>Buyer Information</td>
					<td></td>
				</tr>
				<tr>
					<td><p class="ov1" title="${fn:escapeXml(purDto.dealer.companyName)}">Merchants：${fn:escapeXml(purDto.dealer.companyName)}</p></td>
					<td>Tel：${fn:escapeXml(purDto.receivePhone)}</td>
				</tr>
				<tr class="t1">
					<td>Order Information</td>
					<td></td>
				</tr>
				<tr>
					<td>Order Number：${fn:escapeXml(purDto.poId )}</td>
					<td>Deal Time：<fmt:formatDate value="${purDto.createTime}" type="both"/></td>
				</tr>
			</table>
		</div>
	
		<!--商品清单开始-->
		<div class="xing4">
			<div class="zong">
				<div class="z1">
					<p>
					  <span class="sp">Product</span>
					  <span class="jg">Total Price(${purDto.moneyUnitNameEn})</span>
					  <span class="sl">Number</span>
					  <span class="sfk">Actual Payments(${purDto.moneyUnitNameEn})</span>
					</p>
				</div>
				<div class="z2">
					<dl>
							<dt><img src="${purDto.imgUrl}" alt="Product Details" style="width:80px; height:80px;"></dt>
							<dd title="${fn:escapeXml(purDto.pName)}">${fn:escapeXml(purDto.pName) }</dd>
						</dl>
						<div class="blink"></div>
						<p>
							<span class="s1">
							${fn:escapeXml(purDto.moneyUnitSymbols)}
								<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(purDto.price)}"></fmt:formatNumber>
							</span>
							<span class="s2">${fn:escapeXml(purDto.qty )}</span>
							<span class="s3">
							${fn:escapeXml(purDto.moneyUnitSymbols)}
								<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(purDto.price)}"></fmt:formatNumber>
							</span>
							<span class="s4">
						   </span>
						</p>
				</div>
			</div>
			
			<div class="c3" >
				<div class="two">	
	<!-- 获取订单的下的信息显示出来 -->
					<div class="two1">
					<table class="sq" width="100%">
					    <tr class="t1">	
						    <td>SKU</td>
							<td>Specification</td>
							<td>Number</td>
							<td>Price(${purDto.moneyUnitNameEn})</td>
						</tr>
						<c:forEach items="${purDto.itemlist }" var="skulist">
						<tr>
							<td>${skulist.skuId }</td>
							<td><p class="ov2" title="${fn:escapeXml(skulist.skuNameEn)}">${fn:escapeXml(skulist.skuNameEn)}</p></td>
							<td>${fn:escapeXml(skulist.qty)}</td>
							<td>
							${fn:escapeXml(purDto.moneyUnitSymbols)}
								<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(skulist.price )}"></fmt:formatNumber>
							</td>
						</tr>
						</c:forEach>
						</table>
						<span class="s4">
						   </span>
						</p>
					</div>
					<div class="blink"></div>
					<div class="two2">
					</div>
					
				</div>
			</div>
		</div>
	
		<div class="bink"></div>
		<div class="xing5"></div>
	</div>
	<!--订单信息结束-->
</div>
   <!-- 底部 start -->
	<%@include file="/WEB-INF/views/en/include/last.jsp"%>
	<!-- 底部 end -->
	
	<!-- <script>
		$(document).ready(function(){
			//heb();
			hg();
		});
		var hg=function(){
			$(".xing4").mouseenter(function(){
				$(".c3").show();
			}).mouseleave(function(){
			    $(".c3").hide();
			})
		};
		/* var heb=function(){
			$(".two2").hide();
			$(".two").toggle(function(){
                $(this).find(".two2").show();
			    $(this).css("border","2px solid #ff4f00");
            },function(){
                $(this).find(".two2").hide();
				$(this).css("border","none");
              }); 
		   };*/
		

	</script> -->
</body>
</html>