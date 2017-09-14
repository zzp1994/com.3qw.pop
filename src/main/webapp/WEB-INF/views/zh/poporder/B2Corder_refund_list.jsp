<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>POP_退款订单</title>
	<%@include file="/WEB-INF/views/zh/include/base3.jsp" %>
<link rel="stylesheet" type="text/css" href="${path}/css/poporder/B2C_orderlist.css"/>
	<script type="text/javascript" src="${path}/js/poporder/b2c_order_refund_list.js"></script>
	
</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
<div class="center">
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>
	<div class="right">
		<div class="c21">
			<div class="title">
				<p>卖家中心&nbsp;&gt;&nbsp; </p>
				<p>订单管理&nbsp;&gt;&nbsp; </p>
				<p class="c1">退款订单</p>
			</div>
		</div>
			
		<div class="xia">
		<form action="">
			<p class="p1">
				<span>订单编号 :</span><input type="text" id="orderId">
				<span>下单时间 :</span>
				 <input type="text" id="startTime" class="rl" onClick="WdatePicker()"> <i>至</i>
				 <input type="text" id="endTime" class="rl" onClick="WdatePicker()">
			</p>
			<p class="p1">
				<span>商品名称 :</span><input type="text" id="pName">
				<span>买家昵称 :</span><input type="text" id="userName">
			</p>
			<p class="p1">
				<span>订单状态 :</span>
				<!-- 67,68,69 -->
				<select id="status">
				   <option value="">全部</option>
			       <option value="67">海关审核订单失败(待退款)</option>
			       <option value="68">海关支付单审核失败</option>
			       <option value="69">海关物流单审核失败</option>
			       <option value="70">海关审核失败</option>
			       <option value="79">已退款</option>
			       <option value="99">用户取消</option>
				</select>
				
			 	<span>收货人 :</span><input type="text" id="receiveName">
			</p>
			</form>
			<p class="p2">
				<button type="button" onclick="byConditionSearchcustomerRefundOrder(1)">搜索</button>
				<a href="javascript:void(0)" id="czhi" onclick="resetfm()">重置</a>
			</p>
		</div>
		<div class="tab-bd">
		
		</div>
	</div>
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
	
	byConditionSearchcustomerRefundOrder(1);
});

//获取窗口的高度 
var windowHeight; 
// 获取窗口的宽度 
var windowWidth; 
// 获取弹窗的宽度 
var popWidth; 
// 获取弹窗高度 
var popHeight; 
function init(){ 
    windowHeight=$(window).height(); 
    windowWidth=$(window).width(); 
    popHeight=$(".window").height(); 
    popWidth=$(".window").width(); 
} 
//关闭窗口的方法 
function closeWindow(){ 
    $(".title img").click(function(){ 
        $(this).parent().parent().hide("slow"); 
    }); 
    $("#closeShipWinBtn").click(function(){ 
        $("#center").hide("slow"); 
    }); 
} 
//定义弹出居中窗口的方法 
function popCenterWindow(){ 
    init(); 
    //计算弹出窗口的左上角Y的偏移量 
	var popY=(windowHeight-popHeight)/2 + document.body.scrollTop; 
	var popX=(windowWidth-popWidth)/2; 
	//alert('jihua.cnblogs.com'); 
	//设定窗口的位置 
	$("#center").css("top",popY).css("left",popX).slideToggle("slow");  
	closeWindow(); 
} 
</script>
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
</body>
</html>