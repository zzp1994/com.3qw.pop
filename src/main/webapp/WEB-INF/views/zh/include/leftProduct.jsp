<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
   $(document).ready(function(){
		var url='${url}';
		if(url.indexOf("onSaleList")!=-1||url.indexOf("showProduct")!=-1||url.indexOf("editProductUI")!=-1){
			$("#product_onSale").attr("class","p2 c_cut2");
		}
		if(url.indexOf("productlist")!=-1||url.indexOf("showProduct")!=-1||url.indexOf("editProductUI")!=-1){
			$("#product_POPonSale").attr("class","p2 c_cut2");
		}
// 		if(url.indexOf("importlist")!=-1||url.indexOf("showProduct")!=-1||url.indexOf("editProductUI")!=-1){
// 			$("#product_POPImportonSale").attr("class","p2 c_cut2");
// 		}
		if(url.indexOf("category")!=-1||url.indexOf("addProductUI")!=-1){
			$("#product_addProduct").attr("class","p2 c_cut2");
		}
		if(url.indexOf("cateXfg")!=-1||url.indexOf("UIXf")!=-1){
			$("#product_addProduct2").attr("class","p2 c_cut2");
		}
		if(url.indexOf("/draft")!=-1||url.indexOf("/product/draftList")!=-1){
			$("#product_draft").attr("class","p2 c_cut2");
		}
		if(url.indexOf("/poporder/or")!=-1){
			$("#supplier_order").attr("class","p2 c_cut2");
		}
		if(url.indexOf("/toImport")!=-1){
			$("#purchase_price").attr("class","p2 c_cut2");
		}
		if(url.indexOf("repertory")!=-1){
			$("#inventory").attr("class","p2 c_cut2");
		}
		if(url.indexOf("soldOut")!=-1){
			$("#supplier_order").attr("class","p2 c_cut2");
		}
		if(url.indexOf("refund_list")!=-1){
			$("#supplier_order1").attr("class","p2 c_cut2");
		}
		if(url.indexOf("brand")!=-1){
			$("#supplier_brand").attr("class","p2 c_cut2");
		}
		if(url.indexOf("store")!=-1){
			$("#supplier_store").attr("class","p2 c_cut2");
		}
		if(url.indexOf("product/orderBalance")!=-1){
			$("#supplier_bal_order").attr("class","p2 c_cut2");
		}
	});
   
</script>
<div class="center">
		<!-- 左边 start -->
		<div class="left f_l">
			<div class="title">
				<p class="f_l"><img src="${path}/images/img_title_sm.png" alt=""></p>
				<p class="f_l p1">卖家中心</p>
				<p class="clear"></p>
			</div>
			<div class="blank5"></div>
			<div class="list_box">
				<div class="demo">
					<h2><p class="p1">
					   <c:if test="${!empty meunMap['商品管理']}" >
	                   <img src="${path}/images/img_t1.png"/>商品管理
					   </c:if>
					   </p></h2>
					<div class="p_b">
					   <%--<c:if test="${ !empty meunMap['货品列表']}" >
	                       <p class="p2" id="product_onSale"><a href="javascript:void(0)" onclick="getProduct()">货品列表</a></p>
					   </c:if>--%>
					   
					   <c:if test="${ supplier.activeStatus ne -1 && noPub ne 1}" >
						    <c:if test="${ !empty meunMap['发布商品']}" >
								<p class="p2" id="product_addProduct"><a href="javascript:void(0)" onclick="addProduct()">发布商品</a></p>
							</c:if>
						</c:if>
						<c:if test="${ supplier.activeStatus ne -1 && supplier.organizationType ne 5}" >
						    <c:if test="${ !empty meunMap['发布幸福购商品']}" >
								<p class="p2" id="product_addProduct2"><a href="javascript:void(0)" onclick="addXfProduct()">发布幸福购商品</a></p>
							</c:if>
						</c:if>
						
						<c:if test="${ !empty meunMap['货品列表']}" >
					    	<p class="p2" id="product_POPonSale"><a href="javascript:void(0)" onclick="getPOPProduct()">货品列表</a></p>
					    </c:if>
<!-- 					    <p class="p2" id="product_POPImportonSale"><a href="javascript:void(0)" onclick="getPOPImportProduct()">导入货品列表</a></p> -->
					 <%-- <c:if test="${ !empty meunMap['草稿箱']}" >
	                    	<p class="p2" id="product_draft"><a href="javascript:void(0)" onclick="getDrafts()">草稿箱</a></p>
	                 </c:if>--%>
						<%-- <c:if test="${ !empty meunMap['发布商品']}" >
							<p class="p2" id="product_addProduct"><a href="javascript:void(0)" onclick="addProduct()">发布商品</a></p>
						</c:if> --%>
	                 
						<c:if test="${ !empty meunMap['库存管理']}" >
							<p class="p2" id="inventory"><a href="javascript:void(0)" onclick="getInventory()">库存管理</a></p>
						</c:if>
						<c:if test="${ !empty meunMap['品牌管理']}" >
							<p class="p2" id="supplier_brand"><a href="javascript:void(0)" onclick="getBrand()">品牌管理</a></p>
						</c:if>
					</div>
				</div>
				<div class="demo">
					<c:if test="${ !empty meunMap['订单管理']}" >
					<h2><p class="p1">
	                      <img src="${path}/images/img_t2.png"/>订单管理
					   </p></h2>
					   </c:if>
					<div class="p_b">
					   <c:if test="${ !empty meunMap['已卖出的货品']}" >
	                   		<p class="p2" id="supplier_order"><a href="javascript:void(0)" onclick="getAllOrder()">已卖出的货品</a></p>
					   </c:if>

					   <c:if test="${ !empty meunMap['订单管理']}" >
					<div class="p_b">
	                   	<p class="p2" id="supplier_order"><a href="javascript:void(0)" onclick="goOrderListPage()">订单管理</a></p>
					</div>
					   </c:if>
					   <div class="p_b">
	                   		<p class="p2" id="supplier_bal_order"><a href="javascript:void(0)" onclick="goBalanceOrderListPage()">结算订单</a></p>
						</div>
						 <div class="p_b">
						<c:if test="${ !empty meunMap['退款订单']}" >
	                   		<p class="p2" id="supplier_order1"><a href="javascript:void(0)" onclick="getRefundOrder()">退款订单</a></p>
					   </c:if>
					   </div>
					</div>
				</div>
				<div class="demo">
					<c:if test="${ !empty meunMap['商品采购']}" >
						<h2><p class="p1">
		                      <img src="${path}/images/img_t2.png"/>商品采购
						   </p></h2>
					     </c:if>
					<div class="p_b">
						<c:if test="${ !empty meunMap['采购列表']}" >
						<p class="p2" id="purchase_price"><a href="javascript:void(0)" onclick="window.parent.location='${path}/product/toImport'">采购列表</a></p>
						</c:if>
					</div>
				</div>
				<div class="demo">
					<c:if test="${ !empty meunMap['店铺管理']}" >
						<h2><p class="p1">
	                      <img src="${path}/images/img_t2.png"/>店铺管理
					   </p></h2>
					   </c:if>
					<div class="p_b">
						<c:if test="${ !empty meunMap['模板管理']}" >
							<p class="p2" ><a href="javascript:void(0)" onclick="window.parent.location='${path}/store/modle/getManagementModle'">模板管理</a></p>
						</c:if>
						<c:if test="${ !empty meunMap['页面编辑']}" >
							<p class="p2" id="supplier_store" ><a href="javascript:void(0)" onclick="window.parent.location='${path}/store/initEdit'">页面编辑</a></p>
						</c:if>
					</div>
				</div>
				<div class="demo">
					<c:if test="${ !empty meunMap['企业转账记录']}" >
						<h2><p class="p1">
						  <img src="${path}/images/img_t2.png"/>企业转账记录
					   </p></h2>
				   </c:if>
					<div class="p_b">
						<c:if test="${ !empty meunMap['企业转账记录']}" >
							<p class="p2" ><a href="javascript:void(0)" onclick="window.parent.location='${path}/recording/virementRecording'">企业转账记录</a></p>
						</c:if>
						<c:if test="${ !empty meunMap['企业与企业个人转账']}" >
							<p class="p2" ><a href="javascript:void(0)" onclick="window.parent.location='${path}/company/virementSetting'">企业与企业个人转账</a></p>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<!-- 左边 end -->
