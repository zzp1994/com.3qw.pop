<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>商家后台管理系统-查看商品</title>
<%@include file="/WEB-INF/views/zh/include/base.jsp"%>
<link rel="stylesheet" href="${path}/css/zh/shang.css">
<link href="${path}/css/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${path}/js/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/queue.js"></script>

<script type="text/javascript"
	src="${path}/js/product/swfUploadEventHandler.js"></script>
<script type="text/javascript" src="${path}/js/product/zh/viewProduct.js"></script>

</head>
<body>
<%@include file="/WEB-INF/views/zh/include/header.jsp"%>
<%@include file="/WEB-INF/views/zh/include/leftProduct.jsp"%>
<div class="right f_l">
	<!-- 边框start -->
		<div class="right f_l">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;>&nbsp;</p>
					<p>商品管理&nbsp;>&nbsp;</p>
					<p class="c1">查看商品</p>
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


								<input type="text"  name="pname" id="productinfo" readonly="readonly"
									value="${fn:escapeXml(proObj.supplierProductBase.productname)}"> 
							</p>
							<div class="blank10"></div>
							<p class="p1">产品属性：</p>
							<div class="p3">
								<div class="bb">
									<p class="blank10"></p>
									<!-- 基本属性属性值 -->
									 <p class="p1">
								      <i class="c_red">*</i> 主品牌：
							       </p>
							       <p class="t2">
								       <input type="text" value="${fn:escapeXml(proObj.brand.nameCn)}" readonly="readonly">
									</p>
									<p class="blank10"></p>
									<c:if test="${!empty proObj.subBrand.nameCn}">
										<p class="p1">
										      <i class="c_red">*</i> 子品牌：
									    </p>
								        <p class="t2">
								           <input type="text" value="${fn:escapeXml(proObj.subBrand.nameCn)}" readonly="readonly">
										</p>
									</c:if>
									<p class="blank10"></p>
									<c:forEach items="${proObj.supplierProductAttrDTOs}" var="supplierProductAttr" varStatus="vs">
										<c:if test="${supplierProductAttr.supplierProductAttr.saleAttr != 1 && supplierProductAttr.supplierProductAttr.buyAttr != 1 }">
											<p class="p1" title="${fn:escapeXml(supplierProductAttr.supplierProductAttr.attrNameCn)}">
												<%-- <c:if test="${supplierProductAttr.supplierProductAttr.isneed == 1}">
													<i class="c_red">*</i>
												</c:if> --%>
												
												${fn:escapeXml(supplierProductAttr.supplierProductAttr.attrNameCn)}：
											</p>
													<c:if test="${supplierProductAttr.supplierProductAttr.type == 1}">
															<p class="i_radio f_l">
																<c:forEach items="${supplierProductAttr.supplierProductAttrvals}"
																	var="proAttrVal" varStatus="cbs">
																		<span class="r2" title="${fn:escapeXml(proAttrVal.lineAttrvalNameCn)}"><input type="checkbox" disabled="disabled"
																			name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[${cbs.index}].lineAttrvalNameCn"
																			<c:if test="${proAttrVal.isProdAttr}">checked</c:if>/>
																		${fn:escapeXml(proAttrVal.lineAttrvalNameCn)}</span>
																</c:forEach>
															</p>
													</c:if>
													
													<c:if test="${supplierProductAttr.supplierProductAttr.type ==2}">
														<p class="s_1">
															<select name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn" disabled="disabled">
																<c:forEach items="${supplierProductAttr.supplierProductAttrvals}" var="supplierProductAttrval">
																	<option value="${fn:escapeXml(supplierProductAttrval.lineAttrvalNameCn)}"
																		<c:if test="${supplierProductAttrval.isProdAttr}">selected</c:if>>
																		${fn:escapeXml(supplierProductAttrval.lineAttrvalNameCn)} 
																	</option>
																</c:forEach>
															</select>
														</p> 
													</c:if>
													
													<c:if test="${supplierProductAttr.supplierProductAttr.type == 3}">
															<p class="t2">
															<c:choose>
																<c:when test="${supplierProductAttr.supplierProductAttrvals[0].isProdAttr}">
																	<input type="text" readonly="readonly"
																		value="${fn:escapeXml(supplierProductAttr.supplierProductAttrvals[0].lineAttrvalNameCn)}" /></p>
																</c:when>
																<c:otherwise>
																	<input type="text" disabled="disabled"
																		value="" /></p>
																	
																</c:otherwise>
															</c:choose>
													</c:if>
													
											<p class="blank10"></p>
											</c:if>
									</c:forEach>
									<!-- 基本属性属性值 -->


									<p class="blank10"></p>
									<p class="p1">
										<i class="c_red">*</i> 原产国：
									</p>
									<p class="t2">
										<input  name="supplierProduct.originplace" disabled="disabled"
											type="text" value="${fn:escapeXml(proObj.supplierProduct.originplaceCName)}">
									</p>
									</p>
									<p class="blank10"></p>
									<p class="p1">
										<i class="c_red">*</i> 制造商：
									</p>
									<p class="t2">
										<input readonly="readonly"
											name="supplierProduct.manufacturers" type="text"
											value="${fn:escapeXml(proObj.supplierProduct.manufacturers)}"> 
									</p>
									</p>
									<p class="blank10"></p>
										<p class="p1">保质期：</p>
										<p class="t2">
											<input name="supplierProductDetail.sheilLife" type="text"
												style="width:200px"
												disabled="disabled"
												value="${proObj.supplierProductDetail.sheilLife}">
													<c:if test="${proObj.supplierProductDetail.sheilLifeType==2}">年</c:if>
													<c:if test="${proObj.supplierProductDetail.sheilLifeType==1}">月</c:if>
													<c:if test="${proObj.supplierProductDetail.sheilLifeType==0}">天</c:if>
											</select>
										</p>
								</div>
								
								
								<p class="blank10"></p>
								<p class="blank10"></p>
									<p class="p1">海关税则代码：</p>
									<p class="t2">
										<textarea id="customCode"  disabled="disabled" style="width: 400px; height: 150px;"  name="supplierProductDetail.customCode">${proObj.supplierProductDetail.customCode}</textarea>
									</p>
									<span class="dpl-tip-inline-warning">海关税则不能大于200字</span>
									<p class="blank10"></p>
								<p class="blank10"></p>

								<p class="blank10"></p>
									<p class="p1">商品备注：</p>
									<p class="t2">
										<textarea id="remark" disabled="disabled"  style="width: 400px; height: 150px;"  name="supplierProduct.remark">${proObj.supplierProduct.remark}
										</textarea>
									</p>
									<p class="blank10"></p>
							</div>
						</div>
						
						<p class="blank15"></p>
							<div  class="z" id="zizhi">
								
								<div class='wenzi'>证明资质的图片:</div>
								<ul id="00_img">
								<li class="img-1">
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								<li>
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								<li class="img-6">
								<div class="p-img"></div>
								<div class="operate">
								<i class="toleft">左移</i>
								<i class="toright">右移</i>
								<i class="del">删除</i>
								</div>
								</li>
								</ul>
							</div>
							<p class="blank15"></p>
						
						
						
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
											<span>*</span>${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}： 
										</div>
										<div class="yanse2">
											<p>
												<c:forEach items="${attr.supplierProductAttrvals}" var="av" varStatus="vars">
													<span title="${fn:escapeXml(av.lineAttrvalNameCn)}">
													<input type="checkbox" disabled="disabled"
														name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].lineAttrvalNameCn"
														<c:if test="${av.isProdAttr}">checked</c:if>
														value="${fn:escapeXml(av.lineAttrvalNameCn)}" id="${vars.index}">${fn:escapeXml(av.lineAttrvalNameCn)}</span>
												</c:forEach>
											</p>
										</div>
									</div>
									<br>
								</c:if>

								<c:if test="${attr.supplierProductAttr.saleAttr==1}">
									<!-- 规格属性 -->
									<div class="chim">
										<div class="chim1" title="${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}">
											<span>*</span> ${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}： 
										</div>
										<div class="chim2">
											<p>
												<c:forEach items="${attr.supplierProductAttrvals}" var="av" varStatus="vs">
													<span title="${fn:escapeXml(av.lineAttrvalNameCn)}">
													<input type="checkbox" disabled="disabled"
														name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].lineAttrvalNameCn"
														value="${fn:escapeXml(av.lineAttrvalNameCn)}" 
														<c:if test="${av.isProdAttr}">checked="checked"</c:if>
														id="${vs.index}">
														${fn:escapeXml(av.lineAttrvalNameCn)}
														</span>
												</c:forEach>
											</p>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<!-- 规格属性 -->
							
							
							<div class="z">
								<div id="d"></div>
							</div>
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
							<div class="p3">
								<p class="blank5"></p>
								<p class="t1"><i class="c_red">*</i>计量单位：</p>
								<p class="s_1">
									<input type="text" id="measure" disabled="disabled" value="${fn:escapeXml(proObj.supplierProductPackage.measureCname)}">
								</p>
								<p class="blank5"></p>
								<p class="t1"><i class="c_red">*</i>计价单位：</p>
								
								<p class="s_1">
									<input type="text" id="price" disabled="disabled" value="${fn:escapeXml(proObj.supplierProductSaleSetting.moneyUnitNameCn)}">
								</p>
								<p class="blank5"></p>
								
								
								<div <c:if test="${supplierType eq 3 }">style="display: none"</c:if> >
									<p class="t1"><i class="c_red">*</i> 价格类型：</p>
									<div class="select-quote" style="margin-left:120px" id="priceTypes">
										
										<input type="radio"  disabled="disabled"  name="priceType" value="0" <c:if test="${proObj.supplierProductDetail.priceType==0}">checked</c:if>  id="priceType"/>
										<strong>FOB价格</strong>&nbsp;&nbsp;离岸港口名称<input  id="priceType0text"  disabled="disabled" type="text" name="fobPort" <c:if test="${proObj.supplierProductDetail.priceType==0}">value="${proObj.supplierProductDetail.portName}"</c:if> >
										<span id="priceType0warning" class="dpl-tip-inline-warning"></span> 
										<div class="clear"></div>
										<input type="radio"  disabled="disabled"  name="priceType" value="1" <c:if test="${proObj.supplierProductDetail.priceType==1}">checked</c:if> id="priceType"/>
										<strong>CIF价格</strong>&nbsp;&nbsp;&nbsp;到岸港口名称<input id="priceType1text"  disabled="disabled" type="text" name="cifPort" <c:if test="${proObj.supplierProductDetail.priceType==1}">value="${proObj.supplierProductDetail.portName}"</c:if>>
										<span id="priceType1warning" class="dpl-tip-inline-warning"></span> 
										<div class="clear"></div>
										<input type="radio"  disabled="disabled"  name="priceType" value="2" <c:if test="${proObj.supplierProductDetail.priceType==2}">checked</c:if> id="priceType"/>
										<strong>EXW价格</strong>
									</div>
									<p class="blank5"></p>
									
									
									
									<p class="t1">
										<i class="c_red">*</i>报价：</p>
											<div class="select-quote">
											<input type="radio" name="cost"  disabled="disabled" id="pic_count" class="cp1" value="1"/>
											
											<strong>按产品数量报价</strong>
											<input type="radio" name="cost" disabled="disabled" id="pic_sku" value="2" class="cp2" />
											<strong>按产品规格报价</strong>
									</div>

								<div class="tqz">
									<!--<p class="tq1"><i class="c_red">*</i>价格区间：</p>-->

									<div class="tq2">
										<p class="pp">
											
										</p>
									</div>
									<div class="g">
										<p class="blank"></p>
										<div class="blank10"></div>
										<div class="tab_box">
											最小起订量：<input type='text' disabled="disabled" name='minNum' value="${proObj.supplierProductSaleSetting.minWholesaleQty }">
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
														<th><span class="c_red"> *</span>单价（元）<br />
														
														<input id="same_price" type="hidden"></th></th>
													</tr>
												</thead>
												<tbody>
												</tbody>

											</table>

										</div>
										<!-- 表格 end -->



										<p class="blank15"></p>
									</div>
									<p class="blank10"></p>
								</div>
								
								
								
							<!-- 	<p class="blank15"></p> -->
								<p class="blank5"></p>
								<p class="t1">
								<i class="c_red">*</i> 订单收集类型：</p>
								<div class="select-quote">
								<input type="radio" disabled="disabled" name="supplierProductDetail.orderType" <c:if test="${proObj.supplierProductDetail.orderType==1}">checked</c:if>  value="1"  onchange="changeOrderType('1')"/>
								<strong>现货库存</strong>
								<input type="radio" disabled="disabled" name="supplierProductDetail.orderType" <c:if test="${proObj.supplierProductDetail.orderType==0}">checked</c:if> value="0" onchange="changeOrderType('2')"/>
								<strong>收集订单</strong>
								</div>
								
							</div>
						
						<div id="collection"  <c:if test="${proObj.supplierProductDetail.orderType!=0}">style="display:none"</c:if>>
						<p class="blank15"></p>
						<p class="t1"><i class="c_red">*</i>预计发货日期：</p>
						<p class="s_1">
							<input type="text" disabled="disabled" name="supplierProductDetail.deliverDate" value="<fmt:formatDate value="${proObj.supplierProductDetail.deliverDate}" pattern="yyyy-MM-dd"/>"
									readonly="readonly" id="delivery" onClick="WdatePicker({minDate:'%y-%M-%d'})">
							<span id="deliveryDateWarning" class="dpl-tip-inline-warning"></span>	
							</p>
							<p class="blank15"></p>
							<p class="t1"><i class="c_red">*</i>生产能力：</p>
							<p class="s_3">
								<input id="produceNum" disabled="disabled"  type="text" name="supplierProductDetail.produceNum" value="${proObj.supplierProductDetail.produceNum}"/><span class="danwei">${fn:escapeXml(proObj.supplierProductPackage.measureCname)}</span>
								<select name="supplierProductDetail.produceType" disabled="disabled" >
										<option value="0" <c:if test="${proObj.supplierProductDetail.produceType==0}">selected</c:if>>天</option>
										<option value="4" <c:if test="${proObj.supplierProductDetail.produceType==4}">selected</c:if>>周</option>
										<option value="1" <c:if test="${proObj.supplierProductDetail.produceType==1}">selected</c:if>>月</option>
										<option value="2" <c:if test="${proObj.supplierProductDetail.produceType==2}">selected</c:if>>年</option>
								</select>
									<span id="produceNumWarning" class="dpl-tip-inline-warning"></span> 
									<br>
							</p>
																<p class="blank15"></p>
								<p class="t1"><i class="c_red">*</i>最后收单日期：</p>
								<p class="s_1">
								<input type="text" name="supplierProductDetail.receiveDate" disabled="disabled"
									readonly="readonly" id="closing" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'delivery\')}',minDate:'%y-%M-%d'})"
									value="<fmt:formatDate value="${proObj.supplierProductDetail.receiveDate}" pattern="yyyy-MM-dd"/>"
									>
										<span id="closingWarning" class="dpl-tip-inline-warning"></span> 
									
							</p>
							<span id="orderDate" class="dpl-tip-inline-warning"></span> 
								<p class="blank15"></p>
								<p class="t1"><i class="c_red">*</i>最大收单量：</p>
								<p class="s_1">
									<input  id="maxProdNum" type="text" name="supplierProductDetail.maxProdNum" disabled="disabled" value="${proObj.supplierProductDetail.maxProdNum}">
								<span id="maxProdNumWarning" class="dpl-tip-inline-warning"></span>
								</p>
							 
							<p class="blank15"></p>
							
						</div>
							</div>
							
							<div class="blank20"></div>
							<p class="p1">条形码信息：</p>
							<div class="p3">							
								<p class="blank5"></p>
								<div class="tab_box" style="margin-left:60px;" id="skuCodeTable">
					
								<!-- 	<span style="color:red;">请如实填写条形码</span> -->
									<table cellspacing="0" cellpadding="0" border="0" style="margin-top:10px;" id="tb-tiaoxingma">
										<colgroup>
					            			<col class="color">
					                       	<col class="size">
						 					<col class="price">
											<!-- <col class="operate">	 -->	
										</colgroup>
										<thead>
											<tr >
							   				<th>
													${fn:escapeXml(buyAttrName[0])}
												</th>
												<th>
													${fn:escapeXml(saleAttrName[0])}
												</th>
												<th><span class="c_red"> *</span>条形码<br /></th>
												<th>条形码图片</th>
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

							<div class="mingxi">
								<div class="m1">商品明细：</div>
								<div class="mm">
									<p class="m2">
										<span>包装清单：</span>
										<textarea disabled="disabled" name="supplierProductDetail.packingList">${fn:escapeXml(proObj.supplierProductDetail.packingList)}</textarea>
									</p>
									<p class="m3">
										<span>售后服务：</span>
										<textarea disabled="disabled" name="supplierProductDetail.salesServiceDescription">${fn:escapeXml(proObj.supplierProductDetail.salesServiceDescription)}</textarea>
									</p>
									<p class="m4">
										<span  class="s1">售后电话：</span>
										<input type="text" disabled="disabled"
											name="supplierProductDetail.salesCalls"
											value="${proObj.supplierProductDetail.salesCalls}" />
									</p>
									
								</div>
							</div>
						</div>


						<!-- 文本编辑框 -->

						<div class="blank30"></div>
						<div class="i_box">
							<h2>图文详情</h2>
							<div class="blank20"></div>
							<!--style给定宽度可以影响编辑器的最终宽度-->
							<div style="max-width:820px; height:auto; overflow:auto;" id="attach">
								<c:catch var="catchAtach">
									<c:import url="${fileurl}" charEncoding="utf-8"></c:import>
								</c:catch>
							</div>
							</div>
						<!-- 文本编辑框结束 -->
						<div class="blank"></div>
						<!-- 填写基本信息  -->

						<div class="blank30"></div>
					</div>
					<!-- 内容 end -->
				</div>
				<!-- 边框 end -->
				<div class="blank10"></div>
				<div class="btn_box">
					<button type="button" id="retBtn" class="fabu_btn">返回</button>
					<p class="clear"></p>
				</div>
			</div>
			<div class="clear"></div>
			<p class="blank30"></p>
		</div>
		</div>
<input type="hidden" name="dpro" id="dpro" value="${dpro}">
<input type="hidden" name="page" id="page" value="${page}">
</div>
</div>
<div class="clear"></div>
<div class="blank10"></div>
<!-- 底部 start -->
<%@include file="/WEB-INF/views/zh/include/last.jsp"%>
</body>
</html>

	<script type="text/javascript">
	$(document).ready(function(){
		var url_array = ${jsonImg};
		$.each(url_array,function(n,value){
			adduploadimg(value[1],value[2],value[3]); 
		});
		
		var qualification =  ${qualificationUrl};
		inituploadzizhi(qualification);
		
		var sku_array= ${skuPriceAndCount};
		var measure = $("#measure").val();
		var price = $("#price").val();
 	 	$.each(sku_array,function(keys,values){
 	 	
 	 			var statu = values.type;
 	 			   if(statu=='0'){
 	 			  
 	 			  $("#pic_count").attr("checked","checked");
 	 			  $('.pp').empty();
 	 			  $.each(values.start,function(key,value){
 	 			  	if(key==0){
 	 					$('.pp').append( "<span class='b2'>起批量：<input type='text'disabled='disabled' name='start' value='"+value+"'><span class='danwei'>"+measure+"</span>及以上 <input name='pic' type='text' disabled='disabled'  value='"+values.pic[key]+"'><span class='price'>"+price+"</span>/<span class='danwei'>"+measure+"</span></span>" );
 	 			 	}else{
 	 			 		$('.pp').append( "<span class='b2'>起批量：<input type='text' disabled='disabled' name='start' value='"+value+"'><span class='danwei'>"+measure+"</span>及以上 <input name='pic' disabled='disabled' type='text'  value='"+values.pic[key]+"'><span class='price'>"+price+"</span>/<span class='danwei'>"+measure+"</span></span>" );
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
 	 		
 	 		var skuCode = ${skusCode};
 	 		
 	 		var skuCode_array = new Array();
			$.each(skuCode,function(key,value){
				skuCode_array.push(value);
				var new_array = new Array();
				new_array.push(skuCode_array);
				_fShowTableInfo(skuCode,"tb-tiaoxingma"); 
			});

        $("#retBtn").click(function(){
            location.href="../product/onSaleList?page="+$("#page").val()+"&dpro="+$("#dpro").val();
        });
		});  
	
</script>
