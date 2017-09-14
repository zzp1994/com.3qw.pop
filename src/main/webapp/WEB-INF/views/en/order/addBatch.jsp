<%@ page language="java" import="java.util.*" pageEncoding="utf8" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Supplier-Delivery confirmation</title>
<%@include file="/WEB-INF/views/en/include/base.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/en/dingdan.css"/>
</head>
<body>
<%@include file="/WEB-INF/views/en/include/header.jsp" %>
	<div class="center">
	<!--logo开始-->
	<div class="logo3">
		<p class="p1">Seller Center > Sold Products > <span>Delivery confirmation</span></p>
		<p class="p2" id="p2"></p>
	</div>
	<!--logo结束-->

	<!--订单信息开始-->
	<div class="xing">
		<div class="xing1"><p>Order Information</p></div>
	
		<!--商品清单开始-->
		<div class="xing4">
			<div class="zong">
				
				<div class="z2">
				
						<p>
							<span class="s2">ProdectName： ${fn:escapeXml(purDto.pName)}</span> 
							<span class="s2">Order Number:${fn:escapeXml(purDto.qty)}</span>
							<%-- <span class="s3">${fn:escapeXml(purDto.price)}</span> --%>
							<!-- <span class="s4">
						   </span> -->
						</p>
				</div>
			</div>
			
			<div class="c3" >
				<div class="two">	
	<!-- 获取订单的下的信息显示出来 -->
					<div class="two1">
					<form action="/${path}order/despatch" id="despatch">
					<input name="isBatch" type="hidden" value="${sheilLife}">
					<input name="orderId" type="hidden" value="${purDto.poId}">
					<input name="pid" type="hidden" value="${purDto.pid}">
					<input name="purchaseId" type="hidden" value="${purDto.poId}">
					<div class="sq">
					  <c:choose>
					   <c:when test="${sheilLife==1}">
						<c:forEach items="${purDto.itemlist }" var="skulist">
							<div class="tabborder">
							 <div class="t1">	
						    <span>SKU </span>
							<span>Specification</span>
							<span>Number</span>
							<span>Price(${purDto.moneyUnitNameEn})</span>
							</div>
							<div class="t2">
								<span>${skulist.skuId }</span>
								<span class="ov2" title="${fn:escapeXml(skulist.skuNameCn)}">${fn:escapeXml(skulist.skuNameCn)}</span>
								<span>${fn:escapeXml(skulist.qty)}</span>
								<span>
								${purDto.moneyUnitSymbols} 
									<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(skulist.price)}"></fmt:formatNumber>
								</span>
							</div>
							
							<table class="sq_wrap">
									<tr >
										<th>BatchNo</th>
										<th>Number</th>
										<th>ProduceDate</th>
										<th>ValidDate</th>
										<th>Operate</th>
									</tr>
									<tr class="sq_b">
									
										<td><input type="hidden" name="skuId" value="${skulist.skuId }">
										
										<input type="text" name="batchNo" class="pici"></td>
										<td><input type="text" name="qty" class="num"></td>
										<td><input type="text" readonly="readonly" onClick="WdatePicker()" name="createTime" id="createTime"></td>
										<td><input type="text" readonly="readonly" onClick="WdatePicker()" name="endTime" id="endTime"></td>
										<td><a>delete</a></td>
									</tr>
									
								</table>
								<button class="zengj" type="button" onclick="addtime(event,'${skulist.skuId}')">add</button>
							</div>
						</c:forEach>
					
						
						<!-- <span class="s4">
						   </span>
						</p> -->
						
						</c:when>
						<c:otherwise>
						
						
						<c:forEach items="${purDto.itemlist }" var="skulist">
						<div  class="tabborder">
						 <div class="t1">	
						    <span>SKU</span>
							<span>Specification</span>
							<span>Number</span>
							<span>Price(${purDto.moneyUnitNameEn})</span>
							</div>
							<div class="t2">
								<span>${skulist.skuId }</span>
								<span class="ov2" title="${fn:escapeXml(skulist.skuNameCn)}">${fn:escapeXml(skulist.skuNameCn)}</span>
								<span>${fn:escapeXml(skulist.qty)}</span>
								<span>
								${purDto.moneyUnitSymbols}
									<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(skulist.price)}"></fmt:formatNumber>
								</span>
							</div>
							
							<table class="sq_wrap">
									<tr>
										<th>BatchNo</th>
										<th>Number</th>
										<th>Operate</th>
									</tr>
									<tr class="sq_b">
										<td><input type="hidden" name="skuId" value="${skulist.skuId }">
										<input type="text" name="batchNo" class="pici"></td>
										<td><input type="text" name="qty" class="num"></td>
										<td><a>delete</a></td>
									</tr>
									
								</table>
								<button type="button" class="zengj" onclick="add(event,'${skulist.skuId}')">add</button>
								</div>
						</c:forEach>
						</c:otherwise>
						</c:choose>
						<button type="button" class="sub" >submit</button>
					</div>
					
					<div class="blink"></div>
					<div class="two2">
					</div>
				</form>
				</div>
			</div>
		</div>
		
		<div class="bink"></div>
		<div class="xing5"></div>
	</div>
	<!--订单信息结束-->
</div>
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
	<script src="${path}/js/order/orderoperate_en.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript" src="${path}/js/my97/en/My97DatePicker/WdatePicker.js"></script>
</body>
</html>