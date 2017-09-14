<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>商家后台管理系统-修改商品</title>
<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
<link rel="stylesheet" href="${path}/css/zh/shang.css">
<link href="${path}/css/uploadify.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="${path}/js/ueditor/third-party/webuploader/webuploader.css">
<link rel="stylesheet" type="text/css" href="${path}/css/webuploaderframe.css">

</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp"%>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp"%>
<div class="right f_l">
	<!-- 边框start -->
	<form method="post" 
		id="productAction" enctype="multipart/form-data">
		<input type="hidden" id="language" value="${language}">
		<input type="hidden" id="sessionId" value="${sid}"/>
		<input type="hidden" id="supplierType" value="${supplierType}" />
		<input type="hidden" id="productId" name="productId" value="${proObj.productId}">
		<c:forEach items="${proObj.supplierProductSkuDTOs}" var="skuHide" varStatus="skui">
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductSku.productSkuId" value="${skuHide. supplierProductSku.productSkuId}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductPriceMap.supplierprice" value="${skuHide.supplierProductPriceMap.supplierprice}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductPriceMap.prodPriceId" value="${skuHide.supplierProductPriceMap.prodPriceId}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductPriceMap.priceId" value="${skuHide.supplierProductPriceMap.priceId}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductSku.skuNameCn" value="${fn:escapeXml(skuHide. supplierProductSku.skuNameCn)}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductSku.skuNameEn" value="${fn:escapeXml(skuHide. supplierProductSku.skuNameEn)}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductSku.skuId" value="${fn:escapeXml(skuHide. supplierProductSku.skuId)}"/>
		</c:forEach>
		<div class="right f_l">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;>&nbsp;</p>
					<p>商品管理&nbsp;>&nbsp;</p>
					<p class="c1">修改商品</p>
					<div class="clear"></div>
				</div>
			</div>
			<div class="blank10"></div>

			<!-- 边框start -->
			<div class="border">
				<div class="blank"></div>
				<div class="cont">
					<!-- 填写基本信息  -->
					<div class="i_box">
						<h2>填写基本信息</h2>
						<div class="app">
						<span>你当前所在的类目是：</span>
						<c:forEach items="${cateNames}"  var="cateName" varStatus="var">
							<span>${fn:escapeXml(cateName.pubNameCn)}</span>
						<c:if test="${!var.last}">
							<span>&gt;</span>
						</c:if>
						</c:forEach>
						</div>
						<div class="blank15"></div>
						<div class="p_box">
							<p class="p1">
								<i class="c_red">*</i> 商品标题：
							</p>
							<p class="p2">


								<input type="text" required="required" id="productinfo"
									value="${fn:escapeXml(proObj.supplierProductBase.productname)}"> 
							</p>
							<div class="blank10"></div>
						<div class="jinben">
							<div class="chanp">
								<p>产品规格:</p>
							</div>
							
							<div class="p3">
							<!-- 规格属性 -->
							<c:forEach items="${proObj.supplierProductAttrDTOs }" var="attr" varStatus="saleVs">
								<c:if test="${attr.supplierProductAttr.buyAttr == 1}">
									<!-- 购买属性 -->
									<div class="yanse">
										<div class="yanse1" title="${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}">
											<span>*</span>${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}
											： 
											<input type="hidden" name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrId"  value="${attr.supplierProductAttr.attrId}">
											<input type="hidden" name="buyIndex" value="${saleVs.index}">
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrNameCn"
												value="${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}" id="${saleVs.index}">
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.type"
												value="${attr.supplierProductAttr.type}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.style"
												value="${attr.supplierProductAttr.style}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.isneed"
												value="${attr.supplierProductAttr.isneed}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.buyAttr"
												value="${attr.supplierProductAttr.buyAttr}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.saleAttr"
												value="${attr.supplierProductAttr.saleAttr}">
										</div>
										<div class="yanse2">
											<p>
												<c:forEach items="${attr.supplierProductAttrvals}" var="av" varStatus="vars">
													<span title="${fn:escapeXml(av.lineAttrvalNameCn)}">
													<input type="hidden"
														name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].attrValId"
														value="${av.attrValId}" >
														
														<c:choose>
															<c:when test="${proObj.isUpdateSku }">
																<input type="checkbox"
																	name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].lineAttrvalNameCn"
																	value="${fn:escapeXml(av.lineAttrvalNameCn)}" 
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	id="${vars.index}">
															</c:when>
															<c:otherwise>
																<input type="checkbox" disabled="disabled"
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	value="${fn:escapeXml(av.lineAttrvalNameCn)}" 
																	id="${vars.index}">	
																	<c:if test="${av.isProdAttr}">
																		<input type="hidden" name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].lineAttrvalNameCn" value="${fn:escapeXml(av.lineAttrvalNameCn)}" >														
																	</c:if>
															</c:otherwise>
														
														</c:choose>
														${av.lineAttrvalNameCn}
													</span>
												</c:forEach>
											</p>
												<span class="dpl-tip-inline-warning" style="display: none">请至少选择一项</span>
										</div>
									</div>
									<br>
								</c:if>

								<c:if test="${attr.supplierProductAttr.saleAttr==1}">
									<!-- 规格属性 -->
									<div class="chim">
										<div class="chim1" title="${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}">
											<span>*</span> ${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}
											： 
											<input
												type="hidden" name="saleIndex" value="${saleVs.index}">
												<input type="hidden" name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrId"  value="${attr.supplierProductAttr.attrId}">
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrNameCn"
												value="${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}" id="${saleVs.index}">
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.type"
												value="${attr.supplierProductAttr.type}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.style"
												value="${attr.supplierProductAttr.style}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.isneed"
												value="${attr.supplierProductAttr.isneed}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.buyAttr"
												value="${attr.supplierProductAttr.buyAttr}"> 
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.saleAttr"
												value="${attr.supplierProductAttr.saleAttr}">
										</div>
										<div class="chim2">
											<p>
												<c:forEach items="${attr.supplierProductAttrvals}" var="av" varStatus="vs">
													<span title="${fn:escapeXml(av.lineAttrvalNameCn)}">
													<input type="hidden"
														name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].attrValId"
														value="${av.attrValId}" >
														
														<c:choose>
															<c:when test="${proObj.isUpdateSku }">
																<input type="checkbox"
																	name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].lineAttrvalNameCn"
																	value="${fn:escapeXml(av.lineAttrvalNameCn)}" 
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	id="${vs.index}">
																
															</c:when>
															<c:otherwise>
																<input type="checkbox" disabled="disabled"
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	value="${fn:escapeXml(av.lineAttrvalNameCn)}" 
																	id="${vs.index}">	
																<c:if test="${av.isProdAttr}">			
																	<input type="hidden" name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].lineAttrvalNameCn" value="${fn:escapeXml(av.lineAttrvalNameCn)}" >
																</c:if>											
															</c:otherwise>
														
														</c:choose>
														${fn:escapeXml(av.lineAttrvalNameCn)}
														</span>
												</c:forEach>
											</p>
												<span class="dpl-tip-inline-warning" style="display: none">请至少选择一项</span>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<!-- 规格属性 -->
							
							
							
							</div>
							
							
						</div>
					</div>
					<div class="blank"></div>
					<!-- 填写基本信息  -->
					<div class="i_box">
						<h2>产品销售信息</h2>
						<div class="blank5"></div>
						<div class="p_box">
							<div class="blank20"></div>
							<p class="p1">交易信息：</p>
							<div class="p3" style="min-height:300px">
									<p class="blank5"></p>
									<p class="t1">
										<i class="c_red">*</i>报价：
										</p>
										<div class="select-quote">
										<input type="radio" name="cost"   id="pic_count" class="cp1" value="1"/>
										<strong>按产品数量报价</strong>
										<input type="radio" name="cost" id="pic_sku" value="2" class="cp2" />
										<strong>按产品规格报价</strong>
									</div>
								<div class="tqz">

									<div class="tq2">
										<span class="b1"><b></b></span>
										<p class="pp">								
										   <span class="b2">起批量：<input type="text" name='start' id="startNum"><span class="danwei">${fn:escapeXml(measure[0])}</span>及以上 
											<input type="text" name='pic'><span class="price">${fn:escapeXml(measure[0])}</span>/<span class="danwei">${fn:escapeXml(moneyUnit[0])} </span>
											</span>
										</p>
											<span class="dpl-tip-inline-warning" id="inputwarning">
										</span>
										
										<span class="b3">
											<img src="../images/img_+bg.jpg"> 增加数量区间
										</span>
									</div>
									
									<div class="g">
										<p class="blank"></p>
										<div class="blank10"></div>
										<div class="tab_box">
											最小起订量：<input type='text' id="minNum" name='minNum' value="${proObj.supplierProductSaleSetting.minWholesaleQty }">
											<table id="tb-speca-quotation" border="0" cellpadding="0"
												cellspacing="0">
												<colgroup>
													<col class="color">
													<col class="size">
													<col class="price">
													<col class="operate">
												</colgroup>
												<thead>
													<tr>
														<th>
															${fn:escapeXml(buyAttrName[0])}
														</th>
														<th>
															${fn:escapeXml(saleAttrName[0])}
														</th>
														<th>
															<span class="c_red"> 
															*
															</span>单价<br/> 
															<input id="same_price" type="checkbox">全部相同</th>
													</tr>
												</thead>
												
												<tbody>
												</tbody>

											</table>

										</div>
										<span class="dpl-tip-inline-warning"></span>
										<!-- 表格 end -->

										<p class="blank15"></p>
									</div>
																		</div>
									
									<p class="blank10"></p>

							
					
						<p class="blank15"></p>
							</div>

						</div>


						<!-- 填写基本信息  -->

						<div class="blank30"></div>
					</div>
					<!-- 内容 end -->
				</div>
				<!-- 边框 end -->
				<div class="blank10"></div>
				<div class="btn_box">
					<button type="button" id="editPrice" class="fabu_btn" >修改商品</button>

<!-- 					<input  type="submit" id="previewProd" class="fabu_btn" >预览商品</button> -->
					<p class="clear"></p>
				</div>
			</div>
			<div class="clear"></div>
			<p class="blank30"></p>
		</div>
	</form>
</div>
</div>
</div>
<div class="clear"></div>
<div class="blank10"></div>
<!-- 底部 start -->
<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
</body>
</html>
<script type="text/javascript" src="${path}/js/product/zh/editPrice.js"></script>

<!--引入JS-->

<script type="text/javascript">


	$(document).ready(function(){
		
		
		
		var sku_array= ${skuPriceAndCount};
		var measure = "${measure[0]}";
		var price = "${moneyUnit[0]}";
 	 	$.each(sku_array,function(keys,values){
 	 	
 	 			var statu = values.type;
 	 			   if(statu=='0'){
 	 			  
 	 			   changebox();
 	 			  $("#pic_count").attr("checked","checked");
 	 			  $('.pp').empty();
 	 			  $.each(values.start,function(key,value){
 	 			  
 	 			  	var startLength = values.start.length;
 	 			  	if(key==startLength-1&&key!=0){
 	 					$('.pp').append( "<span class='b2'>起批量：<input type='text' name='start' value='"+value+"'><span class='danwei'>"+measure+"</span>及以上 <input name='pic' type='text'  value='"+values.pic[key]+"'><span class='price'>"+price+"</span>/<span class='danwei'>"+measure+"</span><span class='del'>删除</span></span>" );
 	 			 	}else{
 	 			 		$('.pp').append( "<span class='b2'>起批量：<input type='text' name='start' value='"+value+"'><span class='danwei'>"+measure+"</span>及以上 <input name='pic' type='text'  value='"+values.pic[key]+"'><span class='price'>"+price+"</span>/<span class='danwei'>"+measure+"</span></span>" );
 	 			 	}
 	 			 	var length = $(".pp .b2").length;
						if (length>=3){
							$(".b3").hide();
						}
						
						$(".g").hide();
				
 	 			  });
 
 	 				}else{
 	 			 	var pku = values.pic;
 	 			 	
 	 			 	$("#pic_sku").attr("checked","checked");
 	 			 	$(".g").show();
 	 			 	$(".tq2").hide();
 	 				var pku_array = new Array();
 	 				$.each(pku,function(key,value){
 	 					pku_array.push(value);
 	 					var new_array = new Array();
 	 					new_array.push(pku_array);
 	 					changebox();
 	 					_fShowTableInfo(pku,"tb-speca-quotation"); 
 	 				});
 	 			 }; 
 	 		});
 	 		
 	 		
		});  
	
</script>
 </body>
</html>