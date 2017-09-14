<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>商家后台管理系统-订单管理</title>
	<%@include file="/WEB-INF/views/zh/include/base3.jsp" %>
    
    <script type="text/javascript" src="${path}/js/poporder/poporder2.js"></script>
	<!--	物流公司搜索提示用-->
	 <link rel="stylesheet" href="${path}/css/poporder/bootstrap-3.3.4.css">  
   	 <link rel="stylesheet" href="${path}/css/poporder/bootstrap-select.css">
   	 <link rel="stylesheet" type="text/css" href="${path}/css/poporder/poporder.css"/>
     <script src="${path}/js/poporder/bootstrap-3.3.4.js"> </script>
	 <script src="${path}/js/poporder/bootstrap-select.js"></script>
	 
   
</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>

	 <!--左边右边-->
	 <div class="c2">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;>&nbsp; </p>
					<p>订单管理&nbsp;>&nbsp; </p>
					<p class="c1">订单管理</p>
				</div>
			</div>
			<div class="blank10"></div>
			<input type="hidden" value="${path}">
			<div class="c22">
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
						<span>收货人 :</span><input type="text" id="receiveName">
					</p>
					<p class="p1">
						<span>订单状态 :</span>
						<!-- 67,68,69 -->
						<select id="status">
						   <option value="">全部</option>
					       <option value="1">待支付</option>
					       <option value="21">已支付</option>
					       <option value="41">待发货</option>
					       <option value="79">已退款</option>
					       <option value="81">待收货</option>
					       <option value="91">已收货</option>
					       <option value="99">用户取消</option>
					       <option value="100">自动取消</option>
						</select>
						<!-- 11.宁波海外直邮  12.宁波保税区发货 13.郑州海外直邮 14.郑州保税区发货  1.国内发货 21.韩国直邮 -->
<!-- 						<span>货源种类 :</span> -->
<!-- 						<select id="supplyType"> -->
<!-- 							<option value="51">第三方国际发货(POP)</option> -->
						 <!-- <option value="13">郑州海外直邮</option>
						 <option value="14">郑州保税区发货</option> -->
<!-- 						 </select> -->
						<span>平台类型 :</span>
						<select id="orderPlatform">
						<option value="">全部方式</option>
						 <option value="1">PC</option>
						 <option value="2">ANDROID</option>
						 <option value="3">WAP</option>
						 <option value="4">IOS</option>
						 </select>
						 <span>订单类型 :</span>
						<select id="companyQy">
						<option value="">全部</option>
						 
						 <option value="8">幸福购订单</option>
						 <option value="1">普通订单</option>
						 </select>
					</p>
				  </form>
				  
				  <p class="p2">
				 		
						<button type="button" onclick="byConditionSearchCustomerOrder(1)">搜索</button>
						<a href="javascript:void(0)" id="czhi" onclick="resetfm()">重置</a>
						<button onclick="exportCustomerOrderExcel()" type="button" class="dc-btn">导出</button>
						<!-- <button onclick="hsz(1)" type="button" class="dc-btn">回收站</button> -->
						
					</p>
				</div>
				<div class="clear:both;"></div>
				
				
				<!-- 补录物流信息开始 -->
				<div class="window" id="center" style="z-index:9;display: none;"> 
			    	<div id="title" class="title" style="z-index:9;"><img src="../images/uploadify-cancel.png" alt="关闭" />录入物流信息</div> 
			    	<div class="content" style="z-index:9;">
						<div class="log-c2">
							<div class="item">
								<i class="error" style="width: 100%;text-align: center;float: left;color: #f00;"></i>
							</div>
							<div class="item">
								<span style="float:left;">物流商：</span>
								
								<div >
								
							       	<select id="logistic3" class="selectpicker show-tick"  data-live-search="true">
							       		  <c:if test="${ not empty logisticTemps }">
							       		  		<c:forEach items="${logisticTemps }"  var="temp" > 
										  		 	<option value="${temp.providerId}">${temp.providerName}</option> 
							       				</c:forEach> 
							       			</c:if>
							       	</select>
							    </div>
							</div>
							<div class="item" style="margin-top:15px;">
								<span style="float:left;">物流单号:</span>
								<input type="text" id="logisticCode" class="">
							</div>
							<input type="hidden" value="" id="shipOrderId">
							
							<div class="item" style="font-size:12px;">
								<span style="height:15px;font-weight:bold;line-height:15px;">收货人：</span><font style="height:15px;" id="receiveNameField"> </font></br>
							</div>
							
							<div class="item" style="font-size:12px;">
								<span style="height:15px;font-weight:bold;line-height:15px;">联系电话：</span><font style="height:15px;" id="receivePhoneField"> </font></br>
							</div>
							<div class="item" style="font-size:12px;">
								<span style="height:15px;font-weight:bold;line-height:15px;float:left">收货地址：</span>
								<font style="height:15px;" >
									<table>
									<tr><td>
										<font id="receiveAddressField"></font>
									</td></tr>
								</table>
								</font>
							</div>
						</div>
						
						<div class="log-c3">
							<button type="button" onclick="goUpdateShipOrderLogistic()">确定</button>
							<button type="button" id="closeShipWinBtn">取消</button>
						</div>
					</div> 
			    </div>
				<!-- 补录物流信息结束 -->
				
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
	
	byConditionSearchCustomerOrder(1);
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

 <div class="blank10"></div>
 <!-- 底部 start -->
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<!-- 底部 end -->

</body>
</html>