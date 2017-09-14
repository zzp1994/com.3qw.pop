<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>商家后台管理系统-支付列表列表</title>
<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/css/zh/chus.css" />
</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp" %>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>
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

	<div class="c2">
			<div class="c21">
			<div class="title">
				<p>卖家中心&nbsp;>&nbsp; </p>
				<p>商品管理&nbsp;>&nbsp; </p>
				<p class="c1">货品列表</p>
			</div>
			</div>
			<div class="blank10"></div>
			
			<div class="c22">
 			<div class="c3" id="cp3">
 				<ul class="top">
					<li class="list" id="li_chushou"><a href="javascript:void(0)" onclick="getDownProduct(1)" id='1'>出售中的货品</a></li>
					<li class="" id="li_shenhe"><a href="javascript:void(0)"      onclick="getDownProduct(2)" id='2'>待审核的货品</a></li>
					<li class="" id="li_meishenhe"><a href="javascript:void(0)"   onclick="getDownProduct(3)" id='3'>审核未通过的货品</a></li>
					<li class="" id="li_xiajia"><a href="javascript:void(0)"      onclick="getDownProduct(4)" id='4'>下架的货品</a></li>
				</ul>
			<div class="xia">
				<form>
					<p class="p1">
					  <strong>商品名称 ：</strong> <input type="text" class="text1" id="findProductName">
					   <strong class="st">商品ID ：</strong> <input type="text" class="text1" id="selectProdId">
					   <c:if test="${not empty subSuppliers }">
						   <strong class="st">子供应商 ：</strong>
						 <select id="subSupplier">
							 <option value="">请选择</option>
						 	<c:forEach items="${subSuppliers}" var="subSupplier">  
						 		<option value="${subSupplier.supplierId }">${subSupplier.name}</option>
						 	</c:forEach>
						 </select> 
					   </c:if>
					</p>
					<p class="p5">
						
					   <c:if test="${not empty brands }">
						  <strong class="sv">品牌 ：</strong>
						 <select id="brands" >
							 <option value="">请选择</option>
						 	<c:forEach items="${brands}" var="brand">
						 		<option value="${brand.systemBrandId }">${brand.name}</option>
						 	</c:forEach>
						 </select>
						  
						 <span id="reloadspan">
							 <select id="subBrand">
							 </select>
						 </span> 
					   </c:if>
					     
					</p>
					<p class="p1">
					
					 <strong>商品类目 ：
					 <select id="firstcategory" ><option value="">请选择</option></select> 
					 <select id="secondcategory"></select>
					  <select id="thirdcategory"></select>
					   <select id="fourthcategory"></select>
					 </strong>
					</p>
					<p class="p3">
						<button type="button" onclick="clickSubmit()">搜索</button>
						<a href="#" id="czhi" onclick="resetfm()">重置</a>
					</p>
				</form>	
			</div>
			
				
				
			<div class="blank5"></div>
					
			<div class="c3"  id="c3">
	
	            	
			</div>
			</div>
	  		</div>
	</div>
	</div>
	
  <div class="blank10"></div>
 <!-- 底部 start -->
	<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
	<!-- 底部 end -->
	
	<div class="lightbox" id="goout-box">
	<div class="lightbox-overlay"></div>
	<div class="lightbox-box" onclick="close_editinv_box()">
		<div class="close-box"></div>
		<div class="lightbox-box-hd">
			<h2>请填写下架原因</h2>
		</div>
		<div class="lightbox-box-bd">
			<form id="alertProductStopReason">
			<select id="stopReasonType">
					<option value="缺货">缺货</option>
					<option value="滞销">滞销</option>
					<option value="汰换">汰换</option>
					<option value="更新商品信息">更新商品信息</option>
					<option value="其他">其他</option>
				</select>
				<div class="clear"></div>
				<textarea rows="3" cols="20" class="goout-text" name="stopReason" id="stopReason"></textarea>
				<input type="hidden" value="" id="alertProductStopReasonId" name="pid">
			</form>
		</div>
		<div class="lightbox-box-bar">
			<a href="javascript:void(0);" class="lightbox-btn true-btn" onclick="proDown()">提 交</a>
			<span style="margin-left: 20px;color: red;" id="boxwarn"></span>
		</div>
	</div>
</div>
<div class="lightbox" id="inv-edit-box">
	<div class="lightbox-overlay"></div>
	<div class="lightbox-box">
		<div class="close-box" onclick="close_editinv_box()"></div>
		<div class="lightbox-box-hd">
			<h2>修改库存</h2>
		</div>
		<div class="lightbox-box-bd">
			<form id="edit_inv_qty">
				<%--<table id="showBach">
					<tr>
						<th>规格</th>
						<th>订单占用数量</th>
						<th>锁定数量</th>
						<th>库存数量</th>
					</tr>
					<tr>
						<td id="editNotBatchOrderOccupiedNum"></td>
						<td id="editNotBatchOrderOccupiedNum"></td>
						<td id="editNotBatchLockQty"></td>
						<td><input type="text" id="editNotBatchQty" class="frame"></td>
					</tr>
				</table>--%>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript" src="${path}/js/product/zh/onSale.js"></script>
<script type="text/javascript">

	$(document).ready(function() {

		$(".alert_user3").hide();
		$(".sr").click(function() {
			$(".alert_user3").show();
		});
		$(".w_close").click(function() {
			$(".alert_user3").hide();
		})
	});
	function showmsg(msg) {
		$("#showmsgplat").html(msg);
		$(".alert_user3").show();
	}
</script>
</body>
</html>
