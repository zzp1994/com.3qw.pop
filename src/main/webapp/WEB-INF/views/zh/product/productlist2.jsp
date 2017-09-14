<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" >
	<title>商家后台管理系统-商品列表</title>
	<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
    <link rel="stylesheet" type="text/css" href="${path }/css/product.css"/>
    <link rel="stylesheet" type="text/css" href="${path }/css/product/reset.css"/>
    <link rel="stylesheet" type="text/css" href="${path }/css/product/reset2.css"/>
    <script type="text/javascript" src="${path }/js/product_list_fn2.js"></script>
</head>
<body>
	
	<!-- 导航 start -->
	<%@include file="/WEB-INF/views/zh/include/header.jsp"%>
	<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp" %>

	<!-- 导航 end -->
	<input type="hidden" name="dpro" id="dpro" value="${dpro}">
	<input type="hidden" name="page" id="page" value="${page}">

		<div class="c2">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;&gt;&nbsp;</p>
					<p>商品管理&nbsp;&gt;&nbsp;</p>
					<p class="c1">商品列表</p>
				</div>
			</div>
			<div class="blank10"></div>

			<div class="c22">
				<div class="c3" id="cp3">
					<ul class="top goods-tab">
					<li class="list" id="li_POP_sheng"><a href="javascript:void(0)" onclick="getDownProduct(2)"  liststatus='2'>审核列表</a></li>
					<li class="list" id="li_POP_tong"><a href="javascript:void(0)" onclick="getDownProduct(1)"  liststatus='1'>商品列表</a></li>
					
					</ul>
					<div class="xia">
						<form action="javascript:void(0)">
						 	<p class="p1">
								<span>商品名称 ：</span> 
								<input type="text" class="text1" id="b2cProductName">
								<span>商品ID ：</span>
								<input type="text" class="text1" id="productId">
								<span>&nbsp;&nbsp;条形码 ：</span> 
								<input type="text" class="text1" id="barCode">
								</p>
								<p class="p1"> 
									<span>商品类目 ： </span>
									<select id="firstcategory"><option value="">请选择</option></select>
									<select id="secondcategory"></select> 
									<select id="thirdcategory"></select> 
									<select id="fourthcategory"></select>
							</p>
							
							<p class="p1" id="productIsTate">
								<span>&nbsp;&nbsp;&nbsp;&nbsp;状态 ：</span>
								<select id="popIsTate">
									<option value="-1">请选择</option>
									<option value="1">已上架的商品</option>
									<option value="0">已下架的商品</option>
								</select>
							</p>
							<p class="p1" id="shengheIsTate">
								<span>&nbsp;&nbsp;&nbsp;&nbsp;审核状态 ：</span>
								<select id="popshengIsTate">
									<option value="-1">请选择</option>
									<option value="0">待审核</option>
									<option value="1">审核不通过</option>
									<option value="5">审核驳回</option>
								</select>
							</p>
							<p class="p3">
								<span style="color: red;">已达到发布上限，不能再发布商品,如有疑问请联系后台</span>
								<button type="submit" id="subfm" onclick="clickSubmit()">搜索</button>
								<a href="#" id="czhi" onclick="resetfm()">重置</a>
							</p>
						</form>
					</div>


					<div class="blank5"></div>
					<a href="javascript:void(0)" onclick="downProductListExcel()"> 
									<span class="button red" id="exportExcelDiv"> 
										<span class="text">
											<img alt="" src="${path }/images/down-icon.png" height="19px" width="19px">导出表格
										</span>
									</span>
								</a>

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
		
<div class="lightbox" id="goout-box">
	<div class="lightbox-overlay"></div>
	<div class="lightbox-box">
		<div class="close-box" onclick="close_editinv_box()"></div>
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
				<textarea rows="3" cols="20" class="goout-text" name="stopReason" id="stopReason" ></textarea>
				<input type="hidden" value="" id="alertProductStopReasonId" name="pid">
			</form>
		</div>
		<div class="lightbox-box-bar">
			<a href="javascript:void(0);" class="lightbox-btn true-btn" onclick="proDown()">提 交</a>
			<span style="margin-left: 20px;color: red;" id="boxwarn"></span>
		</div>
	</div>
</div>

<div class="lightbox" id="del-box">
	<div class="lightbox-overlay"></div>
	<div class="lightbox-box">
		<div class="close-box" onclick="close_editinv_box()"></div>
		<div class="lightbox-box-hd">
			<h2>请填写删除原因</h2>
		</div>
		<div class="lightbox-box-bd">
			<form id="alertProductStopReason">
				<textarea rows="3" cols="20" class="goout-text" name="delReason" id="delReason" ></textarea>
				<input type="hidden" value="" id="alertProductdelReasonId" name="pid">
			</form>
		</div>
		<div class="lightbox-box-bar">
			<a href="javascript:void(0);" class="lightbox-btn true-btn" onclick="del_product()">提 交</a>
			<span style="margin-left: 20px;color: red;" id="boxwarn"></span>
		</div>
	</div>
</div>
		
<div class="lightbox" id="copyData" style="display:none">
	<div class="lightbox-overlay"></div>
	<div class="lightbox-box">
		
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