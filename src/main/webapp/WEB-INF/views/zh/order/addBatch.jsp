<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="UTF-8">
	<title>商家后台管理系统-确认发货</title>
<%@include file="/WEB-INF/views/zh/include/base.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/zh/dingdan.css"/>
</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
	<div class="center">
	<!--logo开始-->
	<div class="logo3">
		<p class="p1">您的位置： 卖家中心 > 已卖出的货品 > <span>确认发货</span></p>
		<p class="p2" id="p2"></p>
	</div>
	<!--logo结束-->

	<!--订单信息开始-->
	<div class="xing">
		<div class="xing1"><p>订单信息</p></div>
	
		<!--商品清单开始-->
		<div class="xing4">
			<div class="zong">
				
				<div class="z2">
				
						<p>
							<span class="s2">商品名称： ${fn:escapeXml(purDto.pName)}</span> 
							<span class="s2">采购单总数量:${fn:escapeXml(purDto.qty)}</span>
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
					<form id="despatch">
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
						    <span>SKU号</span>
							<span>规格</span>
							<span>数量</span>
							<span>价格(${purDto.moneyUnitNameCn})</span>
							</div>
							<div class="t2">
								<span>${skulist.skuId }</span>
								<span class="ov2" title="${fn:escapeXml(skulist.skuNameCn)}">${fn:escapeXml(skulist.skuNameCn)}</span>
								<span>${fn:escapeXml(skulist.qty)}</span>
								<span>
								${fn:escapeXml(purDto.moneyUnitSymbols)}
									<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(skulist.price)}"></fmt:formatNumber>
								</span>
							</div>
							
							<table class="sq_wrap">
									<tr >
										<th>批次号</th>
										<th>数量</th>
										<th>生产日期</th>
										<th>有效日期</th>
										<th>操作</th>
									</tr>
									<tr class="sq_b">
									
										<td><input type="hidden" name="skuId" value="${skulist.skuId }">
										
										<input type="text" name="batchNo" class="pici"></td>
										<td><input type="text" name="qty" class="num"></td>
										<td><input type="text" readonly="readonly" id="createTime" onClick="WdatePicker()" name="createTime"></td>
										<td><input type="text" readonly="readonly" id="endTime" onClick="WdatePicker()" name="endTime"></td>
										<td><a>删除</a></td>
									</tr>
									
								</table>
								<button class="zengj" type="button" onclick="addtime(event,'${skulist.skuId}')">添加</button>
							</div>
						</c:forEach>
					   	
					   	
					   	</c:when>
					   
					   	<c:otherwise>
						   		<c:forEach items="${purDto.itemlist }" var="skulist">
							<div  class="tabborder">
							 <div class="t1">	
							    <span>SKU号</span>
								<span>规格</span>
								<span>数量</span>
								<span>价格</span>
								</div>
								<div class="t2">
									<span>${skulist.skuId }</span>
									<span class="ov2" title="${fn:escapeXml(skulist.skuNameCn)}">${fn:escapeXml(skulist.skuNameCn)}</span>
									<span>${fn:escapeXml(skulist.qty)}</span>
									<span>
										<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(skulist.price)}"></fmt:formatNumber>
									</span>
									
									
								</div>
								
								<table class="sq_wrap">
										<tr>
											<th>批次号</th>
											<th>数量</th>
											<th>操作</th>
										</tr>
										<tr class="sq_b">
											<td><input type="hidden" name="skuId" value="${skulist.skuId}">
											<input type="text" name="batchNo" class="pici"></td>
											<td><input type="text" name="qty" class="num"></td>
											<td><a>删除</a></td>
										</tr>
										
									</table>
									<button type="button" class="zengj" onclick="add(event,'${skulist.skuId}')">添加</button>
									</div>
							</c:forEach>
					   	</c:otherwise>
					   </c:choose>
						<%--  --%>
					
						
						<!-- <span class="s4">
						   </span>
						</p> -->
						
						
						
						
						
						<button class="sub" type="button" >提交</button>
					</div>
					</form>
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
</div>
   <!-- 底部 start -->
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
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
	<script src="${path}/js/order/orderoperate.js" type="text/javascript"></script>
</body>
</html>