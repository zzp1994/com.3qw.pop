<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
   $(document).ready(function(){
		var url='${url}';
		if(url.indexOf("onSaleList")!=-1||url.indexOf("showProduct")!=-1||url.indexOf("editProductUI")!=-1){
			$("#product_onSale").attr("class","p2 c_cut2");
		}
		if(url.indexOf("/draft")!=-1||url.indexOf("/product/draftList")!=-1){
			$("#product_draft").attr("class","p2 c_cut2");
		}
		if(url.indexOf("category")!=-1||url.indexOf("addProductUI")!=-1){
			$("#product_addProduct").attr("class","p2 c_cut2");
		}
		if(url.indexOf("repertory")!=-1){
			$("#inventory").attr("class","p2 c_cut2");
		}
		if(url.indexOf("soldOut")!=-1){
			$("#supplier_order").attr("class","p2 c_cut2");
		}
		
		if(url.indexOf("brand")!=-1){
			$("#supplier_brand").attr("class","p2 c_cut2");
		}
	});
   
</script>
<div class="center">
		<!-- 左边 start -->
		<div class="left f_l">
			<div class="title">
				<p class="f_l"><img src="${path}/images/img_title.png" alt=""></p>
				<p class="f_l p1">Seller Center</p>
				<p class="clear"></p>
			</div>
			<div class="blank5"></div>
			<div class="list_box">
				<div class="demo">
					<h2><p class="p1">
					   <c:if test="${!empty meunMap['商品管理']}" >
	                   <img src="${path}/images/img_t1.png"/>Products
					   </c:if>
					   </p></h2>
					<div class="p_b">
					   <c:if test="${ !empty meunMap['货品列表']}" >
	                       <p class="p2" id="product_onSale"><a href="javascript:void(0)" onclick="getProduct()"> Posted Products</a></p>
					   </c:if>
					     <c:if test="${ !empty meunMap['草稿箱']}" >
	                    	<p class="p2" id="product_draft"><a href="javascript:void(0)" onclick="getDrafts()">Drafts</a></p>
	                 </c:if>
					  <c:if test="${ !empty meunMap['发布商品']}" >
	                    	<p class="p2" id="product_addProduct"><a href="javascript:void(0)" onclick="addProduct()">Post Products</a></p>
	                 </c:if>
					   <c:if test="${ !empty meunMap['库存管理']}" >
	                   <p class="p2" id="inventory"><a href="javascript:void(0)" onclick="getInventory()">Inventory</a></p>
					   </c:if>
					    <c:if test="${ !empty meunMap['品牌管理']}" >
	                   <p class="p2" id="supplier_brand"><a href="javascript:void(0)" onclick="getBrand()">Brand</a></p>
					   </c:if>
					</div>
				</div>
				<div class="demo">
					<h2><p class="p1">
					   <c:if test="${ !empty meunMap['订单管理']}" >
	                      <img src="${path}/images/img_t2.png"/>Orders
					   </c:if>
					   </p></h2>
					<div class="p_b">
					   <c:if test="${ !empty meunMap['已卖出的货品']}" >
	                   	<p class="p2" id="supplier_order"><a href="javascript:void(0)" onclick="getAllOrder()">Sold Products</a></p>
					   </c:if>
					
		
					</div>
				</div>
			</div>
		</div>
		<!-- 左边 end -->
