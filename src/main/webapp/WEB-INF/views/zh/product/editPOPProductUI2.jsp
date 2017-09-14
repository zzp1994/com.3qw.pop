<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/views/zh/include/base.jsp"%>

<title>商家后台管理系统-

	<c:choose>
		<c:when test="${type == 2 }">
			克隆商品
		</c:when>
		<c:otherwise>
			修改商品
		</c:otherwise>
	</c:choose>
				
</title>
<link rel="stylesheet" href="${path}/css/zh/shang.css">
<link href="${path}/css/uploadify.css" rel="stylesheet" type="text/css" />
<link href="${path}/css/tooltip.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="${path}/js/ueditor/third-party/webuploader/webuploader.css">
<link rel="stylesheet" type="text/css" href="${path}/css/webuploaderframe.css">
<link rel="stylesheet" type="text/css" href="${path}/js/jquery-AutoComplete/jquery.autocomplete.css">
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
		<input type="hidden" id="cid"	name="supplierProduct.catePubId" value="${proObj.supplierProduct.catePubId}">
		<input type="hidden" id="productId" name="productId" value="${proObj.productId}">
		<c:forEach items="${proObj.supplierProductSkuDTOs}" var="skuHide" varStatus="skui">
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductSku.productSkuId" value="${skuHide. supplierProductSku.productSkuId}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductPriceMap.supplierprice" value="${skuHide.supplierProductPriceMap.supplierprice}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductPriceMap.prodPriceId" value="${skuHide.supplierProductPriceMap.prodPriceId}"/>
			<input type="hidden" name="supplierProductSkuDTOs[${skui.index }].supplierProductPriceMap.priceId" value="${skuHide.supplierProductPriceMap.priceId}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductSku.skuNameCn" value="${fn:escapeXml(skuHide. supplierProductSku.skuNameCn)}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductSku.skuNameEn" value="${fn:escapeXml(skuHide. supplierProductSku.skuNameEn)}"/>
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductSku.skuId" value="${fn:escapeXml(skuHide. supplierProductSku.skuId)}"/>
			<c:forEach items="${skuHide.supplierProductSkuAttrvals}" var="skuvalHide" varStatus="skuvali">
			<input type="hidden"  name="supplierProductSkuDTOs[${skui.index }].supplierProductSkuAttrvals[${skuvali.index }].tdProSkuAttrvalId" 
			value="${fn:escapeXml(skuvalHide.tdProSkuAttrvalId)}"/>
			</c:forEach>
		</c:forEach>
		<div class="right f_l">
			<div class="c21">
				<div class="title">
					<p>卖家中心&nbsp;>&nbsp;</p>
					<p>商品管理&nbsp;>&nbsp;</p>
					<p class="c1">
						<c:choose>
							<c:when test="${type == 2 }">
								克隆商品
							</c:when>
							<c:otherwise>
								修改商品
							</c:otherwise>
						</c:choose>
					</p>
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
						<input type="button" value="修改分类"  class="download-btn" id="toEditCategory"/>
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
<!-- 									<select id="firstcategory" name="brandId" >
										<option value="">请选择</option>
									</select>  -->
									<input id="keyword" style="float: left;margin-right:5px;height:25px;" value="${proObj.brand.nameCn}"/>  
                                    <input id="firstcategory" name="brandId" type="hidden" />  
						 			<select id="secondcategory" name="subBrandId"></select>
						 			
									</p>
									<span class="dpl-tip-inline-warning"></span>
									<p class="blank10"></p>
									<!-- 基本属性属性值 -->
									<div id="attrdiv">
											<input type="button" id="addTable" value="添加普通属性"/>
											<span id="tblError" class="dpl-tip-inline-warning"></span>
											<table id="tbl" style="margin-top:10px;border:1px;border-style: solid; border-color: #c3c3c3;">
											<colgroup>
											<col style="width: 35px;border:1px;border-style: solid; border-color: #c3c3c3;">
											<col style="width: 65px;border:1px;border-style: solid; border-color: #c3c3c3;">
											<col style="width: 80px;border:1px;border-style: solid; border-color: #c3c3c3;">
											<col style="width: 450px;border:1px;border-style: solid; border-color: #c3c3c3;">
											<col style="width: 50px;border:1px;border-style: solid; border-color: #c3c3c3;">
											</colgroup>
												<tr style="height: 30px;">
													<th>排序</th>
													<th>形式</th>
													<th>属性</th>
													<th>属性值</th>
													<th>操作</th>
												</tr>
												<c:forEach items="${simpleAttrs}" var="supplierProductAttrDTO" varStatus="vs">
											<tr>
												<td>
													<input type="text" id="attrOrd${vs.index}" name="attrOrd" value="${supplierProductAttrDTO.supplierProductAttr.sortval}" style="width: 30px;"/>
													<input type="hidden" name="attrRows" value="100${vs.index}"/>
												</td>
												<td>
													<select name="type100${vs.index}">
														<option value="3" <c:if test="${supplierProductAttrDTO.supplierProductAttr.type ==3 }">selected="selected"</c:if>>文本</option>
														<option value="1" <c:if test="${supplierProductAttrDTO.supplierProductAttr.type ==1 }">selected="selected"</c:if>>多选框</option>
													</select>
												</td>
												<td>
													<input type="text" id="attrNm${vs.index}" name="attrName" value="${supplierProductAttrDTO.supplierProductAttr.attrNameCn}" style='width: 80px;'/>
												</td>
												<td id="addAttrvals100${vs.index}">
													<img src="../images/img_+bg.jpg" onclick="addAttrval('100${vs.index}')">
													<c:forEach items="${supplierProductAttrDTO.supplierProductAttrvals}" var="proAttrVal" varStatus="cbs">
														<input type="text" name="attrval100${vs.index}" id="attrval100${vs.index}${cbs.index}" value="${fn:escapeXml(proAttrVal.lineAttrvalNameCn)}" style="width: 100px;"/>
														<img src="../images/img_23.png" id="img100${vs.index}${cbs.index}" onclick="delAttrval('100${vs.index}${cbs.index}')">
													</c:forEach>
												</td>
												<td>
													<input type="button" onclick="delAttr(this)" value="删除"/>
													<input type="hidden" class="attrLists" value="${vs.index}"/>
												</td>
											</tr>
									</c:forEach>
											</table>
										</div>
									<!-- 基本属性属性值 -->

									<p class="blank10"></p>
									<!-- <p class="p1">
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
									</p> -->
									<input type="hidden" name="supplierProduct.originplace" value="141957609135423570">
									<input type="hidden"  value="3" id="hqj" name="hqjcode"/>
									<input type="hidden"  value="1" id="fhed" name="fhedcode"/>
									<input type="hidden"  value="${costPriceMultiple}" id="scj" name="scjcode"/>
									<input type="hidden"  value="${limitNum}" id="limit" name="limit"/>
									<p class="blank10" style="display: none;"></p>
									<p class="p1" style="display: none;">
										<i class="c_red">*</i> 制造商：
									</p>
									<p class="t2" style="display: none;">
										<input required="required"
											name="supplierProduct.manufacturers" type="text"
											value="${proObj.supplierProduct.manufacturers}"> 
											<span class="dpl-tip-inline-warning">制造商只能1-200字</span>
									</p>

									<%-- 新加 b2c字段开始部分 start--%>

									<p class="blank10" style="display: none"></p>
									<p class="p1" style="display: none"><i class="c_red">*</i> 发货地：</p>
									<p class="t2" style="display: none">
										<input required="required" name="b2cProductDetail.OriginCountry" type="text" value="${proObj.b2cProductDetail.originCountry}">
									<span class="dpl-tip-inline-warning">
									发货地只能1-200字
									</span>
									</p>

									<p class="blank10" style="display: none;"></p>
									<p class="p1" style="display: none;"><i class="c_red">*</i> 国外币种：</p>
									<p class="s_1" style="display: none;">
										<select name="b2cProductDetail.b2cMoneyUnitId">
											<option value="1" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==1}">selected</c:if> >人民币</option>
											<option value="2" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==2}">selected</c:if> >欧元</option>
											<option value="4" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==4}">selected</c:if> >英镑</option>
											<option value="5" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==5}">selected</c:if> >日元</option>
											<option value="6" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==6}">selected</c:if> >美元</option>
											<option value="15" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==15}">selected</c:if> >新台币</option>
											<option value="17" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==17}">selected</c:if> >阿联酋迪拉姆</option>
											<option value="18" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==18}">selected</c:if> >澳元</option>
											<option value="19" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==19}">selected</c:if> >澳门元</option>
											<option value="20" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==20}">selected</c:if> >埃及磅</option>
											<option value="21" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==21}">selected</c:if> >俄罗斯卢布</option>
											<option value="22" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==22}">selected</c:if> >丹麦克朗</option>
											<option value="23" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==23}">selected</c:if> >新西兰元</option>
											<option value="24" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==24}">selected</c:if> >新加坡元</option>
											<option value="25" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==25}">selected</c:if> >文莱元</option>
											<option value="26" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==26}">selected</c:if> >匈牙利福林</option>
											<option value="27" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==27}">selected</c:if> >越南盾</option>
											<option value="28" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==28}">selected</c:if> >印度卢比</option>
											<option value="29" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==29}">selected</c:if> >印尼卢比</option>
											<option value="30" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==30}">selected</c:if> >智利比索</option>
											<option value="31" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==31}">selected</c:if> >瑞士法郎</option>
											<option value="32" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==32}">selected</c:if> >瑞典克朗</option>
											<option value="33" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==33}">selected</c:if> >斯里兰卡卢比</option>
											<option value="34" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==34}">selected</c:if> >泰铢</option>
											<option value="35" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==35}">selected</c:if> >肯尼亚先令</option>
											<option value="36" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==36}">selected</c:if> >老挝基普</option>
											<option value="37" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==37}">selected</c:if> >缅甸元</option>
											<option value="38" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==38}">selected</c:if> >马来西亚林吉特</option>
											<option value="39" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==39}">selected</c:if> >墨西哥元</option>
											<option value="40" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==40}">selected</c:if> >挪威克朗</option>
											<option value="41" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==41}">selected</c:if> >南非兰特</option>
											<option value="42" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==42}">selected</c:if> >加元</option>
											<option value="43" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==43}">selected</c:if> >韩元</option>
											<option value="44" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==44}">selected</c:if> >港元</option>
											<option value="45" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==45}">selected</c:if> >菲律宾比索</option>
											<option value="46" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==46}">selected</c:if> >柬埔寨瑞尔</option>
											<option value="47" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==47}">selected</c:if> >哥伦比亚比索</option>
											<option value="49" <c:if test="${proObj.b2cProductDetail.b2cMoneyUnitId==49}">selected</c:if> >新土耳其里拉</option>
										</select>
										<%--<span class="dpl-tip-inline-warning">--%>
										<%--发货地只能1-200字--%>
										<%--</span>--%>
									</p>

									<p class="blank10" style="display: none"></p>
									<p class="p1" style="display: none"><i class="c_red">*</i>货源种类：</p>
									<p class="s_1" style="display: none">
										<select name="b2cProductDetail.b2cSupply">
											<option value="1" >一般贸易</option>
											<option value="11">海外直邮</option>
											<option value="12">保税区发货</option>
											<option value="21">韩国直邮</option>
											<option value="50">海外预售</option>
											<option value="51" selected="selected">第三方国际发货(POP)</option>
										</select>
										<%--<span class="dpl-tip-inline-warning">--%>
										<%--发货地只能1-200字--%>
										<%--</span>--%>
									</p>

									<div style="display: none;">
										<p class="blank10"></p>
										<p class="p1"><i class="c_red">*</i>行邮税（%）：</p>
										<p class="s_1">
											<select name="b2cProductDetail.tariff">
												<option value="0" selected="selected">无</option>
												<option value="10">10</option>
												<option value="20">20</option>
												<option value="30">30</option>
												<option value="50">50</option>
											</select>
											<%--<span class="dpl-tip-inline-warning">--%>
											<%--发货地只能1-200字--%>
											<%--</span>--%>
										</p>
									</div>

									<%-- 新加 b2c字段开始部分 end--%>

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
								<p class="blank10" style="display: none;"></p>
									<p class="p1" style="display: none;">海关税则代码：</p>
									<p class="t2" style="display: none;">
										<textarea id="customCode"  style="width: 400px; height: 150px;"  name="supplierProductDetail.customCode">${proObj.supplierProductDetail.customCode}</textarea>
									</p>
									<span class="dpl-tip-inline-warning">海关税则不能大于50字</span>
									<p class="blank10"></p>
								<p class="blank10"></p>
									<p class="p1">搜索关键词：</p>
									<p class="t2" >
										<textarea id="remark"  style="width: 400px; height: 150px;"  name="supplierProduct.remark">${proObj.supplierProduct.remark}</textarea>
									</p>
									<span class="dpl-tip-inline-warning">搜索关键词不能大于200字</span>
									<p class="blank10" style="display: none"></p>
								</div>

								<p class="blank10"></p>
							</div>
							<p class="blank15"></p>
							
							<div id="uploader_00" class="wu-example" style="display: none;">
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
										<table style="margin-top:10px;border:1px;border-style: solid; border-color: #c3c3c3;">
										<colgroup>
										<col style="width: 120px;border:1px;border-style: solid; border-color: #c3c3c3;">
										<col style="width: 580px;border:1px;border-style: solid; border-color: #c3c3c3;">
										</colgroup>
										<tr>
										<th>展示属性</th>
										<th>属性值</th></tr>
										<tr id="yanse">
										<td class="yanse1" align="center">
											<input type="text" style="width:118px;"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrNameCn"
												value="${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}" onblur="changeboxth()"/>
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrName"
												value="${fn:escapeXml(attr.supplierProductAttr.attrName)}"/>
											<input type="hidden" name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrId"  value="${attr.supplierProductAttr.attrId}">
											<input type="hidden" name="buyIndex" value="${saleVs.index}">
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
										</td>
										<td class="yanse2">
												<c:forEach items="${attr.supplierProductAttrvals}" var="av" varStatus="vars">
													<input type="hidden"
														name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].attrValId"
														value="${av.attrValId}" >
														
														<c:choose>
															<c:when test="${proObj.isUpdateSku }">
																<input type="checkbox" disabled="disabled"
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	value="${fn:escapeXml(av.lineAttrvalNameCn)}" 
																	id="${vars.index}">	
																	<c:if test="${av.isProdAttr}">
																	<input type="text" id="${vars.index}"  style="width:100px;" onblur="changeAttrValName(${vars.index})"
																		name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].lineAttrvalNameCn" value="${fn:escapeXml(av.lineAttrvalNameCn)}" >
																		<input type="hidden"
																		name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].lineAttrvalName" value="${fn:escapeXml(av.lineAttrvalName)}" >														
																	</c:if>
															</c:when>
															<c:otherwise>
																<input type="checkbox" disabled="disabled"
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	value="${fn:escapeXml(av.lineAttrvalNameCn)}" 
																	id="${vars.index}">	
																	<c:if test="${av.isProdAttr}">
																	<input type="text" id="${vars.index}"  style="width:100px;" onblur="changeAttrValName(${vars.index})"
																		name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].lineAttrvalNameCn" value="${fn:escapeXml(av.lineAttrvalNameCn)}" >
																		<input type="hidden"
																		name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vars.index}].lineAttrvalName" value="${fn:escapeXml(av.lineAttrvalName)}" >														
																	</c:if>
															</c:otherwise>
														</c:choose>
												</c:forEach>
												<span class="dpl-tip-inline-warning" style="display: none">请至少选择一项</span>
										</td>
										</tr>
										</table>
									<br>
								</c:if>
							</c:forEach>
							<table id="tblBuy" style="margin-top:10px;border:1px;border-style: solid; border-color: #c3c3c3;">
										<colgroup>
										<col style="width: 120px;border:1px;border-style: solid; border-color: #c3c3c3;">
										<col style="width: 580px;border:1px;border-style: solid; border-color: #c3c3c3;">
										</colgroup>
										<tr>
										<th>规格属性</th>
										<th>属性值</th></tr>
										
							<c:forEach items="${proObj.supplierProductAttrDTOs }" var="attr" varStatus="saleVs">
							<c:if test="${attr.supplierProductAttr.saleAttr==1}">
									<!-- 规格属性 -->
									<tr class="chim">
										<td class="chim1" align="center">
											<input type="text"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrNameCn" style="width: 118px;"
												value="${fn:escapeXml(attr.supplierProductAttr.attrNameCn)}" onblur="changeAttrName()"/>
											<input type="hidden"
												name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrName" 
												value="${fn:escapeXml(attr.supplierProductAttr.attrName)}"/>
											<input
												type="hidden" name="saleIndex" value="${saleVs.index}">
												<input type="hidden" name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttr.attrId"  value="${attr.supplierProductAttr.attrId}">
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
										</td>
										<td class="chim2">
												<c:forEach items="${attr.supplierProductAttrvals}" var="av" varStatus="vs">
													<input type="hidden"
														name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].attrValId"
														value="${av.attrValId}" >
														
														<c:choose>
															<c:when test="${proObj.isUpdateSku }">
																<input type="checkbox" disabled="disabled"
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	value="${fn:escapeXml(av.lineAttrvalNameCn)}" 
																	id="${vs.index}">	
																<c:if test="${av.isProdAttr}">			
																	<input type="text" style="width: 100px;" onblur="changeAttrValName()" 
																		name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].lineAttrvalNameCn" value="${fn:escapeXml(av.lineAttrvalNameCn)}" >
																		<input type="hidden" 
																		name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].lineAttrvalName" value="${fn:escapeXml(av.lineAttrvalName)}" >
																</c:if>	
															</c:when>
															<c:otherwise>
																<input type="checkbox" disabled="disabled"
																	<c:if test="${av.isProdAttr}">checked="checked"</c:if>
																	value="${fn:escapeXml(av.lineAttrvalNameCn)}" 
																	id="${vs.index}">	
																<c:if test="${av.isProdAttr}">			
																	<input type="text" style="width: 100px;" onblur="changeAttrValName()" 
																		name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].lineAttrvalNameCn" value="${fn:escapeXml(av.lineAttrvalNameCn)}" >
																		<input type="hidden" 
																		name="supplierProductAttrDTOs[${saleVs.index}].supplierProductAttrvals[${vs.index}].lineAttrvalName" value="${fn:escapeXml(av.lineAttrvalName)}" >
																</c:if>											
															</c:otherwise>
														</c:choose>
												</c:forEach>
												<span class="dpl-tip-inline-warning" style="display: none">请至少选择一项</span>
										</td>
									</tr>
								</c:if>
							</c:forEach>
							</table>
							<!-- 规格属性 -->
							
							
							<div class="z">
								<div id="d"></div>
							</div>
							</div>
							
							<div class='gshi'>
							上传的图片格式只能是.jpg、.png、.jpeg，尺寸不得小于800*800像素，大小小于400K，图片数量不得少于1张
							<i class="J_PopTip poptip-help" rel="tooltip" tip="图片上传要求：<br>
								1.像素：图片大小800*800像素，分辨率不低于72像素/英寸,图片质量要清晰，不要虚化<br>
								2.纵横比要求1:1<br>
								3.大小：商品的主图上传大小≥30K且≤100K<br>
								4.格式：商品的主图上传格式需为jpg, gif, png, bmp<br>
								5.背景：白色<br>
								6.数量：至少1张（如：产品外部包装正面图、背面图、侧面图、食用方法或配料、内部包装细节图、内部商品细节图、图片应多多展示商品细节）">
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
							<%--<p class="p1">交易信息：</p>--%>
							<div class="p3" style="display: none;">
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
								</div>

								<div class="tqz" <c:if test="${supplierType eq 3 }">style="display: none"</c:if>>
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
													<col class="cm2" style="width: 50px;">
					                       			<col class="cm3" style="width: 50px;">
					                       			<col class="cm3" style="width: 50px;">
													<col class="price">
													<col class="operate">
												</colgroup>
												<thead>
													<tr>
														<th>
															<!-- ${fn:escapeXml(buyAttrName[0])} -->
															<span id="zhan1"></span>
														</th>
														<th class="cm1">
															<!-- ${fn:escapeXml(saleAttrName[0])} -->
															<span></span>
														</th>
														<th class="cm2" style="display: none;"><span></span></th>
														<th class="cm3" style="display: none;"><span></span></th>
														<th class="cm4" style="display: none;"><span></span></th>
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
					
									<span style="color:red;">请如实填写条形码，条形码应为8,10,12,13,16位数字</span><br>
									<c:if test="${proObj.isUpdateSku }">
										<span ><input type="checkbox"  name="auto"  value="1" >自动生成</span>
											<i class="J_PopTip poptip-help" rel="tooltip" 
											tip="如果商品没有条形码，请选择自动生成。 <br>
											保存商品后可以查看生成的条形码信息。">						
											</i><br>
									</c:if>
									
									<table cellspacing="0" cellpadding="0" border="0" style="margin-top:10px;" id="tb-tiaoxingma" width="100%">
										<colgroup>
					            			<!-- <col class="color">
					                       	<col class="size">
											<col class="cm2" style="width: 70px;">
					                       	<col class="cm3" style="width: 70px;">
					                       	<col class="cm3" style="width: 70px;">
											<col class="price">
											<col class="tiao">
											<col class="operate"> -->
											<!-- <col class="operate">	 -->	
										</colgroup>
										<thead>
											<tr >
												<th>
													<!-- ${fn:escapeXml(buyAttrName[0])} -->
													<span id="zhan2"></span>
												</th>
												<th class="cm1">
													<!-- ${fn:escapeXml(saleAttrName[0])} -->
													<span></span>
												</th>
												<th class="cm2" style="display: none;"><span></span></th>
												<th class="cm3" style="display: none;"><span></span></th>
												<th class="cm4" style="display: none;"><span></span></th>
												<th><span class="c_red"> *</span>条形码<br /></th>
												<th style="display: none;"><span class="c_red"> *</span>条形码图片</th>
												<!-- <th>上传条形码图片</th> -->
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


							<!-- b2c 价格录入 start-->
							<div class="blank20"></div>
							<p class="p1">商品价格信息：</p>
							<div class="p3">
								<p class="blank5"></p>

								<div class="tab_box" style="margin-left:60px;" id="skuPriceTable">
									<span style="color:red;">如要设置现金比例，请联系相关客服<span>
									<table cellspacing="0" cellpadding="0" border="0" style="margin-top:10px;" id="tb-skuprice" width="100%">
									<!-- <table cellspacing="0" cellpadding="0" border="0" style="margin-top:10px;"  width="100%" > -->
										<colgroup>
											<!-- <col class="color">
											<col class="size">
											<col class="price">
											<col class="tiao"> -->
											<!-- <col class="operate"> -->

										</colgroup>
										<thead>
										<tr>
											<th >
													<!-- ${fn:escapeXml(buyAttrName[0])} -->
													<span id="zhan3"></span>
												</th>
												<th class="cm1">
													${fn:escapeXml(saleAttrName[0])}
													<span></span>
												</th>
												<th class="cm2" style="display: none;"><span></span></th>
												<th class="cm3" style="display: none;"><span></span></th>
												<th class="cm4" style="display: none;"><span></span></th>
												<th style="display: none;">商品货号</th>
											<th><i class="c_red">*</i>市场价(￥)</th>
											<th><i class="c_red">*</i>零售价(￥)</th>
											
										
											
											
											
											<th style="display: none;"><i class="c_red">*</i>翼支付价(￥)</th>
											<th ><i class="c_red"></i>现金比例(%)</th>
											<th style="display: none;"><i class="c_red"></i>赠送红旗劵</th>
											<th style="display: none;"><i class="c_red"></i>分红额度</th>
										</tr>
											
										<!-- <td>0</td>
										<td>0</td> -->
										
										
										</thead>
									</table>
									
								</div>
								<span class="dpl-tip-inline-warning" style="margin-left: 60px;"></span>
								<!-- 表格 end -->
								<p class="blank15"></p>
							</div>
							<!-- b2c 价格录入 end-->


							<div class="mingxi" style="display: none">
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
								3.大小：商品的主图上传大小≥30K且≤100K<br>
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
					<button type="button" id="retBtn" class="fabu_btn">返回</button>

						<button type="button" id="editProd" class="fabu_btn" >修改商品</button>

				
				
<!-- 					<input  type="submit" id="previewProd" class="fabu_btn" >预览商品</button> -->
					<p class="clear"></p>
				</div>
			</div>
			<div class="clear"></div>
			<p class="blank30"></p>
		</div>
			<input type="hidden" name="dpro" id="dpro" value="${dpro}">
			<input type="hidden" name="page" id="page" value="${page}">
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
<script type="text/javascript" src="${path}/js/product/zh/editProduct_popshow1.js"></script>
<script type="text/javascript" src="${path}/js/commons/tooltip.js"></script>

<!--引入JS-->
<script type="text/javascript" src=' ${path}/js/ueditor/third-party/webuploader/webuploader.js'></script>
<script type="text/javascript" src="${path}/js/product/zh/webuploaderhandler.js"></script>
<script type="text/javascript" src="${path}/js/jquery-AutoComplete/jquery.autocomplete.js"></script>
<script type="text/javascript">


    //实例化编辑器
    var ue = new UE.ui.Editor();
	ue.render("editor");
	$(document).ready(function(){
		$("#toEditCategory").click(function(){
			window.location.href="../product/toEditCategoryUI?productId="+productId;
		});
		$("#domesticPrice").blur(function(event){
			var scj = $("#scj").val();
			var unitpri = event.target;
			var trthis = $(unitpri).parent().parent();
			trthis.find('#unitPrice').val(Math.round(parseFloat($(unitpri).val()*scj)));
			
		});
	
		var cid = $("#cid").val();
		var brandId='${proObj.brand.id}';
//		var nameCn="${proObj.brand.nameCn}";
//	     $('#keyword').val(nameCn);   //不知为何自动返回值后总是加了个“,”,所以改成后赋值  
         $("#firstcategory").val(brandId); 
         onChange(brandId);
		$.ajax({
			 type : "post", 
         	 url : "../product/getBrands",
         	 data:"cid="+cid,
         	 dataType:"json", 
          	 success : function(msg) {
          		 $("#keyword").autocomplete(msg, {
                     minChars: 0,					//最少输入字条
                     max: 1000,
                     autoFill: false,				//是否选多个,用","分开
                     mustMatch: false,				//是否全匹配, 如数据中没有此数据,将无法输入
                     matchContains: true,			//是否全文搜索,否则只是前面作为标准
                     scrollHeight:500,
                     width:240,
                     multiple: false,
                     formatItem: function (row, i, max) {//显示格式
                         return ""+row.nameCn;
                     },
                     formatMatch: function (row, i, max) {//以什么数据作为搜索关键词,可包括中文,
                         return row.nameCn;
                     },
                     formatResult: function (row) {//返回结果
                         return row.id;
                     }
                 }).result(function(event, data, formatted) { //回调  
                 	  $('#keyword').val(data.nameCn);   //不知为何自动返回值后总是加了个“,”,所以改成后赋值  
                      $("#firstcategory").val(data.id); 
                      onChange(data.id);
                 });
		}
		}); 
		
		var url_array = ${jsonImg};
		$.each(url_array,function(n,value){
			//adduploadimg(value[1],value[2],value[3]); 
			addupload(value[1],value[2],value[3]); 
		});
		
		var qualification =  ${qualificationUrl};
	    inituploader("证明资质的图片","00",qualification);
	    /* inituploader1("上传文件","mm",[]);  */
		
		var sku_array= ${skuPriceAndCount};
		var measure = $("#measure").find("option:selected").text();
		var price = $("#price").find("option:selected").text();
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
 	 		
 	 		var skuCode = ${skusCode};
 	 		var skuCode_array = new Array();
			$.each(skuCode,function(key,value){
				skuCode_array.push(value);
				var new_array = new Array();
				new_array.push(skuCode_array);
				_fShowTableInfo(skuCode,"tb-tiaoxingma");
				_fShowTableInfo(skuCode,"tb-skuprice");
			});

        $("#retBtn").click(function(){
            location.href="../product/onSaleList?page="+$("#page").val()+"&dpro="+$("#dpro").val();
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