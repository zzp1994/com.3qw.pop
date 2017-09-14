<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
	<meta charset="UTF-8">
	<title>商家后台管理系统-订单详情</title>
<%@include file="/WEB-INF/views/zh/include/base.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/zh/dingdan.css"/>
    <script type="text/javascript">
    
	    $(document).ready(function(){
	    
	    	var path = $("#address").val();
	    	var status = $("#orderStatus").val();
	    	if(status==32){
	    	$("#p2 img").attr("src",""+path+"/images/buy_status1.png");
	    	$("#purOrderStatus").html("经销商已填写合同");
	    	}
	    	if(status==33){
	    	$("#p2 img").attr("src",""+path+"/images/buy_status2.png");
	    	$("#purOrderStatus").html("已填写合同");
	    	}
	    	if(status==34){
	    	$("#p2 img").attr("src",""+path+"/images/buy_status3.png");
	    	$("#purOrderStatus").html("经销商已确认合同");
	    	}
	    	if(status==62){
	    	$("#p2 img").attr("src",""+path+"/images/buy_status4.png");
	    	$("#purOrderStatus").html("已确认合同");
	    	}
	    	if(status==71){
	    	$("#p2 img").attr("src",""+path+"/images/buy_status5.png");
	    	$("#purOrderStatus").html("已发货");
	    	}
	    	if(status==81){
	    	$("#p2 img").attr("src",""+path+"/images/buy_status6.png");
	    	$("#purOrderStatus").html("已完成");
	    	}
	    });
    </script>
</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
	<div class="center">
	
	<input type="hidden" id="address" value="${path }">
	<input type="hidden"  id="orderStatus" value="${purDto.status }">
	<!--logo开始-->
	<div class="logo3">
		<p class="p1">您的位置： 卖家中心 > 已卖出的货品 > <span>订单详情</span></p>
		<p class="p2" id="p2"><img></p>
	</div>
	<!--logo结束-->
	
	<!--订单状态开始-->
	<div class="ding">
		<div class="ding1">
			订单号：${purDto.poId } 状态：<span id="purOrderStatus">
			<c:if test="${purDto.status=='32' }">
				<i class="status" >经销商已填写合同</i>
			</c:if>
			<c:if test="${purDto.status=='33' }">
				<i class="status" >已填写合同</i>
			</c:if>
				<c:if test="${purDto.status=='34' }">
				<i class="status" >经销商已确认合同</i>
			</c:if>
			<c:if test="${purDto.status=='51' }">
				<i class="status" >买家已付款</i>
				</c:if>
				
			<c:if test="${purDto.status=='61' }">
				<i class="status" >等待打印发货单</i>
				</c:if>
			<c:if test="${purDto.status=='62' }">
				<i class="status" >已确认合同</i>
				</c:if>
			<c:if test="${purDto.status=='71' }">
				<i class="status" >已发货</i>
				</c:if>
			<c:if test="${purDto.status=='81' }">
				<i class="status" >已完成</i>
				</c:if>
			
			</span>
		</div>
		
		<div class="ding2">
			<!-- <p> -->
				<span class="s1">订单信息</span>
				<!-- 循环orderMsg集合并取出 -->
				 <c:forEach items="${purDto.retailerOrderMsgDto}" var="msg">
				 <p>
				  	<span class="time"><fmt:formatDate value="${msg.createTime }"  type="both"/></span>
				  	<span class="time1">${fn:escapeXml(msg.createBy)}</span>
				  	<span class="state">${fn:escapeXml(msg.msg)}</span>
				  </p>
				 </c:forEach>
				<span class="s2"></span>   
			<!-- </p> -->
		</div>
		
	</div>
	<!--订单状态结束-->

	<!--订单信息开始-->
	<div class="xing">
		<div class="xing1"><p>订单信息</p></div>
		<div class="xing2">
			<dl>
				<dt>收货人信息</dt>
				<dd>
					<ul>
						<li>收&nbsp&nbsp货&nbsp&nbsp人：${fn:escapeXml(purDto.receiveNameCn)}</li>
						<li>地&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp址：<span class="ov" title="${fn:escapeXml(purDto.receiveAddressCn)}">${fn:escapeXml(purDto.receiveAddressCn)}</span></li>
						<li>手机号码 ：${purDto.receiveMobile}</li>
					</ul>
				</dd>
			</dl>
		</div>
		<div class="xing3">
			<table>
				<tr class="t1">
					<td>买家信息</td>
					<td></td>
				</tr>
				<tr>
					<td><p class="ov1" title="${fn:escapeXml(purDto.dealer.companyName)}">商家：${fn:escapeXml(purDto.dealer.companyName)}</p></td>
					<td>联系电话：${fn:escapeXml(purDto.receivePhone)}</td>
				</tr>
				<tr class="t1">
					<td>订单信息</td>
					<td></td>
				</tr>
				<tr>
					<td>采购单编号：${purDto.poId }</td>
					<td>成交时间：<fmt:formatDate value="${purDto.createTime}" type="both"/></td>
				</tr>
			</table>
		</div>
	
		<!--商品清单开始-->
		<div class="xing4">
			<div class="zong">
				<div class="z1">
					<p>
					  <span class="sp">商品</span>
					  <span class="jg">总价格(${purDto.moneyUnitNameCn})</span>
					  <span class="sl">数量</span>
					  <span class="sfk">实付款(${purDto.moneyUnitNameCn})</span>
					</p>
				</div>
				<div class="z2">
					<dl>
							<dt><img src="${purDto.imgUrl}" alt="查看宝贝详情" style="width:80px; height:80px;"></dt>
							<dd title="${fn:escapeXml(purDto.pName)}">${fn:escapeXml(purDto.pName)}</dd>
						</dl>
						<div class="blink"></div>
						<p>
							<span class="s1">
							${fn:escapeXml(purDto.moneyUnitSymbols)}
								<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(purDto.price)}"></fmt:formatNumber>
							</span>
							<span class="s2">${fn:escapeXml(purDto.qty)}</span>
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
						    <td>SKU号</td>
							<td>规格</td>
							<td>数量</td>
							<td>价格(${fn:escapeXml(purDto.moneyUnitNameCn)})</td>
						</tr>
						<c:forEach items="${purDto.itemlist }" var="skulist">
						<tr>
							<td>${skulist.skuId }</td>
							<td><p class="ov2" title="${fn:escapeXml(skulist.skuNameCn)}">${fn:escapeXml(skulist.skuNameCn)}</p></td>
							<td>${fn:escapeXml(skulist.qty)}</td>
							<td>
							${fn:escapeXml(purDto.moneyUnitSymbols)}
								<fmt:formatNumber pattern="0.0000#" value="${fn:escapeXml(skulist.price)}"></fmt:formatNumber>
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
</body>
</html>