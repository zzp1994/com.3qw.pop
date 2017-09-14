<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>商家后台管理系统-已卖出的货品</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/zh/maichu.css"/>
    <script type="text/javascript" src="${path}/js/order/order.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>

<!--消息弹框开始-->
<%-- 	<div class="alert_xiaox">
		<div class="bg"></div>
		<div class="wrap">
			<div class="box1">
				<p class="pic"><img src="${path}/commons/images/close.jpg" class="b_colse"></p>
				<h2>消息</h2>
			</div>
			<div class="box2">
				<div class="xinx">
				
				</div>
			</div>
		</div>
	</div> --%>
<!--消息弹框结束-->

	 <!--左边右边-->
	 <div class="c2">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;>&nbsp; </p>
					<p>订单管理&nbsp;>&nbsp; </p>
					<p class="c1">已卖出的货品</p>
				</div>
			</div>
			<div class="blank10"></div>
			<input type="hidden" value="${path}">
			<div class="c22">
				<div class="c21">
					<ul class="top">
						<li class="list" id="suoyou"><a href="javascript:void(0)" onclick="getOrder(999)">所有订单</a></li>
						<li id="queren"><a href="javascript:void(0)" onclick="getOrder(998)">等待确认</a></li>
						<li id="dengdai"><a href="javascript:void(0)" onclick="getOrder(62)">等待发货</a></li>
						<li id="shouhuo"><a href="javascript:void(0)" onclick="getOrder(71)">已发货</a></li>
						<li id="wancheng"><a href="javascript:void(0)" onclick="getOrder(81)">已完成</a></li>
					</ul>
				</div>
				

				<div class="xia">
				  <form>
				  <input type="hidden" value="${language}" id="language">
					<p class="p1">
					<strong class="st">商品名称 ：</strong> <input type="text" class="text1" id="pName">
					<strong class="st">经销商名称 ：</strong> <input type="text" class="text1" id="dealerName">
					</p>
					<p class="p3">
					<strong class="st">订单编号 ：</strong> <input type="text" class="text1" id="orderId">
						<strong class="st">下单时间： 从 </strong><span>
						<input type="text" class="text1" readonly="readonly" id="startTime" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\',{d:-1});}'})"><span> 到 <span>
						<input type="text" class="text1" readonly="readonly" id="endTime" onClick="WdatePicker({minDate:'#F{$dp.$D(\'startTime\',{d:1});}'})"></span>
					</p>
					<p class="p2">
						<strong id="statusList" class="st">订单状态 ：</strong>

							<select id="state">
							<option value="999">请选择</option>
							<!-- <option value="1">等待分配采购单</option>
							<option value="21">等待经销商下单</option>
							<option value="31">已提交采购单</option> -->
							<option value="32">待填写合同</option>
							<option value="33">等待经销商确认合同</option>
							<option value="34">待确认合同</option>
							<!-- <option value="41">合同已生成</option>
							<option value="51">买家已付款</option>
							<option value="61">等待打印发货单 </option> -->
							<option value="62">待发货</option>
							<option value="71">已发货</option>
							<option value="81">已完成</option>
						</select>
						
					</p>
					<p class="p4">
						<button type="button" onclick="clickSubmit()">搜索</button>
						<a href="#" id="czhi" onclick="resetfm()">重置</a>
					</p>
				   </form>
				</div>
				<div class="clear:both;"></div>
			<!-- 所有订单 -->
			<div class="c3">
            	
			</div>
			
		</div>

  </div>
	  <div class="blank10"></div>
	<!--下一页-->
	
</div>

<script type="text/javascript">
$(document).ready(function(){
	$("#orderId").change(function(){
   		var orderId = $("#orderId").val();
   		var  matchnum = /^[0-9]*$/;
   	    if(!matchnum.test(orderId)){
   	     		alert("订单id只能为数字！");
   	     		 $("#orderId").val("");
   	     		 $("#orderId").focus();
   	     }
   	});
});

</script>


 <div class="blank10"></div>
 <!-- 底部 start -->
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<!-- 底部 end -->

</body>
</html>