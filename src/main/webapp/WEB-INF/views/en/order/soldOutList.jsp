<%@ page language="java" import="java.util.*" pageEncoding="utf8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Supplier-Sold Products</title>
	<%@include file="/WEB-INF/views/en/include/base.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/en/maichu.css"/>
    <script type="text/javascript" src="${path}/js/order/order.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/en/include/header.jsp" %>
<%@include file="/WEB-INF/views/en/include/leftProduct.jsp" %>

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
					<p>Seller Center&nbsp;>&nbsp; </p>
					<p>Orders &nbsp;>&nbsp; </p>
					<p class="c1">Sold Products</p>
				</div>
			</div>
			<div class="blank10"></div>
			<div class="c22">
				<div class="c21">
					<ul class="top">
						<li class="list" id="suoyou"><a href="javascript:void(0)" onclick="getOrder(999)">All Orders</a></li>
						<li id="queren"><a href="javascript:void(0)" onclick="getOrder(998)">To be confirmed</a></li>
						<li id="dengdai"><a href="javascript:void(0)" onclick="getOrder(62)">To Be Shipped</a></li>
						<li id="shouhuo"><a href="javascript:void(0)" onclick="getOrder(71)">Delivered</a></li>
						<li id="wancheng"><a href="javascript:void(0)" onclick="getOrder(81)">Completed</a></li>
					</ul>
				</div>
				

				<div class="xia">
				  <form>
				  <input type="hidden" value="${language}" id="language">
					<p class="p1">
					<strong class="st" style="margin-left:28px;">Product Name：</strong> <input type="text" class="text1" id="pName">
					<strong class="st" style="margin-left:35px;">Dealer's Name ：</strong> <input type="text" class="text1" id="dealerName">
					</p>
					<p class="p3">
					<strong class="st">Order Number ：</strong> <input type="text" class="text1" id="orderId">
						<strong class="st">Transaction Time：</strong><span>
						<input type="text" class="text1" readonly="readonly" id="startTime" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\',{d:-1});}'})"><span> To<span>
						<input type="text" class="text1" readonly="readonly" id="endTime" onClick="WdatePicker({minDate:'#F{$dp.$D(\'startTime\',{d:1});}'})"></span>
					</p>
					<p class="p2">
						<strong id="statusList" class="st" style="margin-left:35px;">Order Status ：</strong>
							<select id="state">
							<option value="999">Please Select</option>
							<!-- <option value="1">Purchase orders to be assigned</option>
							<option value="21">Waiting for dealer order</option>
							<option value="31">Purchase Order Submitted</option> -->
							<option value="32">Waiting for supplier to fill out the contract</option>
							<option value="33">Waiting for dealer to confirm the contract</option>
							<option value="34">Waiting for supplier to confirm the contract</option>
							<!-- <option value="41">Contracts have been submitted</option>
							<option value="51">The seller has paid the order</option>
							<option value="61">Waiting to print Dispatch Bill </option> -->
							<option value="62">Waiting for shipment</option>
							<option value="71">Delivered</option>
							<option value="81">Completed</option>
						</select>
						
					</p>
					<p class="p4">
						<button type="button" onclick="clickSubmit()">Search</button>
						<a href="#" id="czhi" onclick="resetfm()">Reset</a>
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
   	     		alert("Only numbers can be entered in orderId！");
   	     		 $("#orderId").val("");
   	     		 $("#orderId").focus();
   	     }
   	});
});

</script>
 <div class="blank10"></div>
 <!-- 底部 start -->
	<%@include file="/WEB-INF/views/en/include/last.jsp"%>
	<!-- 底部 end -->

</body>
</html>