<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
<title>商家后台管理系统-库存管理</title>
<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/css/zh/kuc.css" />
<link rel="stylesheet" type="text/css" href="${path}/css/zh/stock.css" />
<link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%@include file="/WEB-INF/views/zh/include/header.jsp"%>
	<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp"%>
	<div class="c2">
		<div class="c21">
			<div class="title">
				<p>卖家中心&nbsp;&gt;&nbsp;</p>
				<p>商品管理&nbsp;&gt;&nbsp;</p>
				<p class="c1">库存管理</p>
			</div>
		</div>
		<div class="blank10"></div>

		<div class="c22">
			<div class="c21">
				<ul class="top">
					<li class="list" id="showAllList"><a href="javascript:void(0)"
						onclick="getInventoryListByLabel(1)">现货库存</a></li>
					<li id="showZeroList"><a href="javascript:void(0)"
						onclick="getInventoryListByLabel(0)">收集订单</a></li>
				</ul>
			</div>
			<div class="blank10"></div>
			<div class="xia">
				<form>
					<p class="p1">
						<!-- <strong>创建时间 ：</strong> 
							<input type="text" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'stopTime\',{d:-1});}'})"readonly="readonly" id="createTime"> 到
							<input type="text" onClick="WdatePicker({minDate:'#F{$dp.$D(\'createTime\',{d:1});}'})" readonly="readonly" id="stopTime"> -->

						<strong class="st">商品名称 ：</strong><input name="productName" type="text" id="productName">
					</p>

					<!-- <p class="p1" id="zeroCount">
						<strong>现货库存：</strong> <input type="text" id="sqty">
						到 <input id="eqtyNum" type="text" name="eqty">
						<strong class="st">最大见单生产量：</strong> <input type="text" id="sProductionQty">
						到 <input id="eProductionQty" type="text" name="eqty">
						
					</p>
 -->
					<p class="p4">
						<button type="button" id="toGetConList" onclick="clickSubmit()">搜索</button>
						<a href="#" id="czhi" onclick="resetfm()">重置</a>
					</p>
				</form>
			</div>
		</div>

		<div class="stock-wrap">
			<div class="stock" id="c24">
			</div>
		</div>
	</div>
	<div class="blank20"></div>

	<div class="blank10"></div>
	<!-- 底部 start -->

	<!--修改开始-->
	<div class="alert_shul1">
		<div class="bg"></div>
		<div class="wrap">
			<div class="box1">
				<p class="pic">
					<img src="${path}/images/close.jpg" class="b_colse" id="cancel">
				</p>
			</div>
			<div id="tipmsg"></div>
			<div class="box2">
		
				<form>
					<div class="o-y-auto">
						<table width="100%">
							<thead>
								<tr><th>订单占用数量</th><th>现货库存</th></tr>
							</thead>
							<tbody id="bachsingle">
								
							</tbody>
						</table>
					</div>
					<button type="button" class="bt1" onclick="fmToUp()">确定</button>
					<button type="button" class="bt2" id="cancel">取消</button>
				</form>

			</div>
		</div>
	</div>
	<!--修改结束-->
	</div>
	
	<script language="javascript" type="text/javascript" src="${path}/js/product/zh/repertory.js"></script>
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>
</body>
</html>