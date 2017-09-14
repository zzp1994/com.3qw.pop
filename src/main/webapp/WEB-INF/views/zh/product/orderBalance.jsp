<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" >
	<title>商家后台管理系统-结算订单列表</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
    <link rel="stylesheet" type="text/css" href="${path }/css/product.css"/>
    <link rel="stylesheet" type="text/css" href="${path }/css/product/reset.css"/>
    <link rel="stylesheet" type="text/css" href="${path }/css/product/reset2.css"/>
    <script type="text/javascript" src="${path }/js/balance_list_fn.js"></script>
   
</head>
<body>
	
	<!-- 导航 start -->
	<%@include file="/WEB-INF/views/zh/include/header.jsp"%>
	<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>
	<!-- 导航 end -->


<script type="text/javascript">

function exportExcel(){
	
	var startTime  = $("#fromDate").val();
	var endTime  = $("#toDate").val();
	var oid = $("#oid").val();
	var type = $("#typeId").val().trim();

	var customerOrder_array = new Array();
	
	if(startTime != ""){
		customerOrder_array.push("startTime="+startTime);
	}
	if(endTime != ""){
		customerOrder_array.push("endTime="+endTime);
	}
	if(oid != ""){
		customerOrder_array.push("oid="+oid);
	}
	if(type != ""){
		customerOrder_array.push("type="+type);
	}
	
   
   
window.location.href = "../order/exportExcel?"+customerOrder_array.join("&");
}

</script>

		<div class="c2">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;&gt;&nbsp;</p>
					<p>订单管理&nbsp;&gt;&nbsp;</p>
					<p class="c1">结算列表</p>
				</div>
			</div>
			<div class="blank10"></div>

			<div class="c22">
				<div class="c3" id="cp3">
					<input id="typeId" value="" type="hidden"/>
					<ul class="top goods-tab">
					<li class="list" id="li_POP_sheng"><a href="javascript:void(0)" onclick="getBalanceOrder(2)"  liststatus='2'>结算订单</a></li>
					<li class="list" id="li_POP_tong"><a href="javascript:void(0)" onclick="getBalanceOrder(1)"  liststatus='1'>未结算订单</a></li>
					</ul>
				<div class="xia" style="min-height: 100px;">
				  <form action="">
					<p class="p1">
						<span>日期:</span>
						 <input type="text" id="fromDate" class="rl" onClick="WdatePicker()"> <i>至</i>
						 <input type="text" id="toDate" class="rl" onClick="WdatePicker()">
					</p>
					<p class="p1">
						<span>订单编号:</span>
						 <input type="text" id="oid" class="rl" >
						 
					</p>
				  	<p class="p3" style="">
						<button type="button" onclick="clickSubmit('1')">搜索</button>
						<a href="javascript:void(0)" id="czhi" onclick="resetfm()">重置</a>
						 <button onclick="exportExcel()" type="button" class="dc-btn">导出</button> 
						 
					</p>
				  </form>
				</div>
					<div class="blank5"></div>
					<div class="c3" id="c3"></div>
				</div>
			</div>
		</div>
			<div class="blank10"></div>
    <div class="blank"></div>
		<!--中间左边开始-->
		<!-- 左边 start -->

<%-- 			<%@include file="/WEB-INF/views/zh/dealerseller/leftPage.jsp"%> --%>

		<!-- 左边 end -->
		<!--中间左边结束-->
		<div class="alert_user3" style="display: none;">
			<div class="bg"></div>
			<div class="w">
				<div class="box1">
					<img src="${path}/images/close.jpg" class="w_close">
				</div>
				<div class="box3">
					<p id="showmsgplat"></p>
				</div>
				<div class="blank20"></div>
			</div>
		</div>


	</div>

	<div class="blank10"></div>
	 <!-- 底部 start -->
		<%@include file="/WEB-INF/views/zh/include/foot.jsp"%>
		<!-- 底部 end -->
		
<div class="lightbox" id="copyData" style="display:none">
	<div class="lightbox-overlay"></div>
	<div class="lightbox-box">
		
	</div>
</div>
</body>
</html>