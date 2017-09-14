<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Supplier-Inventory</title>
	<%@include file="/WEB-INF/views/en/include/base.jsp" %>

	
   <link rel="stylesheet" type="text/css" href="${path}/css/en/kuc.css" />
   <link rel="stylesheet" type="text/css" href="${path}/css/en/stock.css" />
   <link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%@include file="/WEB-INF/views/en/include/header.jsp" %>
<%@include file="/WEB-INF/views/en/include/leftProduct.jsp" %>


	<div class="c2">
		<div class="c21">
			<div class="title">
				<p>Seller Central&nbsp;&gt;&nbsp;</p>
				<p>Products&nbsp;&gt;&nbsp;</p>
				<p class="c1">Inventory</p>
			</div>
		</div>
		<div class="blank10"></div>

		<div class="c22">
			<div class="c21">
				<ul class="top">
					<li class="list" id="showAllList"><a href="javascript:void(0)"
						onclick="getInventoryListByLabel(1)">Item In Stock</a></li>
					<li id="showZeroList"><a href="javascript:void(0)"
						onclick="getInventoryListByLabel(0)">Collection</a></li>
				</ul>
			</div>
			<div class="blank10"></div>
			<div class="xia">
			
			
				<form>
					<p class="p1">
					
						<strong class="st">Product Name ：</strong><input name="productName"
							type="text" id="productName">
					</p>


					<p class="p4">
						<button type="button" id="toGetConList" onclick="clickSubmit()">Search</button>
						<a href="#" id="czhi" onclick="resetfm()">Reset</a>
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

	<!--创建状态一开始-->
	<div class="alert_user">
		<div class="bg"></div>
		<div class="wrap">
			<div class="box1">
				<p class="pic">
					<img src="${path}/images/close.jpg" class="b_colse" id="cancel">
				</p>
			</div>

			<div class="box2">
				<form>
					<p class="pc">
						<span>Batch Number：</span><input type="text" id="batchNum"
							name="batchNum"><br> <span>Stock Amount：</span><input
							type="text" id="amount" name="amount"> <span>Production
							Date：</span><input type="text" readonly="readonly" id="startTime"
							name="startTime" onClick="WdatePicker()"> <span>Valid
							Date：</span><input type="text" readonly="readonly" id="endTime"
							name="endTime" onClick="WdatePicker()"> <input
							type="hidden" id="skuId" name="skuId" value=""> <input
							type="hidden" id="sheilLife" name="sheilLife" value=""> <input
							type="hidden" id="pid" name="pid" value="">
					</p>
					<button class="bt1" type="button" id="fmc">confim</button>
					<button class="bt2" type="button" id="cancel">cancel</button>
				</form>
			</div>

		</div>
	</div>
	<!--创建状态一结束-->

	<!--修改状态一开始-->
	<div class="alert_shul">
		<div class="bg"></div>
		<div class="wrap">
			<div class="box1">
				<p class="pic">
					<img src="${path}/images/close.jpg" class="b_colse" id="cancel">
				</p>
			</div>
			<div class="box2">

				<form>
					<div class="o-y-auto">
						<table id="showBach">

						</table>
					</div>
					<button class="bt1" type="button" id="upBach1">confirm</button>
					<button class="bt2" type="button" id="closeboxformviewacount">cancel</button>
				</form>

			</div>
		</div>
	</div>
	<!--修改状态一结束-->



	<!--修改开始-->
	<div class="alert_shul1">
		<div class="bg"></div>
		<div class="wrap">
			<div class="box1">
				<p class="pic">
					<img src="${path}/images/close.jpg" class="b_colse" id="cancel">
				</p>
			</div>
			<div class="box2">

				<form>
					<div class="o-y-auto">
						<table>
							<thead>
								<tr><th>Order Reserved</th><th>Item In Stock</th></tr>
							</thead>
							<tbody id="bachsingle">
								
							</tbody>
						</table>
					</div>
					<button type="button" class="bt1" onclick="fmToUp()">confirm</button>
					<button type="button" class="bt2" id="cancel">cancel</button>
				</form>

			</div>
		</div>
	</div>
	<!--修改结束-->
	</div>
	
	<script language="javascript" type="text/javascript" src="${path}/js/product/en/repertory.js"></script>
	<%@include file="/WEB-INF/views/en/include/last.jsp"%>
	<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>
</body>
</html>