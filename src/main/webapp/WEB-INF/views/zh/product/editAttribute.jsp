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
		<input type="hidden" id="subBrandId" value="${proObj.subBrand.id}">
		<input type="hidden" name="supplierProduct.prodLineId"	value="${proObj.supplierProduct.prodLineId }"> 
		<input type="hidden"	name="supplierProduct.cateDispId" value="${proObj.supplierProduct.cateDispId}">
		<input type="hidden" id="cid"	name="supplierProduct.catePubId" value="${proObj.supplierProduct.catePubId}">
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

								<input type="text" required="required" name="pname" id="productinfo"  title="原产国+品牌名称（国外品牌名称+中文品牌名称）+产品类别（使用人群+功能性修饰语+产品属类）+产品属性（货号、颜色、数量、规格等）"
									value="${fn:escapeXml(proObj.supplierProductBase.productname)}"> 
									<i class="J_PopTip poptip-help" rel="tooltip" tip="“+”代表半角一个空格商品名称不能包含“特供”“专供”“促销”“特价”“包邮”“正品”“买赠”等与商品本身无关的字样品牌（需英文品牌在前,中文品牌在后,无英文品牌只填写中文品牌即可,英文品牌的大小写以厂家注册为准）请使用半角符号简体单位应当为半角英文g,  ml,  L,不应该是中文产品数量为1的产品不用写:1瓶1盒1罐等多包装商品在单个商品规格后乘以数字即可例:125g*2。<br>如：意大利 ARMANI COLLEAIONI阿玛尼 女士时尚经典连衣裙 34485988ke 蓝色 XL">						
								</i><br>
									<span class="dpl-tip-inline-warning" id="productMsg">商品标题不能是空的</span>
							</p>
							<div class="blank10"></div>
							<p class="p1">产品属性：</p>
							<div class="p3" id="attrobjs">
								<div class="bb">
									<p class="blank10"></p>
									
									<p class="p1">
									<i class="c_red">*</i> 品牌：</p>
									<p class="s_1">
									<select id="firstcategory" name="brandId" >
										<option value="">请选择</option>
									</select> 
									
						 			<select id="secondcategory" name="subBrandId"></select>
						 			
									</p>
									<span class="dpl-tip-inline-warning"></span>
									<p class="blank10"></p>
									<!-- 基本属性属性值 -->
									<div id="attrdiv">
										<c:forEach items="${proObj.supplierProductAttrDTOs}" var="supplierProductAttr" varStatus="vs">
											<c:if test="${supplierProductAttr.supplierProductAttr.saleAttr != 1 && supplierProductAttr.supplierProductAttr.buyAttr != 1 }">
												<p class="p1" title="${fn:escapeXml(supplierProductAttr.supplierProductAttr.attrNameCn)}">
													<c:if test="${supplierProductAttr.supplierProductAttr.isneed == 1}">
														<i class="c_red">*</i>
													</c:if>
													${fn:escapeXml(supplierProductAttr.supplierProductAttr.attrNameCn)}
													<c:if test="${not empty supplierProductAttr.supplierProductAttr.ismeasure }">
														<i class="J_PopTip poptip-help" rel="tooltip" tip="${supplierProductAttr.supplierProductAttr.ismeasure}">						
														</i>
													</c:if>
													
													：
												</p>
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.attrNameCn"
													value="${fn:escapeXml(supplierProductAttr.supplierProductAttr.attrNameCn)}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.attrId"
													value="${supplierProductAttr.supplierProductAttr.attrId}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.type"
													value="${supplierProductAttr.supplierProductAttr.type}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.style"
													value="${supplierProductAttr.supplierProductAttr.style}">
												<input type="hidden"
													name="supplierProductAttrDTOs[${vs.index}].supplierProductAttr.isneed"
													value="${supplierProductAttr.supplierProductAttr.isneed}">
														
														<c:if test="${supplierProductAttr.supplierProductAttr.type == 1}">
																<p <c:if test="${supplierProductAttr.supplierProductAttr.isneed == 1}">required="required"</c:if>>
																	<c:forEach items="${supplierProductAttr.supplierProductAttrvals}"
																		var="proAttrVal" varStatus="cbs">
																			<span class="r2" title="${fn:escapeXml(proAttrVal.lineAttrvalNameCn)}"><input type="checkbox"
																				name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[${cbs.index}].lineAttrvalNameCn"
																				<c:if test="${proAttrVal.isProdAttr}">checked</c:if> value="${fn:escapeXml(proAttrVal.lineAttrvalNameCn)}"/>
																			${fn:escapeXml(proAttrVal.lineAttrvalNameCn)}</span>
																	</c:forEach>
																	<span class="dpl-tip-inline-warning" style="margin-left:120px;"></span>
																</p>
																
																
														</c:if>
														
														<c:if test="${supplierProductAttr.supplierProductAttr.type ==2}">
															<p class="s_1">
																<select name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn">
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
																		<c:choose>
																			<c:when test="${supplierProductAttr.supplierProductAttr.isneed == 1}">
																				<input type="text" required="required"
																				    name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn"
																					value="${fn:escapeXml(supplierProductAttr.supplierProductAttrvals[0].lineAttrvalNameCn)}" />
																				<span class="dpl-tip-inline-warning" >${fn:escapeXml(supplierProductAttr.supplierProductAttr.attrNameCn)}只能1-100字</span>
																			</c:when>
																			<c:otherwise>
																				<input type="text"
																				    name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn"
																					value="${fn:escapeXml(supplierProductAttr.supplierProductAttrvals[0].lineAttrvalNameCn)}" />
																			
																			</c:otherwise>
																		</c:choose>
																	</c:when>
																	<c:otherwise>
																		<input type="text"
																		    name="supplierProductAttrDTOs[${vs.index}].supplierProductAttrvals[0].lineAttrvalNameCn"
																			value="" />
																	</c:otherwise>
																	
																</c:choose>
																<span class="dpl-tip-inline-warning"></span>
															</p>
														</c:if>
														
												<p class="blank10"></p>
												</c:if>
										</c:forEach>
									</div>
									<!-- 基本属性属性值 -->

									<p class="blank10"></p>
									<p class="p1">
										<i class="c_red">*</i> 原产国：
									</p>
									<p class="s_1">
										<select required="required" name="supplierProduct.originplace">
											<c:forEach items="${countries}" var="country">
												<option 
												<c:if test="${proObj.supplierProduct.originplace == country.countryid}">selected</c:if>
												value="${country.countryid}">${fn:escapeXml(country.name)}</option>
											</c:forEach>
										</select>
										<span class="dpl-tip-inline-warning">请填写 原产国</span>
									</p>
									</p>
									<p class="blank10"></p>
									<p class="p1">
										<i class="c_red">*</i> 制造商：
									</p>
									<p class="t2">
										<input required="required"
											name="supplierProduct.manufacturers" type="text"
											value="${proObj.supplierProduct.manufacturers}"> 
											<span class="dpl-tip-inline-warning">制造商只能1-200字</span>
									</p>
									</p>
									<p class="blank10"></p>
										<p class="p1">保质期：</p>
										<p class="t2">
										<input name="supplierProductDetail.sheilLife" type="text"
											id="sheilLife"
											style="width:200px"
											value="${proObj.supplierProductDetail.sheilLife}">
									<select name="supplierProductDetail.sheilLifeType">
										<option value="2" <c:if test="${proObj.supplierProductDetail.sheilLifeType==2}">selected</c:if>>年</option>
										<option value="1" <c:if test="${proObj.supplierProductDetail.sheilLifeType==1}">selected</c:if>>月</option>
										<option value="0" <c:if test="${proObj.supplierProductDetail.sheilLifeType==0}">selected</c:if>>日</option>
									</select>
											
												
												
											
									</p>
									

								<p class="blank10"></p>
								<p class="blank10"></p>
									<p class="p1">海关税则代码：</p>
									<p class="t2">
										<textarea id="customCode"  style="width: 400px; height: 150px;"  name="supplierProductDetail.customCode">${proObj.supplierProductDetail.customCode}</textarea>
									</p>
									<span class="dpl-tip-inline-warning">海关税则不能大于200字</span>
									<p class="blank10"></p>
								<p class="blank10"></p>
									<p class="p1">商品备注：</p>
									<p class="t2">
										<textarea id="remark"  style="width: 400px; height: 150px;"  name="supplierProduct.remark">${proObj.supplierProduct.remark}</textarea>
									</p>
									<span class="dpl-tip-inline-warning">商品备注不能大于200字</span>
									<p class="blank10"></p>
								</div>

								<p class="blank10"></p>
							</div>
							<p class="blank15"></p>
							<!-- <div  class="z" id="zizhi">
								
								<div class='wenzi'>证明资质的图片:<input id='00_upload'  name='button'   type='submit'  value='上传资质' />
								<i class="J_PopTip poptip-help" rel="tooltip" tip="请上传商标注册证明（若商品经过注册须提供）、品牌销售授权（非生产厂家须提供）、商品合格证明（必须提供）和其他相关证明文件（如包装上宣称获得的一些奖项等）。">						
								</i>
								<span id="zizhiImg" class='dpl-tip-inline-warning'>请至少上传一张资质图片</span></div>
								<div class='gshi' style="color:grey">资质图片格式只能是'*.jpg;*.png;*.jpeg;',只能小于1M 一次最多上传6张。</div>
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
							</div> -->
							<div id="uploader_00" class="wu-example">
								<span id="zizhiImg" class='dpl-tip-inline-warning'>请至少上传一张资质图片</span>
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
											<span>*</span>${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}
											<c:if test="${not empty attr.supplierProductAttr.ismeasure }">
												<i class="J_PopTip poptip-help" rel="tooltip" tip="${attr.supplierProductAttr.ismeasure}">						
												</i>
											</c:if>
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
											<c:if test="${not empty attr.supplierProductAttr.ismeasure }">
												<i class="J_PopTip poptip-help" rel="tooltip" tip="${attr.supplierProductAttr.ismeasure}">						
												</i>
											</c:if>
											
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
							
							
							<div class="z">
								<div id="d"></div>
							</div>
							</div>
							
							<div class='gshi'>
							上传的图片格式只能是.jpg、.png、.jpeg，尺寸不得小于800*800像素，大小小于400K，图片数量不得少于3张
							<i class="J_PopTip poptip-help" rel="tooltip" tip="图片上传要求：<br>
								1.像素：图片大小800*800像素，分辨率不低于72像素/英寸,图片质量要清晰，不要虚化<br>
								2.纵横比要求1:1<br>
								3.大小：商品的主图上传大小≥30K且≤100K<br>
								4.格式：商品的主图上传格式需为jpg, gif, png, bmp<br>
								5.背景：白色<br>
								6.数量：至少6张（如：产品外部包装正面图、背面图、侧面图、食用方法或配料、内部包装细节图、内部商品细节图、图片应多多展示商品细节）">						
								</i>
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
								<p class="t1"><i class="c_red">*</i>计量单位：</p>
								<input name="supplierProductPackage.packageid" type="hidden" value="${proObj.supplierProductPackage.packageid}"></input>
								<p class="s_1"><select name="supplierProductPackage.measureid" id="measure">
								<c:forEach items="${measure}" var="measure">
									<option value="${measure.measureid}" <c:if test="${proObj.supplierProductPackage.measureid == measure.measureid}">selected</c:if> >${fn:escapeXml(measure.cname)}</option>
								</c:forEach>
								</select></p>
								<p class="blank5"></p>
									
									<p class="blank5"></p>
								<p class="t1"><i class="c_red">*</i>计价单位：</p>
								
								<p class="s_1"><select  name="supplierProductSaleSetting.moneyUnitId" id="price">
									<c:forEach items="${price}" var="price">
										<option value="${price.id}" <c:if test="${proObj.supplierProductSaleSetting.moneyUnitId == price.id}">selected</c:if>>${fn:escapeXml(price.moneyUnitCn)}</option>
									</c:forEach>
								</select></p>
								
								
								
								<div <c:if test="${supplierType eq 3 }">style="display: none"</c:if> >
										<p class="blank5"></p>
										<p class="t1"><i class="c_red">*</i> 价格类型：</p>
										<div class="select-quote" style="margin-left:120px" id="priceTypes">
										<!-- onclick="javascript:$('#priceType1text').attr('disabled','disabled')" -->
										<input type="radio"  name="priceType" value="0"    <c:if test="${proObj.supplierProductDetail.priceType==0}">checked</c:if>  id="priceType"/>
										
										<strong>FOB价格</strong>&nbsp;&nbsp;离岸港口名称<input  id="priceType0text" type="text" name="fobPort"  <c:if test="${proObj.supplierProductDetail.priceType==0}">value="${proObj.supplierProductDetail.portName}"</c:if> >
										<span id="priceType0warning" class="dpl-tip-inline-warning"></span> 
										<div class="clear"></div>
										<input type="radio" name="priceType" value="1" <c:if test="${proObj.supplierProductDetail.priceType==1}">checked</c:if> id="priceType"/>
										<strong>CIF价格</strong>&nbsp;&nbsp;&nbsp;到岸港口名称<input id="priceType1text" type="text" name="cifPort"   <c:if test="${proObj.supplierProductDetail.priceType==1}">value="${proObj.supplierProductDetail.portName}"</c:if>>
										<span id="priceType1warning" class="dpl-tip-inline-warning"></span> 
										<div class="clear"></div>
										<input type="radio"  name="priceType" value="2" <c:if test="${proObj.supplierProductDetail.priceType==2}">checked</c:if> id="priceType"/>
										<strong>EXW价格</strong>
									</div>
								</div>
										
									<p class="blank5"></p>
									
								<div class="tqz" style="display: none">
									<p class="t1">
										<i class="c_red">*</i>报价：
										</p>
										<div class="select-quote">
										<input type="radio" name="cost"   id="pic_count" class="cp1" value="1"/>
										<strong>按产品数量报价</strong>
										<input type="radio" name="cost" id="pic_sku" value="2" class="cp2" />
										<strong>按产品规格报价</strong>
									</div>
								

								
									<div class="tq2">
										<span class="b1"><b></b></span>
										<p class="pp">								
										   <span class="b2">起批量：<input type="text" name='start' id="startNum"><span class="danwei">${fn:escapeXml(proObj.supplierProductPackage.measureCname)}</span>及以上 
											<input type="text" name='pic'><span class="price">${fn:escapeXml(proObj.supplierProductSaleSetting.moneyUnitNameCn)}</span>/<span class="danwei">${fn:escapeXml(proObj.supplierProductPackage.measureCname)} </span>
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
									<p class="blank10"></p>
								</div>

								<div <c:if test="${supplierType eq 3 }">style="display: none"</c:if>>
									<p class="blank5"></p>
									<p class="t1">
									<i class="c_red">*</i> 订单收集类型：</p>
									
								<div class="select-quote" >
									<c:choose>
										<c:when test="${proObj.isUpdateSku}">
											<input type="radio" name="supplierProductDetail.orderType" <c:if test="${proObj.supplierProductDetail.orderType==1}">checked</c:if>  value="1"  onchange="changeOrderType('1')"/>
											<strong>现货库存</strong>
											<input type="radio" name="supplierProductDetail.orderType" <c:if test="${proObj.supplierProductDetail.orderType==0}">checked</c:if> value="0" onchange="changeOrderType('2')"/>
											<strong>收集订单</strong>
										</c:when>
										<c:otherwise>
											<input type="radio" disabled="disabled" name="supplierProductDetail.orderType" <c:if test="${proObj.supplierProductDetail.orderType==1}">checked</c:if>  value="1"  onchange="changeOrderType('1')"/>
											<strong>现货库存</strong>
											<input type="radio" disabled="disabled" name="supplierProductDetail.orderType" <c:if test="${proObj.supplierProductDetail.orderType==0}">checked</c:if> value="0" onchange="changeOrderType('2')"/>
											<strong>收集订单</strong>
											<input type="hidden" name="supplierProductDetail.orderType" value="${proObj.supplierProductDetail.orderType}">
										</c:otherwise>
									
									</c:choose>
									</div>
								</div>
						
						<div id="collection"  style="display: none" >
						
						<p class="blank15"></p>
						<p class="t1"><i class="c_red">*</i>预计发货日期：</p>
						<p class="s_1">
							<input type="text" name="supplierProductDetail.deliverDate" value="<fmt:formatDate value="${proObj.supplierProductDetail.deliverDate}" pattern="yyyy-MM-dd"/>"
									readonly="readonly" id="delivery" onClick="WdatePicker({minDate:'%y-%M-%d'})">
							<span id="deliveryDateWarning" class="dpl-tip-inline-warning"></span>	
							</p>
							<p class="blank15"></p>
							<p class="t1"><i class="c_red">*</i>生产能力：</p>
							<p class="s_3">
								<input id="produceNum"  type="text" name="supplierProductDetail.produceNum" value="${proObj.supplierProductDetail.produceNum}"/><span class="danwei">${fn:escapeXml(proObj.supplierProductPackage.measureCname)}</span>
								<select name="supplierProductDetail.produceType" >
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
								<input type="text" name="supplierProductDetail.receiveDate" 
									readonly="readonly" id="closing" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'delivery\')}',minDate:'%y-%M-%d'})"
									value="<fmt:formatDate value="${proObj.supplierProductDetail.receiveDate}" pattern="yyyy-MM-dd"/>"
									>
										<span id="closingWarning" class="dpl-tip-inline-warning"></span> 
									
							</p>
							<span id="orderDate" class="dpl-tip-inline-warning"></span> 
								<p class="blank15"></p>
								<p class="t1"><i class="c_red">*</i>最大收单量：</p>
								<p class="s_1">
								
								
									<input  id="maxProdNum"  type="text" name="supplierProductDetail.maxProdNum" value="${proObj.supplierProductDetail.maxProdNum}" <c:if test="${!proObj.isUpdateSku}">readonly="readonly"</c:if>>
								<span id="maxProdNumWarning" class="dpl-tip-inline-warning"></span>
								</p>
							 
							<p class="blank15"></p>
							
						</div>
						<p class="blank15"></p>
							</div>



							<div class="blank20"></div>
							<p class="p1">条形码信息：</p>
							<div class="p3">							
								<p class="blank5"></p>
								<div class="tab_box" style="margin-left:60px;" id="skuCodeTable">
					
									<span style="color:red;">请如实填写条形码，条形码应为8,12,13,16位数字</span><br>
									<c:if test="${proObj.isUpdateSku }">
										<span ><input type="checkbox"  name="auto"  value="1" >自动生成</span>
											<i class="J_PopTip poptip-help" rel="tooltip" 
											tip="如果商品没有条形码，请选择自动生成。 <br>
											保存商品后可以查看生成的条形码信息。">						
											</i><br>
									</c:if>
									
									<table cellspacing="0" cellpadding="0" border="0" style="margin-top:10px;" id="tb-tiaoxingma">
										<colgroup>
					            			<col class="color">
					                       	<col class="size">
											<col class="price">
											<col class="tiao">
											<col class="operate">
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
												<th><span class="c_red"> *</span>条形码图片</th>
												<th>上传条形码图片</th>
											</tr>
										</thead>
									    <tbody>
										</tbody>
									    
									</table>
									
								</div>
								<span class="dpl-tip-inline-warning" style="margin-left: 60px;"></span>
								<!-- 表格 end -->

								
								
							
							<p class="blank15"></p>
					
						
					</div>
							<div class="mingxi">
								<div class="m1">商品明细：</div>
								<div class="mm">
									<p class="m2">
										<span>包装清单：</span>
										<textarea id="packingList" name="supplierProductDetail.packingList">${fn:escapeXml(proObj.supplierProductDetail.packingList)}</textarea>
									</p>
									<span class="dpl-tip-inline-warning">请填写 包装清单</span>
									<p class="m3">
										<span>售后服务：</span>
										<textarea id="salesService"  name="supplierProductDetail.salesServiceDescription">${fn:escapeXml(proObj.supplierProductDetail.salesServiceDescription)}</textarea>
									</p>
									<span class="dpl-tip-inline-warning">请填写 售后描述</span>
									<p class="m4">
										<span  class="s1">售后电话：</span>
										<select >
										<option>39</option>
										</select>-
										<input  type="text" name="fristPhone" id="area" value="${phoneNumber[1]}"/>-
										<input  type="text" name="subPhone" id="number" value="${phoneNumber[2]}"/>
									</p>
									<span class="dpl-tip-inline-warning" id="mobiletext" style="margin-right:100px;"></span>
									
								</div>
							</div>
						</div>


						<!-- 文本编辑框 -->

						<div class="blank30"></div>
						<div class="i_box">
							<h2>图文详情
							<i class="J_PopTip poptip-help" rel="tooltip" 
							tip="一、上传图片，要求如下（包含但不仅限于以下内容）：<br>
								1.像素：图片大小800*800像素，分辨率不低于72像素/英寸,图片质量要清晰，不要虚化<br>
								2.纵横比要求1:1<br>
								3.大小：商品的主图上传大小≥30K且≤1M<br>
								4.格式：商品的主图上传格式需为jpg, gif, png, bmp<br>
								5.背景：不限<br>
								6.数量：至少6张。图片应多多展示商品细节和突出商品卖点，如：商品实物细节图（例：巧克力、面包、糕点剖面展示，则突出细腻、松软等特点）、生产线图片、原料图片等。<br>
								主要作用是展示商品的颜色、食用方法、主要特点、增加购买欲、丰富美化页面等<br>
								二、上传文字描述，要求如下（包含但不仅限于以下内容）：<br>
								1.商品卖点，如商品生产工艺，加工流程、商品生产环节的详细介绍，或凸出商品与同行产品的差异等介绍说明<br>
								2.商品介绍<br>
								3.商品使用、食用方法<br>
								4.品牌介绍、商品口号（广告词等）<br>
								5.温馨提示<br>">						
								</i>
							</h2>
							<div class="blank20"></div>
							<input type="hidden" name="supplierProductAttachs[0].productattachid" value="${prodAttachId}">
							<!--style给定宽度可以影响编辑器的最终宽度-->
							<div>
							<span class="dpl-tip-inline-warning" id="Details"></span>
								<script id="editor" type="text/plain">${attch}</script>
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
					<button type="button" id="editProdAttr" class="fabu_btn" >修改商品</button>

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
<script type="text/javascript" src="${path}/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${path}/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="${path}/js/uploadify/queue.js"></script>
<script type="text/javascript" src="${path}/js/product/swfUploadEventHandler.js"></script>
<script type="text/javascript" src="${path}/js/product/zh/editAttribute.js"></script>
<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>

<!--引入JS-->
<script type="text/javascript" src=' ${path}/js/ueditor/third-party/webuploader/webuploader.js'></script>
<script type="text/javascript" src="${path}/js/product/zh/webuploaderhandler.js"></script>

<script type="text/javascript">


    //实例化编辑器
    var ue = new UE.ui.Editor();
	ue.render("editor");
	$(document).ready(function(){
		
		
		var cid = $("#cid").val();
		var brandId='${proObj.brand.id}';
		$.ajax({
			 type : "post", 
         	 url : "../product/getBrands",
         	 data:"cid="+cid,
         	 dataType:"json", 
          	 success : function(msg) {
          	 	var firstcategory="";
          	 	if(msg!=''){
					$.each(eval(msg),function(i,n){
						if(brandId==n.id){
							firstcategory += "<option selected='selected' value='"+n.id+"'>"+n.nameCn+"</option>";
						}else{
							firstcategory += "<option value='"+n.id+"'>"+n.nameCn+"</option>";
						}
					});	
					$("#firstcategory").append(firstcategory);
						$.ajax({
							type : "post",
							url : "../product/getOtherBrand",
							data : "brandId="+ brandId,
							success : function(msg) {
								if(msg.length>2){
									var fistBrandlist = "";
									$.each(eval(msg),function(i,n) {
											if('${proObj.subBrand.id}'!=''){
												if(n.id=='${proObj.subBrand.id}'){
													fistBrandlist += "<option selected='selected' value='"+ n.id+ "'>"+ n.nameCn + "</option>";
												}
											}else{
												fistBrandlist += "<option value='"+ n.id+ "'>"+ n.nameCn + "</option>";
											}
									});
									$("#secondcategory").append(fistBrandlist).show();
								} else{
									$("#secondcategory").hide();
								}
							}
						});
				}
		}
		}); 
		
		var url_array = ${jsonImg};
		$.each(url_array,function(n,value){
			//adduploadimg(value[1],value[2],value[3]); 
			addupload(value[1],value[2],value[3]); 
		});
		
		var qualification =  ${qualificationUrl};
	    inituploader("证明资质的图片","00",qualification);
 	 		
 	 		var skuCode = ${skusCode};
 	 		
 	 		var skuCode_array = new Array();
			$.each(skuCode,function(key,value){
				skuCode_array.push(value);
				var new_array = new Array();
				new_array.push(skuCode_array);
				_fShowTableInfo(skuCode,"tb-tiaoxingma"); 
			});
 	 		
		});  
	
	var orderType=$('input:radio[name="supplierProductDetail.orderType"]:checked').val();
	if(orderType==0){
		$("#collection").css('display','block'); 
	}
	function changeOrderType(type) {
		if (type == 2) {
			$("#collection").show();			
		}else{
			$("#collection").hide();			
		}
	};
	
</script>
 </body>
</html>