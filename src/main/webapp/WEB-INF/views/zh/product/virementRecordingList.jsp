<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>商家后台管理系统-企业转账记录</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp" %>
    <link rel="stylesheet" type="text/css" href="${path}/css/poporder/poporder.css"/>
    <script type="text/javascript" src="${path}/js/poporder/poporder.js"></script>
    <style>
    	.btn_class{
    	    width: 65px;
            height: 23px;
            border: 1px solid #c8c8c8;
            border-radius: 5px;
            background: url(/images/img_btn.png) repeat-x;
            font-size: 14px;
            cursor: pointer;
        }
    </style>
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
					<p class="c1">企业转账记录</p>
				</div>
			</div>
			<div class="blank10"></div>
			<input type="hidden" value="${path}">
			<div class="c22">
				<div class="xia" style="width: 840px;height:60px;background:#f2f2f2;overflow:hidden;">
				  <form id="SearchFrom" action="/recording/virementRecording" method="post">
				  	<input type="hidden" id="page" name="page"/>
				  	<input type="hidden" id="pageSize" name="pageSize"/>
					<p class="p1">
						<span style="width:60px;">时间:</span>
						<input type="text" id="startTime" name="startTime" value="${startTime}" onClick="WdatePicker()">
						<span style="width:30px;">至&nbsp;</span>
						<input type="text" id="endTime" name="endTime" value="${endTime}" onClick="WdatePicker()">
						&nbsp;&nbsp;
						<button type="button" class="btn_class" onclick="toGetList()" >搜索</button>
						&nbsp;&nbsp;
						<a href="#" id="czhi" onclick="resetfm()">重置</a>
					</p>
<!--
					<p class="p1">
						<span>序号:</span>
						<input type="text" id="trancNo" name="trancNo" value="${trancNo}">
					</p>
-->
				  </form>
				</div>
				<div class="clear:both;"></div>
			<!-- 所有订单 -->
			<div class="c3">
				<table id="J_BoughtTable" class="bought-table" data-spm="9" width="100%">
					<thead class="tb-void">
					 <tr class="ar1">
					 <th class="ar1">序号</th>
					 <th class="ar1">时间</th>
					 <th class="ar1">企业ID</th>
					 <th class="ar1">企业个人ID&nbsp;(姓名)</th>
					 <th class="ar1">额度&nbsp;(券)</th>
					</tr>
					</thead>
					<tbody class="data tb-void">
					<c:forEach items="${pb.result}" var="transferRecord">
						<tr>
							<td>${transferRecord.id }</td>
							<td><fmt:formatDate value="${transferRecord.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td>${transferRecord.fromId }</td>
							<td>${transferRecord.toId }&nbsp;(${transferRecord.memo })</td>
							<td>${transferRecord.totalPrice }</td>
						</tr>
					</c:forEach>
					</tbody>
			</table>

			<c:if test="${!empty pb.result}">
				<%@include file="/WEB-INF/views/zh/include/paging.jsp" %>
			</c:if>
			</div>
		</div>
  </div>
	  <div class="blank10"></div>
	<!--下一页-->
</div>

<script type="text/javascript">
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

function toGetList(){
	$("#SearchFrom").submit();
}

function clickSubmit(pagenum){
	$("#page").val(pagenum)
	toGetList();
}
</script>

 <div class="blank10"></div>
 <!-- 底部 start -->
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<!-- 底部 end -->

</body>
</html>