<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Supplier-Posted Products</title>
<%@include file="/WEB-INF/views/en/include/base.jsp"%>
<link rel="stylesheet" type="text/css" href="${path}/css/en/chus.css" />
<script type="text/javascript" src="${path}/js/product/en/onSale.js"></script>
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
</head>
<body>
<%@include file="/WEB-INF/views/en/include/header.jsp" %>
<%@include file="/WEB-INF/views/en/include/leftProduct.jsp" %>
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
				<p>Seller Center&nbsp;>&nbsp; </p>
				<p>Product&nbsp;>&nbsp; </p>
				<p class="c1">Product List</p>
			</div>
			</div>
			<div class="blank10"></div>
			
			<div class="c22">
 			<div class="c3" id="cp3">
 				<ul class="top">
					<li class="list" id="li_chushou"><a href="javascript:void(0)" onclick="getDownProduct(1)" id='1'>For Sale</a></li>
					<li class="" id="li_shenhe"><a href="javascript:void(0)"      onclick="getDownProduct(2)" id='2'>To be Approved</a></li>
					<li class="" id="li_meishenhe"><a href="javascript:void(0)"   onclick="getDownProduct(3)" id='3'>Rejected</a></li>
					<li class="" id="li_xiajia"><a href="javascript:void(0)"      onclick="getDownProduct(4)" id='4'>Off Shelf</a></li>
				</ul>
			<div class="xia">
			<form>
					<p class="p1">
					  <strong>Product Name ：</strong> <input type="text" class="text1" id="findProductName">
					   <strong class="st">Prodcut ID ：</strong> <input type="text" class="text1" id="selectProdId">
					 <c:if test="${not empty subSuppliers }">
						  <strong style="margin-left:8px;">Sub-Supplier ：</strong>
						 <select id="subSupplier" >
							 <option value="">please select</option>
						 	<c:forEach items="${subSuppliers}" var="subSupplier">
						 		<option value="${subSupplier.supplierId}">${subSupplier.name}</option>
						 	</c:forEach>
						 </select> 
					   </c:if>
					</p>
					<p class="p5">
						
					   
					 <c:if test="${not empty brands }">
						   <strong class="sv">Brand ：</strong>
						 <select id="brands" >
							 <option value="">please select</option>
						 	<c:forEach items="${brands}" var="brand">
						 		<option value="${brand.systemBrandId }">${brand.name}</option>
						 	</c:forEach>
						 </select> 
						 <span id="reloadspan">
						  <select id="subBrand" >
						 </select> 
						 </span>
					   </c:if>
					</p>
				
					<p class="p1">
					 <strong>Product Category ：
					 <select id="firstcategory" ><option value="">please select</option></select> 
					 <select id="secondcategory"></select>
					  <select id="thirdcategory"></select>
					   <select id="fourthcategory"></select>
					 </strong>
					</p>
					<p class="p3">
						<button type="button" onclick="clickSubmit()">Search</button>
						<a href="#" id="czhi" onclick="resetfm()">Reset</a>
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
	<%@include file="/WEB-INF/views/en/include/last.jsp"%>
	<!-- 底部 end -->
<div class="lightbox" id="goout-box">
	<div class="lightbox-overlay"></div>
	<div class="lightbox-box">
		<div class="close-box" onclick="close_editinv_box()"></div>
		<div class="lightbox-box-hd">
			<h2>Please fill in the reason</h2>
		</div>
		<div class="lightbox-box-bd">
			<form id="alertProductStopReason">
				<select id="stopReasonType">
					<option value="缺货">stockout</option>
					<option value="滞销">unmarketable</option>
					<option value="汰换">nventory in transit</option>
					<option value="更新商品信息">Update the product information</option>
					<option value="其他">Other</option>
				</select>
				<div class="clear"></div>
				<textarea rows="3" cols="20" class="goout-text" name="stopReason" id="stopReason"></textarea>
				<input type="hidden" value="" id="alertProductStopReasonId" name="pid">
			</form>
		</div>
		<div class="lightbox-box-bar">
			<a href="javascript:void(0);" class="lightbox-btn true-btn" onclick="proDown()">Submit</a>
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
</body>
</html>